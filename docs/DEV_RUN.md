# 开发启动方式

## 构建

开发仓库使用 PowerShell：

```powershell
.\scripts\dev.ps1 build
```

产物位于 `build/server.exe`、`build/game.swf` 和 `build/swf/`。

构建不覆盖 `GOPATH`、`GOMODCACHE` 或 `GOCACHE`，使用开发者当前 Go环境。

## 启动

| 根目录入口 | 用途 |
|---|---|
| `启动游戏.bat` | 普通播放器 |
| `启动游戏-flashplayer_sa_debug.bat` | Debug Player |
| `启动修改器.bat` | 本地修改器 |
| `工具.bat` | 备份、清档、打开目录、清理残留和战车修复 |

启动不会重新构建；缺少产物时会提示开发者先运行 PowerShell 构建命令。

## 验收与发行

```powershell
.\scripts\dev.ps1 verify -Mode quick
.\scripts\dev.ps1 verify -Mode full
.\scripts\dev.ps1 verify -Mode release
.\scripts\dev.ps1 release -Version 版本号
```

`quick` 检查构建、Go、修改器和入口；`full` 增加可复现性和服务
冒烟；`release` 增加存档兼容验证。

## 存档

权威目录为根目录 `saves/`。低频存档操作统一从 `工具.bat` 进入。
