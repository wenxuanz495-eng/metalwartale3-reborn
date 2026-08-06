@echo off
chcp 65001 >nul
setlocal EnableExtensions

set "REPO_ROOT=%~dp0.."
set "OUT_ROOT=D:\superalloy"
set "VERSION=2.061"
if not "%~1"=="" set "VERSION=%~1"
set "PACKAGE_MODE=%~2"
set "COOP_ONLY="
if /i "%PACKAGE_MODE%"=="coop" set "COOP_ONLY=1"
set "NORMAL=%OUT_ROOT%\%VERSION%内测版"
set "SILENT=%OUT_ROOT%\%VERSION%静音内测版"
set "PLAYER_SOURCE=%REPO_ROOT%\tools\runtime\FlashPlayer.exe"
set "PLAYER_SHA256=7D492DB82A337D4457D53B3AAE5FB4041C3B2DDD580B5AA6610BF31202DEE979"
set "SILENT_SOURCE=%OUT_ROOT%\静音版"

if exist "%NORMAL%.7z" goto target_exists
if not defined COOP_ONLY if exist "%SILENT%.7z" goto target_exists
if not exist "%PLAYER_SOURCE%" goto missing_player
for /f "skip=1 tokens=*" %%H in ('certutil -hashfile "%PLAYER_SOURCE%" SHA256 2^>nul') do if not defined PLAYER_ACTUAL_SHA256 set "PLAYER_ACTUAL_SHA256=%%H"
set "PLAYER_ACTUAL_SHA256=%PLAYER_ACTUAL_SHA256: =%"
if /i not "%PLAYER_ACTUAL_SHA256%"=="%PLAYER_SHA256%" goto invalid_player
if not defined COOP_ONLY if not exist "%SILENT_SOURCE%\_diagnostics\silenced-sounds.csv" goto missing_silent
if not defined COOP_ONLY if not exist "%SILENT_SOURCE%\静音版说明.txt" goto missing_silent_docs
if not defined COOP_ONLY if not exist "%SILENT_SOURCE%\死亡音效替换文件清单.txt" goto missing_silent_docs

call "%REPO_ROOT%\scripts\build_all.bat"
if errorlevel 1 exit /b %ERRORLEVEL%
copy /y "%REPO_ROOT%\runtime\公告.txt" "%REPO_ROOT%\build\公告.txt" >nul

call :make_package "%NORMAL%" "%REPO_ROOT%\build\swf"
if errorlevel 1 exit /b %ERRORLEVEL%
if defined COOP_ONLY goto compress_packages
call :make_package "%SILENT%" "%SILENT_SOURCE%\swf"
if errorlevel 1 exit /b %ERRORLEVEL%

call "%REPO_ROOT%\scripts\build_silent_preview.bat" "%SILENT_SOURCE%"
if errorlevel 1 exit /b %ERRORLEVEL%
 xcopy "%SILENT_SOURCE%\swf" "%SILENT%\build\swf\" /e /i /q /y >nul
copy /y "%REPO_ROOT%\build\game.swf" "%SILENT%\build\game.swf" >nul
copy /y "%REPO_ROOT%\build\server.exe" "%SILENT%\build\server.exe" >nul
xcopy "%REPO_ROOT%\build\bgm" "%SILENT%\build\bgm\" /e /i /q /y >nul
if exist "%SILENT%\build\bgm\player" rmdir /s /q "%SILENT%\build\bgm\player"
mkdir "%SILENT%\build\bgm\player" >nul 2>nul
xcopy "%REPO_ROOT%\build\tools\audio" "%SILENT%\build\tools\audio\" /e /i /q /y >nul
copy /y "%SILENT_SOURCE%\静音版说明.txt" "%SILENT%\静音版说明.txt" >nul
copy /y "%SILENT_SOURCE%\死亡音效替换文件清单.txt" "%SILENT%\死亡音效替换文件清单.txt" >nul

