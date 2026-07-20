param(
  [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
)
$ErrorActionPreference = "Stop"
Write-Host "==== Build server ===="
& (Join-Path $PSScriptRoot "build_server.ps1") -RepoRoot $RepoRoot
Write-Host "==== Build SWF ===="
& (Join-Path $PSScriptRoot "build_swf.ps1") -RepoRoot $RepoRoot
Write-Host "==== Build done ===="
Write-Host "Next: run .\启动游戏.bat  (launch only, no rebuild)"
