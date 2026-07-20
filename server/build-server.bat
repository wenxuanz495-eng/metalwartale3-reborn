@echo off
setlocal
pushd "%~dp0" || exit /b 1

set "GOEXE="
where go >nul 2>&1
if not errorlevel 1 set "GOEXE=go"
if not defined GOEXE if exist "%~dp0..\.tools\go\bin\go.exe" set "GOEXE=%~dp0..\.tools\go\bin\go.exe"

if not defined GOEXE (
  echo [ERROR] Go toolchain was not found.
  popd
  pause
  exit /b 1
)

echo Testing Go server...
"%GOEXE%" test ./...
if errorlevel 1 (
  echo [ERROR] Tests failed. Existing offline\server.exe was not changed.
  popd
  pause
  exit /b 1
)

echo Building offline\server.exe...
"%GOEXE%" build -trimpath -ldflags "-s -w" -o "%~dp0..\offline\server.new.exe" .
if errorlevel 1 (
  echo [ERROR] Build failed. Existing offline\server.exe was not changed.
  popd
  pause
  exit /b 1
)

move /y "%~dp0..\offline\server.new.exe" "%~dp0..\offline\server.exe" >nul
set "EXIT_CODE=%ERRORLEVEL%"
popd
if not "%EXIT_CODE%"=="0" (
  echo [ERROR] Could not replace offline\server.exe.
  pause
  exit /b %EXIT_CODE%
)
echo [OK] Built offline\server.exe
pause