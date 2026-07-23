@echo off
cd /d "%~dp0"
call "%~dp0scripts\launch_game.bat" sa_debug
exit /b %ERRORLEVEL%
