@echo off
setlocal EnableExtensions
cd /d "%~dp0"

echo Cleaning collaboration game and modifier processes...
taskkill /f /t /fi "WINDOWTITLE eq SA_COLLAB_SERVER_*" >nul 2>nul
taskkill /f /t /fi "WINDOWTITLE eq SA_COLLAB_MODIFIER_*" >nul 2>nul
ping 127.0.0.1 -n 2 -w 200 >nul
taskkill /f /t /fi "WINDOWTITLE eq SA_COLLAB_SERVER_*" >nul 2>nul
taskkill /f /t /fi "WINDOWTITLE eq SA_COLLAB_MODIFIER_*" >nul 2>nul
echo Cleanup finished.
exit /b 0
