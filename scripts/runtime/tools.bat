@echo off
rem Runtime-only maintenance menu shipped with player releases.
chcp 65001 >nul
setlocal EnableExtensions EnableDelayedExpansion
for %%I in ("%~dp0..\..") do set "REPO_ROOT=%%~fI"
cd /d "%REPO_ROOT%"

set "COMMAND=%~1"
if /i "%COMMAND%"=="backup" goto backup
if /i "%COMMAND%"=="open-saves" goto open_saves
if /i "%COMMAND%"=="open-backups" goto open_backups
if /i "%COMMAND%"=="clear" goto clear
if /i "%COMMAND%"=="cleanup" goto cleanup
if /i "%COMMAND%"=="fix-car" goto fix_car

echo ========================================
echo 项目工具
echo ========================================
echo 1. 备份存档
echo 2. 打开存档目录
echo 3. 打开备份目录
echo 4. 清除存档
echo 5. 清理后台残留
echo 6. 修复战车零属性
echo 0. 退出
choice /C 1234560 /N /M "请选择: "
if errorlevel 7 exit /b 0
if errorlevel 6 goto fix_car
if errorlevel 5 goto cleanup
if errorlevel 4 goto clear
if errorlevel 3 goto open_backups
if errorlevel 2 goto open_saves
goto backup

:backup
if not exist "saves\game_save.bin" (
  echo [ERROR] 存档不存在：saves\game_save.bin
  pause
  exit /b 1
)
if not exist "saves\backups" mkdir "saves\backups"
set "BACKUP_NAME=game_save.manual-!RANDOM!-!RANDOM!.bin"
copy /y "saves\game_save.bin" "saves\backups\!BACKUP_NAME!" >nul
if errorlevel 1 exit /b 2
echo 已创建备份：!BACKUP_NAME!
start "" explorer.exe "saves\backups"
pause
exit /b 0

:open_saves
if not exist "saves" mkdir "saves"
start "" explorer.exe "saves"
exit /b 0

:open_backups
if not exist "saves\backups" mkdir "saves\backups"
start "" explorer.exe "saves\backups"
exit /b 0

:clear
call :ensure_stopped
if errorlevel 1 exit /b 1
echo 将永久删除 "%REPO_ROOT%\saves" 下的全部文件。
choice /C YN /N /M "继续？[Y/N]: "
if errorlevel 2 exit /b 0
if not exist "saves" mkdir "saves"
pushd "saves"
del /f /q * >nul 2>nul
for /d %%D in (*) do rd /s /q "%%D"
popd
mkdir "saves\backups" >nul 2>nul
echo 存档已清除。
pause
exit /b 0

:cleanup
taskkill /f /t /fi "WINDOWTITLE eq SA_COLLAB_SERVER_*" >nul 2>nul
taskkill /f /t /fi "WINDOWTITLE eq SA_COLLAB_MODIFIER_*" >nul 2>nul
echo 后台残留已清理。
exit /b 0

:fix_car
call :ensure_stopped
if errorlevel 1 exit /b 1
if not exist "build\server.exe" (
  echo [ERROR] 开发仓库请先运行 powershell -File scripts\dev.ps1 build
  pause
  exit /b 1
)
if not exist "saves\game_save.bin" (
  echo [ERROR] 缺少 saves\game_save.bin
  pause
  exit /b 1
)
if exist "saves\zero_car_affix_fixed.flag" (
  echo [ERROR] 一键修复已经使用过。
  pause
  exit /b 2
)
"build\server.exe" --root "%REPO_ROOT%" --fix-zero-car-affix-once
set "FIX_ERROR=!ERRORLEVEL!"
pause
exit /b !FIX_ERROR!

:ensure_stopped
for %%P in (flashplayer_sa.exe flashplayer_sa_debug.exe flashplayer_32_sa_debug.exe) do (
  tasklist /fi "IMAGENAME eq %%P" 2>nul | find /i "%%P" >nul
  if not errorlevel 1 (
    echo [ERROR] 请先关闭游戏和修改器。
    exit /b 1
  )
)
tasklist /v /fi "WINDOWTITLE eq SA_COLLAB_SERVER_*" 2>nul | find /i "SA_COLLAB_SERVER_" >nul
if not errorlevel 1 exit /b 1
tasklist /v /fi "WINDOWTITLE eq SA_COLLAB_MODIFIER_*" 2>nul | find /i "SA_COLLAB_MODIFIER_" >nul
if not errorlevel 1 exit /b 1
exit /b 0
