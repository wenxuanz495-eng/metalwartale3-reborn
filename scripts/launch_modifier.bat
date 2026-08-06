@echo off
setlocal EnableExtensions EnableDelayedExpansion

set "CHECK_ONLY="
set "SMOKE_ONLY="
if /i "%~1"=="--check" set "CHECK_ONLY=1"
if /i "%~1"=="--smoke" set "SMOKE_ONLY=1"

set "REPO_ROOT=%~dp0.."
for %%I in ("%REPO_ROOT%") do set "REPO_ROOT=%%~fI"
set "BUILD_DIR=%REPO_ROOT%\build"
set "SAVE_DIR=%BUILD_DIR%\saves"
set "ENGINE=%BUILD_DIR%\server.exe"
set "MODIFIER_SOURCE=%REPO_ROOT%\modifier.html"
set "MODIFIER=%BUILD_DIR%\modifier.html"
set "ENGINE_TITLE=SA_COLLAB_MODIFIER_%RANDOM%_%RANDOM%"
set "BROWSER="
set "PORT="
set /a PORT_START=52000 + !RANDOM! %% 12000
set /a PORT_END=PORT_START + 40
set "BROWSER_PROFILE=%TEMP%\sa-collab-modifier-%RANDOM%-%RANDOM%"

if not exist "%ENGINE%" goto missing_build
where curl.exe >nul 2>nul
if errorlevel 1 goto missing_curl

if not exist "%BUILD_DIR%\.release-ready" (
  echo [CHECK] Verifying 175 tracked runtime resources before launch...
  echo [CHECK] If the window title starts with Select, press Esc to resume.
  call "%~dp0prepare_build_runtime.bat"
  if errorlevel 1 exit /b %ERRORLEVEL%
)
if not exist "%MODIFIER_SOURCE%" goto missing_modifier
copy /y "%MODIFIER_SOURCE%" "%MODIFIER%" >nul

if exist "%ProgramFiles%\Microsoft\Edge\Application\msedge.exe" set "BROWSER=%ProgramFiles%\Microsoft\Edge\Application\msedge.exe"
if not defined BROWSER if exist "%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe" set "BROWSER=%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe"
if not defined BROWSER if exist "%ProgramFiles%\Google\Chrome\Application\chrome.exe" set "BROWSER=%ProgramFiles%\Google\Chrome\Application\chrome.exe"
if not defined BROWSER if exist "%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe" set "BROWSER=%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe"

if defined CHECK_ONLY (
  echo [OK] Pure BAT modifier prerequisites are ready.
  if defined BROWSER echo Browser: !BROWSER!
  if not defined BROWSER echo Browser: system default fallback
  exit /b 0
)

tasklist /fi "IMAGENAME eq flashplayer_sa.exe" 2>nul | find /i "flashplayer_sa.exe" >nul
if not errorlevel 1 goto game_running
tasklist /fi "IMAGENAME eq flashplayer_sa_debug.exe" 2>nul | find /i "flashplayer_sa_debug.exe" >nul
if not errorlevel 1 goto game_running
tasklist /fi "IMAGENAME eq flashplayer_32_sa_debug.exe" 2>nul | find /i "flashplayer_32_sa_debug.exe" >nul
if not errorlevel 1 goto game_running

if defined SMOKE_ONLY goto start_engine

if exist "%SAVE_DIR%\game_save.bin" (
  copy /y "%SAVE_DIR%\game_save.bin" "%SAVE_DIR%\backups\game_save.before-modifier-!RANDOM!-!RANDOM!.bin" >nul
  if errorlevel 1 goto backup_failed
)

:start_engine
call :cleanup_modifier
echo Starting collaboration modifier with pure BAT...

for /l %%P in (!PORT_START!,1,!PORT_END!) do (
  if not defined PORT (
    set "ENGINE_TITLE=SA_COLLAB_MODIFIER_!RANDOM!_!RANDOM!"
    start "!ENGINE_TITLE!" /min cmd.exe /d /c ""%ENGINE%" -host 127.0.0.1 -port %%P -root "%BUILD_DIR%""
    call :wait_engine %%P
    if not errorlevel 1 (
      set "PORT=%%P"
    ) else (
      taskkill /f /t /fi "WINDOWTITLE eq !ENGINE_TITLE!" >nul 2>nul
    )
  )
)

if not defined PORT goto engine_failed
set "MODIFIER_URL=http://127.0.0.1:!PORT!/modifier.html"
echo Modifier ready: !MODIFIER_URL!
if defined SMOKE_ONLY (
  curl.exe --silent --fail --max-time 2 -o nul "!MODIFIER_URL!"
  if errorlevel 1 (
    call :cleanup_modifier
    goto modifier_page_failed
  )
  call :cleanup_modifier
  echo [OK] Pure BAT modifier server smoke test passed.
  exit /b 0
)

if defined BROWSER (
  start "" /wait "!BROWSER!" "--app=!MODIFIER_URL!" "--user-data-dir=!BROWSER_PROFILE!" --no-first-run --disable-background-mode
) else (
  start "" "!MODIFIER_URL!"
  echo Close the modifier page, then return here and press any key.
  pause >nul
)

call :cleanup_modifier
if exist "!BROWSER_PROFILE!" rd /s /q "!BROWSER_PROFILE!" >nul 2>nul
exit /b 0

:wait_engine
for /l %%W in (1,1,30) do (
  curl.exe --silent --fail --max-time 1 -o "%TEMP%\sa-collab-modifier-%~1.tmp" "http://127.0.0.1:%~1/api/status" 2>nul
  if not errorlevel 1 (
    findstr /i /c:"backend" "%TEMP%\sa-collab-modifier-%~1.tmp" >nul 2>nul
    if not errorlevel 1 (
      del /q "%TEMP%\sa-collab-modifier-%~1.tmp" >nul 2>nul
      exit /b 0
    )
  )
  ping 127.0.0.1 -n 2 -w 200 >nul
)
del /q "%TEMP%\sa-collab-modifier-%~1.tmp" >nul 2>nul
exit /b 1

:cleanup_modifier
taskkill /f /t /fi "WINDOWTITLE eq SA_COLLAB_MODIFIER_*" >nul 2>nul
ping 127.0.0.1 -n 2 -w 200 >nul
exit /b 0

:missing_build
echo [ERROR] Missing build\server.exe. Run build.bat first.
exit /b 1

:missing_modifier
echo [ERROR] Missing modifier.html in the game root directory.
exit /b 2

:missing_curl
echo [ERROR] Windows curl.exe is required for the local server health check.
exit /b 3

:game_running
echo [ERROR] Close the game before opening the modifier.
pause
exit /b 4

:backup_failed
echo [ERROR] Save backup failed. Modifier was not started.
pause
exit /b 5

:engine_failed
echo [ERROR] Modifier engine could not start on high ports !PORT_START!-!PORT_END!.
pause
exit /b 6

:modifier_page_failed
echo [ERROR] Modifier page health check failed.
exit /b 7
