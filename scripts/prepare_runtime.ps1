param(
  [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path,
  [string]$SealDir = "D:\superalloy\超合金离线优化海豹版1.2"
)
$ErrorActionPreference = "Stop"
$rt = Join-Path $RepoRoot "runtime"
$srcSwf = Join-Path $RepoRoot "swf"
if (-not (Test-Path $srcSwf)) { throw "repo swf missing" }
New-Item -ItemType Directory -Force -Path (Join-Path $rt "swf") | Out-Null
Write-Host "Copying resources from repo swf -> runtime/swf"
robocopy $srcSwf (Join-Path $rt "swf") /E /NFL /NDL /NJH /NJS /nc /ns /np | Out-Null
$baseSrc = Join-Path $SealDir "game.swf"
if (Test-Path $baseSrc) {
  Copy-Item $baseSrc (Join-Path $rt "game.base.swf") -Force
  Write-Host " baselined game.base.swf from seal 1.2"
}
$serverSrc = Join-Path $SealDir "server.exe"
if ((-not (Test-Path (Join-Path $rt "server.exe"))) -and (Test-Path $serverSrc)) {
  Copy-Item $serverSrc (Join-Path $rt "server.exe") -Force
}
Write-Host "Runtime resources prepared. Next: .\\scripts\\build_and_deploy.ps1"
