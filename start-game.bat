@echo off
cd /d "%~dp0"
if not exist "runtime\launch.ps1" (
  echo [ERROR] runtime\launch.ps1 not found.
  echo Run scripts\prepare_runtime.ps1 and scripts\build_and_deploy.ps1 first.
  pause
  exit /b 1
)
if not exist "runtime\game.swf" (
  echo [ERROR] runtime\game.swf not found.
  echo Run scripts\prepare_runtime.ps1 and scripts\build_and_deploy.ps1 first.
  pause
  exit /b 1
)
if not exist "runtime\server.exe" (
  echo [ERROR] runtime\server.exe not found.
  echo Copy server.exe into runtime or build it from server\.
  pause
  exit /b 1
)
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0runtime\launch.ps1"
if errorlevel 1 pause
