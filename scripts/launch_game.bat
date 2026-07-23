@echo off
setlocal EnableExtensions EnableDelayedExpansion

set "CHECK_ONLY="
set "SMOKE_ONLY="
set "PLAYER_TYPE=%~1"
if /i "%~1"=="--check" (
  set "CHECK_ONLY=1"
  set "PLAYER_TYPE=%~2"
)
if /i "%~1"=="--smoke" (
  set "SMOKE_ONLY=1"
  set "PLAYER_TYPE=%~2"
)
if not defined PLAYER_TYPE set "PLAYER_TYPE=sa"

set "REPO_ROOT=%~dp0.."
for %%I in ("%REPO_ROOT%") do set "REPO_ROOT=%%~fI"
set "BUILD_DIR=%REPO_ROOT%\build"
set "SERVER=%BUILD_DIR%\server.exe"
set "GAME=%BUILD_DIR%\game.swf"
set "PLAYER="
set "PLAYER_IMAGE="
set "SERVER_TITLE=SA_COLLAB_SERVER_%RANDOM%_%RANDOM%"
set "PORT="

if /i "%PLAYER_TYPE%"=="sa" (
  if exist "%REPO_ROOT%\tools\debug\flashplayer_sa.exe" set "PLAYER=%REPO_ROOT%\tools\debug\flashplayer_sa.exe"
  if not defined PLAYER if exist "D:\superalloy\flashplayer_sa.exe" set "PLAYER=D:\superalloy\flashplayer_sa.exe"
)
if /i "%PLAYER_TYPE%"=="sa_debug" (
  if exist "%REPO_ROOT%\tools\debug\flashplayer_sa_debug.exe" set "PLAYER=%REPO_ROOT%\tools\debug\flashplayer_sa_debug.exe"
  if not defined PLAYER if exist "D:\superalloy\flashplayer_32_sa_debug.exe" set "PLAYER=D:\superalloy\flashplayer_32_sa_debug.exe"
  if not defined PLAYER if exist "D:\superalloy\flashplayer_sa_debug.exe" set "PLAYER=D:\superalloy\flashplayer_sa_debug.exe"
)

if not exist "%SERVER%" goto missing_build
if not exist "%GAME%" goto missing_build
if not defined PLAYER goto missing_player
where curl.exe >nul 2>nul
if errorlevel 1 goto missing_curl

call "%~dp0prepare_build_runtime.bat"
if errorlevel 1 exit /b %ERRORLEVEL%

if defined CHECK_ONLY (
  echo [OK] Pure BAT game prerequisites are ready.
  echo Player: %PLAYER%
  exit /b 0
)

call :cleanup_servers
echo Starting collaboration build with pure BAT...
echo Player: %PLAYER%

for /l %%P in (8765,1,8805) do (
  if not defined PORT (
    set "SERVER_TITLE=SA_COLLAB_SERVER_!RANDOM!_!RANDOM!"
    start "!SERVER_TITLE!" /min cmd.exe /d /c ""%SERVER%" -host 127.0.0.1 -port %%P -root "%BUILD_DIR%""
    call :wait_server %%P
    if not errorlevel 1 (
      set "PORT=%%P"
    ) else (
      taskkill /f /t /fi "WINDOWTITLE eq !SERVER_TITLE!" >nul 2>nul
    )
  )
)

if not defined PORT goto server_failed
echo Local server ready on port !PORT!.
if defined SMOKE_ONLY (
  call :cleanup_servers
  echo [OK] Pure BAT game server smoke test passed.
  exit /b 0
)
if not exist "%BUILD_DIR%\saves\game_save.bin" if exist "%BUILD_DIR%\swf\empty-save-template.bin" copy /y "%BUILD_DIR%\swf\empty-save-template.bin" "%BUILD_DIR%\saves\game_save.bin" >nul
"%PLAYER%" "http://127.0.0.1:!PORT!/game.swf?localrun=!RANDOM!!RANDOM!"
set "GAME_ERROR=!ERRORLEVEL!"
call :cleanup_servers
if not "!GAME_ERROR!"=="0" goto player_failed
exit /b 0

:wait_server
for /l %%W in (1,1,30) do (
  curl.exe --silent --fail --max-time 1 -o "%TEMP%\sa-collab-status-%~1.tmp" "http://127.0.0.1:%~1/api/status" 2>nul
  if not errorlevel 1 (
    findstr /i /c:"backend" "%TEMP%\sa-collab-status-%~1.tmp" >nul 2>nul
    if not errorlevel 1 (
      del /q "%TEMP%\sa-collab-status-%~1.tmp" >nul 2>nul
      exit /b 0
    )
  )
  ping 127.0.0.1 -n 2 -w 200 >nul
)
del /q "%TEMP%\sa-collab-status-%~1.tmp" >nul 2>nul
exit /b 1

:cleanup_servers
taskkill /f /t /fi "WINDOWTITLE eq SA_COLLAB_SERVER_*" >nul 2>nul
ping 127.0.0.1 -n 2 -w 200 >nul
exit /b 0

:missing_build
echo [ERROR] Missing build\server.exe or build\game.swf.
echo Run build.bat before launching the game.
exit /b 1

:missing_player
echo [ERROR] Flash player not found for type: %PLAYER_TYPE%
exit /b 2

:missing_curl
echo [ERROR] Windows curl.exe is required for the local server health check.
exit /b 3

:server_failed
echo [ERROR] Could not start the local server on ports 8765-8805.
pause
exit /b 4

:player_failed
echo [ERROR] Flash Player exited with code !GAME_ERROR!.
pause
exit /b !GAME_ERROR!
