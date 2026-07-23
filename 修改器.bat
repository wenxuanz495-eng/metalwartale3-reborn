@echo off
cd /d "%~dp0"
call "%~dp0scripts\launch_modifier.bat"
exit /b %ERRORLEVEL%
