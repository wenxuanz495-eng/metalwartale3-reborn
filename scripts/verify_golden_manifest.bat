@echo off
chcp 65001 >nul
setlocal EnableExtensions EnableDelayedExpansion

set "GOLDEN_ROOT=%~1"
set "MANIFEST=%~2"

if not defined GOLDEN_ROOT set "GOLDEN_ROOT=D:\superalloy\1.26.2.1-BAT\1.26.2.1"
if not defined MANIFEST set "MANIFEST=%~dp0..\docs\baselines\1.26.2.1-BAT.sha256"

for %%I in ("%GOLDEN_ROOT%") do set "GOLDEN_ROOT=%%~fI"
for %%I in ("%MANIFEST%") do set "MANIFEST=%%~fI"

if not exist "%GOLDEN_ROOT%\" goto missing_golden
if not exist "%MANIFEST%" goto missing_manifest

set /a CHECKED=0
set /a ERRORS=0
echo Verifying golden release without modifying it:
echo   %GOLDEN_ROOT%

for /f "usebackq tokens=1,*" %%H in ("%MANIFEST%") do call :verify_one "%%H" "%%I"

if !CHECKED! EQU 0 (
  echo [ERROR] Manifest is empty.
  exit /b 2
)
if !ERRORS! NEQ 0 (
  echo [ERROR] Golden release verification failed: !ERRORS! errors.
  exit /b 3
)

echo Golden release verified: !CHECKED! files unchanged.
exit /b 0

:verify_one
set "EXPECTED=%~1"
set "ENTRY=%~2"
set "REL=!ENTRY:~1!"
set "FILE=%GOLDEN_ROOT%\!REL!"
set /a CHECKED+=1
if defined GOLDEN_VERIFY_VERBOSE echo [CHECK] !REL!

if not exist "!FILE!" (
  echo [MISSING] !REL!
  set /a ERRORS+=1
  exit /b 0
)

set "ACTUAL="
for /f "skip=1 tokens=*" %%A in ('certutil -hashfile "!FILE!" SHA256 2^>nul') do (
  if not defined ACTUAL set "ACTUAL=%%A"
)
set "ACTUAL=!ACTUAL: =!"
if /i not "!ACTUAL!"=="!EXPECTED!" (
  echo [CHANGED] !REL!
  set /a ERRORS+=1
)
exit /b 0

:missing_golden
echo [ERROR] Golden release directory not found:
echo   %GOLDEN_ROOT%
exit /b 1

:missing_manifest
echo [ERROR] Manifest not found:
echo   %MANIFEST%
exit /b 1
