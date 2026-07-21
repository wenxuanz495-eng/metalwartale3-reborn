@echo off
setlocal
set "BACKUP_DIR=%~dp0saves\backups"
if not exist "%BACKUP_DIR%" mkdir "%BACKUP_DIR%"
start "" explorer.exe "%BACKUP_DIR%"
endlocal
