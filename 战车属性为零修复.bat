@echo off
chcp 65001 >nul
setlocal
cd /d "%~dp0"
echo ============================================
echo  战车属性为零修复（一键，仅一次）
echo ============================================
echo 目标存档: build\saves\game_save.bin
echo 会重roll全0属性，并对已有长小数属性做四舍五入清理。
echo 请先完全退出游戏和修改器。
echo.
pause
if not exist "build\server.exe" (
  echo 缺少 build\server.exe ，请先运行 构建.bat
  pause
  exit /b 1
)
if not exist "build\saves\game_save.bin" (
  echo 缺少 build\saves\game_save.bin
  pause
  exit /b 1
)
if exist "build\saves\zero_car_affix_fixed.flag" (
  echo 一键修复已经使用过。请改用修改器多次修复入口。
  pause
  exit /b 2
)
"build\server.exe" --root "%CD%\build" --fix-zero-car-affix-once
set ERR=%ERRORLEVEL%
if not "%ERR%"=="0" (
  echo 修复失败，错误码=%ERR%
  pause
  exit /b %ERR%
)
echo 完成。
pause
exit /b 0