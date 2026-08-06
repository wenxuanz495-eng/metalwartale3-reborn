@echo off
setlocal EnableExtensions

set "DEV_BGM_DIR="
for /d %%D in ("%~dp0..\*") do if exist "%%~fD\.playlist-root" if not defined DEV_BGM_DIR set "DEV_BGM_DIR=%%~fD"

if not defined DEV_BGM_DIR goto missing_source
set "DEV_LIBRARY_DIR="
for /d %%D in ("%DEV_BGM_DIR%\*") do if exist "%%~fD\developer-playlists.json" if not defined DEV_LIBRARY_DIR set "DEV_LIBRARY_DIR=%%~fD"
if not defined DEV_LIBRARY_DIR goto missing_library
if /i "%~1"=="--check" (
  echo [OK] Developer BGM library: %DEV_LIBRARY_DIR%
  exit /b 0
)
start "" explorer.exe "%DEV_LIBRARY_DIR%"
exit /b 0

:missing_source
echo [ERROR] Developer BGM source folder was not found next to the repository.
echo Expected marker: .playlist-root
pause
exit /b 1

:missing_library
echo [ERROR] Unified developer BGM library was not found.
echo Expected file: developer-playlists.json
pause
exit /b 2
