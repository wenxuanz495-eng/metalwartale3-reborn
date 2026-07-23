@echo off
chcp 65001 >nul
setlocal EnableExtensions EnableDelayedExpansion

set "GOLDEN_ROOT=%~1"
set "OUTPUT_FILE=%~2"

if not defined GOLDEN_ROOT set "GOLDEN_ROOT=D:\superalloy\1.26.2.1-BAT\1.26.2.1"
if not defined OUTPUT_FILE set "OUTPUT_FILE=%~dp0..\docs\baselines\1.26.2.1-BAT.sha256"

for %%I in ("%GOLDEN_ROOT%") do set "GOLDEN_ROOT=%%~fI"
for %%I in ("%OUTPUT_FILE%") do set "OUTPUT_FILE=%%~fI"

if not exist "%GOLDEN_ROOT%\game.swf" goto missing_golden
if not exist "%GOLDEN_ROOT%\server.exe" goto missing_golden
if not exist "%GOLDEN_ROOT%\swf\" goto missing_golden

for %%I in ("%OUTPUT_FILE%") do if not exist "%%~dpI" mkdir "%%~dpI"

set "TEMP_LIST=%TEMP%\superalloy-golden-%RANDOM%-%RANDOM%.txt"
set "HASH_FAILED="
if exist "%TEMP_LIST%" del /q "%TEMP_LIST%"

echo Reading golden release without modifying it:
echo   %GOLDEN_ROOT%

for /r "%GOLDEN_ROOT%" %%F in (*) do (
  set "FULL=%%~fF"
  set "REL=!FULL:%GOLDEN_ROOT%\=!"
  call :should_include "!REL!"
  if not errorlevel 1 call :append_hash "%%~fF" "!REL!"
)

if defined HASH_FAILED goto hash_failed
if not exist "%TEMP_LIST%" goto no_files
move /y "%TEMP_LIST%" "%OUTPUT_FILE%" >nul

for /f %%C in ('find /c /v "" ^< "%OUTPUT_FILE%"') do set "FILE_COUNT=%%C"
echo Manifest written: %OUTPUT_FILE%
echo Included files : %FILE_COUNT%
exit /b 0

:should_include
set "REL=%~1"
if /i "!REL:~0,6!"=="saves\" exit /b 1
if /i "!REL!"=="game_save.bin" exit /b 1
if /i "!REL!"=="game_save.last-good.bin" exit /b 1
if /i "!REL!"=="saves.db" exit /b 1
if /i "!REL!"=="yagao.json" exit /b 1
if /i "!REL!"=="client_errors.log" exit /b 1
if /i "!REL:~-4!"==".log" exit /b 1
exit /b 0

:append_hash
set "HASH="
for /f "skip=1 tokens=*" %%H in ('certutil -hashfile "%~1" SHA256 2^>nul') do (
  if not defined HASH set "HASH=%%H"
)
if not defined HASH (
  echo [ERROR] Could not hash: %~1
  set "HASH_FAILED=1"
  exit /b 2
)
set "HASH=!HASH: =!"
>>"%TEMP_LIST%" echo !HASH! *%~2
exit /b 0

:missing_golden
echo [ERROR] Golden release is missing or incomplete:
echo   %GOLDEN_ROOT%
exit /b 1

:no_files
echo [ERROR] No distributable files were found.
exit /b 2

:hash_failed
if exist "%TEMP_LIST%" del /q "%TEMP_LIST%" >nul 2>nul
echo [ERROR] Manifest was not written because at least one file could not be hashed.
exit /b 3
