param(
  [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path,
  [int]$Port = 8766
)
$ErrorActionPreference = "Stop"
. (Join-Path $PSScriptRoot "go_env.ps1")

function Stop-RootServers([string]$rootPath, [string]$serverExePath) {
  $rootFull = [System.IO.Path]::GetFullPath($rootPath).TrimEnd('\')
  $exeFull = $null
  if ($serverExePath -and (Test-Path -LiteralPath $serverExePath)) {
    $exeFull = [System.IO.Path]::GetFullPath($serverExePath)
  }
  Get-CimInstance Win32_Process -ErrorAction SilentlyContinue | Where-Object {
    $_.Name -eq 'server.exe' -and $_.CommandLine
  } | ForEach-Object {
    $cmd = [string]$_.CommandLine
    $matchRoot = $cmd.Contains($rootFull)
    $matchExe = $false
    if ($exeFull) { $matchExe = $cmd.Contains($exeFull) }
    if ($matchRoot -or $matchExe) {
      try {
        Stop-Process -Id $_.ProcessId -Force -ErrorAction Stop
        Write-Host ("Cleaned leftover server PID={0}" -f $_.ProcessId)
      } catch {}
    }
  }
}


$buildDir = Join-Path $RepoRoot "build"
$serverExe = Join-Path $buildDir "server.exe"
$gameSwf = Join-Path $buildDir "game.swf"
$savesDir = Join-Path $buildDir "saves"
$modSrc = Join-Path $RepoRoot "runtime\modifier.html"
$modDst = Join-Path $buildDir "modifier.html"
$browserProfile = Join-Path $env:TEMP ("superalloy-modifier-profile-" + [guid]::NewGuid().ToString("N"))

if (-not (Test-Path $serverExe)) { throw "missing $serverExe`nPlease run build first: .\build.bat" }
if (-not (Test-Path $gameSwf)) { throw "missing $gameSwf`nPlease run build first: .\build.bat" }
if (-not (Test-Path $modSrc)) { throw "missing modifier page: $modSrc" }

New-Item -ItemType Directory -Force -Path $savesDir, $browserProfile | Out-Null
Copy-Item $modSrc $modDst -Force

function Test-PortFree([int]$Port) {
  try {
    $l = [System.Net.Sockets.TcpListener]::new([System.Net.IPAddress]::Loopback, $Port)
    $l.Start(); $l.Stop(); return $true
  } catch { return $false }
}
if (-not (Test-PortFree $Port)) {
  for ($p = $Port + 1; $p -le ($Port + 40); $p++) {
    if (Test-PortFree $p) { $Port = $p; break }
  }
}

function Resolve-Browser {
  $candidates = @(
    "$env:ProgramFiles\Microsoft\Edge\Application\msedge.exe",
    "${env:ProgramFiles(x86)}\Microsoft\Edge\Application\msedge.exe",
    "$env:ProgramFiles\Google\Chrome\Application\chrome.exe",
    "${env:ProgramFiles(x86)}\Google\Chrome\Application\chrome.exe"
  )
  foreach ($c in $candidates) {
    if ($c -and (Test-Path -LiteralPath $c)) { return $c }
  }
  return $null
}

Write-Host "========================================"
Write-Host "Launch modifier"
Write-Host "Page   : /modifier.html"
Write-Host "Saves  : $savesDir"
Write-Host "Server : $serverExe"
Write-Host "Port   : $Port"
Write-Host "========================================"
Write-Host "Tip: fully exit the game before saving with modifier."
Write-Host "Close the modifier window to stop server and auto-close this console."

Stop-RootServers -rootPath $buildDir -serverExePath $serverExe
Start-Sleep -Milliseconds 200

$psi = New-Object System.Diagnostics.ProcessStartInfo
$psi.FileName = $serverExe
$psi.Arguments = "--root `"$buildDir`" --port $Port"
$psi.WorkingDirectory = $buildDir
$psi.UseShellExecute = $false
$serverProc = [System.Diagnostics.Process]::Start($psi)
$browserProc = $null
try {
  $ok = $false
  for ($i = 0; $i -lt 60; $i++) {
    Start-Sleep -Milliseconds 200
    try {
      $r = Invoke-WebRequest -Uri "http://127.0.0.1:$Port/api/status" -UseBasicParsing -TimeoutSec 1
      if ($r.StatusCode -eq 200) { $ok = $true; break }
    } catch {}
  }
  if (-not $ok) { throw "modifier server failed to start on port $Port" }

  $url = "http://127.0.0.1:$Port/modifier.html"
  try {
    Invoke-WebRequest $url -UseBasicParsing -TimeoutSec 2 | Out-Null
  } catch {
    $url = "http://127.0.0.1:$Port/editor"
    Write-Host "modifier.html unavailable, fallback to $url"
  }

  $browser = Resolve-Browser
  if ($browser) {
    Write-Host "Browser  : $browser"
    Write-Host "Open     : $url"
    $args = @(
      "--user-data-dir=$browserProfile",
      "--no-first-run",
      "--no-default-browser-check",
      "--new-window",
      "--app=$url"
    )
    $browserProc = Start-Process -FilePath $browser -ArgumentList $args -PassThru
    if ($browserProc) { Wait-Process -Id $browserProc.Id }

    # Follow only browser processes of this dedicated profile.
    $waitRounds = 0
    while ($waitRounds -lt 1200) {
      $alive = Get-CimInstance Win32_Process -Filter "Name='msedge.exe' OR Name='chrome.exe'" -ErrorAction SilentlyContinue |
        Where-Object { $_.CommandLine -and $_.CommandLine.Contains($browserProfile) }
      if (-not $alive) { break }
      Start-Sleep -Milliseconds 500
      $waitRounds++
    }
  } else {
    Write-Host "Open     : $url"
    Write-Host "No Edge/Chrome found. Opened with default browser."
    Write-Host "If the console does not auto-close, press Enter after finishing."
    Start-Process $url
    [void][System.Console]::ReadLine()
  }
}
finally {
  if ($browserProc -and -not $browserProc.HasExited) {
    Stop-Process -Id $browserProc.Id -Force -ErrorAction SilentlyContinue
  }
  if ($serverProc -and -not $serverProc.HasExited) {
    Stop-Process -Id $serverProc.Id -Force -ErrorAction SilentlyContinue
  }
  # Hard clean leftovers bound to this build root.
  Stop-RootServers -rootPath $buildDir -serverExePath $serverExe
  if (Test-Path -LiteralPath $browserProfile) {
    Remove-Item -LiteralPath $browserProfile -Recurse -Force -ErrorAction SilentlyContinue
  }
}
