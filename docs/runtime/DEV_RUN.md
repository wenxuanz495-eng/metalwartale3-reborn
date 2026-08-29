# 开发启动方式（构建 / 启动分离，多播放器对照）

> ⚠️ **部分内容已过时（2026-08 文档整理时标注）**：`scripts\build_all.ps1` 与 `run_dev.ps1` 等 PowerShell 入口已被纯 BAT 构建链取代（`构建.bat` / `scripts\build_all.bat`，见 [../build/BUILD_SOURCE_OF_TRUTH.md](../build/BUILD_SOURCE_OF_TRUTH.md)）；`D:\superalloy\.gopath` 为原作者机器本地路径。构建/启动分离与多播放器对照的思路仍有效。

## 1. 构建（会花时间）

- `构建.bat` / `build.bat`
- 或 `.\scripts\build_all.ps1`

产物：

- `build/server.exe`
- `build/game.swf`

Go 缓存：`D:\superalloy\.gopath\...`

## 2. 启动（不重新构建，按播放器分开）

| 脚本 | 播放器 |
|---|---|
| `启动游戏-flashplayer_sa.bat` | `flashplayer_sa.exe`（新对照，非 debug） |
| `启动游戏-flashplayer_sa_debug.bat` | `flashplayer_sa_debug.exe`（旧 debug） |

英文同名：

- `start-game-flashplayer_sa.bat`
- `start-game-flashplayer_sa_debug.bat`

播放器查找顺序：

- **sa**: `tools\runtime\FlashPlayer.exe`
- **sa_debug**: `tools\debug\flashplayer_sa_debug.exe`

PowerShell：

```powershell
.\scripts\run_dev.ps1 -PlayerType sa
.\scripts\run_dev.ps1 -PlayerType sa_debug
```

## 3. 构建并启动（可选）

```powershell
.\scripts\run_dev.ps1 -Build -PlayerType sa
```

## 注意

- 启动脚本不会自动构建；缺产物时提示先运行 `构建.bat`
- 资源优先使用海豹 1.2 层级目录（`swf/ui` 等）
- 不要把 `runtime/` 当主运行路径

## 存档目录

- 权威目录：`build/saves`
- 快捷打开：`打开存档目录.bat` / `open-saves.bat`

## 修改器

- `启动修改器.bat` / `start-modifier.bat`
- 启动本地 server，并打开 `/modifier.html`
- 修改存档：`build/saves/game_save.bin`
- 使用前请先完全退出游戏

## 自动关闭 CMD

- 游戏：关闭 Flash 播放器后，脚本结束，CMD 自动关闭
- 修改器：关闭修改器浏览器窗口后，本地 server 停止，CMD 自动关闭
- 仅在启动失败时才会 pause 等待查看错误

## 后台残留清理

合作版游戏和修改器都会启动 `build/server.exe`。

现已处理：

1. 启动前清理本目录残留 `server.exe`
2. 关闭游戏/修改器窗口后强制结束本会话 server
3. 再扫一遍并清理同 `build` 根目录的残留 server
4. CMD 成功路径自动关闭

