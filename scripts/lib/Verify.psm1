Set-StrictMode -Version Latest

function Invoke-Checked {
  param([Parameter(Mandatory)][scriptblock]$Command, [Parameter(Mandatory)][string]$Label)
  Write-Host "==== $Label ===="
  & $Command
  if ($LASTEXITCODE -ne 0) { throw "$Label failed with exit code $LASTEXITCODE" }
}

function Test-Quick {
  param([Parameter(Mandatory)][string]$RepoRoot)
  Invoke-Checked { node.exe --test (Join-Path $RepoRoot "scripts\tests\check_pcode.test.js") } "P-code checker tests"
  Invoke-Checked { powershell.exe -NoProfile -File (Join-Path $RepoRoot "scripts\tests\swf_cache.test.ps1") } "SWF cache tests"
  Build-All $RepoRoot
  Push-Location (Join-Path $RepoRoot "server")
  try { Invoke-Checked { go.exe test ./... } "Go tests" } finally { Pop-Location }
  Invoke-Checked { node.exe (Join-Path $RepoRoot "scripts\check_modifier.js") (Join-Path $RepoRoot "modifier.html") } "Modifier source"
  Invoke-Checked { node.exe (Join-Path $RepoRoot "scripts\check_modifier.js") (Join-Path $RepoRoot "build\modifier.html") } "Modifier build"
  $runtime = Join-Path $RepoRoot "scripts\runtime\run.bat"
  Invoke-Checked { & $env:ComSpec /d /c call $runtime "check-game" } "Game entry"
  Invoke-Checked { & $env:ComSpec /d /c call $runtime "check-debug" } "Debug entry"
  Invoke-Checked { & $env:ComSpec /d /c call $runtime "check-modifier" } "Modifier entry"
  Write-Host "[OK] Quick verification passed."
}

function Test-ReproducibleSwf {
  param([Parameter(Mandatory)][string]$RepoRoot)
  $root = Join-Path $RepoRoot "build\reproducibility-check"
  $first = Join-Path $root "game-first.swf"
  $second = Join-Path $root "game-second.swf"
  $binary = Join-Path $root "binary-data"
  Remove-Item -LiteralPath $root -Recurse -Force -ErrorAction SilentlyContinue
  New-Item -ItemType Directory -Force -Path $root | Out-Null
  Build-Swf $RepoRoot -NoCache
  Copy-Item (Join-Path $RepoRoot "build\game.swf") $first
  Build-Swf $RepoRoot -NoCache
  Copy-Item (Join-Path $RepoRoot "build\game.swf") $second
  if ((Get-Sha256 $first) -ne (Get-Sha256 $second)) { throw "Two SWF builds are not byte-identical" }

  $ffdec = Join-Path $RepoRoot "tools\packaging\ffdec\ffdec-cli.exe"
  New-Item -ItemType Directory -Force -Path $binary | Out-Null
  & $ffdec -onerror abort -export binaryData $binary $second | Out-Null
  if ($LASTEXITCODE -ne 0) { throw "BinaryData export failed" }
  $sources = Get-ChildItem (Join-Path $RepoRoot "decompiled\embedded-xml-assets") -Filter *.bin
  if ($sources.Count -ne 21) { throw "Expected 21 embedded XML sources" }
  foreach ($source in $sources) {
    $exported = Join-Path $binary $source.Name
    if (-not (Test-Path $exported) -or (Get-Sha256 $source.FullName) -ne (Get-Sha256 $exported)) {
      throw "Embedded BinaryData differs from source: $($source.Name)"
    }
  }
  Write-Host "[OK] Reproducible SWF and 21 BinaryData assets verified."
}

function Test-Full {
  param([Parameter(Mandatory)][string]$RepoRoot)
  Test-Quick $RepoRoot
  Test-ReproducibleSwf $RepoRoot
  $runtime = Join-Path $RepoRoot "scripts\runtime\run.bat"
  Invoke-Checked { & $env:ComSpec /d /c call $runtime "smoke-game" } "Game smoke"
  Invoke-Checked { & $env:ComSpec /d /c call $runtime "smoke-modifier" } "Modifier smoke"
  Write-Host "[OK] Full verification passed."
}

function Test-Release {
  param([Parameter(Mandatory)][string]$RepoRoot)
  Test-Full $RepoRoot
  Push-Location (Join-Path $RepoRoot "server")
  try { Invoke-Checked { go.exe test -count=1 ./... } "Uncached save regressions" } finally { Pop-Location }
  Write-Host "[OK] Release verification passed."
}

Export-ModuleMember -Function Test-Quick, Test-Full, Test-Release, Test-ReproducibleSwf
