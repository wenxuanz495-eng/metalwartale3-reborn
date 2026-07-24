Set-StrictMode -Version Latest

function Test-ReleaseFolder {
  param([Parameter(Mandatory)][string]$Path)
  foreach ($required in @("build\.release-ready", "build\game.swf", "build\server.exe", "build\modifier.html", "build\公告.txt", "build\swf", "modifier.html", "scripts\runtime\run.bat", "scripts\runtime\launch_game.bat", "scripts\runtime\launch_modifier.bat", "scripts\runtime\tools.bat", "tools\runtime\flashplayer_sa.exe", "版本信息.txt", "saves", "saves\backups", "启动游戏.bat", "启动修改器.bat", "工具.bat")) {
    if (-not (Test-Path -LiteralPath (Join-Path $Path $required))) {
      throw "Release is missing: $required"
    }
  }
  if (Test-Path -LiteralPath (Join-Path $Path "build\saves")) { throw "Release contains obsolete build\saves" }
  if (Test-Path -LiteralPath (Join-Path $Path "tools\debug")) { throw "Release contains development-only tools\debug" }
  $saveFiles = @(Get-ChildItem -LiteralPath (Join-Path $Path "saves") -Recurse -File -Force)
  if ($saveFiles.Count) { throw "Release root saves directory must be empty: $($saveFiles.FullName -join ', ')" }
  $bad = Get-ChildItem -LiteralPath $Path -Recurse -File -Force | Where-Object {
    $_.Name -in @("game_save.bin", "game_save.last-good.bin", "saves.db", "yagao.json") -or
    $_.Name -match "(?i)flashplayer.*debug|debug.*flashplayer" -or
    $_.Extension -in @(".sol", ".log", ".tmp", ".bak") -or
    $_.FullName -match "[\\/]saves[\\/]backups[\\/].+"
  }
  if ($bad) { throw "Release contains forbidden runtime files: $($bad.FullName -join ', ')" }
  Write-Host "[OK] Release checked: $((Get-ChildItem $Path -Recurse -File).Count) files"
}

function New-PlayerRelease {
  param(
    [Parameter(Mandatory)][string]$RepoRoot,
    [Parameter(Mandatory)][ValidateNotNullOrEmpty()][string]$Version
  )
  if ($Version -ne [IO.Path]::GetFileName($Version) -or $Version.IndexOfAny([IO.Path]::GetInvalidFileNameChars()) -ge 0) {
    throw "Version must be a single valid directory name"
  }
  Test-Release $RepoRoot
  $releaseRoot = Join-Path $RepoRoot "release"
  $target = Join-Path $releaseRoot $Version
  if (Test-Path -LiteralPath $target) { throw "Release target already exists: $target" }
  $player = Join-Path $RepoRoot "tools\runtime\flashplayer_sa.exe"
  if (-not (Test-Path -LiteralPath $player -PathType Leaf)) { throw "Tracked Flash Player is missing: $player" }

  New-Item -ItemType Directory -Force -Path $releaseRoot | Out-Null
  $release = Join-Path $releaseRoot (".staging-$Version-" + [guid]::NewGuid().ToString("N"))
  try {
    New-Item -ItemType Directory -Force -Path `
      (Join-Path $release "build"), `
      (Join-Path $release "saves\backups"), `
      (Join-Path $release "scripts\runtime"), `
      (Join-Path $release "tools\runtime") | Out-Null
    Copy-Item (Join-Path $RepoRoot "build\swf") (Join-Path $release "build\swf") -Recurse
    foreach ($file in @("game.swf", "server.exe", "modifier.html", "公告.txt")) {
      $source = Join-Path $RepoRoot "build\$file"
      if (-not (Test-Path -LiteralPath $source -PathType Leaf)) { throw "Missing release input: $source" }
      Copy-Item $source (Join-Path $release "build\$file")
    }
    New-Item -ItemType File -Path (Join-Path $release "build\.release-ready") | Out-Null
    Copy-Item (Join-Path $RepoRoot "modifier.html") (Join-Path $release "modifier.html")
    Copy-Item $player (Join-Path $release "tools\runtime\flashplayer_sa.exe")
    $playerItem = Get-Item -LiteralPath $player
    @(
      "Flash Player file: tools\runtime\flashplayer_sa.exe"
      "Flash Player version: $($playerItem.VersionInfo.FileVersion)"
      "Flash Player SHA256: $((Get-FileHash -LiteralPath $player -Algorithm SHA256).Hash)"
    ) | Set-Content -LiteralPath (Join-Path $release "版本信息.txt") -Encoding utf8
    Copy-Item (Join-Path $RepoRoot "scripts\runtime\*.bat") (Join-Path $release "scripts\runtime")
    foreach ($file in @("启动游戏.bat", "启动修改器.bat", "工具.bat")) {
      Copy-Item (Join-Path $RepoRoot $file) (Join-Path $release $file)
    }
    Test-ReleaseFolder $release
    Move-Item -LiteralPath $release -Destination $target
  } finally {
    if (Test-Path -LiteralPath $release) { Remove-Item -LiteralPath $release -Recurse -Force }
  }
  Write-Host "[OK] Release created: $target"
}

Export-ModuleMember -Function Test-ReleaseFolder, New-PlayerRelease
