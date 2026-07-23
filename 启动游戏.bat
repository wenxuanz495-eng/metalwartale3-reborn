@echo off
cd /d "%~dp0"
call "%~dp0scripts\launch_game.bat" sa
exit /b %ERRORLEVEL%
