@echo off
setlocal EnableExtensions

set "REPO_ROOT=%~dp0.."
for %%I in ("%REPO_ROOT%") do set "REPO_ROOT=%%~fI"
set "BUILD_DIR=%REPO_ROOT%\build"
set "SERVER_DIR=%REPO_ROOT%\server"
set "OUTPUT=%BUILD_DIR%\server.exe"
set "TEMP_OUTPUT=%BUILD_DIR%\server.new.exe"
set "GO_EXE="

for /f "delims=" %%G in ('where go.exe 2^>nul') do if not defined GO_EXE set "GO_EXE=%%G"
if not defined GO_EXE goto missing_go
if not exist "%SERVER_DIR%\go.mod" goto missing_source
if not exist "%BUILD_DIR%" mkdir "%BUILD_DIR%"

set "GOPATH=D:\superalloy\.gopath"
set "GOMODCACHE=%GOPATH%\pkg\mod"
set "GOCACHE=%GOPATH%\cache"
if not exist "%GOMODCACHE%" mkdir "%GOMODCACHE%"
if not exist "%GOCACHE%" mkdir "%GOCACHE%"
if exist "%TEMP_OUTPUT%" del /q "%TEMP_OUTPUT%"

echo Building Go server with pure BAT...
pushd "%SERVER_DIR%"
"%GO_EXE%" build -trimpath -buildvcs=false -o "%TEMP_OUTPUT%" .
set "BUILD_ERROR=%ERRORLEVEL%"
popd

if not "%BUILD_ERROR%"=="0" goto build_failed
if not exist "%TEMP_OUTPUT%" goto build_failed
move /y "%TEMP_OUTPUT%" "%OUTPUT%" >nul
if errorlevel 1 goto deploy_failed

echo [OK] Server built: %OUTPUT%
exit /b 0

:missing_go
echo [ERROR] go.exe was not found on PATH.
exit /b 1

:missing_source
echo [ERROR] Missing server\go.mod.
exit /b 2

:build_failed
if exist "%TEMP_OUTPUT%" del /q "%TEMP_OUTPUT%" >nul 2>nul
echo [ERROR] Go server build failed.
exit /b 3

:deploy_failed
echo [ERROR] Could not replace build\server.exe.
exit /b 4
