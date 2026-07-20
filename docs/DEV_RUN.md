# 开发启动方式（自构建，不用 runtime 主路径）

1. 自己构建 SWF（FFDec 导入 decompiled 源码）
2. 自己用 Go 构建 server（模块缓存放到 D 盘）
3. 用 tools/debug/flashplayer_sa_debug.exe 运行

## 一键

根目录：

- 启动游戏.bat
- start-game.bat

```powershell
.\scripts\run_dev.ps1
```

## 分步

```powershell
.\scripts\build_server.ps1
.\scripts\build_swf.ps1
.\scripts\run_dev.ps1 -SkipBuild
```

## 产物

- build/server.exe
- build/game.swf
- build/saves/
- build/www/（临时静态根，资源链接到仓库 swf/）

## Go 缓存（非 C 盘用户目录）

scripts/go_env.ps1：

- GOPATH=D:\superalloy\.gopath\gopath
- GOMODCACHE=D:\superalloy\.gopath\pkg\mod
- GOCACHE=D:\superalloy\.gopath\cache

## 运行时注意

- 资源优先使用海豹 1.2 的层级目录（`swf/ui`、`swf/enemy` 等），仓库平铺 `swf/` 不能直接作为运行资源。
- `run_dev.ps1` 会自动选择带 `ui` 目录的资源布局。
