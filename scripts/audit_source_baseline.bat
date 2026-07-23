@echo off
chcp 65001 >nul
setlocal EnableExtensions EnableDelayedExpansion

set "REPO_ROOT=%~dp0.."
for %%I in ("%REPO_ROOT%") do set "REPO_ROOT=%%~fI"
set "BUILD_DIR=%REPO_ROOT%\build"
set "AUDIT_ROOT=%BUILD_DIR%\source-baseline-audit"
set "STAGE=%AUDIT_ROOT%\staging"
set "RESULT=%AUDIT_ROOT%\results.tsv"
set "SOURCE_ROOT=%REPO_ROOT%\decompiled\gamefile\scripts"
set "BASELINE=%REPO_ROOT%\swf\baselines\1.26.2.1-BAT.game.swf"
set "FFDEC=%REPO_ROOT%\tools\packaging\ffdec\ffdec-cli.exe"
set /a TOTAL=0
set /a EXACT=0
set /a DIFFERENT=0
set /a FAILED=0

if /i not "%AUDIT_ROOT%"=="%REPO_ROOT%\build\source-baseline-audit" goto unsafe_path
if not exist "%BASELINE%" goto missing_input
if not exist "%FFDEC%" goto missing_input
if not exist "%SOURCE_ROOT%" goto missing_input
if exist "%AUDIT_ROOT%" rd /s /q "%AUDIT_ROOT%"
mkdir "%AUDIT_ROOT%"
>"%RESULT%" echo status	path	output_sha256

call :hash_file "%BASELINE%" BASELINE_HASH
echo Auditing each ActionScript class against the immutable baseline...

for /r "%SOURCE_ROOT%" %%F in (*.as) do call :audit_one "%%~fF"

echo.
echo Source baseline audit complete.
echo Total    : !TOTAL!
echo Exact    : !EXACT!
echo Different: !DIFFERENT!
echo Failed   : !FAILED!
echo Results  : %RESULT%

if not "!FAILED!"=="0" exit /b 3
exit /b 0

:audit_one
set "FULL=%~1"
set "REL=!FULL:%SOURCE_ROOT%\=!"
set /a TOTAL+=1

if exist "%STAGE%" rd /s /q "%STAGE%"
set "DEST=%STAGE%\scripts\!REL!"
for %%D in ("!DEST!") do if not exist "%%~dpD" mkdir "%%~dpD"
copy /y "!FULL!" "!DEST!" >nul
if errorlevel 1 goto audit_copy_failed

"%FFDEC%" -onerror abort -importScript "%BASELINE%" "%STAGE%\candidate.swf" "%STAGE%\scripts" >"%STAGE%\ffdec.log" 2>"%STAGE%\ffdec.err"
if errorlevel 1 goto audit_compile_failed
if not exist "%STAGE%\candidate.swf" goto audit_compile_failed

call :hash_file "%STAGE%\candidate.swf" CANDIDATE_HASH
if /i "!CANDIDATE_HASH!"=="!BASELINE_HASH!" (
  set /a EXACT+=1
  >>"%RESULT%" echo exact	!REL!	!CANDIDATE_HASH!
) else (
  set /a DIFFERENT+=1
  >>"%RESULT%" echo different	!REL!	!CANDIDATE_HASH!
  echo [DIFFERENT] !REL!
)
if !TOTAL! EQU 1 echo Checked !TOTAL! class...
set /a REMAINDER=TOTAL%%50
if !REMAINDER! EQU 0 echo Checked !TOTAL! classes...
exit /b 0

:audit_copy_failed
set /a FAILED+=1
>>"%RESULT%" echo copy_failed	!REL!	-
echo [COPY FAILED] !REL!
exit /b 0

:audit_compile_failed
set /a FAILED+=1
>>"%RESULT%" echo compile_failed	!REL!	-
echo [COMPILE FAILED] !REL!
exit /b 0

:hash_file
set "HASH_TEMP="
for /f "skip=1 tokens=*" %%H in ('certutil -hashfile "%~1" SHA256 2^>nul') do if not defined HASH_TEMP set "HASH_TEMP=%%H"
set "HASH_TEMP=!HASH_TEMP: =!"
set "%~2=!HASH_TEMP!"
exit /b 0

:unsafe_path
echo [ERROR] Refusing to clear an unexpected source audit directory.
exit /b 1

:missing_input
echo [ERROR] Missing source tree, immutable baseline, or FFDec.
exit /b 2
