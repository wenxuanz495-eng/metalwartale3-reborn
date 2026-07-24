Set-StrictMode -Version Latest

function Initialize-ProjectEnvironment {
  param([Parameter(Mandatory)][string]$RepoRoot)
  Write-Host "[ENV] Using the current Go environment."
  return (Resolve-Path -LiteralPath $RepoRoot).Path
}

function Get-Sha256 {
  param([Parameter(Mandatory)][string]$Path)
  return (Get-FileHash -LiteralPath $Path -Algorithm SHA256).Hash
}

function Get-StringSha256 {
  param([Parameter(Mandatory)][string]$Value)
  $sha256 = [Security.Cryptography.SHA256]::Create()
  try {
    $bytes = [Text.Encoding]::UTF8.GetBytes($Value)
    return ([BitConverter]::ToString($sha256.ComputeHash($bytes))).Replace("-", "")
  } finally {
    $sha256.Dispose()
  }
}

function Get-SwfCacheKey {
  param([Parameter(Mandatory)][string[]]$Entries)
  $framed = foreach ($entry in $Entries) { "$($entry.Length):$entry" }
  return Get-StringSha256 ($framed -join "`n")
}

function Test-SwfCacheEntry {
  param(
    [Parameter(Mandatory)][string]$Directory,
    [Parameter(Mandatory)][string]$Key,
    [Parameter(Mandatory)][string]$ArtifactName,
    [string]$ReportName = ""
  )
  $artifact = Join-Path $Directory $ArtifactName
  $metadataPath = Join-Path $Directory "metadata.json"
  if (-not (Test-Path -LiteralPath $artifact) -or -not (Test-Path -LiteralPath $metadataPath)) { return $false }
  try {
    $metadata = Get-Content -LiteralPath $metadataPath -Raw | ConvertFrom-Json
    $valid = $metadata.version -eq 1 -and
      $metadata.key -eq $Key -and
      $metadata.artifact -eq $ArtifactName -and
      $metadata.sha256 -eq (Get-Sha256 $artifact)
    if ($ReportName) {
      $report = Join-Path $Directory $ReportName
      $valid = $valid -and
        (Test-Path -LiteralPath $report) -and
        $metadata.reportSha256 -eq (Get-Sha256 $report)
    }
    return $valid
  } catch {
    return $false
  }
}

function Publish-SwfCacheEntry {
  param(
    [Parameter(Mandatory)][string]$Directory,
    [Parameter(Mandatory)][string]$Key,
    [Parameter(Mandatory)][string]$Source,
    [Parameter(Mandatory)][string]$ArtifactName,
    [string]$Report = ""
  )
  $reportName = if ($Report) { "pcode-report.txt" } else { "" }
  if (Test-SwfCacheEntry $Directory $Key $ArtifactName $reportName) { return }
  $parent = Split-Path $Directory
  New-Item -ItemType Directory -Force -Path $parent | Out-Null
  $temporary = Join-Path $parent (".new-" + [Guid]::NewGuid().ToString("N"))
  New-Item -ItemType Directory -Path $temporary | Out-Null
  try {
    Copy-Item -LiteralPath $Source -Destination (Join-Path $temporary $ArtifactName)
    if ($Report) { Copy-Item -LiteralPath $Report -Destination (Join-Path $temporary "pcode-report.txt") }
    $metadata = [ordered]@{
      version = 1
      key = $Key
      artifact = $ArtifactName
      sha256 = Get-Sha256 $Source
    }
    if ($Report) { $metadata.reportSha256 = Get-Sha256 $Report }
    $metadata | ConvertTo-Json | Set-Content -LiteralPath (Join-Path $temporary "metadata.json") -Encoding utf8
    if (Test-Path -LiteralPath $Directory) {
      if (Test-SwfCacheEntry $Directory $Key $ArtifactName $reportName) { return }
      $invalid = Join-Path $parent (".invalid-" + [Guid]::NewGuid().ToString("N"))
      Move-Item -LiteralPath $Directory -Destination $invalid
      try {
        Move-Item -LiteralPath $temporary -Destination $Directory
      } catch {
        if (-not (Test-Path -LiteralPath $Directory) -and (Test-Path -LiteralPath $invalid)) {
          Move-Item -LiteralPath $invalid -Destination $Directory
        }
        throw
      }
      Remove-Item -LiteralPath $invalid -Recurse -Force -ErrorAction SilentlyContinue
    } else {
      try {
        Move-Item -LiteralPath $temporary -Destination $Directory
      } catch {
        if (-not (Test-SwfCacheEntry $Directory $Key $ArtifactName $reportName)) { throw }
      }
    }
  } finally {
    Remove-Item -LiteralPath $temporary -Recurse -Force -ErrorAction SilentlyContinue
  }
}

