@echo off
setlocal EnableExtensions
cd /d "%~dp0"
set "BACKUP_DIR=%~dp0build\saves\backups"
if not exist "%BACKUP_DIR%" mkdir "%BACKUP_DIR%"
start "" explorer.exe "%BACKUP_DIR%"
exit /b 0
