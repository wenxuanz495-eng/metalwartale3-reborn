param(
  [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path,
  [string]$BaselineSwf = ""
)
$ErrorActionPreference = "Stop"
$ffdec = Join-Path $RepoRoot "tools\packaging\ffdec\ffdec-cli.exe"
$scriptsDir = Join-Path $RepoRoot "decompiled\gamefile\scripts"
$outDir = Join-Path $RepoRoot "build"
New-Item -ItemType Directory -Force -Path $outDir | Out-Null
$out = Join-Path $outDir "game.swf"
$log = Join-Path $outDir "ffdec-build.log"
$err = Join-Path $outDir "ffdec-build.err"
if (-not (Test-Path $ffdec)) { throw "ffdec-cli missing: $ffdec" }
if (-not (Test-Path $scriptsDir)) { throw "missing scripts: $scriptsDir" }
if (-not $BaselineSwf) {
  $candidates = @(
    "D:\superalloy\超合金离线优化海豹版1.2\game.swf",
    (Join-Path $RepoRoot "swf\gamefile.swf")
  )
  foreach ($c in $candidates) { if (Test-Path $c) { $BaselineSwf = $c; break } }
}
if (-not (Test-Path $BaselineSwf)) { throw "baseline SWF not found" }
Write-Host "Baseline: $BaselineSwf"
Write-Host "Scripts : $scriptsDir"
Write-Host "Output  : $out"
if (Test-Path $out) { Remove-Item $out -Force }
$p = Start-Process -FilePath $ffdec -ArgumentList @("-onerror","abort","-importScript",$BaselineSwf,$out,$scriptsDir) -NoNewWindow -PassThru -Wait -RedirectStandardOutput $log -RedirectStandardError $err
if ($p.ExitCode -ne 0 -or -not (Test-Path $out)) {
  if (Test-Path $log) { Get-Content $log -Tail 40 }
  if (Test-Path $err) { Get-Content $err -Tail 40 }
  throw "ffdec build failed, exit=$($p.ExitCode)"
}
Write-Host "OK $out"
Write-Host ("SHA256=" + (Get-FileHash $out -Algorithm SHA256).Hash)
Write-Host ("Size=" + (Get-Item $out).Length)
