@echo off
chcp 65001 >nul
setlocal EnableExtensions

rem 用法：build_player_packages.bat <完整版本名>
rem 版本名原样使用（不再追加"内测版"后缀），产出：
rem   工作区根\<版本名>\        完整包（含开发者推荐曲库）
rem   工作区根\<版本名>.mini\    迷你包（排除开发者推荐曲库，保留原版默认 BGM 与外置播放器）
rem   对应 .7z 压缩包
rem 静音版流程自 2026-09-19 起停用（历史版本见 git 历史与 F 盘冷备）。

set "REPO_ROOT=%~dp0.."
rem 输出根默认 = 工作区根（仓库上一级），不写死盘符；可用环境变量 PKG_OUT_DIR 重定向（如工作区的 临时封装目录\）
for %%I in ("%~dp0..\..") do set "OUT_ROOT=%%~fI"
if defined PKG_OUT_DIR for %%I in ("%PKG_OUT_DIR%") do set "OUT_ROOT=%%~fI"
set "VERSION=2.061"
if not "%~1"=="" set "VERSION=%~1"
set "NORMAL=%OUT_ROOT%\%VERSION%"
set "MINI=%OUT_ROOT%\%VERSION%.mini"
set "PLAYER_SOURCE=%REPO_ROOT%\tools\runtime\FlashPlayer.exe"
set "PLAYER_SHA256=7D492DB82A337D4457D53B3AAE5FB4041C3B2DDD580B5AA6610BF31202DEE979"

if exist "%NORMAL%.7z" goto target_exists
if exist "%MINI%.7z" goto target_exists
if not exist "%PLAYER_SOURCE%" goto missing_player
for /f "skip=1 tokens=*" %%H in ('certutil -hashfile "%PLAYER_SOURCE%" SHA256 2^>nul') do if not defined PLAYER_ACTUAL_SHA256 set "PLAYER_ACTUAL_SHA256=%%H"
set "PLAYER_ACTUAL_SHA256=%PLAYER_ACTUAL_SHA256: =%"
if /i not "%PLAYER_ACTUAL_SHA256%"=="%PLAYER_SHA256%" goto invalid_player

call "%REPO_ROOT%\scripts\build_all.bat"
if errorlevel 1 exit /b %ERRORLEVEL%
copy /y "%REPO_ROOT%\runtime\游戏更新公告.txt" "%REPO_ROOT%\build\游戏更新公告.txt" >nul

call :make_package "%NORMAL%"
if errorlevel 1 exit /b %ERRORLEVEL%
call :make_package "%MINI%"
if errorlevel 1 exit /b %ERRORLEVEL%
rem 迷你版：排除开发者推荐曲库（build\bgm\recommended），保留原版默认 BGM 与外置播放器本体
if exist "%MINI%\build\bgm\recommended" rmdir /s /q "%MINI%\build\bgm\recommended"

"%ProgramFiles%\7-Zip\7z.exe" a -t7z "%NORMAL%.7z" "%NORMAL%" -mx=9
if errorlevel 1 exit /b %ERRORLEVEL%
"%ProgramFiles%\7-Zip\7z.exe" a -t7z "%MINI%.7z" "%MINI%" -mx=9
if errorlevel 1 exit /b %ERRORLEVEL%
rem 生成 SHA-256 校验文件（findstr 只保留纯 ASCII 哈希行，避免控制台中文编码问题），与 .7z 同目录
certutil -hashfile "%NORMAL%.7z" SHA256 | findstr /r "^[0-9a-fA-F]*$" > "%NORMAL%.7z.sha256.txt"
certutil -hashfile "%MINI%.7z" SHA256 | findstr /r "^[0-9a-fA-F]*$" > "%MINI%.7z.sha256.txt"
:package_done
echo [OK] Player packages created.
echo   %NORMAL%
echo   %MINI%
exit /b 0

:make_package
set "DEST=%~1"
mkdir "%DEST%\build\saves\backups" "%DEST%\saves\backups" "%DEST%\scripts" "%DEST%\tools\runtime" >nul 2>nul
xcopy "%REPO_ROOT%\build\swf" "%DEST%\build\swf\" /e /i /q /y >nul
xcopy "%REPO_ROOT%\build\bgm" "%DEST%\build\bgm\" /e /i /q /y >nul
xcopy "%REPO_ROOT%\build\ui" "%DEST%\build\ui\" /e /i /q /y >nul
if exist "%DEST%\build\bgm\player" rmdir /s /q "%DEST%\build\bgm\player"
mkdir "%DEST%\build\bgm\player" >nul 2>nul
xcopy "%REPO_ROOT%\build\tools\audio" "%DEST%\build\tools\audio\" /e /i /q /y >nul
copy /y "%REPO_ROOT%\build\game.swf" "%DEST%\build\game.swf" >nul
copy /y "%REPO_ROOT%\build\server.exe" "%DEST%\build\server.exe" >nul
for %%F in ("%REPO_ROOT%\build\*.exe") do if /i not "%%~nxF"=="server.exe" copy /y "%%~fF" "%DEST%\%%~nxF" >nul
copy /y "%REPO_ROOT%\build\modifier.html" "%DEST%\build\modifier.html" >nul
for %%F in ("%REPO_ROOT%\runtime\*.txt") do copy /y "%%~fF" "%DEST%\build\%%~nxF" >nul
type nul > "%DEST%\build\.release-ready"
copy /y "%REPO_ROOT%\scripts\launch_game.bat" "%DEST%\scripts\launch_game.bat" >nul
copy /y "%REPO_ROOT%\scripts\launch_modifier.bat" "%DEST%\scripts\launch_modifier.bat" >nul
copy /y "%REPO_ROOT%\scripts\prepare_build_runtime.bat" "%DEST%\scripts\prepare_build_runtime.bat" >nul
for %%F in ("启动游戏-flashplayer_sa.bat" "启动修改器.bat" "一键备份存档.bat" "打开存档目录.bat" "打开存档备份文件夹.bat" "清除存档.bat" "清理后台残留.bat" "打开公告目录.bat" "modifier.html" "发布装包规范.txt") do copy /y "%REPO_ROOT%\%%~F" "%DEST%\%%~F" >nul
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