function Install-SwfArtifact {
  param(
    [Parameter(Mandatory)][string]$Source,
    [Parameter(Mandatory)][string]$Destination
  )
  $temporary = "$Destination.new"
  Copy-Item -LiteralPath $Source -Destination $temporary -Force
  Move-Item -LiteralPath $temporary -Destination $Destination -Force
}

function Invoke-External {
  param(
    [Parameter(Mandatory)][string]$FilePath,
    [string[]]$Arguments = @(),
    [string]$WorkingDirectory = ""
  )
  $previous = Get-Location
  try {
    if ($WorkingDirectory) { Set-Location -LiteralPath $WorkingDirectory }
    & $FilePath @Arguments
    if ($LASTEXITCODE -ne 0) {
      throw "$FilePath failed with exit code $LASTEXITCODE"
    }
  } finally {
    Set-Location $previous
  }
}

function Build-Server {
  param([Parameter(Mandatory)][string]$RepoRoot)
  $RepoRoot = Initialize-ProjectEnvironment $RepoRoot
  $serverDir = Join-Path $RepoRoot "server"
  $buildDir = Join-Path $RepoRoot "build"
  $candidate = Join-Path $buildDir "server.new.exe"
  $output = Join-Path $buildDir "server.exe"
  if (-not (Get-Command go.exe -ErrorAction SilentlyContinue)) { throw "go.exe was not found on PATH" }
  New-Item -ItemType Directory -Force -Path $buildDir | Out-Null
  Remove-Item -LiteralPath $candidate -Force -ErrorAction SilentlyContinue
  Invoke-External "go.exe" @("build", "-trimpath", "-buildvcs=false", "-o", $candidate, ".") $serverDir
  if (-not (Test-Path -LiteralPath $candidate)) { throw "Go build did not create $candidate" }
  Move-Item -LiteralPath $candidate -Destination $output -Force
  Write-Host "[OK] Server built: $output"
}

function Read-PatchManifest {
  param([Parameter(Mandatory)][string]$Path)
  Get-Content -LiteralPath $Path | ForEach-Object { $_.Trim() } |
    Where-Object { $_ -and -not $_.StartsWith("#") }
}

