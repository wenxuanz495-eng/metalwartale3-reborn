@echo off
chcp 65001 >nul
setlocal
cd /d "%~dp0"
echo [1.2.3] Launching modifier...
echo Keep this window open while using the modifier.
echo Close the modifier window to auto-close this CMD and clean background processes.
echo Script dir: %CD%
powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -File "%~dp0editor-launch.ps1"
set ERR=%ERRORLEVEL%
if not "%ERR%"=="0" (
  echo.
  echo Editor launch failed. Error=%ERR%
  echo If root not found, ensure these files exist here:
  echo   game.swf
  echo   swf\
  echo   modifier-engine.exe or server.exe
  echo   modifier.html
  pause
  exit /b %ERR%
)
exit 0