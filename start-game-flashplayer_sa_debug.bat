@echo off
cd /d "%~dp0"
echo ========================================
echo Launch game
echo Player: flashplayer_sa_debug.exe (DEBUG)
echo Type  : sa_debug
echo ========================================
if not exist "build\server.exe" (
  echo [ERROR] build\server.exe missing.
  echo Please run build.bat first.
  pause
  exit /b 1
)
if not exist "build\game.swf" (
  echo [ERROR] build\game.swf missing.
  echo Please run build.bat first.
  pause
  exit /b 1
)
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0scripts\run_dev.ps1" -PlayerType sa_debug
if errorlevel 1 pause
