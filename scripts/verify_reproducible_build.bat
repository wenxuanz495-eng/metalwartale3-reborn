@echo off
chcp 65001 >nul
setlocal EnableExtensions EnableDelayedExpansion

set "REPO_ROOT=%~dp0.."
for %%I in ("%REPO_ROOT%") do set "REPO_ROOT=%%~fI"
set "BUILD_DIR=%REPO_ROOT%\build"
set "CHECK_DIR=%BUILD_DIR%\reproducibility-check"
set "EXPORT_DIR=%CHECK_DIR%\binary-data"
set "FFDEC=%REPO_ROOT%\tools\packaging\ffdec\ffdec-cli.exe"
set "XML_SOURCE=%REPO_ROOT%\decompiled\embedded-xml-assets"
set "BASELINE=%REPO_ROOT%\swf\baselines\1.26.2.1-BAT.game.swf"
set "XML_COUNT=0"
set "XML_ERRORS=0"

if /i not "%CHECK_DIR%"=="%REPO_ROOT%\build\reproducibility-check" goto unsafe_path
if exist "%CHECK_DIR%" rd /s /q "%CHECK_DIR%"
mkdir "%CHECK_DIR%"

echo Reproducibility pass 1...
call "%~dp0build_swf.bat"
if errorlevel 1 exit /b %ERRORLEVEL%
copy /y "%BUILD_DIR%\game.swf" "%CHECK_DIR%\game-first.swf" >nul

echo Reproducibility pass 2...
call "%~dp0build_swf.bat"
if errorlevel 1 exit /b %ERRORLEVEL%
copy /y "%BUILD_DIR%\game.swf" "%CHECK_DIR%\game-second.swf" >nul

fc /b "%CHECK_DIR%\game-first.swf" "%CHECK_DIR%\game-second.swf" >nul
if errorlevel 1 goto nondeterministic

echo Exporting embedded BinaryData for source verification...
mkdir "%EXPORT_DIR%"
"%FFDEC%" -onerror abort -export binaryData "%EXPORT_DIR%" "%BUILD_DIR%\game.swf" >"%CHECK_DIR%\binary-export.log" 2>"%CHECK_DIR%\binary-export.err"
if errorlevel 1 goto export_failed

for %%F in ("%XML_SOURCE%\*.bin") do call :compare_xml "%%~fF" "%%~nxF"
if not "!XML_COUNT!"=="21" goto xml_count_failed
if not "!XML_ERRORS!"=="0" goto xml_compare_failed

call :count_manifest "%REPO_ROOT%\config\build\swf-script-patches.txt" SCRIPT_PATCHES
call :count_manifest "%REPO_ROOT%\config\build\swf-binary-patches.txt" BINARY_PATCHES
if "!SCRIPT_PATCHES!"=="0" if "!BINARY_PATCHES!"=="0" (
  fc /b "%BASELINE%" "%BUILD_DIR%\game.swf" >nul
  if errorlevel 1 goto baseline_mismatch
)

call :hash_file "%BUILD_DIR%\game.swf" OUTPUT_HASH
echo [OK] Reproducible SWF build verified.
echo SHA256=!OUTPUT_HASH!
echo BinaryData verified: !XML_COUNT!
echo Script patches: !SCRIPT_PATCHES!
echo Binary patches: !BINARY_PATCHES!
exit /b 0

:compare_xml
set /a XML_COUNT+=1
if not exist "%EXPORT_DIR%\%~2" (
  echo [MISSING] Exported BinaryData %~2
  set /a XML_ERRORS+=1
  exit /b 0
)
fc /b "%~1" "%EXPORT_DIR%\%~2" >nul
if errorlevel 1 (
  echo [DIFFERENT] BinaryData %~2
  set /a XML_ERRORS+=1
)
exit /b 0

:count_manifest
set /a MANIFEST_COUNT=0
for /f "usebackq eol=# delims=" %%L in ("%~1") do set /a MANIFEST_COUNT+=1
set "%~2=!MANIFEST_COUNT!"
exit /b 0

:hash_file
set "HASH_TEMP="
for /f "skip=1 tokens=*" %%H in ('certutil -hashfile "%~1" SHA256 2^>nul') do if not defined HASH_TEMP set "HASH_TEMP=%%H"
set "HASH_TEMP=!HASH_TEMP: =!"
set "%~2=!HASH_TEMP!"
exit /b 0

:unsafe_path
echo [ERROR] Refusing to clear an unexpected reproducibility directory.
exit /b 1

:nondeterministic
echo [ERROR] Two consecutive SWF builds are not byte-identical.
exit /b 2

:export_failed
echo [ERROR] FFDec BinaryData export failed.
exit /b 3

:xml_count_failed
echo [ERROR] Expected 21 embedded XML files, found !XML_COUNT!.
exit /b 4

:xml_compare_failed
echo [ERROR] Embedded BinaryData differs from source: !XML_ERRORS! errors.
exit /b 5

:baseline_mismatch
echo [ERROR] Empty patch manifests must reproduce the immutable baseline exactly.
exit /b 6