:compress_packages
"%ProgramFiles%\7-Zip\7z.exe" a -t7z "%NORMAL%.7z" "%NORMAL%" -mx=9
if errorlevel 1 exit /b %ERRORLEVEL%
if defined COOP_ONLY goto package_done
"%ProgramFiles%\7-Zip\7z.exe" a -t7z "%SILENT%.7z" "%SILENT%" -mx=9
if errorlevel 1 exit /b %ERRORLEVEL%
:package_done
echo [OK] Player packages created.
echo   %NORMAL%
if not defined COOP_ONLY echo   %SILENT%
exit /b 0

:make_package
set "DEST=%~1"
set "RESOURCE_SOURCE=%~2"
mkdir "%DEST%\build\saves\backups" "%DEST%\saves\backups" "%DEST%\scripts" "%DEST%\tools\runtime" >nul 2>nul
xcopy "%REPO_ROOT%\build\swf" "%DEST%\build\swf\" /e /i /q /y >nul
xcopy "%REPO_ROOT%\build\bgm" "%DEST%\build\bgm\" /e /i /q /y >nul
xcopy "%REPO_ROOT%\build\ui" "%DEST%\build\ui\" /e /i /q /y >nul
if exist "%DEST%\build\bgm\player" rmdir /s /q "%DEST%\build\bgm\player"
mkdir "%DEST%\build\bgm\player" >nul 2>nul
xcopy "%REPO_ROOT%\build\tools\audio" "%DEST%\build\tools\audio\" /e /i /q /y >nul
if not "%RESOURCE_SOURCE%"=="%REPO_ROOT%\build\swf" xcopy "%RESOURCE_SOURCE%" "%DEST%\build\swf\" /e /i /q /y >nul
copy /y "%REPO_ROOT%\build\game.swf" "%DEST%\build\game.swf" >nul
copy /y "%REPO_ROOT%\build\server.exe" "%DEST%\build\server.exe" >nul
copy /y "%REPO_ROOT%\build\超合金战记启动器.exe" "%DEST%\超合金战记启动器.exe" >nul
copy /y "%REPO_ROOT%\build\超合金战记启动器-x86.exe" "%DEST%\超合金战记启动器-x86.exe" >nul
copy /y "%REPO_ROOT%\build\modifier.html" "%DEST%\build\modifier.html" >nul
for %%F in ("%REPO_ROOT%\runtime\*.txt") do copy /y "%%~fF" "%DEST%\build\%%~nxF" >nul
type nul > "%DEST%\build\.release-ready"
copy /y "%REPO_ROOT%\scripts\launch_game.bat" "%DEST%\scripts\launch_game.bat" >nul
copy /y "%REPO_ROOT%\scripts\launch_modifier.bat" "%DEST%\scripts\launch_modifier.bat" >nul
copy /y "%REPO_ROOT%\scripts\prepare_build_runtime.bat" "%DEST%\scripts\prepare_build_runtime.bat" >nul
for %%F in ("启动游戏-flashplayer_sa.bat" "启动修改器.bat" "修改器.bat" "一键备份存档.bat" "打开存档目录.bat" "打开存档备份文件夹.bat" "清除存档.bat" "清理后台残留.bat" "战车属性为零修复.bat" "打开公告.bat" "modifier.html" "发布装包规范.txt") do copy /y "%REPO_ROOT%\%%~F" "%DEST%\%%~F" >nul
for %%F in ("%REPO_ROOT%\runtime\*.txt") do if %%~zF EQU 1476 copy /y "%%~fF" "%DEST%\%%~nxF" >nul
copy /y "%PLAYER_SOURCE%" "%DEST%\tools\runtime\FlashPlayer.exe" >nul
exit /b 0

:target_exists
echo [ERROR] Package target already exists. Remove old packages before rebuilding.
exit /b 2
:missing_player
echo [ERROR] Missing CleanFlash Player 34: %PLAYER_SOURCE%
exit /b 3
:invalid_player
echo [ERROR] Repository player is not CleanFlash SA 34.0.0.330.
echo [ERROR] Flash Player 29 and Debug Player are forbidden in packages.
exit /b 5
:missing_silent
echo [ERROR] Missing silent replacement manifest: %SILENT_SOURCE%
exit /b 4
:missing_silent_docs
echo [ERROR] Missing 静音版说明.txt or 死亡音效替换文件清单.txt: %SILENT_SOURCE%
exit /b 6
