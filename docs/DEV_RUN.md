# 开发启动方式（构建 / 启动分离，多播放器对照）

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
| `启动游戏-FlashPlayer发行版.bat` | 1.2 的 `FlashPlayer.exe` |

英文同名：

- `start-game-flashplayer_sa.bat`
- `start-game-flashplayer_sa_debug.bat`
- `start-game-FlashPlayer-release.bat`

播放器查找顺序：

- **sa**: `tools\debug\flashplayer_sa.exe` → `D:\superalloy\flashplayer_sa.exe`
- **sa_debug**: `tools\debug\flashplayer_sa_debug.exe` → `D:\superalloy\flashplayer_32_sa_debug.exe`
- **release**: `超合金离线优化海豹版1.2\FlashPlayer.exe`

PowerShell：

```powershell
.\scripts\run_dev.ps1 -PlayerType sa
.\scripts\run_dev.ps1 -PlayerType sa_debug
.\scripts\run_dev.ps1 -PlayerType release
```

## 3. 构建并启动（可选）

```powershell
.\scripts\run_dev.ps1 -Build -PlayerType sa
```

## 注意

- 启动脚本不会自动构建；缺产物时提示先运行 `构建.bat`
- 资源优先使用海豹 1.2 层级目录（`swf/ui` 等）
- 不要把 `runtime/` 当主运行路径
