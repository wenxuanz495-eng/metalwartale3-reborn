param(
  [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path,
  [string]$BaselineSwf = ""
)
$ErrorActionPreference = "Stop"

$ffdecDir = Join-Path $RepoRoot "tools\packaging\ffdec"
$ffdecExe = Join-Path $ffdecDir "ffdec-cli.exe"
$ffdecJar = Join-Path $ffdecDir "ffdec-cli.jar"
$scriptsDir = Join-Path $RepoRoot "decompiled\gamefile\scripts"
$outDir = Join-Path $RepoRoot "build"
New-Item -ItemType Directory -Force -Path $outDir | Out-Null
$out = Join-Path $outDir "game.swf"
$log = Join-Path $outDir "ffdec-build.log"
$err = Join-Path $outDir "ffdec-build.err"

if (-not (Test-Path $scriptsDir)) { throw "missing scripts: $scriptsDir" }
if (-not ((Test-Path $ffdecExe) -or (Test-Path $ffdecJar))) {
  throw "ffdec-cli missing under: $ffdecDir"
}

if (-not $BaselineSwf) {
  $candidates = @(
    (Join-Path $RepoRoot "build\game.import.swf"),
    (Join-Path $RepoRoot "runtime\game.swf"),
    "D:\superalloy\超合金离线优化海豹版1.2.2（内测）\game.swf",
    "D:\superalloy\超合金离线优化海豹版1.2\game.swf",
    (Join-Path $RepoRoot "swf\gamefile.swf")
  )
  foreach ($c in $candidates) {
    if (Test-Path $c) { $BaselineSwf = $c; break }
  }
}
if (-not (Test-Path $BaselineSwf)) { throw "baseline SWF not found" }

# Isolate FFDec config/home so sandbox or locked %APPDATA% cannot NPE on flashlib.
$ffdecHomeRoot = Join-Path $RepoRoot "build\ffdec-home"
$appData = Join-Path $ffdecHomeRoot "AppData\Roaming"
$localAppData = Join-Path $ffdecHomeRoot "AppData\Local"
$ffdecHome = Join-Path $appData "JPEXS\FFDec"
$flashlib = Join-Path $ffdecHome "flashlib"
New-Item -ItemType Directory -Force -Path $ffdecHomeRoot, $appData, $localAppData, $flashlib | Out-Null
$srcFlashlib = Join-Path $ffdecDir "flashlib"
if (Test-Path $srcFlashlib) {
  Copy-Item (Join-Path $srcFlashlib "*") $flashlib -Force -ErrorAction SilentlyContinue
}

$env:APPDATA = $appData
$env:LOCALAPPDATA = $localAppData
$env:USERPROFILE = $ffdecHomeRoot
$env:HOMEDRIVE = ([System.IO.Path]::GetPathRoot($ffdecHomeRoot)).TrimEnd('\')
$env:HOMEPATH = $ffdecHomeRoot.Substring($env:HOMEDRIVE.Length)

Write-Host "Baseline: $BaselineSwf"
Write-Host "Scripts : $scriptsDir"
Write-Host "Output  : $out"
Write-Host "FFDec APPDATA: $env:APPDATA"
if (Test-Path $out) { Remove-Item $out -Force }

$java = $null
foreach ($candidate in @(
  "C:\Program Files\Eclipse Adoptium\jdk-25.0.3.9-hotspot\bin\java.exe",
  "C:\Program Files\Eclipse Adoptium\jdk-21\bin\java.exe",
  "C:\Program Files\Java\jdk-21\bin\java.exe",
  "C:\Program Files\Java\bin\java.exe"
)) {
  if (Test-Path $candidate) { $java = $candidate; break }
}
if (-not $java) {
  $cmd = Get-Command java -ErrorAction SilentlyContinue
  if ($cmd) { $java = $cmd.Source }
}

Push-Location $ffdecDir
try {
  if ($java -and (Test-Path $ffdecJar)) {
    Write-Host "Using java: $java"
    $argList = @(
      "-Duser.home=$ffdecHomeRoot",
      "-Djava.util.Arrays.useLegacyMergeSort=true",
      "-Djna.nosys=true",
      "-Xmx1024m",
      "-jar", $ffdecJar,
      "-onerror", "abort",
      "-importScript", $BaselineSwf, $out, $scriptsDir
    )
    & $java @argList 1> $log 2> $err
    $exitCode = $LASTEXITCODE
  } else {
    Write-Host "Using ffdec-cli.exe"
    & $ffdecExe -onerror abort -importScript $BaselineSwf $out $scriptsDir 1> $log 2> $err
    $exitCode = $LASTEXITCODE
  }
} finally {
  Pop-Location
}

if ($exitCode -ne 0 -or -not (Test-Path $out)) {
  if (Test-Path $log) { Get-Content $log -Tail 40 }
  if (Test-Path $err) { Get-Content $err -Tail 40 }
  throw "ffdec build failed, exit=$exitCode"
}

Write-Host "OK $out"
Write-Host ("SHA256=" + (Get-FileHash $out -Algorithm SHA256).Hash)
Write-Host ("Size=" + (Get-Item $out).Length)
