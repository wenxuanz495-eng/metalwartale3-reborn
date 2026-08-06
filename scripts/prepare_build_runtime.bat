@echo off
chcp 65001 >nul
setlocal EnableExtensions EnableDelayedExpansion

set "REPO_ROOT=%~dp0.."
for %%I in ("%REPO_ROOT%") do set "REPO_ROOT=%%~fI"
set "BUILD_DIR=%REPO_ROOT%\build"
set "MANIFEST=%REPO_ROOT%\docs\baselines\1.26.2.1-BAT.sha256"
set "RESOURCE_SOURCE=%REPO_ROOT%\swf"
set "RESOURCE_COUNT=0"
set "RESOURCE_PROGRESS=0"
set "COPY_FAILED="
set "RECOMMENDED_BGM_SOURCE="
for /d %%D in ("%REPO_ROOT%\..\*") do if exist "%%~fD\.playlist-root" set "RECOMMENDED_BGM_SOURCE=%%~fD"

if not exist "%MANIFEST%" goto missing_input
if not exist "%RESOURCE_SOURCE%" goto missing_input
if not exist "%BUILD_DIR%" mkdir "%BUILD_DIR%"
if not exist "%BUILD_DIR%\swf" mkdir "%BUILD_DIR%\swf"
if not exist "%BUILD_DIR%\saves" mkdir "%BUILD_DIR%\saves"
if not exist "%BUILD_DIR%\saves\backups" mkdir "%BUILD_DIR%\saves\backups"
if not exist "%BUILD_DIR%\bgm\default" mkdir "%BUILD_DIR%\bgm\default"
if not exist "%BUILD_DIR%\tools\audio" mkdir "%BUILD_DIR%\tools\audio"
if not exist "%BUILD_DIR%\ui\chip-sell" mkdir "%BUILD_DIR%\ui\chip-sell"
if not exist "%BUILD_DIR%\ui\auto-level" mkdir "%BUILD_DIR%\ui\auto-level"
if not exist "%BUILD_DIR%\ui\pause-settings" mkdir "%BUILD_DIR%\ui\pause-settings"

for /f "usebackq tokens=1,*" %%H in ("%MANIFEST%") do call :copy_resource "%%H" "%%I"
if defined COPY_FAILED goto copy_failed
if not "!RESOURCE_COUNT!"=="175" goto count_failed

if not exist "%REPO_ROOT%\config\build\resource-overrides\car1130.swf" goto missing_input
if not exist "%REPO_ROOT%\config\build\resource-overrides\battle_boom.mp3" goto missing_input
if not exist "%REPO_ROOT%\config\build\resource-overrides\death_electric.mp3" goto missing_input
if not exist "%REPO_ROOT%\config\build\resource-overrides\death_delay_electric.mp3" goto missing_input
if not exist "%REPO_ROOT%\config\build\resource-overrides\environment_break.mp3" goto missing_input
copy /y "%REPO_ROOT%\config\build\resource-overrides\car1130.swf" "%BUILD_DIR%\swf\car1130.swf" >nul
if errorlevel 1 goto copy_failed
for %%F in ("%REPO_ROOT%\config\build\resource-overrides\*.mp3") do copy /y "%%~fF" "%BUILD_DIR%\swf\%%~nxF" >nul

if not exist "%REPO_ROOT%\tools\audio\miniaudio.dll" goto missing_input
if not exist "%REPO_ROOT%\tools\audio\LICENSE.txt" goto missing_input
copy /y "%REPO_ROOT%\tools\audio\miniaudio.dll" "%BUILD_DIR%\tools\audio\miniaudio.dll" >nul
if errorlevel 1 goto copy_failed
copy /y "%REPO_ROOT%\tools\audio\LICENSE.txt" "%BUILD_DIR%\tools\audio\LICENSE.txt" >nul
if errorlevel 1 goto copy_failed
for %%F in ("%REPO_ROOT%\config\build\bgm-default\*.mp3") do copy /y "%%~fF" "%BUILD_DIR%\bgm\default\%%~nxF" >nul
if errorlevel 1 goto copy_failed
if not exist "%REPO_ROOT%\assets\ui\chip-sell\space-bg.jpg" goto missing_input
if not exist "%REPO_ROOT%\assets\ui\chip-sell\button-normal.png" goto missing_input
if not exist "%REPO_ROOT%\assets\ui\chip-sell\button-hover.png" goto missing_input
if not exist "%REPO_ROOT%\assets\ui\chip-sell\checkbox-frame.png" goto missing_input
copy /y "%REPO_ROOT%\assets\ui\chip-sell\space-bg.jpg" "%BUILD_DIR%\ui\chip-sell\space-bg.jpg" >nul
copy /y "%REPO_ROOT%\assets\ui\chip-sell\button-normal.png" "%BUILD_DIR%\ui\chip-sell\button-normal.png" >nul
copy /y "%REPO_ROOT%\assets\ui\chip-sell\button-hover.png" "%BUILD_DIR%\ui\chip-sell\button-hover.png" >nul
copy /y "%REPO_ROOT%\assets\ui\chip-sell\checkbox-frame.png" "%BUILD_DIR%\ui\chip-sell\checkbox-frame.png" >nul
if errorlevel 1 goto copy_failed
if not exist "%REPO_ROOT%\assets\ui\auto-level\button-normal.png" goto missing_input
if not exist "%REPO_ROOT%\assets\ui\auto-level\button-selected.png" goto missing_input
copy /y "%REPO_ROOT%\assets\ui\auto-level\button-normal.png" "%BUILD_DIR%\ui\auto-level\button-normal.png" >nul
copy /y "%REPO_ROOT%\assets\ui\auto-level\button-selected.png" "%BUILD_DIR%\ui\auto-level\button-selected.png" >nul
if errorlevel 1 goto copy_failed
if not exist "%REPO_ROOT%\assets\ui\pause-settings\button-normal.png" goto missing_input
if not exist "%REPO_ROOT%\assets\ui\pause-settings\button-hover.png" goto missing_input
copy /y "%REPO_ROOT%\assets\ui\pause-settings\button-normal.png" "%BUILD_DIR%\ui\pause-settings\button-normal.png" >nul
copy /y "%REPO_ROOT%\assets\ui\pause-settings\button-hover.png" "%BUILD_DIR%\ui\pause-settings\button-hover.png" >nul
if errorlevel 1 goto copy_failed

