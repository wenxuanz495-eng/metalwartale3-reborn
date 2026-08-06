@echo off
chcp 65001 >nul
setlocal EnableExtensions EnableDelayedExpansion

if "%~1"=="" (
  echo Usage: scripts\check_release.bat release-directory
  exit /b 1
)
for %%I in ("%~1") do set "RELEASE=%%~fI"
if not exist "%RELEASE%\build\game.swf" goto missing
if not exist "%RELEASE%\build\server.exe" goto missing
if not exist "%RELEASE%\build\tools\audio\miniaudio.dll" goto missing
if not exist "%RELEASE%\build\bgm\default\Decisions.mp3" goto missing
if not exist "%RELEASE%\build\modifier.html" goto missing
if not exist "%RELEASE%\启动游戏-flashplayer_sa.bat" goto missing
if not exist "%RELEASE%\启动修改器.bat" goto missing

set "BAD=0"
for /r "%RELEASE%" %%F in (*) do call :check_file "%%~fF" "%%~nxF"
if not "!BAD!"=="0" (
  echo [ERROR] Release contains !BAD! forbidden runtime files.
  exit /b 2
)

for /f %%C in ('dir /s /b /a-d "%RELEASE%" 2^>nul ^| find /c /v ""') do set "COUNT=%%C"
echo [OK] Release contains no player saves, backups, logs or temporary files.
echo Files checked: !COUNT!
exit /b 0

:check_file
set "FULL=%~1"
set "NAME=%~2"
set "REL=!FULL:%RELEASE%\=!"
if /i "!NAME!"=="game_save.bin" goto bad
if /i "!NAME!"=="game_save.last-good.bin" goto bad
if /i "!NAME!"=="saves.db" goto bad
if /i "!NAME!"=="yagao.json" goto bad
if /i "!NAME:~-4!"==".sol" goto bad
if /i "!NAME:~-4!"==".log" goto bad
if /i "!NAME:~-4!"==".tmp" goto bad
if /i "!NAME:~-4!"==".bak" goto bad
echo(!REL!| findstr /i /l /c:"saves\backups\" >nul && goto bad
exit /b 0
:bad
echo [BAD] !REL!
set /a BAD+=1
exit /b 0

:missing
echo [ERROR] Release is missing a required runtime file.
exit /b 3
