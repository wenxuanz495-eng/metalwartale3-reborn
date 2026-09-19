@echo off
chcp 65001 >nul
setlocal EnableExtensions

rem 打开游戏更新公告（打包后位于 build\，仓库开发态回退 runtime\）
set "TARGET="
if exist "%~dp0build\游戏更新公告.txt" set "TARGET=%~dp0build\游戏更新公告.txt"
if not defined TARGET if exist "%~dp0runtime\游戏更新公告.txt" set "TARGET=%~dp0runtime\游戏更新公告.txt"

if not defined TARGET (
  echo [ERROR] Update notice TXT not found.
  echo Checked: "%~dp0build\游戏更新公告.txt" and "%~dp0runtime\游戏更新公告.txt"
  pause
  exit /b 1
)

start "" notepad.exe "%TARGET%"
exit /b 0
