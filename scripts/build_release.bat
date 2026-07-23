@echo off
chcp 65001 >nul
setlocal EnableExtensions

set "REPO_ROOT=%~dp0.."
for %%I in ("%REPO_ROOT%") do set "REPO_ROOT=%%~fI"
set "VERSION=1.26.3-source-synced"
if not "%~1"=="" set "VERSION=%~1"
set "RELEASE=%REPO_ROOT%\release\%VERSION%"
set "PLAYER=%REPO_ROOT%\tools\runtime\FlashPlayer.exe"
set "PLAYER_HASH=B6BA115C2B43D87AADDF0060C44726E7AF1A12C9501FC63DE652A9517D7367DB"

if exist "%RELEASE%" (
  echo [ERROR] Release target already exists; refusing to overwrite:
  echo   %RELEASE%
  exit /b 1
)
if not exist "%PLAYER%" (
  echo [ERROR] Missing tracked normal Flash Player: %PLAYER%
  exit /b 2
)
for /f "skip=1 tokens=*" %%H in ('certutil -hashfile "%PLAYER%" SHA256 2^>nul') do if not defined ACTUAL_PLAYER_HASH set "ACTUAL_PLAYER_HASH=%%H"
set "ACTUAL_PLAYER_HASH=%ACTUAL_PLAYER_HASH: =%"
if /i not "%ACTUAL_PLAYER_HASH%"=="%PLAYER_HASH%" (
  echo [ERROR] Tracked normal Flash Player hash mismatch.
  exit /b 3
)

call "%~dp0build_all.bat"
if errorlevel 1 exit /b %ERRORLEVEL%

mkdir "%RELEASE%\build\saves\backups"
mkdir "%RELEASE%\scripts"
mkdir "%RELEASE%\tools\debug"
xcopy "%REPO_ROOT%\build\swf" "%RELEASE%\build\swf\" /e /i /q /y >nul
copy /y "%REPO_ROOT%\build\game.swf" "%RELEASE%\build\game.swf" >nul
copy /y "%REPO_ROOT%\build\server.exe" "%RELEASE%\build\server.exe" >nul
copy /y "%REPO_ROOT%\build\modifier.html" "%RELEASE%\build\modifier.html" >nul
if exist "%REPO_ROOT%\build\公告.txt" copy /y "%REPO_ROOT%\build\公告.txt" "%RELEASE%\build\公告.txt" >nul
copy /y nul "%RELEASE%\build\.release-ready" >nul
copy /y "%PLAYER%" "%RELEASE%\tools\debug\flashplayer_sa.exe" >nul
copy /y "%REPO_ROOT%\tools\debug\flashplayer_sa_debug.exe" "%RELEASE%\tools\debug\flashplayer_sa_debug.exe" >nul
copy /y "%REPO_ROOT%\scripts\launch_game.bat" "%RELEASE%\scripts\launch_game.bat" >nul
copy /y "%REPO_ROOT%\scripts\launch_modifier.bat" "%RELEASE%\scripts\launch_modifier.bat" >nul

for %%F in ("启动游戏.bat" "启动游戏-flashplayer_sa.bat" "启动游戏-flashplayer_sa_debug.bat" "启动修改器.bat" "修改器.bat" "一键备份存档.bat" "清除存档.bat" "打开存档目录.bat" "打开存档备份文件夹.bat" "清理后台残留.bat" "战车属性为零修复.bat") do copy /y "%REPO_ROOT%\%%~F" "%RELEASE%\%%~F" >nul

call "%~dp0check_release.bat" "%RELEASE%"
if errorlevel 1 exit /b %ERRORLEVEL%
echo [OK] New release created without modifying old versions:
echo   %RELEASE%
exit /b 0
