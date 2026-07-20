@echo off
setlocal
cd /d "%~dp0"

echo This will permanently delete all saves in:
echo %~dp0saves
echo.
choice /C YN /N /M "Continue? [Y/N]: "
if errorlevel 2 exit /b 0

powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -File "clear-saves.ps1"
if errorlevel 1 (
  echo.
  echo Clear failed. Close the game and try again.
  pause
  exit /b 1
)

echo.
echo All saves have been cleared.
echo Start the game to create a new save.
pause

