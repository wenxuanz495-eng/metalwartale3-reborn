@echo off
setlocal EnableExtensions
cd /d "%~dp0"

tasklist /fi "IMAGENAME eq flashplayer_sa.exe" 2>nul | find /i "flashplayer_sa.exe" >nul
if not errorlevel 1 goto game_running
tasklist /fi "IMAGENAME eq flashplayer_sa_debug.exe" 2>nul | find /i "flashplayer_sa_debug.exe" >nul
if not errorlevel 1 goto game_running

echo This permanently deletes all files under:
echo %CD%\build\saves
echo.
choice /C YN /N /M "Continue? [Y/N]: "
if errorlevel 2 exit /b 0

if not exist "build\saves" mkdir "build\saves"
pushd "build\saves"
del /f /q * >nul 2>nul
for /d %%D in (*) do rd /s /q "%%D"
popd
if not exist "build\saves\backups" mkdir "build\saves\backups"

echo All collaboration saves have been cleared.
pause
exit /b 0

:game_running
echo [ERROR] Close the game before clearing saves.
pause
exit /b 1
