@echo off
setlocal EnableExtensions
cd /d "%~dp0.."

echo ==== Build server ====
call "%~dp0build_server.bat"
if errorlevel 1 exit /b %ERRORLEVEL%

echo ==== Build launcher ====
call "%~dp0build_launcher.bat"
if errorlevel 1 exit /b %ERRORLEVEL%

echo ==== Build game SWF ====
call "%~dp0build_swf.bat"
if errorlevel 1 exit /b %ERRORLEVEL%

echo ==== Prepare runtime ====
call "%~dp0prepare_build_runtime.bat"
if errorlevel 1 exit /b %ERRORLEVEL%

echo ==== Validate core build artifacts ====
if not exist "%~dp0..\build\game.swf" echo [ERROR] Missing core artifact: build\game.swf&exit /b 6
for %%F in ("%~dp0..\build\game.swf") do if %%~zF LEQ 0 echo [ERROR] Zero-byte core artifact: build\game.swf&exit /b 6
if not exist "%~dp0..\build\swf\arms1100.swf" echo [ERROR] Missing core artifact: build\swf\arms1100.swf&exit /b 6
for %%F in ("%~dp0..\build\swf\arms1100.swf") do if %%~zF LEQ 0 echo [ERROR] Zero-byte core artifact: build\swf\arms1100.swf&exit /b 6
if not exist "%~dp0..\runtime\swf\arms1100.swf" echo [ERROR] Missing core artifact: runtime\swf\arms1100.swf&exit /b 6
for %%F in ("%~dp0..\runtime\swf\arms1100.swf") do if %%~zF LEQ 0 echo [ERROR] Zero-byte core artifact: runtime\swf\arms1100.swf&exit /b 6
if exist "%~dp0..\build\swf\swf\arms1100.swf" echo [ERROR] Unexpected nested artifact: build\swf\swf\arms1100.swf&exit /b 6
echo [OK] Core build artifacts validated.

echo [OK] Pure BAT build completed.
exit /b 0
