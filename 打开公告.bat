@echo off
setlocal EnableExtensions EnableDelayedExpansion

set "BEST_FILE="
set "BEST_SIZE=-1"

for %%D in ("%~dp0build" "%~dp0runtime") do (
  if exist "%%~fD\" (
    for %%F in ("%%~fD\*.txt") do (
      if %%~zF GTR !BEST_SIZE! (
        set "BEST_FILE=%%~fF"
        set "BEST_SIZE=%%~zF"
      )
    )
  )
)

if not defined BEST_FILE (
  echo [ERROR] Update notice TXT was not found.
  echo Checked: "%~dp0build" and "%~dp0runtime"
  pause
  exit /b 1
)

start "" notepad.exe "%BEST_FILE%"
exit /b 0
