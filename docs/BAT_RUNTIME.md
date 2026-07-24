# 纯 BAT 运行体系

日期：2026-07-23

## 目标

合作版的玩家运行入口不依赖 PowerShell。根目录仅保留游戏、Debug、修改器
和工具入口；备份、清档、打开目录、战车修复和残留清理由
`工具.bat` 统一提供。

游戏从根目录运行，构建产物位于：

```text
build\
```

权威存档位于游戏根目录：

```text
saves\game_save.bin
```

## 玩家入口

| 入口 | 行为 |
|---|---|
| `启动游戏.bat` | 使用普通 SA 播放器启动 |
| `启动游戏-flashplayer_sa_debug.bat` | Debug Player 入口 |
| `启动修改器.bat` | 备份后启动修改器 |
| `工具.bat` | 备份、清档、打开存档目录及其他维护操作 |

## 内部 BAT

- `scripts\dev.ps1 build`：构建 Go、主 SWF并准备175个运行资源。
- `scripts\dev.ps1 verify`：执行quick/full/release三档验收。
- `scripts\dev.ps1 release`：生成并检查玩家发行目录。
- `scripts\runtime\launch_game.bat`：端口探测、服务健康检查、播放器启动和退出清理。
- `scripts\runtime\launch_modifier.bat`：存档备份、端口探测、浏览器应用窗口和退出清理。

资源准备只读取仓库内已跟踪的 `swf/` 与 `runtime/` 文件，不读取或写入外部黄金版。所有生成和写入目标都位于合作版 `build/`。

## 边界

发行包运行流程不依赖 PowerShell。开发仓库使用 `scripts/dev.ps1` 组织构建、
验收和打包；主 SWF采用不可变基线和显式最小补丁，构建后自动检查
`Game.as` P-code 控制流。
详细边界见 [`REPRODUCIBLE_BUILD.md`](REPRODUCIBLE_BUILD.md)。

## 静态自检

```bat
scripts\runtime\run.bat check-game
scripts\runtime\run.bat check-debug
scripts\runtime\run.bat check-modifier
```

自检不会启动游戏、服务端或浏览器。

服务端短时冒烟测试：

```bat
scripts\runtime\run.bat smoke-game
scripts\runtime\run.bat smoke-modifier
```

冒烟测试会短时启动合作版服务端并检查 HTTP，然后立即清理；不会启动 Flash 或浏览器，也不会创建、清除或备份存档。
