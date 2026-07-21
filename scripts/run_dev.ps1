param(
  [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path,
  [int]$Port = 8765,
  [switch]$Build,
  [switch]$SkipBuild,
  [ValidateSet("sa", "sa_debug", "release")]
  [string]$PlayerType = "sa_debug",
  [string]$PlayerPath = ""
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
$swfDir = Join-Path $RepoRoot "swf"
$sealDir = "D:\superalloy\超合金离线优化海豹版1.2"
$sealSwf = Join-Path $sealDir "swf"
if (Test-Path (Join-Path $sealSwf "ui")) {
  $swfDir = $sealSwf
  Write-Host "Using seal resource layout: $swfDir"
} else {
  Write-Host "Using repo resource layout: $swfDir"
}
$serverExe = Join-Path $buildDir "server.exe"
$gameSwf = Join-Path $buildDir "game.swf"
$saves = Join-Path $buildDir "saves"

function Resolve-PlayerPath([string]$type, [string]$explicit) {
  if ($explicit -and (Test-Path -LiteralPath $explicit)) {
    return (Resolve-Path -LiteralPath $explicit).Path
  }
  $candidates = @()
  switch ($type) {
    "sa" {
      $candidates = @(
        (Join-Path $RepoRoot "tools\debug\flashplayer_sa.exe"),
        "D:\superalloy\flashplayer_sa.exe"
      )
    }
    "sa_debug" {
      $candidates = @(
        (Join-Path $RepoRoot "tools\debug\flashplayer_sa_debug.exe"),
        "D:\superalloy\flashplayer_32_sa_debug.exe",
        "D:\superalloy\flashplayer_sa_debug.exe"
      )
    }
    "release" {
      $candidates = @(
        (Join-Path $sealDir "FlashPlayer.exe"),
        (Join-Path $RepoRoot "tools\debug\FlashPlayer.exe"),
        "D:\superalloy\FlashPlayer.exe"
      )
    }
  }
  foreach ($c in $candidates) {
    if ($c -and (Test-Path -LiteralPath $c)) {
      return (Resolve-Path -LiteralPath $c).Path
    }
  }
  throw "Flash player not found for type=$type. Checked: $($candidates -join ' | ')"
}

if ($Build -and -not $SkipBuild) {
  & (Join-Path $PSScriptRoot "build_server.ps1") -RepoRoot $RepoRoot
  & (Join-Path $PSScriptRoot "build_swf.ps1") -RepoRoot $RepoRoot
}

if (-not (Test-Path $serverExe)) {
  throw "missing $serverExe`nPlease run build first: .\构建.bat or .\scripts\build_all.ps1"
}
if (-not (Test-Path $gameSwf)) {
  throw "missing $gameSwf`nPlease run build first: .\构建.bat or .\scripts\build_all.ps1"
}
if (-not (Test-Path $swfDir)) { throw "missing resource dir: $swfDir" }

$player = Resolve-PlayerPath -type $PlayerType -explicit $PlayerPath
Write-Host "PlayerType : $PlayerType"
Write-Host "Player     : $player"

New-Item -ItemType Directory -Force -Path $saves | Out-Null
$buildSwf = Join-Path $buildDir "swf"
New-Item -ItemType Directory -Force -Path $buildSwf | Out-Null
Write-Host "Syncing resources to build\swf ..."
robocopy $swfDir $buildSwf /E /XO /NFL /NDL /NJH /NJS /nc /ns /np | Out-Null

$modSrc = Join-Path $RepoRoot "runtime\modifier.html"
if (Test-Path $modSrc) { Copy-Item $modSrc (Join-Path $buildDir "modifier.html") -Force }
$notice = Join-Path $RepoRoot "runtime\公告.txt"
if (Test-Path $notice) { Copy-Item $notice (Join-Path $buildDir "公告.txt") -Force }

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

Write-Host "Starting self-built server on $Port"
Write-Host "Static root: $buildDir"
Write-Host "Saves      : $saves"

Stop-RootServers -rootPath $buildDir -serverExePath $serverExe
Start-Sleep -Milliseconds 200

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
  if (-not $ok) { throw "self-built server failed to start" }
  Write-Host "Server OK: http://127.0.0.1:$Port/game.swf"
  $playerProc = Start-Process -FilePath $player -ArgumentList @("http://127.0.0.1:$Port/game.swf") -PassThru -WorkingDirectory $buildDir
  Wait-Process -Id $playerProc.Id
}
finally {
  if ($serverProc -and -not $serverProc.HasExited) {
    Stop-Process -Id $serverProc.Id -Force -ErrorAction SilentlyContinue
  }
  # Hard clean leftovers bound to this build root.
  Stop-RootServers -rootPath $buildDir -serverExePath $serverExe
}
