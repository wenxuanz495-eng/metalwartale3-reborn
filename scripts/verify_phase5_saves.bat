@echo off
chcp 65001 >nul
setlocal EnableExtensions EnableDelayedExpansion

set "REPO_ROOT=%~dp0.."
for %%I in ("%REPO_ROOT%") do set "REPO_ROOT=%%~fI"
set "TEST_ROOT=%REPO_ROOT%\build\phase5-tests"
set "SERVER=%REPO_ROOT%\build\server.exe"
set "GAME=%REPO_ROOT%\build\game.swf"
set "FRESH=%REPO_ROOT%\swf\empty-save-template.bin"
set "PROGRESS=D:\superalloy\归档\旧版本与压缩包\1.26\saves\game_save.bin"
set "LEGACY=D:\superalloy\归档\存档备份\1.1老存档兼容迁移样本-20260722\saves\game_save.bin"

if /i not "%TEST_ROOT%"=="%REPO_ROOT%\build\phase5-tests" goto unsafe_path
if not exist "%SERVER%" goto missing_input
if not exist "%GAME%" goto missing_input
if not exist "%FRESH%" goto missing_input
if not exist "%PROGRESS%" goto missing_input
if not exist "%LEGACY%" goto missing_input
where curl.exe >nul 2>nul
if errorlevel 1 goto missing_tool
where node.exe >nul 2>nul
if errorlevel 1 goto missing_tool

call :cleanup
if exist "%TEST_ROOT%" rd /s /q "%TEST_ROOT%"
mkdir "%TEST_ROOT%"

call :test_fixture fresh "%FRESH%" 8891
if errorlevel 1 exit /b %ERRORLEVEL%
call :test_fixture progress "%PROGRESS%" 8892
if errorlevel 1 exit /b %ERRORLEVEL%
call :test_fixture legacy-1.1 "%LEGACY%" 8893
if errorlevel 1 exit /b %ERRORLEVEL%

call :cleanup
rd /s /q "%TEST_ROOT%" >nul 2>nul
echo [OK] Three isolated save round trips passed.
exit /b 0

:test_fixture
set "NAME=%~1"
set "SOURCE=%~2"
set "PORT=%~3"
set "ROOT=%TEST_ROOT%\!NAME!"
set "TITLE=SA_PHASE5_SAVE_!NAME!"
mkdir "!ROOT!\saves\backups"
copy /y "%GAME%" "!ROOT!\game.swf" >nul
copy /y "!SOURCE!" "!ROOT!\saves\game_save.bin" >nul
for %%F in ("!ROOT!\saves\game_save.bin") do set "ORIGINAL_SIZE=%%~zF"
start "!TITLE!" /min cmd.exe /d /c ""%SERVER%" -host 127.0.0.1 -port !PORT! -root "!ROOT!""
call :wait_server !PORT!
if errorlevel 1 (
  echo [ERROR] !NAME! server did not start.
  call :cleanup
  exit /b 10
)
curl.exe --silent --fail --max-time 5 -o "!ROOT!\editor-data.json" "http://127.0.0.1:!PORT!/api/editor/data"
if errorlevel 1 goto fixture_failed
node "%~dp0phase5_roundtrip.js" "!ROOT!\editor-data.json" "!ROOT!\save-request.json"
if errorlevel 1 goto fixture_failed
curl.exe --silent --fail --max-time 5 -H "Content-Type: application/json" --data-binary "@!ROOT!\save-request.json" -o "!ROOT!\save-response.json" "http://127.0.0.1:!PORT!/api/editor/save"
if errorlevel 1 goto fixture_failed
node "%~dp0phase5_roundtrip.js" --verify "!ROOT!\save-response.json"
if errorlevel 1 goto fixture_failed
curl.exe --silent --fail --max-time 5 -o "!ROOT!\roundtrip.bin" "http://127.0.0.1:!PORT!/api/game-save"
if errorlevel 1 goto fixture_failed
for %%F in ("!ROOT!\roundtrip.bin") do set "ROUNDTRIP_SIZE=%%~zF"
set "BACKUP_COUNT=0"
set "BACKUP_FILE="
for %%F in ("!ROOT!\saves\backups\*.bin") do if exist "%%~fF" (
  set /a BACKUP_COUNT+=1
  set "BACKUP_FILE=%%~fF"
)
if !BACKUP_COUNT! LSS 1 goto fixture_failed
call :hash_file "!BACKUP_FILE!" BACKUP_HASH
call :hash_file "!SOURCE!" SOURCE_HASH
if /i not "!BACKUP_HASH!"=="!SOURCE_HASH!" goto fixture_failed
taskkill /f /t /fi "WINDOWTITLE eq !TITLE!" >nul 2>nul
echo [OK] !NAME!: !ORIGINAL_SIZE! -^> !ROUNDTRIP_SIZE! bytes, backup preserved.
exit /b 0

:wait_server
for /l %%W in (1,1,30) do (
  curl.exe --silent --fail --max-time 1 -o nul "http://127.0.0.1:%~1/api/status" 2>nul
  if not errorlevel 1 exit /b 0
  ping 127.0.0.1 -n 2 -w 200 >nul
)
exit /b 1

:hash_file
set "HASH_TEMP="
for /f "skip=1 tokens=*" %%H in ('certutil -hashfile %~1 SHA256 2^>nul') do if not defined HASH_TEMP set "HASH_TEMP=%%H"
set "HASH_TEMP=!HASH_TEMP: =!"
set "%~2=!HASH_TEMP!"
exit /b 0

:cleanup
taskkill /f /t /fi "WINDOWTITLE eq SA_PHASE5_SAVE_*" >nul 2>nul
exit /b 0

:fixture_failed
echo [ERROR] Save round trip failed: !NAME!
call :cleanup
rd /s /q "%TEST_ROOT%" >nul 2>nul
exit /b 11

:unsafe_path
echo [ERROR] Unsafe phase 5 test directory.
exit /b 1

:missing_input
echo [ERROR] A phase 5 save fixture or build input is missing.
exit /b 2

:missing_tool
echo [ERROR] curl.exe and node.exe are required for save round-trip verification.
exit /b 3
