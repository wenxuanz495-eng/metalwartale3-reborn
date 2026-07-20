# runtime/

海豹 1.2 运行壳 + Git 权威存档服务 + 源码回灌构建产物。

## 启动

- `启动游戏.bat` / `start-game.bat`
- `修改器.bat` / `start-editor.bat`

## 首次准备

1. 将已验证的海豹 1.2 `game.swf` 复制为 `runtime/game.base.swf`
2. 复制 `swf/` 资源与 `server.exe`（或本地 go build）
3. 运行 `..\scripts\build_and_deploy.ps1` 生成 `game.swf`
4. 双击启动

## 说明

- `saves/`、播放器、构建 SWF 默认不进 Git
- 权威存档：`saves/game_save.bin`（Go server）
