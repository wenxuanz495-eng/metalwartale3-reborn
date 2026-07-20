# runtime/

可运行壳目录（部署目标）。

## 目标内容（从 1.2 发行壳迁入/构建生成）

- `game.swf`（由 decompiled 构建部署，不手工长期维护）
- `swf/` 资源
- `server.exe` 或开发时用 `go run`（权威存档）
- `启动游戏.bat` / `launch.ps1`
- `修改器.bat` / `editor-launch.ps1` / `modifier.html`
- `公告.txt`
- `README.txt` / 火绒说明
- `FlashPlayer` / debug player（工具策略另定）
- `saves/`（本地生成，**不进 Git**）

## 规则

1. 源码改动在仓库 `decompiled/` / `server/`。
2. 构建后部署到本目录再测。
3. 玩家存档只存在本机 `runtime/saves`，提交前必须干净。
4. 与 `超合金离线优化海豹版1.2` 对照时，以行为一致为准。
