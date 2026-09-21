@echo off
setlocal EnableExtensions

rem Native chain (2b) launcher: dev.ps1 native must have produced build\native artifacts first.
rem Reuses launch_game.bat server/save/player machinery with ENTRY_PATH=loader.swf.
rem Player type: arg 1 = sa (default) / sa_debug.

set "REPO_ROOT=%~dp0.."
for %%I in ("%REPO_ROOT%") do set "REPO_ROOT=%%~fI"

if not exist "%REPO_ROOT%\build\patch.swf" goto missing_native
if not exist "%REPO_ROOT%\build\loader.swf" goto missing_native
if not exist "%REPO_ROOT%\build\game-baseline.swf" goto missing_native

set "ENTRY_PATH=loader.swf"
call "%REPO_ROOT%\scripts\launch_game.bat" %~1
exit /b %ERRORLEVEL%

:missing_native
echo [ERROR] Native chain artifacts missing. Run first:
echo   powershell -NoProfile -ExecutionPolicy Bypass -File scripts\dev.ps1 native
exit /b 1
