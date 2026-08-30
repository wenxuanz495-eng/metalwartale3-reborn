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
set "SAVE_DIR=%BUILD_DIR%\saves"
set "SERVER=%BUILD_DIR%\server.exe"
set "GAME=%BUILD_DIR%\game.swf"
set "PLAYER="
set "PLAYER_IMAGE="
set "CLEANFLASH_SHA256=7D492DB82A337D4457D53B3AAE5FB4041C3B2DDD580B5AA6610BF31202DEE979"
set "SERVER_TITLE=SA_COLLAB_SERVER_%RANDOM%_%RANDOM%"
set "SERVER_PID="
set "PORT="
set /a PORT_START=52000 + !RANDOM! %% 12000
set /a PORT_END=PORT_START + 40
set "INSTANCE_TOKEN=%RANDOM%%RANDOM%%RANDOM%"

if /i "%PLAYER_TYPE%"=="sa" (
  if exist "%REPO_ROOT%\tools\runtime\FlashPlayer.exe" set "PLAYER=%REPO_ROOT%\tools\runtime\FlashPlayer.exe"
)
if /i "%PLAYER_TYPE%"=="sa_debug" (
  if exist "%REPO_ROOT%\tools\debug\flashplayer_sa_debug.exe" set "PLAYER=%REPO_ROOT%\tools\debug\flashplayer_sa_debug.exe"
)

if not exist "%SERVER%" goto missing_build
if not exist "%GAME%" goto missing_build
if not defined PLAYER goto missing_player
if /i "%PLAYER_TYPE%"=="sa" call :verify_cleanflash
if errorlevel 1 exit /b %ERRORLEVEL%
where curl.exe >nul 2>nul
if errorlevel 1 goto missing_curl

if not exist "%SAVE_DIR%" mkdir "%SAVE_DIR%"
if not exist "%SAVE_DIR%" goto save_dir_failed
if not exist "%SAVE_DIR%\game_save.bin" if exist "%BUILD_DIR%\swf\empty-save-template.bin" copy /y "%BUILD_DIR%\swf\empty-save-template.bin" "%SAVE_DIR%\game_save.bin" >nul
if not exist "%SAVE_DIR%\game_save.bin" goto save_seed_failed

if not exist "%BUILD_DIR%\.release-ready" (
  echo [CHECK] Verifying 175 tracked runtime resources before launch...
  echo [CHECK] If the window title starts with Select, press Esc to resume.
  call "%~dp0prepare_build_runtime.bat"
  if errorlevel 1 exit /b %ERRORLEVEL%
)


if defined CHECK_ONLY (
  echo [OK] Pure BAT game prerequisites are ready.
  echo Player: %PLAYER%
  exit /b 0
)

call :cleanup_servers
echo Starting collaboration build with pure BAT...
echo Player: %PLAYER%

for /l %%P in (!PORT_START!,1,!PORT_END!) do (
  if not defined PORT (
    set "SERVER_TITLE=SA_COLLAB_SERVER_!RANDOM!_!RANDOM!"
    for /f "delims=" %%I in ('powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -Command "$rootArg=[char]34+$env:BUILD_DIR+[char]34; $args=@('-host','127.0.0.1','-port','%%P','-root',$rootArg,'-instance',$env:INSTANCE_TOKEN); $p=Start-Process -FilePath $env:SERVER -ArgumentList $args -WindowStyle Hidden -PassThru; $p.Id" 2^>nul') do set "SERVER_PID=%%I"
    if defined SERVER_PID (
      call :wait_server %%P !INSTANCE_TOKEN!
      if not errorlevel 1 (
        set "PORT=%%P"
      ) else (
        taskkill /f /t /pid !SERVER_PID! >nul 2>nul
        set "SERVER_PID="
      )
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
"%PLAYER%" "http://127.0.0.1:!PORT!/game.swf?localrun=!RANDOM!!RANDOM!"
set "GAME_ERROR=!ERRORLEVEL!"
curl.exe --silent --fail --max-time 2 -X POST "http://127.0.0.1:!PORT!/api/shutdown" >nul 2>nul
for /l %%W in (1,1,20) do (
  if not defined SERVER_PID goto shutdown_wait_done
  tasklist /fi "PID eq !SERVER_PID!" | findstr /r /c:" !SERVER_PID! " >nul 2>nul
  if errorlevel 1 goto shutdown_wait_done
  ping 127.0.0.1 -n 1 -w 100 >nul
)
:shutdown_wait_done
call :cleanup_servers
if not "!GAME_ERROR!"=="0" goto player_failed
exit /b 0

:wait_server
for /l %%W in (1,1,30) do (
  curl.exe --silent --fail --max-time 1 -o "%TEMP%\sa-collab-status-%~1.tmp" "http://127.0.0.1:%~1/api/status" 2>nul
  if not errorlevel 1 (
    findstr /i /c:"%~2" "%TEMP%\sa-collab-status-%~1.tmp" >nul 2>nul
    if not errorlevel 1 (
      del /q "%TEMP%\sa-collab-status-%~1.tmp" >nul 2>nul
      exit /b 0
    )
    del /q "%TEMP%\sa-collab-status-%~1.tmp" >nul 2>nul
    exit /b 2
  )
  ping 127.0.0.1 -n 2 -w 200 >nul
)
del /q "%TEMP%\sa-collab-status-%~1.tmp" >nul 2>nul
exit /b 1

:cleanup_servers
if defined SERVER_PID taskkill /f /t /pid !SERVER_PID! >nul 2>nul
set "SERVER_PID="
taskkill /f /t /fi "WINDOWTITLE eq SA_COLLAB_SERVER_*" >nul 2>nul
ping 127.0.0.1 -n 2 -w 200 >nul
exit /b 0

:verify_cleanflash
set "PLAYER_SHA256="
for /f "skip=1 tokens=*" %%H in ('certutil -hashfile "%PLAYER%" SHA256 2^>nul') do if not defined PLAYER_SHA256 set "PLAYER_SHA256=%%H"
set "PLAYER_SHA256=%PLAYER_SHA256: =%"
if /i not "%PLAYER_SHA256%"=="%CLEANFLASH_SHA256%" goto invalid_player
exit /b 0

:invalid_player
echo [ERROR] The repository player must be CleanFlash SA 34.0.0.330.
echo [ERROR] Flash Player 29 and Debug Player are forbidden for SA launches.
echo SHA-256: %PLAYER_SHA256%
exit /b 5

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
echo [ERROR] Could not start the local server on high ports !PORT_START!-!PORT_END!.
pause
exit /b 4

:save_dir_failed
echo [ERROR] Cannot create the authoritative save directory:
echo %SAVE_DIR%
echo Check folder permissions or security software, then move the game to a writable folder.
pause
exit /b 6

:save_seed_failed
echo [ERROR] Cannot create the initial authoritative save file:
echo %SAVE_DIR%\game_save.bin
echo Check folder permissions or security software. The game will not start without a writable save path.
pause
exit /b 7

:player_failed
echo [ERROR] Flash Player exited with code !GAME_ERROR!.
pause
exit /b !GAME_ERROR!
