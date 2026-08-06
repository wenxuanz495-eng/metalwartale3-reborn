$ErrorActionPreference = "Stop"

$root = [System.IO.Path]::GetFullPath((Split-Path -Parent $MyInvocation.MyCommand.Path)).TrimEnd("\")
$serverPath = Join-Path $root "server.exe"
$playerPath = Join-Path $root "FlashPlayer.exe"
$gamePath = Join-Path $root "game.swf"
$resourcePath = Join-Path $root "swf"
$saveRoot = Join-Path $root "saves"
$savePath = Join-Path $saveRoot "game_save.bin"
$nestedOldSave = Join-Path $saveRoot "saves\game_save.bin"
$singularOldSave = Join-Path $root "save\game_save.bin"
$emptyTemplate = Join-Path $resourcePath "empty-save-template.bin"
$hostName = "127.0.0.1"
$serverProcess = $null
$gameUrl = $null

function Stop-RootServers([string]$gameRoot) {
  $rootFull = [System.IO.Path]::GetFullPath($gameRoot).TrimEnd("\")
  $killed = 0
  Get-Process -Name "server", "modifier-engine" -ErrorAction SilentlyContinue | ForEach-Object {
    $exe = ""
    try { $exe = [string]$_.Path } catch {}
    if ($exe -and $exe.StartsWith($rootFull, [System.StringComparison]::OrdinalIgnoreCase)) {
      try {
        Stop-Process -Id $_.Id -Force -ErrorAction Stop
        $script:killed++
        Write-Host ("已清理后台进程 PID={0} {1}" -f $_.Id, $_.ProcessName)
      } catch {}
    }
  }
  return $killed
}

function Stop-RootPlayers([string]$gameRoot, [string]$urlHint) {
  $rootFull = [System.IO.Path]::GetFullPath($gameRoot).TrimEnd("\")
  Get-Process -ErrorAction SilentlyContinue | Where-Object {
    $_.ProcessName -match '^(FlashPlayer|flashplayer.*)$'
  } | ForEach-Object {
    $exe = ""
    try { $exe = [string]$_.Path } catch {}
    if ($exe -and $exe.StartsWith($rootFull, [System.StringComparison]::OrdinalIgnoreCase)) {
      try {
        Stop-Process -Id $_.Id -Force -ErrorAction Stop
        Write-Host ("已清理播放器残留 PID={0}" -f $_.Id)
      } catch {}
    }
  }
}

function Wait-GameWindow([System.Diagnostics.Process]$process) {
  $windowSeen = $false
  $missingRounds = 0
  $startupRounds = 0
  while (-not $process.HasExited) {
    try { $process.Refresh() } catch { break }
    if ($process.MainWindowHandle -ne 0) {
      $windowSeen = $true
      $missingRounds = 0
    }
    elseif ($windowSeen) {
      $missingRounds++
      if ($missingRounds -ge 8) { break }
    }
    else {
      $startupRounds++
      if ($startupRounds -ge 120) {
        throw "Flash 播放器进程已启动，但 30 秒内没有创建游戏窗口。"
      }
    }
    Start-Sleep -Milliseconds 250
  }
  if (-not $process.HasExited) {
    Stop-Process -Id $process.Id -Force -ErrorAction SilentlyContinue
    try { [void]$process.WaitForExit(3000) } catch {}
  }
}

function Test-PortFree([int]$port) {
  try {
    $listener = [System.Net.Sockets.TcpListener]::new([System.Net.IPAddress]::Loopback, $port)
    $listener.Start()
    $listener.Stop()
    return $true
  } catch {
    return $false
  }
}

foreach ($required in @($serverPath, $playerPath, $gamePath, $resourcePath)) {
  if (-not (Test-Path -LiteralPath $required)) { throw "Required game file is missing: $required" }
}

New-Item -ItemType Directory -Path $saveRoot -Force | Out-Null
if ((Test-Path -LiteralPath $singularOldSave -PathType Leaf) -and
    ((-not (Test-Path -LiteralPath $savePath -PathType Leaf)) -or ((Get-Item -LiteralPath $savePath).Length -le 39))) {
  Copy-Item -LiteralPath $singularOldSave -Destination $savePath -Force
}
elseif (-not (Test-Path -LiteralPath $savePath -PathType Leaf)) {
  if (Test-Path -LiteralPath $nestedOldSave -PathType Leaf) {
    Copy-Item -LiteralPath $nestedOldSave -Destination $savePath -Force
  }
  elseif (Test-Path -LiteralPath $emptyTemplate -PathType Leaf) {
    Copy-Item -LiteralPath $emptyTemplate -Destination $savePath -Force
  }
}

# Ensure no leftover server/modifier engine from previous run.
[void](Stop-RootServers -gameRoot $root)
Start-Sleep -Milliseconds 200

$port = $null
foreach ($candidate in 52100..52140) {
  if (Test-PortFree $candidate) { $port = $candidate; break }
}
if ($null -eq $port) { throw "No free local game port was found." }

$statusUrl = "http://${hostName}:${port}/api/status"
$gameUrl = "http://${hostName}:${port}/game.swf"
try {
  Write-Host "Starting local save service..."
  Write-Host "Root : $root"
  Write-Host "Saves: $savePath"
  Write-Host "Port : $port"
  Write-Host "关闭游戏后，本黑窗口会自动退出并清理后台进程。"

  $serverProcess = Start-Process -FilePath $serverPath `
    -ArgumentList @("--host", $hostName, "--port", "$port", "--root", $root) `
    -WorkingDirectory $root -WindowStyle Hidden -PassThru

  $ready = $false
  foreach ($attempt in 1..40) {
    Start-Sleep -Milliseconds 250
    if ($serverProcess.HasExited) { throw "The local save process exited unexpectedly." }
    try {
      $status = Invoke-RestMethod -Uri $statusUrl -TimeoutSec 1
      if ($status.backend -eq "go") {
        $actual = [System.IO.Path]::GetFullPath([string]$status.saves_dir).TrimEnd("\")
        $expect = [System.IO.Path]::GetFullPath($saveRoot).TrimEnd("\")
        if ([string]::Compare($actual, $expect, $true) -eq 0) {
          $ready = $true
          break
        }
      }
    } catch {}
  }
  if (-not $ready) { throw "The local save process did not become ready." }

  try {
    $gs = Invoke-WebRequest -Uri ("http://{0}:{1}/api/game-save" -f $hostName, $port) -UseBasicParsing -TimeoutSec 2
    Write-Host ("game-save preflight: HTTP {0}" -f $gs.StatusCode)
  } catch {
    $msg = [string]$_.Exception.Message
    if ($msg -match "404") {
      Write-Host "game-save preflight: empty (404) - will create on first successful in-game save"
    } else {
      Write-Host "game-save preflight warning: $msg"
    }
  }

  Write-Host "Starting the offline game. Saves are stored only in: $savePath"
  Write-Host "Please keep this window open until you quit the game."
  $player = Start-Process -FilePath $playerPath -ArgumentList @($gameUrl) -WorkingDirectory $root -PassThru
  if ($player) {
    Wait-GameWindow -process $player
  }
}
finally {
  Write-Host "游戏已关闭，正在清理后台..."
  if ($null -ne $serverProcess -and -not $serverProcess.HasExited) {
    try {
      Stop-Process -Id $serverProcess.Id -Force -ErrorAction SilentlyContinue
      [void]$serverProcess.WaitForExit(3000)
    } catch {}
  }
  Stop-RootPlayers -gameRoot $root -urlHint $gameUrl
  [void](Stop-RootServers -gameRoot $root)
  Start-Sleep -Milliseconds 200
  [void](Stop-RootServers -gameRoot $root)
  Write-Host "清理完成，窗口即将关闭。"
}