function Invoke-SwfBuildCore {
  param(
    [Parameter(Mandatory)][string]$RepoRoot,
    [switch]$NoCache
  )
  $cacheVersion = "swf-cache-v1"
  $RepoRoot = Initialize-ProjectEnvironment $RepoRoot
  $buildDir = Join-Path $RepoRoot "build"
  $baseline = Join-Path $RepoRoot "swf\baselines\1.26.2.1-BAT.game.swf"
  $hashFile = Join-Path $RepoRoot "config\build\swf-baseline.sha256"
  $scriptManifest = Join-Path $RepoRoot "config\build\swf-script-patches.txt"
  $binaryManifest = Join-Path $RepoRoot "config\build\swf-binary-patches.txt"
  $forbiddenManifest = Join-Path $RepoRoot "config\build\swf-forbidden-script-patches.txt"
  $sourceRoot = Join-Path $RepoRoot "decompiled\gamefile\scripts"
  $ffdec = Join-Path $RepoRoot "tools\packaging\ffdec\ffdec-cli.exe"
  $stage = Join-Path $buildDir "swf-minimal-stage"
  $candidate = Join-Path $buildDir "game.candidate.swf"
  $nextCandidate = Join-Path $buildDir "game.next.swf"
  $output = Join-Path $buildDir "game.swf"
  $verification = Join-Path $buildDir "verification"
  $checker = Join-Path $RepoRoot "scripts\check_pcode.js"
  $cacheRoot = Join-Path $buildDir "cache\swf"

  foreach ($required in @($baseline, $hashFile, $scriptManifest, $binaryManifest, $forbiddenManifest, $ffdec, $checker)) {
    if (-not (Test-Path -LiteralPath $required)) { throw "Missing build input: $required" }
  }
  if (-not (Get-Command node.exe -ErrorAction SilentlyContinue)) { throw "node.exe is required" }
  $expected = ((Get-Content -LiteralPath $hashFile -First 1) -split "\s+")[0]
  $actual = Get-Sha256 $baseline
  if ($actual -ne $expected) { throw "Immutable SWF baseline hash mismatch. Expected=$expected Actual=$actual" }

  $forbidden = @(Read-PatchManifest $forbiddenManifest)
  $scriptEntries = @(Read-PatchManifest $scriptManifest)
  $scriptInputs = @()
  foreach ($relative in $scriptEntries) {
    if ($relative.Contains("..") -or $relative.Contains(":")) { throw "Invalid script patch path: $relative" }
    if ($forbidden -contains $relative) { throw "Script must use BinaryData patching: $relative" }
    $source = Join-Path $sourceRoot $relative
    if (-not (Test-Path -LiteralPath $source)) { throw "Missing script patch: $relative" }
    $scriptInputs += "$relative|$(Get-Sha256 $source)"
  }

  $binaryEntries = @()
  foreach ($entry in @(Read-PatchManifest $binaryManifest)) {
    $parts = $entry -split "\|", 2
    if ($parts.Count -ne 2 -or $parts[0] -notmatch "^\d+$") { throw "Invalid BinaryData patch: $entry" }
    if ($parts[1].Contains("..") -or $parts[1].Contains(":")) { throw "Invalid BinaryData path: $($parts[1])" }
    $source = Join-Path $RepoRoot $parts[1]
    if (-not (Test-Path -LiteralPath $source)) { throw "Missing BinaryData patch: $($parts[1])" }
    $binaryEntries += [pscustomobject]@{
      Id = $parts[0]
      Path = $parts[1]
      Source = $source
      Hash = Get-Sha256 $source
    }
  }

  $asInputs = @(
    $cacheVersion
    "baseline|$actual"
    "baseline-declaration|$(Get-Sha256 $hashFile)"
    "ffdec|$(Get-Sha256 $ffdec)"
    "script-manifest|$(Get-Sha256 $scriptManifest)"
    "forbidden-manifest|$(Get-Sha256 $forbiddenManifest)"
  )
  foreach ($dependency in @("ffdec-cli.jar", "ffdec.jar")) {
    $dependencyPath = Join-Path (Split-Path $ffdec) $dependency
    if (Test-Path -LiteralPath $dependencyPath) {
      $asInputs += "$dependency|$(Get-Sha256 $dependencyPath)"
    }
  }
  $asKey = Get-SwfCacheKey ($asInputs + $scriptInputs)
  $binaryKeys = @()
  $previousKey = $asKey
  for ($index = 0; $index -lt $binaryEntries.Count; $index++) {
    $binaryEntry = $binaryEntries[$index]
    $previousKey = Get-SwfCacheKey @(
      $cacheVersion
      "previous|$previousKey"
      "index|$index"
      "id|$($binaryEntry.Id)"
      "path|$($binaryEntry.Path)"
      "content|$($binaryEntry.Hash)"
      "ffdec|$(Get-Sha256 $ffdec)"
    )
    $binaryKeys += $previousKey
  }
  $lastBuildKey = if ($binaryKeys.Count) { $binaryKeys[-1] } else { $asKey }
  $finalKey = Get-SwfCacheKey @(
    $cacheVersion
    "build|$lastBuildKey"
    "binary-manifest|$(Get-Sha256 $binaryManifest)"
    "checker|$(Get-Sha256 $checker)"
  )
  $finalCache = Join-Path $cacheRoot "final\$finalKey"
  if (-not $NoCache -and (Test-SwfCacheEntry $finalCache $finalKey "game.swf" "pcode-report.txt")) {
    $cachedReport = Join-Path $finalCache "pcode-report.txt"
    New-Item -ItemType Directory -Force -Path $verification | Out-Null
    Install-SwfArtifact (Join-Path $finalCache "game.swf") $output
    Copy-Item -LiteralPath $cachedReport -Destination (Join-Path $verification "pcode-report.txt") -Force
    Write-Host "[CACHE] SWF final hit: $finalKey"
    Write-Host "[OK] SWF built: AS imports=0 BinaryData replacements=0 SHA256=$(Get-Sha256 $output)"
    return
  }

  Write-Host "[CACHE] SWF final miss: $finalKey"
  Remove-Item -LiteralPath $stage, $candidate, $nextCandidate -Recurse -Force -ErrorAction SilentlyContinue
  $stagedVerification = Join-Path $stage "verification"
  $pcode = Join-Path $stagedVerification "pcode"
  New-Item -ItemType Directory -Force -Path (Join-Path $stage "scripts"), $pcode | Out-Null
  $asExecuted = 0
  $binaryExecuted = 0
  $resume = 0

  if (-not $NoCache) {
    for ($index = $binaryEntries.Count - 1; $index -ge 0; $index--) {
      $binaryCache = Join-Path $cacheRoot "binary\$($binaryKeys[$index])"
      if (Test-SwfCacheEntry $binaryCache $binaryKeys[$index] "candidate.swf") {
        Copy-Item -LiteralPath (Join-Path $binaryCache "candidate.swf") -Destination $candidate
        $resume = $index + 1
        break
      }
    }
  }

  if ($resume -gt 0) {
    Write-Host "[CACHE] SWF BinaryData resume $resume/$($binaryEntries.Count)"
  } else {
    $asCache = Join-Path $cacheRoot "as\$asKey"
    if (-not $NoCache -and (Test-SwfCacheEntry $asCache $asKey "candidate.swf")) {
      Copy-Item -LiteralPath (Join-Path $asCache "candidate.swf") -Destination $candidate
      Write-Host "[CACHE] SWF AS-stage hit: $asKey"
    } else {
      Copy-Item -LiteralPath $baseline -Destination $candidate -Force
      foreach ($relative in $scriptEntries) {
        $source = Join-Path $sourceRoot $relative
        $destination = Join-Path (Join-Path $stage "scripts") $relative
        New-Item -ItemType Directory -Force -Path (Split-Path $destination) | Out-Null
        Copy-Item -LiteralPath $source -Destination $destination -Force
      }
      if ($scriptEntries.Count -gt 0) {
        Invoke-External $ffdec @("-onerror", "abort", "-importScript", $candidate, $nextCandidate, (Join-Path $stage "scripts"))
        Remove-Item -LiteralPath $candidate -Force
        Move-Item -LiteralPath $nextCandidate -Destination $candidate -Force
        $asExecuted = 1
      }
      if (-not $NoCache) { Publish-SwfCacheEntry $asCache $asKey $candidate "candidate.swf" }
    }
  }

  for ($index = $resume; $index -lt $binaryEntries.Count; $index++) {
    $binaryEntry = $binaryEntries[$index]
    Invoke-External $ffdec @("-replace", $candidate, $nextCandidate, $binaryEntry.Id, $binaryEntry.Source)
    Remove-Item -LiteralPath $candidate -Force
    Move-Item -LiteralPath $nextCandidate -Destination $candidate -Force
    $binaryExecuted++
    if (-not $NoCache) {
      $binaryCache = Join-Path $cacheRoot "binary\$($binaryKeys[$index])"
      Publish-SwfCacheEntry $binaryCache $binaryKeys[$index] $candidate "candidate.swf"
    }
  }

  $exportLog = Join-Path $stagedVerification "pcode-export.log"
  & $ffdec -onerror abort -format script:pcodehex -selectclass Game -export script $pcode $candidate *> $exportLog
  if ($LASTEXITCODE -ne 0) { throw "Game P-code export failed; see $exportLog" }
  $report = Join-Path $stagedVerification "pcode-report.txt"
  & node.exe (Join-Path $RepoRoot "scripts\check_pcode.js") $pcode *> $report
  if ($LASTEXITCODE -ne 0) { Get-Content $report; throw "Automatic Game P-code verification failed" }

  Install-SwfArtifact $candidate $output
  New-Item -ItemType Directory -Force -Path $verification | Out-Null
  Install-SwfArtifact $report (Join-Path $verification "pcode-report.txt")
  Install-SwfArtifact $exportLog (Join-Path $verification "pcode-export.log")
  if (-not $NoCache) { Publish-SwfCacheEntry $finalCache $finalKey $output "game.swf" $report }
  Write-Host "[OK] SWF built: AS imports=$asExecuted BinaryData replacements=$binaryExecuted SHA256=$(Get-Sha256 $output)"
}

