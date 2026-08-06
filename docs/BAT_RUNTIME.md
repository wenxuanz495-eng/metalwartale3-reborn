# 纯 BAT 运行体系

日期：2026-07-23

## 目标

合作版的玩家运行入口不依赖 PowerShell。游戏、修改器、备份、清档、打开目录、战车修复和残留清理均由 BAT 直接驱动 Windows 工具及项目 EXE。

权威运行目录：

```text
build\
```

权威存档：

```text
build\saves\game_save.bin
```

## 玩家入口

| 入口 | 行为 |
|---|---|
| `启动游戏-flashplayer_sa.bat` | 玩家包唯一游戏入口，使用普通 SA 播放器启动 |
| `启动游戏-flashplayer_sa_debug.bat` | Debug Player 入口 |
| `启动修改器.bat` / `修改器.bat` | 备份后启动修改器 |
| `一键备份存档.bat` | 备份到 `build\saves\backups` |
| `清除存档.bat` | 二次确认后清除合作版存档 |
| `打开存档目录.bat` | 打开权威存档目录 |
| `打开存档备份文件夹.bat` | 打开合作版备份目录 |
| `战车属性为零修复.bat` | 直接调用 `build\server.exe` 修复 |
| `清理后台残留.bat` | 只清理合作版专用窗口标题的进程树 |

## 内部 BAT

- `scripts\build_all.bat`：依次构建 Go 服务端、主 SWF，并准备完整运行目录。
- `scripts\build_swf.bat`：从不可变基线应用显式最小补丁清单。
- `scripts\prepare_build_runtime.bat`：只用仓库已跟踪资源重建 `build/` 的 175 个运行资源。
- `scripts\launch_game.bat`：端口探测、服务健康检查、播放器启动和退出清理。
- `scripts\launch_modifier.bat`：存档备份、端口探测、浏览器应用窗口和退出清理。

资源准备只读取仓库内已跟踪的 `swf/` 与 `runtime/` 文件，不读取或写入外部黄金版。所有生成和写入目标都位于合作版 `build/`。

## 边界

从2.04玩家包开始，根目录不再附带内容重复的 `启动游戏.bat`，只保留名称明确的 `启动游戏-flashplayer_sa.bat`。仓库内开发入口不受此装包规则影响。

第三阶段已经消除正式构建流程的 PowerShell 依赖。`构建.bat` 调用纯 BAT 构建链；主 SWF 采用不可变基线和显式最小补丁，禁止一次性导入全部反编译脚本。详细边界与审批规则见 [`REPRODUCIBLE_BUILD.md`](REPRODUCIBLE_BUILD.md)。

## 静态自检

```bat
scripts\launch_game.bat --check sa
scripts\launch_game.bat --check sa_debug
scripts\launch_modifier.bat --check
```

自检不会启动游戏、服务端或浏览器。

服务端短时冒烟测试：

```bat
scripts\launch_game.bat --smoke sa
scripts\launch_modifier.bat --smoke
```

冒烟测试会短时启动合作版服务端并检查 HTTP，然后立即清理；不会启动 Flash 或浏览器，也不会创建、清除或备份存档。
