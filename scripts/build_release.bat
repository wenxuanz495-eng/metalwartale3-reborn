@echo off
chcp 65001 >nul
setlocal EnableExtensions

set "REPO_ROOT=%~dp0.."
for %%I in ("%REPO_ROOT%") do set "REPO_ROOT=%%~fI"
set "VERSION=1.26.3-source-synced"
if not "%~1"=="" set "VERSION=%~1"
set "RELEASE=%REPO_ROOT%\release\%VERSION%"
set "PLAYER=%REPO_ROOT%\tools\runtime\FlashPlayer.exe"
set "PLAYER_HASH=7D492DB82A337D4457D53B3AAE5FB4041C3B2DDD580B5AA6610BF31202DEE979"

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
mkdir "%RELEASE%\tools\runtime"
mkdir "%RELEASE%\build\bgm"
mkdir "%RELEASE%\build\tools\audio"
mkdir "%RELEASE%\build\ui"
xcopy "%REPO_ROOT%\build\swf" "%RELEASE%\build\swf\" /e /i /q /y >nul
xcopy "%REPO_ROOT%\build\bgm" "%RELEASE%\build\bgm\" /e /i /q /y >nul
xcopy "%REPO_ROOT%\build\ui" "%RELEASE%\build\ui\" /e /i /q /y >nul
if exist "%RELEASE%\build\bgm\player" rmdir /s /q "%RELEASE%\build\bgm\player"
mkdir "%RELEASE%\build\bgm\player" >nul 2>nul
xcopy "%REPO_ROOT%\build\tools\audio" "%RELEASE%\build\tools\audio\" /e /i /q /y >nul
xcopy "%REPO_ROOT%\build\ui" "%RELEASE%\build\ui\" /e /i /q /y >nul
copy /y "%REPO_ROOT%\build\game.swf" "%RELEASE%\build\game.swf" >nul
copy /y "%REPO_ROOT%\build\server.exe" "%RELEASE%\build\server.exe" >nul
copy /y "%REPO_ROOT%\build\modifier.html" "%RELEASE%\build\modifier.html" >nul
if exist "%REPO_ROOT%\build\公告.txt" copy /y "%REPO_ROOT%\build\公告.txt" "%RELEASE%\build\公告.txt" >nul
copy /y nul "%RELEASE%\build\.release-ready" >nul
copy /y "%PLAYER%" "%RELEASE%\tools\runtime\FlashPlayer.exe" >nul
copy /y "%REPO_ROOT%\tools\debug\flashplayer_sa_debug.exe" "%RELEASE%\tools\debug\flashplayer_sa_debug.exe" >nul
copy /y "%REPO_ROOT%\scripts\launch_game.bat" "%RELEASE%\scripts\launch_game.bat" >nul
copy /y "%REPO_ROOT%\scripts\launch_modifier.bat" "%RELEASE%\scripts\launch_modifier.bat" >nul

for %%F in ("启动游戏-flashplayer_sa.bat" "启动游戏-flashplayer_sa_debug.bat" "启动修改器.bat" "修改器.bat" "一键备份存档.bat" "清除存档.bat" "打开存档目录.bat" "打开存档备份文件夹.bat" "清理后台残留.bat" "战车属性为零修复.bat") do copy /y "%REPO_ROOT%\%%~F" "%RELEASE%\%%~F" >nul

call "%~dp0check_release.bat" "%RELEASE%"
if errorlevel 1 exit /b %ERRORLEVEL%
echo [OK] New release created without modifying old versions:
echo   %RELEASE%
exit /b 0
