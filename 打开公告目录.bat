@echo off
chcp 65001 >nul
setlocal EnableExtensions

rem 打开公告目录：同时可见 感谢公告.txt 与 游戏更新公告.txt（打包后位于 build\，仓库开发态回退 runtime\）
set "TARGET="
if exist "%~dp0build\游戏更新公告.txt" set "TARGET=%~dp0build"
if not defined TARGET if exist "%~dp0runtime\游戏更新公告.txt" set "TARGET=%~dp0runtime"

if not defined TARGET (
  echo [ERROR] Notice directory not found.
  echo Checked: "%~dp0build" and "%~dp0runtime"
  pause
  exit /b 1
)

start "" explorer.exe "%TARGET%"
exit /b 0
