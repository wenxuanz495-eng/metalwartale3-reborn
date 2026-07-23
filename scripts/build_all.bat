@echo off
setlocal EnableExtensions
cd /d "%~dp0.."

echo ==== Build server ====
call "%~dp0build_server.bat"
if errorlevel 1 exit /b %ERRORLEVEL%

echo ==== Build game SWF ====
call "%~dp0build_swf.bat"
if errorlevel 1 exit /b %ERRORLEVEL%

echo ==== Prepare runtime ====
call "%~dp0prepare_build_runtime.bat"
if errorlevel 1 exit /b %ERRORLEVEL%

echo [OK] Pure BAT build completed.
exit /b 0
