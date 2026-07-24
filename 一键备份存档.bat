@echo off
setlocal EnableExtensions EnableDelayedExpansion
cd /d "%~dp0"

set "SAVE=build\saves\game_save.bin"
set "BACKUPS=build\saves\backups"

if not exist "!SAVE!" (
  echo [ERROR] Save not found: !SAVE!
  echo Start the game and create a save first.
  pause
  exit /b 1
)

if not exist "!BACKUPS!" mkdir "!BACKUPS!"
set "BACKUP_NAME=game_save.manual-!RANDOM!-!RANDOM!.bin"
copy /y "!SAVE!" "!BACKUPS!\!BACKUP_NAME!" >nul
if errorlevel 1 (
  echo [ERROR] Backup failed.
  pause
  exit /b 2
)

echo Backup created: !BACKUP_NAME!
start "" explorer.exe "!BACKUPS!"
pause
exit /b 0
