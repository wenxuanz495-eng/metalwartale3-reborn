$ErrorActionPreference = "Stop"

# IMPORTANT: resolve script directory at top-level (not inside a function).
$scriptDir = $null
if ($PSScriptRoot) {
  $scriptDir = [System.IO.Path]::GetFullPath($PSScriptRoot).TrimEnd("\")
} elseif ($MyInvocation.MyCommand.Path) {
  $scriptDir = [System.IO.Path]::GetFullPath((Split-Path -Parent $MyInvocation.MyCommand.Path)).TrimEnd("\")
} else {
  $scriptDir = [System.IO.Path]::GetFullPath((Get-Location).Path).TrimEnd("\")
}

function Stop-RootServers([string]$gameRoot) {
  $rootFull = [System.IO.Path]::GetFullPath($gameRoot).TrimEnd("\")
  $killed = 0
  Get-CimInstance Win32_Process -ErrorAction SilentlyContinue | Where-Object {
    $_.Name -match '^(server|modifier-engine)\.exe$' -and $_.CommandLine
  } | ForEach-Object {
    $cmd = [string]$_.CommandLine
    $exe = ""
    try { $exe = [string]$_.ExecutablePath } catch {}
    $hit = $cmd.Contains($rootFull) -or ($exe -and $exe.StartsWith($rootFull, [System.StringComparison]::OrdinalIgnoreCase))
    if ($hit) {
      try {
        Stop-Process -Id $_.ProcessId -Force -ErrorAction Stop
        $script:killed++
        Write-Host ("已清理后台进程 PID={0} {1}" -f $_.ProcessId, $_.Name)
      } catch {}
    }
  }
  return $killed
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

function Wait-ApiReady([string]$statusUrl, [string]$expectedSaves, [System.Diagnostics.Process]$proc, [int]$tries = 60) {
  $expected = [System.IO.Path]::GetFullPath($expectedSaves).TrimEnd("\")
  for ($i = 1; $i -le $tries; $i++) {
    Start-Sleep -Milliseconds 200
    if ($proc -and $proc.HasExited) {
      throw ("修改器引擎意外退出，退出代码：{0}" -f $proc.ExitCode)
    }
    try {
      $status = Invoke-RestMethod -Uri $statusUrl -TimeoutSec 1
      if ($status.backend -ne "go") { continue }
      $actual = [System.IO.Path]::GetFullPath([string]$status.saves_dir).TrimEnd("\")
      if ([string]::Compare($actual, $expected, $true) -eq 0) {
        return $true
      }
    } catch {}
  }
  return $false
}

function Resolve-GameRoot([string]$startDir) {
  $candidates = @(
    $startDir,
    (Split-Path -Parent $startDir),
    (Split-Path -Parent (Split-Path -Parent $startDir))
  ) | Where-Object { $_ -and (Test-Path -LiteralPath $_ -PathType Container) } | Select-Object -Unique

  $checked = @()
  foreach ($candidate in $candidates) {
    $full = [System.IO.Path]::GetFullPath($candidate).TrimEnd("\")
    $hasGame = Test-Path -LiteralPath (Join-Path $full "game.swf") -PathType Leaf
    $hasSwfDir = Test-Path -LiteralPath (Join-Path $full "swf") -PathType Container
    $hasEngine = (Test-Path -LiteralPath (Join-Path $full "modifier-engine.exe") -PathType Leaf) -or (Test-Path -LiteralPath (Join-Path $full "server.exe") -PathType Leaf)
    $checked += ("- {0} | game.swf={1} swf/={2} engine={3}" -f $full, $hasGame, $hasSwfDir, $hasEngine)
    if ($hasGame -and ($hasSwfDir -or $hasEngine)) {
      return $full
    }
  }
  $msg = "找不到游戏根目录。请把修改器放回游戏文件夹后重试。`n脚本目录: {0}`n已检查:`n{1}" -f $startDir, ($checked -join "`n")
  throw $msg
}

Write-Host "脚本目录: $scriptDir"
$root = Resolve-GameRoot -startDir $scriptDir
Write-Host "游戏根目录: $root"

$enginePath = @(
  (Join-Path $root "modifier-engine.exe"),
  (Join-Path $root "server.exe"),
  (Join-Path $scriptDir "modifier-engine.exe"),
  (Join-Path $scriptDir "server.exe")
) | Where-Object { Test-Path -LiteralPath $_ -PathType Leaf } | Select-Object -First 1

$modifierPath = Join-Path $root "modifier.html"
if (-not (Test-Path -LiteralPath $modifierPath -PathType Leaf)) {
  $alt = Join-Path $scriptDir "modifier.html"
  if (Test-Path -LiteralPath $alt -PathType Leaf) {
    Copy-Item -LiteralPath $alt -Destination $modifierPath -Force
  }
}

if (-not $enginePath) { throw "找不到 modifier-engine.exe / server.exe。当前根目录: $root" }
if (-not (Test-Path -LiteralPath $modifierPath -PathType Leaf)) { throw "找不到 modifier.html。当前根目录: $root" }

$saveRoot = Join-Path $root "saves"
$savePath = Join-Path $saveRoot "game_save.bin"
$backupDir = Join-Path $saveRoot "backups"
New-Item -ItemType Directory -Path $saveRoot -Force | Out-Null

$legacySaves = @(
  (Join-Path $root "save\game_save.bin"),
  (Join-Path $root "saves\saves\game_save.bin"),
  (Join-Path $root "game_save.bin")
)
$canonicalIsEmpty = (-not (Test-Path -LiteralPath $savePath -PathType Leaf)) -or ((Get-Item -LiteralPath $savePath).Length -le 39)
if ($canonicalIsEmpty) {
  $legacySave = $legacySaves | Where-Object {
    (Test-Path -LiteralPath $_ -PathType Leaf) -and ((Get-Item -LiteralPath $_).Length -gt 39)
  } | Select-Object -First 1
  if ($legacySave) {
    Copy-Item -LiteralPath $legacySave -Destination $savePath -Force
    Write-Host "已导入旧路径存档: $legacySave"
  }
}

$hasRealSave = (Test-Path -LiteralPath $savePath -PathType Leaf) -and ((Get-Item -LiteralPath $savePath).Length -gt 39)
if ($hasRealSave) {
  New-Item -ItemType Directory -Path $backupDir -Force | Out-Null
  $stamp = Get-Date -Format "yyyyMMdd-HHmmss-fff"
  $backupPath = Join-Path $backupDir ("{0}-before-modifier.bin" -f $stamp)
  Copy-Item -LiteralPath $savePath -Destination $backupPath -Force
  Write-Host "已备份当前存档: $backupPath"
} else {
  Write-Host "提示: 当前还没有有效存档。可先进入游戏创建角色；修改器仍可打开。"
}

[void](Stop-RootServers -gameRoot $root)
Start-Sleep -Milliseconds 250

$hostName = "127.0.0.1"
$port = $null
foreach ($candidatePort in 8766..8796) {
  if (Test-PortFree $candidatePort) { $port = $candidatePort; break }
}
if ($null -eq $port) { throw "没有可用的本地修改器端口，请关闭旧修改器后重试。" }

$statusUrl = "http://${hostName}:${port}/api/status"
$engineProcess = $null
$browserProfile = $null
$browserProcess = $null
$modifierUrl = $null

try {
  Write-Host "启动修改器引擎: $enginePath"
  Write-Host "存档目录    : $saveRoot"
  Write-Host "端口        : $port"

  $engineProcess = Start-Process -FilePath $enginePath `
    -ArgumentList @("--host", $hostName, "--port", "$port", "--root", $root) `
    -WorkingDirectory $root -WindowStyle Hidden -PassThru

  if (-not (Wait-ApiReady -statusUrl $statusUrl -expectedSaves $saveRoot -proc $engineProcess)) {
    throw "修改器未能在限定时间内启动。请确认杀软没有拦截 server/modifier-engine。"
  }

  foreach ($path in @("/modifier.html", "/editor")) {
    try {
      $probe = Invoke-WebRequest -Uri ("http://{0}:{1}{2}" -f $hostName, $port, $path) -UseBasicParsing -TimeoutSec 2
      if ($probe.StatusCode -ge 200 -and $probe.StatusCode -lt 400) {
        $modifierUrl = "http://${hostName}:${port}${path}"
        break
      }
    } catch {}
  }
  if (-not $modifierUrl) { $modifierUrl = "http://${hostName}:${port}/modifier.html" }

  try {
    $dataProbe = Invoke-WebRequest -Uri ("http://{0}:{1}/api/editor/data" -f $hostName, $port) -UseBasicParsing -TimeoutSec 3
    if ($dataProbe.StatusCode -lt 200 -or $dataProbe.StatusCode -ge 400) {
      Write-Host "警告: /api/editor/data 返回 $($dataProbe.StatusCode)，页面可能无法加载存档。"
    } else {
      Write-Host "预检通过: /api/editor/data"
    }
  } catch {
    Write-Host "警告: /api/editor/data 预检失败：$($_.Exception.Message)"
  }

  $edgePath = @(
    "$env:ProgramFiles\Microsoft\Edge\Application\msedge.exe",
    "${env:ProgramFiles(x86)}\Microsoft\Edge\Application\msedge.exe",
    "$env:ProgramFiles\Google\Chrome\Application\chrome.exe",
    "${env:ProgramFiles(x86)}\Google\Chrome\Application\chrome.exe"
  ) | Where-Object { $_ -and (Test-Path -LiteralPath $_) } | Select-Object -First 1

  Write-Host "修改器页面: $modifierUrl"
  Write-Host "权威存档  : $savePath"
  Write-Host "修改器服务已就绪。"
  Write-Host "重要：请保持此黑窗口不要关闭，否则页面会 Failed to fetch。"
  Write-Host "关闭修改器窗口后，本窗口会自动退出并清理后台进程。"

  if ($edgePath) {
    $browserProfile = Join-Path ([System.IO.Path]::GetTempPath()) ("superalloy-modifier-" + [guid]::NewGuid().ToString("N"))
    New-Item -ItemType Directory -Path $browserProfile -Force | Out-Null
    $browserProcess = Start-Process -FilePath $edgePath `
      -ArgumentList @("--app=$modifierUrl", "--user-data-dir=$browserProfile", "--no-first-run", "--disable-background-mode", "--new-window") `
      -PassThru
    if ($browserProcess) {
      try { Wait-Process -Id $browserProcess.Id } catch {}
    }

    # Edge may hand the app window to a child using the same profile.
    $waitRounds = 0
    while ($waitRounds -lt 1200) {
      $alive = Get-CimInstance Win32_Process -Filter "Name='msedge.exe' OR Name='chrome.exe'" -ErrorAction SilentlyContinue |
        Where-Object { $_.CommandLine -and $_.CommandLine.Contains($browserProfile) }
      if (-not $alive) { break }
      Start-Sleep -Milliseconds 500
      $waitRounds++
    }
  } else {
    Write-Host "未找到 Edge/Chrome，使用默认浏览器打开。请关闭浏览器标签后回到此窗口按 Enter。"
    Start-Process $modifierUrl
    [void][System.Console]::ReadLine()
  }
}
finally {
  Write-Host "修改器已关闭，正在清理后台..."
  if ($null -ne $engineProcess -and -not $engineProcess.HasExited) {
    try {
      Stop-Process -Id $engineProcess.Id -Force -ErrorAction SilentlyContinue
      $engineProcess.WaitForExit()
    } catch {}
  }
  [void](Stop-RootServers -gameRoot $root)
  Start-Sleep -Milliseconds 200
  [void](Stop-RootServers -gameRoot $root)

  if ($browserProfile) {
    $resolvedProfile = [System.IO.Path]::GetFullPath($browserProfile)
    $resolvedTemp = [System.IO.Path]::GetFullPath([System.IO.Path]::GetTempPath())
    if ($resolvedProfile.StartsWith($resolvedTemp) -and (Split-Path -Leaf $resolvedProfile).StartsWith("superalloy-modifier-") -and (Test-Path -LiteralPath $resolvedProfile)) {
      Remove-Item -LiteralPath $resolvedProfile -Recurse -Force -ErrorAction SilentlyContinue
    }
  }
  Write-Host "清理完成，窗口即将关闭。"
}