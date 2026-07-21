@echo off
cd /d "%~dp0"
echo ========================================
echo Launch modifier
echo Page : /modifier.html
echo Saves: build\saves\game_save.bin
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
if not exist "runtime\modifier.html" (
  echo [ERROR] runtime\modifier.html missing.
  pause
  exit /b 1
)
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0scripts\run_modifier.ps1"
if errorlevel 1 pause
