@echo off
setlocal
set "GAME_DIR=%~dp0"
powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "$root=$env:GAME_DIR; $src=Join-Path $root 'saves\game_save.bin'; $dst=Join-Path $root 'saves\backups'; New-Item -ItemType Directory -Force -Path $dst | Out-Null; if(-not (Test-Path -LiteralPath $src)){Add-Type -AssemblyName PresentationFramework; [System.Windows.MessageBox]::Show('没有找到 saves\game_save.bin，请先进入游戏并创建存档。','备份失败') | Out-Null; exit 1}; $name='game_save.manual-'+(Get-Date -Format 'yyyyMMdd-HHmmss')+'.bin'; Copy-Item -LiteralPath $src -Destination (Join-Path $dst $name) -Force; Add-Type -AssemblyName PresentationFramework; [System.Windows.MessageBox]::Show(('备份成功：'+$name),'存档备份') | Out-Null; Start-Process explorer.exe -ArgumentList $dst"
endlocal
