@echo off
chcp 65001 >nul
setlocal EnableExtensions
cd /d "%~dp0"

echo ========================================
echo  生成或更新静音资源版
echo  目标：D:\superalloy\静音版
echo ========================================
echo.

call "%~dp0scripts\build_silent_preview.bat" "D:\superalloy\静音版"
set "BUILD_ERROR=%ERRORLEVEL%"
if not "%BUILD_ERROR%"=="0" (
  echo.
  echo [ERROR] 静音版生成失败，错误码：%BUILD_ERROR%
  pause
  exit /b %BUILD_ERROR%
)

echo.
echo [OK] 静音版已经更新：D:\superalloy\静音版
pause
exit /b 0
