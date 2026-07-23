@echo off
chcp 65001 >nul
setlocal EnableExtensions EnableDelayedExpansion

set "REPO_ROOT=%~dp0.."
for %%I in ("%REPO_ROOT%") do set "REPO_ROOT=%%~fI"
set "BUILD_DIR=%REPO_ROOT%\build"
set "BASELINE=%REPO_ROOT%\swf\baselines\1.26.2.1-BAT.game.swf"
set "BASELINE_HASH_FILE=%REPO_ROOT%\config\build\swf-baseline.sha256"
set "SCRIPT_MANIFEST=%REPO_ROOT%\config\build\swf-script-patches.txt"
set "BINARY_MANIFEST=%REPO_ROOT%\config\build\swf-binary-patches.txt"
set "FORBIDDEN_MANIFEST=%REPO_ROOT%\config\build\swf-forbidden-script-patches.txt"
set "RISKY_MANIFEST=%REPO_ROOT%\config\build\swf-risky-script-patches.txt"
set "APPROVAL_MANIFEST=%REPO_ROOT%\config\build\swf-risk-approvals.txt"
set "SCRIPT_SOURCE=%REPO_ROOT%\decompiled\gamefile\scripts"
set "FFDEC=%REPO_ROOT%\tools\packaging\ffdec\ffdec-cli.exe"
set "STAGE_ROOT=%BUILD_DIR%\swf-minimal-stage"
set "CANDIDATE_A=%BUILD_DIR%\game.candidate-a.swf"
set "CANDIDATE_B=%BUILD_DIR%\game.candidate-b.swf"
set "OUTPUT=%BUILD_DIR%\game.swf"
set "SCRIPT_COUNT=0"
set "BINARY_COUNT=0"
set "BUILD_FAILED="

if not "%~1"=="" for %%I in ("%~1") do set "SCRIPT_MANIFEST=%%~fI"
if not "%~2"=="" for %%I in ("%~2") do set "BINARY_MANIFEST=%%~fI"

if not exist "%BASELINE%" goto missing_input
if not exist "%BASELINE_HASH_FILE%" goto missing_input
if not exist "%SCRIPT_MANIFEST%" goto missing_input
if not exist "%BINARY_MANIFEST%" goto missing_input
if not exist "%FORBIDDEN_MANIFEST%" goto missing_input
if not exist "%RISKY_MANIFEST%" goto missing_input
if not exist "%APPROVAL_MANIFEST%" goto missing_input
if not exist "%FFDEC%" goto missing_input
if not exist "%BUILD_DIR%" mkdir "%BUILD_DIR%"

set "EXPECTED_HASH="
for /f "usebackq tokens=1" %%H in ("%BASELINE_HASH_FILE%") do if not defined EXPECTED_HASH set "EXPECTED_HASH=%%H"
call :hash_file "%BASELINE%" ACTUAL_HASH
if not defined ACTUAL_HASH goto baseline_hash_failed
if /i not "!ACTUAL_HASH!"=="!EXPECTED_HASH!" goto baseline_hash_failed

if exist "%STAGE_ROOT%" rd /s /q "%STAGE_ROOT%"
if exist "%CANDIDATE_A%" del /q "%CANDIDATE_A%"
if exist "%CANDIDATE_B%" del /q "%CANDIDATE_B%"
mkdir "%STAGE_ROOT%\scripts"
copy /y "%BASELINE%" "%CANDIDATE_A%" >nul
if errorlevel 1 goto build_error

for /f "usebackq eol=# delims=" %%L in ("%SCRIPT_MANIFEST%") do call :stage_script "%%L"
if defined BUILD_FAILED goto build_error

if !SCRIPT_COUNT! GTR 0 (
  echo Importing !SCRIPT_COUNT! explicit ActionScript patches...
  "%FFDEC%" -onerror abort -importScript "%CANDIDATE_A%" "%CANDIDATE_B%" "%STAGE_ROOT%\scripts" >"%BUILD_DIR%\ffdec-script.log" 2>"%BUILD_DIR%\ffdec-script.err"
  if errorlevel 1 goto ffdec_script_error
  move /y "%CANDIDATE_B%" "%CANDIDATE_A%" >nul
  if errorlevel 1 goto build_error
)

for /f "usebackq eol=# tokens=1,* delims=|" %%A in ("%BINARY_MANIFEST%") do call :apply_binary "%%A" "%%B"
if defined BUILD_FAILED goto build_error

if not exist "%CANDIDATE_A%" goto build_error
move /y "%CANDIDATE_A%" "%OUTPUT%" >nul
if errorlevel 1 goto deploy_error

