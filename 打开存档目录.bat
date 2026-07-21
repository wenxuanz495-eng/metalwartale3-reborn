@echo off
cd /d "%~dp0"
set "SAVES=%~dp0build\saves"
if not exist "%SAVES%" mkdir "%SAVES%"
echo ========================================
echo Save directory (authoritative):
echo %SAVES%
echo Main file: game_save.bin
echo ========================================
echo.
echo Tip:
echo 1. Fully exit the game/modifier first
echo 2. Backup current game_save.bin before replace
echo 3. Copy your game_save.bin into this folder
echo.
explorer "%SAVES%"
pause
