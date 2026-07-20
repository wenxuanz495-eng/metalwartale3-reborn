# scripts/

构建与发行辅助脚本（逐步补齐）。

建议命令：

```powershell
# 语法/存在性检查
.\scripts\check_workspace.ps1

# 构建并部署到 runtime（待实现完整流水线）
.\scripts\build_and_deploy.ps1

# 发行包体检（禁存档/备份/临时文件）
.\scripts\check_release.ps1 -Path "..\超合金离线优化海豹版1.2.zip"
```
