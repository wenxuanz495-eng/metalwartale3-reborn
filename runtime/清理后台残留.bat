@echo off
chcp 65001 >nul
setlocal
cd /d "%~dp0"
echo Cleaning leftover server/modifier-engine for this folder...
powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -Command ^
  "$root=[IO.Path]::GetFullPath('%CD%').TrimEnd('\');" ^
  "Get-CimInstance Win32_Process | Where-Object { $_.Name -match '^(server|modifier-engine)\.exe$' -and $_.CommandLine -and $_.CommandLine.Contains($root) } | ForEach-Object { try { Stop-Process -Id $_.ProcessId -Force; Write-Host ('Killed PID=' + $_.ProcessId + ' ' + $_.Name) } catch {} };" ^
  "Write-Host 'Done.'"
echo.
echo Cleanup finished.
timeout /t 2 >nul
exit 0