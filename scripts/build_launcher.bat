@echo off
chcp 65001 >nul
setlocal EnableExtensions

set "REPO_ROOT=%~dp0.."
for %%I in ("%REPO_ROOT%") do set "REPO_ROOT=%%~fI"
set "SOURCE=%REPO_ROOT%\launcher"
set "BUILD=%REPO_ROOT%\build"
set "GOPATH=D:\superalloy\.gopath"
set "GOMODCACHE=%GOPATH%\pkg\mod"
set "GOCACHE=%GOPATH%\cache"
set "GO_EXE="

for /f "delims=" %%G in ('where go.exe 2^>nul') do if not defined GO_EXE set "GO_EXE=%%G"
if not defined GO_EXE goto missing_go
if not exist "%SOURCE%\go.mod" goto missing_source
if not exist "%BUILD%" mkdir "%BUILD%"

echo Building Superalloy Chronicle launchers...
pushd "%SOURCE%"
set "GOOS=windows"
set "GOARCH=amd64"
"%GO_EXE%" build -trimpath -buildvcs=false -ldflags "-H=windowsgui -s -w" -o "%BUILD%\超合金战记启动器.exe" .
if errorlevel 1 goto build_failed_popd
set "GOARCH=386"
"%GO_EXE%" build -trimpath -buildvcs=false -ldflags "-H=windowsgui -s -w" -o "%BUILD%\超合金战记启动器-x86.exe" .
if errorlevel 1 goto build_failed_popd
popd

echo [OK] Launchers built.
exit /b 0

:build_failed_popd
popd
:build_failed
echo [ERROR] Launcher build failed.
exit /b 3

:missing_go
echo [ERROR] go.exe was not found on PATH.
exit /b 1

:missing_source
echo [ERROR] Missing launcher\go.mod.
exit /b 2
