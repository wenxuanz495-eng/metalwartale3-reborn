@echo off
chcp 65001 >nul
setlocal EnableExtensions

set "REPO_ROOT=%~dp0.."
for %%I in ("%REPO_ROOT%") do set "REPO_ROOT=%%~fI"
set "BUILD_DIR=%REPO_ROOT%\build"
set "RESOURCE_SOURCE="

if exist "%REPO_ROOT%\runtime\swf\enemy\" set "RESOURCE_SOURCE=%REPO_ROOT%\runtime\swf"
if not defined RESOURCE_SOURCE if exist "D:\superalloy\1.26.2.1-BAT\1.26.2.1\swf\enemy\" set "RESOURCE_SOURCE=D:\superalloy\1.26.2.1-BAT\1.26.2.1\swf"

if not defined RESOURCE_SOURCE (
  echo [ERROR] Hierarchical SWF resources were not found.
  echo Checked runtime\swf and the read-only 1.26.2.1-BAT reference.
  exit /b 1
)

if not exist "%BUILD_DIR%" mkdir "%BUILD_DIR%"
if not exist "%BUILD_DIR%\swf" mkdir "%BUILD_DIR%\swf"
if not exist "%BUILD_DIR%\saves" mkdir "%BUILD_DIR%\saves"
if not exist "%BUILD_DIR%\saves\backups" mkdir "%BUILD_DIR%\saves\backups"

robocopy "%RESOURCE_SOURCE%" "%BUILD_DIR%\swf" /E /XO /NFL /NDL /NJH /NJS /NC /NS /NP >nul
if errorlevel 8 (
  echo [ERROR] Failed to copy SWF resources into build\swf.
  exit /b 2
)

if exist "%REPO_ROOT%\runtime\modifier.html" copy /y "%REPO_ROOT%\runtime\modifier.html" "%BUILD_DIR%\modifier.html" >nul
if exist "%REPO_ROOT%\runtime\公告.txt" copy /y "%REPO_ROOT%\runtime\公告.txt" "%BUILD_DIR%\公告.txt" >nul

echo Runtime prepared from: %RESOURCE_SOURCE%
exit /b 0
