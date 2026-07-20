$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $Root
$PlayerCandidates = @(
  (Join-Path $Root "flashplayer_sa_debug.exe"),
  (Join-Path $Root "FlashPlayer.exe"),
  "D:\superalloy\flashplayer_32_sa_debug.exe",
  (Join-Path $Root "..\tools\debug\flashplayer_sa_debug.exe")
)
$Player = $PlayerCandidates | Where-Object { Test-Path $_ } | Select-Object -First 1
if (-not $Player) { throw "Flash player not found" }
$Server = Join-Path $Root "server.exe"
if (-not (Test-Path $Server)) { throw "server.exe missing" }
if (-not (Test-Path (Join-Path $Root "game.swf"))) { throw "game.swf missing" }
New-Item -ItemType Directory -Force -Path (Join-Path $Root "saves") | Out-Null
function Test-PortFree([int]$Port) {
  try { $l = [System.Net.Sockets.TcpListener]::new([System.Net.IPAddress]::Loopback, $Port); $l.Start(); $l.Stop(); return $true } catch { return $false }
}
$port = 8765
if (-not (Test-PortFree $port)) { for ($p=8766; $p -le 8799; $p++) { if (Test-PortFree $p) { $port = $p; break } } }
$psi = New-Object System.Diagnostics.ProcessStartInfo
$psi.FileName = $Server
$psi.Arguments = "--root `"$Root`" --port $port"
$psi.WorkingDirectory = $Root
$psi.UseShellExecute = $false
$serverProc = [System.Diagnostics.Process]::Start($psi)
try {
  $ok = $false
  for ($i=0; $i -lt 50; $i++) {
    Start-Sleep -Milliseconds 200
    try { $r = Invoke-WebRequest -Uri "http://127.0.0.1:$port/api/status" -UseBasicParsing -TimeoutSec 1; if ($r.StatusCode -eq 200) { $ok = $true; break } } catch {}
  }
  if (-not $ok) { throw "local server failed on $port" }
  Write-Host "Server ready on $port"
  $playerProc = Start-Process -FilePath $Player -ArgumentList @("http://127.0.0.1:$port/game.swf") -PassThru -WorkingDirectory $Root
  Wait-Process -Id $playerProc.Id
} finally {
  if ($serverProc -and -not $serverProc.HasExited) { Stop-Process -Id $serverProc.Id -Force -ErrorAction SilentlyContinue }
}
