$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $Root
$Server = Join-Path $Root "server.exe"
if (-not (Test-Path $Server)) { throw "server.exe missing" }
function Test-PortFree([int]$Port) {
  try { $l = [System.Net.Sockets.TcpListener]::new([System.Net.IPAddress]::Loopback, $Port); $l.Start(); $l.Stop(); return $true } catch { return $false }
}
$port = 8766
if (-not (Test-PortFree $port)) { for ($p=8767; $p -le 8799; $p++) { if (Test-PortFree $p) { $port = $p; break } } }
$psi = New-Object System.Diagnostics.ProcessStartInfo
$psi.FileName = $Server
$psi.Arguments = "--root `"$Root`" --port $port"
$psi.WorkingDirectory = $Root
$psi.UseShellExecute = $false
$serverProc = [System.Diagnostics.Process]::Start($psi)
try {
  $ok=$false
  for ($i=0;$i -lt 50;$i++){ Start-Sleep -Milliseconds 200; try { $r=Invoke-WebRequest "http://127.0.0.1:$port/api/status" -UseBasicParsing -TimeoutSec 1; if($r.StatusCode -eq 200){$ok=$true;break} } catch {} }
  if(-not $ok){ throw "editor server failed" }
  $url = "http://127.0.0.1:$port/modifier.html"
  try { Invoke-WebRequest $url -UseBasicParsing -TimeoutSec 1 | Out-Null } catch { $url = "http://127.0.0.1:$port/editor" }
  Start-Process $url
  Write-Host "Editor: $url"
  Write-Host "Press Enter to stop server..."
  [void][System.Console]::ReadLine()
} finally {
  if ($serverProc -and -not $serverProc.HasExited) { Stop-Process -Id $serverProc.Id -Force -ErrorAction SilentlyContinue }
}
