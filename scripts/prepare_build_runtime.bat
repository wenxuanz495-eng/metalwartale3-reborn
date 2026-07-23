@echo off
chcp 65001 >nul
setlocal EnableExtensions EnableDelayedExpansion

set "REPO_ROOT=%~dp0.."
for %%I in ("%REPO_ROOT%") do set "REPO_ROOT=%%~fI"
set "BUILD_DIR=%REPO_ROOT%\build"
set "MANIFEST=%REPO_ROOT%\docs\baselines\1.26.2.1-BAT.sha256"
set "RESOURCE_SOURCE=%REPO_ROOT%\swf"
set "RESOURCE_COUNT=0"
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

if exist "%REPO_ROOT%\runtime\modifier.html" copy /y "%REPO_ROOT%\runtime\modifier.html" "%BUILD_DIR%\modifier.html" >nul
if exist "%REPO_ROOT%\runtime\公告.txt" copy /y "%REPO_ROOT%\runtime\公告.txt" "%BUILD_DIR%\公告.txt" >nul

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
