param(
  [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path,
  [int]$Port = 8766
)
$ErrorActionPreference = "Stop"
. (Join-Path $PSScriptRoot "go_env.ps1")

$buildDir = Join-Path $RepoRoot "build"
$serverExe = Join-Path $buildDir "server.exe"
$gameSwf = Join-Path $buildDir "game.swf"
$savesDir = Join-Path $buildDir "saves"
$modSrc = Join-Path $RepoRoot "runtime\modifier.html"
$modDst = Join-Path $buildDir "modifier.html"

if (-not (Test-Path $serverExe)) {
  throw "missing $serverExe`nPlease run build first: .\构建.bat"
}
if (-not (Test-Path $gameSwf)) {
  throw "missing $gameSwf`nPlease run build first: .\构建.bat"
}
if (-not (Test-Path $modSrc)) {
  throw "missing modifier page: $modSrc"
}

New-Item -ItemType Directory -Force -Path $savesDir | Out-Null
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

Write-Host "========================================"
Write-Host "Launch modifier"
Write-Host "Page   : /modifier.html"
Write-Host "Saves  : $savesDir"
Write-Host "Server : $serverExe"
Write-Host "Port   : $Port"
Write-Host "========================================"
Write-Host "Tip: fully exit the game before saving with modifier."

$psi = New-Object System.Diagnostics.ProcessStartInfo
$psi.FileName = $serverExe
$psi.Arguments = "--root `"$buildDir`" --port $Port"
$psi.WorkingDirectory = $buildDir
$psi.UseShellExecute = $false
$serverProc = [System.Diagnostics.Process]::Start($psi)
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

  Write-Host "Open: $url"
  Start-Process $url
  Write-Host ""
  Write-Host "Modifier opened. Close this window after you finish; server will stop."
  Write-Host "Press Enter to stop the local server..."
  [void][System.Console]::ReadLine()
}
finally {
  if ($serverProc -and -not $serverProc.HasExited) {
    Stop-Process -Id $serverProc.Id -Force -ErrorAction SilentlyContinue
  }
}
