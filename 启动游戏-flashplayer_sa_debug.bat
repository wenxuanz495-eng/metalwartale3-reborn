@echo off
cd /d "%~dp0"
call "%~dp0scripts\runtime\run.bat" debug
exit /b %ERRORLEVEL%
