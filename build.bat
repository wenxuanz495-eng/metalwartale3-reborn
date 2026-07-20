@echo off
cd /d "%~dp0"
echo [BUILD] server + game.swf
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0scripts\build_all.ps1"
if errorlevel 1 (
  echo BUILD FAILED
  pause
  exit /b 1
)
echo.
echo BUILD OK. Now you can double-click start-game.bat
pause
