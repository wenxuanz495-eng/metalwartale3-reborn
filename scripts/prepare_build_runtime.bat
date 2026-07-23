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

if not exist "%MANIFEST%" goto missing_input
if not exist "%RESOURCE_SOURCE%" goto missing_input
if not exist "%BUILD_DIR%" mkdir "%BUILD_DIR%"
if not exist "%BUILD_DIR%\swf" mkdir "%BUILD_DIR%\swf"
if not exist "%BUILD_DIR%\saves" mkdir "%BUILD_DIR%\saves"
if not exist "%BUILD_DIR%\saves\backups" mkdir "%BUILD_DIR%\saves\backups"

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
