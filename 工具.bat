@echo off
cd /d "%~dp0"
call "%~dp0scripts\runtime\tools.bat"
exit /b %ERRORLEVEL%
