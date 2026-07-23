@echo off
chcp 65001 >nul
setlocal EnableExtensions
cd /d "%~dp0.."

echo ==== Verify golden reference ====
call "%~dp0verify_golden_manifest.bat"
if errorlevel 1 exit /b %ERRORLEVEL%

echo ==== Pure BAT full build ====
call "%~dp0build_all.bat"
if errorlevel 1 exit /b %ERRORLEVEL%

echo ==== Reproducible SWF ====
call "%~dp0verify_reproducible_build.bat"
if errorlevel 1 exit /b %ERRORLEVEL%

echo ==== Go tests ====
set "GOPATH=D:\superalloy\.gopath"
set "GOMODCACHE=%GOPATH%\pkg\mod"
set "GOCACHE=%GOPATH%\cache"
pushd server
go test ./...
if errorlevel 1 (
  popd
  exit /b 10
)
popd

echo ==== Modifier JavaScript ====
node scripts\check_modifier.js runtime\modifier.html
if errorlevel 1 exit /b 11
node scripts\check_modifier.js build\modifier.html
if errorlevel 1 exit /b 12

echo ==== Game service smoke test ====
call "%~dp0launch_game.bat" --smoke sa
if errorlevel 1 exit /b 13

echo ==== Modifier service smoke test ====
call "%~dp0launch_modifier.bat" --smoke
if errorlevel 1 exit /b 14

echo ==== Recheck golden reference ====
call "%~dp0verify_golden_manifest.bat"
if errorlevel 1 exit /b 15

echo [OK] Phase 3 verification passed.
exit /b 0