if defined RECOMMENDED_BGM_SOURCE if exist "!RECOMMENDED_BGM_SOURCE!" (
if exist "%BUILD_DIR%\bgm\recommended" rmdir /s /q "%BUILD_DIR%\bgm\recommended"
mkdir "%BUILD_DIR%\bgm\recommended"
if not exist "%BUILD_DIR%\bgm\player" mkdir "%BUILD_DIR%\bgm\player"
  robocopy "!RECOMMENDED_BGM_SOURCE!" "%BUILD_DIR%\bgm\recommended" *.mp3 *.flac *.wav *.json /e /r:1 /w:1 /njh /njs /ndl /nc /ns >nul
  if errorlevel 8 goto recommended_bgm_failed
) else (
  echo [WARN] Recommended BGM folder not found; original BGM fallback remains available.
)

if exist "%REPO_ROOT%\runtime\modifier.html" copy /y "%REPO_ROOT%\runtime\modifier.html" "%BUILD_DIR%\modifier.html" >nul
for %%F in ("%REPO_ROOT%\runtime\*.txt") do if "%%~zF"=="4608" copy /y "%%~fF" "%BUILD_DIR%\%%~nxF" >nul

echo Runtime prepared from tracked repository resources: !RESOURCE_COUNT! files.
exit /b 0

:copy_resource
set "EXPECTED=%~1"
set "ENTRY=%~2"
set "REL=!ENTRY:~1!"
if /i not "!REL:~0,4!"=="swf\" exit /b 0
for %%N in ("!REL!") do set "NAME=%%~nxN"
set "SOURCE=%RESOURCE_SOURCE%\!NAME!"
set "DEST=%BUILD_DIR%\!REL!"
if not exist "!SOURCE!" (
  set "COPY_FAILED=missing tracked resource: !NAME!"
  exit /b 0
)
call :hash_file "!SOURCE!" ACTUAL
if /i not "!ACTUAL!"=="!EXPECTED!" (
  set "COPY_FAILED=resource hash mismatch: !NAME!"
  exit /b 0
)
for %%D in ("!DEST!") do if not exist "%%~dpD" mkdir "%%~dpD"
copy /y "!SOURCE!" "!DEST!" >nul
if errorlevel 1 (
  set "COPY_FAILED=resource copy failed: !REL!"
  exit /b 0
)
set /a RESOURCE_COUNT+=1
set /a RESOURCE_PROGRESS=RESOURCE_COUNT%%25
if "!RESOURCE_PROGRESS!"=="0" echo [CHECK] Runtime resources verified: !RESOURCE_COUNT!/175
exit /b 0

:hash_file
set "HASH_TEMP="
for /f "skip=1 tokens=*" %%A in ('certutil -hashfile "%~1" SHA256 2^>nul') do if not defined HASH_TEMP set "HASH_TEMP=%%A"
set "HASH_TEMP=!HASH_TEMP: =!"
set "%~2=!HASH_TEMP!"
exit /b 0

:missing_input
echo [ERROR] Missing tracked resource directory or golden manifest.
exit /b 1

:copy_failed
echo [ERROR] Runtime resource preparation failed: !COPY_FAILED!
exit /b 2

:count_failed
echo [ERROR] Expected 175 resource files, prepared !RESOURCE_COUNT!.
exit /b 3

:recommended_bgm_failed
echo [ERROR] Could not synchronize the recommended BGM folder.
exit /b 4
