@echo off
chcp 65001 >nul
cd /d "%~dp0"
set "DEST=%~dp0build\saves"
if not exist "%DEST%" mkdir "%DEST%"

echo ========================================
echo Import save into correct directory
echo Target: %DEST%
echo Authoritative file: game_save.bin
echo ========================================
echo.
echo Usage:
echo 1. Drag a saves folder OR game_save.bin onto this bat
echo 2. Or run this bat and paste a full path
echo.

set "SRC=%~1"
if "%SRC%"=="" (
  set /p SRC=Input source path (folder or game_save.bin): 
)

if "%SRC%"=="" (
  echo [ERROR] No source path.
  pause
  exit /b 1
)

if not exist "%SRC%" (
  echo [ERROR] Source not found:
  echo %SRC%
  pause
  exit /b 1
)

REM backup existing
for /f %%i in ('powershell -NoProfile -Command "Get-Date -Format yyyyMMdd-HHmmss"') do set "TS=%%i"
if exist "%DEST%\game_save.bin" (
  if not exist "%DEST%\backups" mkdir "%DEST%\backups"
  copy /Y "%DEST%\game_save.bin" "%DEST%\backups\game_save-before-import-%TS%.bin" >nul
  echo Backed up existing game_save.bin
)

REM if source is folder, use its game_save.bin
set "SRCFILE=%SRC%"
if exist "%SRC%\game_save.bin" set "SRCFILE=%SRC%\game_save.bin"
if exist "%SRC%\saves\game_save.bin" set "SRCFILE=%SRC%\saves\game_save.bin"

if /I not "%SRCFILE:~-4%"==".bin" (
  if not exist "%SRCFILE%" (
    echo [ERROR] game_save.bin not found in source.
    echo Source was: %SRC%
    pause
    exit /b 1
  )
)

copy /Y "%SRCFILE%" "%DEST%\game_save.bin" >nul
if errorlevel 1 (
  echo [ERROR] Copy failed.
  pause
  exit /b 1
)

echo.
echo Import OK.
echo Now: %DEST%\game_save.bin
echo.
echo Next: start game with one of the launch scripts.
explorer "%DEST%"
pause
