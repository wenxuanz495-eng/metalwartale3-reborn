$module = Join-Path $PSScriptRoot "..\lib\Release.psm1"
Import-Module $module -Force

function New-TestRelease {
  param([Parameter(Mandatory)][string]$Path)

  $directories = @(
    "build\swf",
    "scripts\runtime",
    "tools\runtime",
    "saves\backups"
  )
  foreach ($directory in $directories) {
    New-Item -ItemType Directory -Force -Path (Join-Path $Path $directory) | Out-Null
  }

  $files = @(
    "build\.release-ready",
    "build\game.swf",
    "build\server.exe",
    "build\modifier.html",
    "build\公告.txt",
    "modifier.html",
    "scripts\runtime\launch_game.bat",
    "scripts\runtime\launch_modifier.bat",
    "scripts\runtime\run.bat",
    "scripts\runtime\tools.bat",
    "tools\runtime\flashplayer_sa.exe",
    "版本信息.txt",
    "启动游戏.bat",
    "启动修改器.bat",
    "工具.bat"
  )
  foreach ($file in $files) {
    New-Item -ItemType File -Force -Path (Join-Path $Path $file) | Out-Null
  }
}

Describe "Test-ReleaseFolder" {
  It "accepts the clean player layout" {
    $release = Join-Path $TestDrive "clean"
    New-TestRelease $release
    { Test-ReleaseFolder $release } | Should Not Throw
  }

  It "rejects any file in root saves" {
    $release = Join-Path $TestDrive "save-file"
    New-TestRelease $release
    New-Item -ItemType File -Path (Join-Path $release "saves\unexpected.dat") | Out-Null
    try { Test-ReleaseFolder $release; $threw = $false } catch { $threw = $true }
    $threw | Should Be $true
  }

  It "rejects a Debug Player regardless of its directory" {
    $release = Join-Path $TestDrive "debug-player"
    New-TestRelease $release
    New-Item -ItemType File -Path (Join-Path $release "flashplayer_sa_debug.exe") | Out-Null
    try { Test-ReleaseFolder $release; $threw = $false } catch { $threw = $true }
    $threw | Should Be $true
  }

  It "rejects the obsolete build saves directory" {
    $release = Join-Path $TestDrive "build-saves"
    New-TestRelease $release
    New-Item -ItemType Directory -Path (Join-Path $release "build\saves") | Out-Null
    try { Test-ReleaseFolder $release; $threw = $false } catch { $threw = $true }
    $threw | Should Be $true
  }
}
