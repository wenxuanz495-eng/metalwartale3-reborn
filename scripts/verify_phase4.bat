@echo off
chcp 65001 >nul
setlocal EnableExtensions
cd /d "%~dp0.."

echo ==== Phase 3 gate ====
call "%~dp0verify_phase3.bat"
if errorlevel 1 exit /b %ERRORLEVEL%

echo ==== Game entry checks ====
call "%~dp0launch_game.bat" --check sa
if errorlevel 1 exit /b 20
call "%~dp0launch_game.bat" --check sa_debug
if errorlevel 1 exit /b 21

echo ==== Modifier entry check ====
call "%~dp0launch_modifier.bat" --check
if errorlevel 1 exit /b 22

echo ==== Root entry files ====
for %%F in ("构建.bat" "启动游戏.bat" "启动游戏-flashplayer_sa.bat" "启动游戏-flashplayer_sa_debug.bat" "启动修改器.bat" "修改器.bat" "一键备份存档.bat" "清除存档.bat" "清理后台残留.bat") do if not exist "%%~F" (
  echo [ERROR] Missing root entry: %%~F
  exit /b 23
)

echo [OK] Phase 4 entry regression passed.
exit /b 0