function Build-Swf {
  param(
    [Parameter(Mandatory)][string]$RepoRoot,
    [switch]$NoCache
  )
  $resolvedRoot = (Resolve-Path -LiteralPath $RepoRoot).Path
  $mutexName = "Local\MetalWarTale3-Swf-" + (Get-StringSha256 $resolvedRoot.ToLowerInvariant()).Substring(0, 24)
  $mutex = [Threading.Mutex]::new($false, $mutexName)
  $acquired = $false
  try {
    try {
      $acquired = $mutex.WaitOne(0)
      if (-not $acquired) {
        Write-Host "[BUILD] Waiting for another SWF build to finish..."
        $acquired = $mutex.WaitOne()
      }
    } catch [Threading.AbandonedMutexException] {
      $acquired = $true
    }
    Invoke-SwfBuildCore $resolvedRoot -NoCache:$NoCache
  } finally {
    if ($acquired) { $mutex.ReleaseMutex() }
    $mutex.Dispose()
  }
}

function Prepare-Runtime {
  param([Parameter(Mandatory)][string]$RepoRoot)
  $buildDir = Join-Path $RepoRoot "build"
  $manifest = Join-Path $RepoRoot "docs\baselines\1.26.2.1-BAT.sha256"
  $swfSource = Join-Path $RepoRoot "swf"
  $swfOutput = Join-Path $buildDir "swf"
  $runtimeStage = Join-Path $buildDir "runtime.new"
  $stageSwf = Join-Path $runtimeStage "swf"
  Remove-Item -LiteralPath $runtimeStage -Recurse -Force -ErrorAction SilentlyContinue
  New-Item -ItemType Directory -Force -Path $stageSwf, (Join-Path $RepoRoot "saves\backups") | Out-Null
  $count = 0
  foreach ($line in Get-Content -LiteralPath $manifest) {
    if ($line -notmatch "^([0-9a-fA-F]{64})\s+\*swf\\(.+)$") { continue }
    $source = Join-Path $swfSource (Split-Path $Matches[2] -Leaf)
    if (-not (Test-Path -LiteralPath $source)) { throw "Missing tracked runtime resource: $source" }
    if ((Get-Sha256 $source) -ne $Matches[1]) { throw "Runtime resource hash mismatch: $source" }
    $destination = Join-Path $stageSwf $Matches[2]
    New-Item -ItemType Directory -Force -Path (Split-Path $destination) | Out-Null
    Copy-Item -LiteralPath $source -Destination $destination -Force
    $count++
  }
  if ($count -ne 175) { throw "Expected 175 runtime resources, prepared $count" }
  Copy-Item (Join-Path $RepoRoot "config\build\resource-overrides\*") $stageSwf -Force
  Copy-Item -LiteralPath (Join-Path $RepoRoot "modifier.html") -Destination (Join-Path $runtimeStage "modifier.html") -Force
  Remove-Item -LiteralPath $swfOutput -Recurse -Force -ErrorAction SilentlyContinue
  Move-Item -LiteralPath $stageSwf -Destination $swfOutput
  Move-Item -LiteralPath (Join-Path $runtimeStage "modifier.html") -Destination (Join-Path $buildDir "modifier.html") -Force
  Remove-Item -LiteralPath $runtimeStage -Recurse -Force
  Write-Host "[OK] Runtime prepared: $count resources"
}

