@echo off
chcp 65001 >nul
setlocal EnableExtensions EnableDelayedExpansion

cd /d "%~dp0.."
set "REPO_ROOT=%CD%"
set "TARGET=%~1"
if not defined TARGET set "TARGET=D:\superalloy\静音版"
set "CURRENT_SWF=%REPO_ROOT%\build\swf"
set "SILENT_CSV=%TARGET%\_diagnostics\silenced-sounds.csv"
set "STAGE=%TARGET%\_diagnostics\_silent-stage"

if not exist "%SILENT_CSV%" (
  echo [ERROR] Missing silent replacement manifest: %SILENT_CSV%
  exit /b 1
)

echo ==== Build non-silent repository version ====
call "%REPO_ROOT%\scripts\build_all.bat"
if errorlevel 1 exit /b %ERRORLEVEL%

if not exist "%TARGET%\swf\enemy" mkdir "%TARGET%\swf\enemy"
if exist "%STAGE%" rd /s /q "%STAGE%"
mkdir "%STAGE%\enemy"

echo ==== Preserve 96 silent enemy overrides ====
for /f "usebackq skip=1 tokens=1 delims=," %%A in ("%SILENT_CSV%") do (
  if not "%%~A"=="" (
    if exist "%TARGET%\swf\enemy\%%~A" copy /y "%TARGET%\swf\enemy\%%~A" "%STAGE%\enemy\%%~A" >nul
  )
)

echo ==== Synchronize current resources into silent preview ====
xcopy "%CURRENT_SWF%" "%TARGET%\swf\" /e /i /q /y >nul
copy /y "%REPO_ROOT%\build\game.swf" "%TARGET%\game.swf" >nul
copy /y "%REPO_ROOT%\build\server.exe" "%TARGET%\server.exe" >nul
xcopy "%REPO_ROOT%\build\bgm" "%TARGET%\bgm\" /e /i /q /y >nul
xcopy "%REPO_ROOT%\build\tools\audio" "%TARGET%\tools\audio\" /e /i /q /y >nul
if exist "%REPO_ROOT%\build\公告.txt" copy /y "%REPO_ROOT%\build\公告.txt" "%TARGET%\公告.txt" >nul

echo ==== Restore silent enemy overrides ====
xcopy "%STAGE%\enemy" "%TARGET%\swf\enemy\" /e /i /q /y >nul
rd /s /q "%STAGE%"

echo [OK] Silent preview updated without modifying repository build outputs:
echo      %TARGET%
exit /b 0
