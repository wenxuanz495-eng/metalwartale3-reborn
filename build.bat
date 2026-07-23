@echo off
setlocal EnableExtensions
cd /d "%~dp0"
call "%~dp0scripts\build_all.bat"
set "BUILD_ERROR=%ERRORLEVEL%"
if not "%BUILD_ERROR%"=="0" (
  echo.
  echo [ERROR] Pure BAT build failed with code %BUILD_ERROR%.
  pause
  exit /b %BUILD_ERROR%
)
echo.
echo Build completed. Run start-game-flashplayer_sa.bat to play.
pause
exit /b 0
