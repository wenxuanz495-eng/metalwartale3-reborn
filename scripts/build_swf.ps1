param(
  [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path,
  [string]$BaselineSwf = ""
)
$ErrorActionPreference = "Stop"

# 旧 PowerShell 构建链已废弃（FFDec 存在已知控制流回归，构建唯一入口 = 构建.bat / scripts\build_all.bat）。
# 本文件仅保留为保护性拒绝入口；完整原版脚本存档于 archive\legacy-build\build_swf.ps1。
throw "This legacy PowerShell build entry point is disabled. Use ..\构建.bat or scripts\build_all.bat. The original script is archived at archive\legacy-build\build_swf.ps1."
