@echo off
chcp 65001 >nul
setlocal
cd /d "%~dp0"
echo [1.2.3] Launching game...
echo Keep this window open while playing.
echo Close the game window to auto-close this CMD and clean background processes.
powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -File "%~dp0launch.ps1"
set ERR=%ERRORLEVEL%
if not "%ERR%"=="0" (
  echo.
  echo Launch failed. Error=%ERR%
  pause
  exit /b %ERR%
)
exit 0