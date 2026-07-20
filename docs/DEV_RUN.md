# 开发启动方式（构建 / 启动分离）

## 1. 构建（会花时间）

根目录：

- `构建.bat`
- 或 `build.bat`

等价：

```powershell
.\scripts\build_all.ps1
```

实际执行：

1. `scripts/build_server.ps1` → `build/server.exe`
2. `scripts/build_swf.ps1` → `build/game.swf`

Go 缓存固定在 D 盘：

- `D:\superalloy\.gopath\...`

## 2. 启动（不重新构建）

根目录：

- `启动游戏.bat`
- 或 `start-game.bat`

等价：

```powershell
.\scripts\run_dev.ps1
```

只会：

1. 检查 `build/server.exe` 和 `build/game.swf` 是否存在
2. 同步资源到 `build/swf`
3. 启动自建 server
4. 用 `tools/debug/flashplayer_sa_debug.exe` 打开游戏

如果缺构建产物，会提示先运行 `构建.bat`。

## 可选：构建并启动

```powershell
.\scripts\run_dev.ps1 -Build
```

## 产物

- `build/server.exe`
- `build/game.swf`
- `build/saves/`
- `build/swf/`（运行资源副本，优先来自海豹 1.2 层级布局）

## 注意

- 不要把 `runtime/` 当主运行路径
- 仓库平铺 `swf/` 不能直接替代发行版层级资源
- 改代码后先 `构建.bat`，再 `启动游戏.bat`