call :hash_file "%OUTPUT%" OUTPUT_HASH
echo [OK] SWF built with pure BAT.
echo Scripts imported : !SCRIPT_COUNT!
echo BinaryData patched: !BINARY_COUNT!
echo SHA256=!OUTPUT_HASH!
exit /b 0

:stage_script
set "REL=%~1"
if not defined REL exit /b 0
echo(!REL!| findstr /l /c:".." >nul && set "BUILD_FAILED=invalid script path: !REL!" && exit /b 0
echo(!REL!| findstr /l /c:":" >nul && set "BUILD_FAILED=invalid script path: !REL!" && exit /b 0
set "SOURCE=%SCRIPT_SOURCE%\!REL!"
set "DEST=%STAGE_ROOT%\scripts\!REL!"
if not exist "!SOURCE!" (
  set "BUILD_FAILED=missing script: !REL!"
  exit /b 0
)
call :list_contains "%FORBIDDEN_MANIFEST%" "!REL!" IS_FORBIDDEN
if defined IS_FORBIDDEN (
  set "BUILD_FAILED=script must use BinaryData patching instead: !REL!"
  exit /b 0
)
call :list_contains "%RISKY_MANIFEST%" "!REL!" IS_RISKY
if defined IS_RISKY (
  call :hash_file "!SOURCE!" RISK_HASH
  call :list_contains "%APPROVAL_MANIFEST%" "!REL!^|!RISK_HASH!" IS_APPROVED
  if not defined IS_APPROVED (
    set "BUILD_FAILED=risky script lacks P-code approval for current hash: !REL!"
    exit /b 0
  )
)
for %%D in ("!DEST!") do if not exist "%%~dpD" mkdir "%%~dpD"
copy /y "!SOURCE!" "!DEST!" >nul
if errorlevel 1 (
  set "BUILD_FAILED=copy failed: !REL!"
  exit /b 0
)
set /a SCRIPT_COUNT+=1
exit /b 0

:apply_binary
set "CHAR_ID=%~1"
set "REL=%~2"
if not defined CHAR_ID exit /b 0
if not defined REL (
  set "BUILD_FAILED=missing BinaryData path for id !CHAR_ID!"
  exit /b 0
)
echo(!REL!| findstr /l /c:".." >nul && set "BUILD_FAILED=invalid BinaryData path: !REL!" && exit /b 0
echo(!REL!| findstr /l /c:":" >nul && set "BUILD_FAILED=invalid BinaryData path: !REL!" && exit /b 0
set "SOURCE=%REPO_ROOT%\!REL!"
if not exist "!SOURCE!" (
  set "BUILD_FAILED=missing BinaryData: !REL!"
  exit /b 0
)
echo Replacing BinaryData character !CHAR_ID!: !REL!
"%FFDEC%" -replace "%CANDIDATE_A%" "%CANDIDATE_B%" !CHAR_ID! "!SOURCE!" >"%BUILD_DIR%\ffdec-binary-!CHAR_ID!.log" 2>"%BUILD_DIR%\ffdec-binary-!CHAR_ID!.err"
if errorlevel 1 (
  set "BUILD_FAILED=FFDec BinaryData replace failed: !CHAR_ID!"
  exit /b 0
)
move /y "%CANDIDATE_B%" "%CANDIDATE_A%" >nul
if errorlevel 1 (
  set "BUILD_FAILED=BinaryData candidate move failed"
  exit /b 0
)
set /a BINARY_COUNT+=1
exit /b 0

:hash_file
set "HASH_TEMP="
for /f "skip=1 tokens=*" %%H in ('certutil -hashfile "%~1" SHA256 2^>nul') do if not defined HASH_TEMP set "HASH_TEMP=%%H"
set "HASH_TEMP=!HASH_TEMP: =!"
set "%~2=!HASH_TEMP!"
exit /b 0

:list_contains
set "%~3="
for /f "usebackq eol=# delims=" %%L in ("%~1") do if /i "%%L"=="%~2" set "%~3=1"
exit /b 0

:missing_input
echo [ERROR] Missing SWF baseline, manifest, or FFDec tool.
exit /b 1

:baseline_hash_failed
echo [ERROR] Immutable SWF baseline hash mismatch.
echo Expected: !EXPECTED_HASH!
echo Actual  : !ACTUAL_HASH!
exit /b 2

:ffdec_script_error
echo [ERROR] FFDec script import failed. See build\ffdec-script.err.
exit /b 3

:build_error
echo [ERROR] SWF build failed: !BUILD_FAILED!
exit /b 4

:deploy_error
echo [ERROR] SWF was built but could not replace build\game.swf.
exit /b 5
