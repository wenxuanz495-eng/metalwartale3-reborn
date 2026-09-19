param(
  [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
)
$ErrorActionPreference = "Stop"
$ffdec = Join-Path $RepoRoot "tools\packaging\ffdec\ffdec-cli.exe"
$rt = Join-Path $RepoRoot "runtime"
$scripts = Join-Path $RepoRoot "decompiled\gamefile\scripts"
$base = Join-Path $rt "game.base.swf"
$out = Join-Path $rt "game.build.swf"
$final = Join-Path $rt "game.swf"
if (-not (Test-Path $ffdec)) { throw "ffdec-cli missing: $ffdec" }
if (-not (Test-Path $base)) { throw "missing runtime/game.base.swf" }
if (-not (Test-Path $scripts)) { throw "missing decompiled scripts" }
Write-Host "Building $out"
& $ffdec -onerror abort -importScript $base $out $scripts
if ($LASTEXITCODE -ne 0) { throw "ffdec failed: $LASTEXITCODE" }
if (-not (Test-Path $out)) { throw "no output swf" }
Copy-Item $out $final -Force
Write-Host "Deployed $final"
Write-Host ("SHA256=" + (Get-FileHash $final -Algorithm SHA256).Hash)
