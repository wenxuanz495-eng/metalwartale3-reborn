@echo off
chcp 65001 >nul
setlocal EnableExtensions
cd /d "%~dp0.."

echo ==== Phase 4 gate ====
call "%~dp0verify_phase4.bat"
if errorlevel 1 exit /b %ERRORLEVEL%

echo ==== Three save fixtures ====
call "%~dp0verify_phase5_saves.bat"
if errorlevel 1 exit /b %ERRORLEVEL%

echo ==== New release ====
if exist "%~dp0..\release\1.26.3-source-synced" (
  call "%~dp0check_release.bat" "%~dp0..\release\1.26.3-source-synced"
  if errorlevel 1 exit /b %ERRORLEVEL%
) else (
  call "%~dp0build_release.bat"
  if errorlevel 1 exit /b %ERRORLEVEL%
)

echo ==== Golden reference recheck ====
call "%~dp0verify_golden_manifest.bat"
if errorlevel 1 exit /b %ERRORLEVEL%

echo [OK] Automated phase 5 verification passed.
exit /b 0
