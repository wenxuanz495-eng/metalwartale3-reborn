param(
  [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
)

$ErrorActionPreference = "Stop"
Write-Host "build_and_deploy.ps1 scaffold"
Write-Host "Repo:" $RepoRoot
Write-Host ""
Write-Host "TODO: wire FFDec importScript + copy into runtime\"
Write-Host "1) compile decompiled/gamefile/scripts into game.swf"
Write-Host "2) deploy resources to runtime\"
Write-Host "3) optionally build server.exe"
Write-Host "This scaffold intentionally does not compile yet."
exit 0