function Build-All {
  param(
    [Parameter(Mandatory)][string]$RepoRoot,
    [switch]$NoSwfCache
  )
  Build-Server $RepoRoot
  Build-Swf $RepoRoot -NoCache:$NoSwfCache
  Prepare-Runtime $RepoRoot
}

function Invoke-SourceBaselineAudit {
  param([Parameter(Mandatory)][string]$RepoRoot)
  $baseline = Join-Path $RepoRoot "swf\baselines\1.26.2.1-BAT.game.swf"
  $sourceRoot = Join-Path $RepoRoot "decompiled\gamefile\scripts"
  $ffdec = Join-Path $RepoRoot "tools\packaging\ffdec\ffdec-cli.exe"
  $auditRoot = Join-Path $RepoRoot "build\source-baseline-audit"
  $stage = Join-Path $auditRoot "stage"
  $result = Join-Path $auditRoot "results.tsv"
  Remove-Item $auditRoot -Recurse -Force -ErrorAction SilentlyContinue
  New-Item -ItemType Directory -Force -Path $auditRoot | Out-Null
  "status`tpath`toutput_sha256" | Set-Content -LiteralPath $result -Encoding utf8
  $baselineHash = Get-Sha256 $baseline
  $total = $exact = $different = $failed = 0
  foreach ($source in Get-ChildItem $sourceRoot -Recurse -Filter *.as) {
    $total++
    Remove-Item $stage -Recurse -Force -ErrorAction SilentlyContinue
    $relative = [IO.Path]::GetRelativePath($sourceRoot, $source.FullName)
    $destination = Join-Path $stage "scripts\$relative"
    New-Item -ItemType Directory -Force -Path (Split-Path $destination) | Out-Null
    Copy-Item $source.FullName $destination
    $candidate = Join-Path $stage "candidate.swf"
    & $ffdec -onerror abort -importScript $baseline $candidate (Join-Path $stage "scripts") *> (Join-Path $stage "ffdec.log")
    if ($LASTEXITCODE -ne 0 -or -not (Test-Path $candidate)) {
      $failed++
      "compile_failed`t$relative`t-" | Add-Content $result
    } else {
      $hash = Get-Sha256 $candidate
      if ($hash -eq $baselineHash) { $exact++; $status = "exact" } else { $different++; $status = "different" }
      "$status`t$relative`t$hash" | Add-Content $result
    }
  }
  Write-Host "[AUDIT] total=$total exact=$exact different=$different failed=$failed"
  if ($failed) { throw "Source baseline audit had $failed compile failures" }
}

Export-ModuleMember -Function Initialize-ProjectEnvironment, Get-Sha256, Invoke-External, Build-Server, Build-Swf, Prepare-Runtime, Build-All, Invoke-SourceBaselineAudit
