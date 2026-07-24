# 存档目录说明

当前自构建启动的权威存档目录是：

```text
saves/
```

权威文件：

```text
saves/game_save.bin
```

## 玩家便捷脚本

| 脚本 | 作用 |
|---|---|
| `工具.bat` | 打开存档目录、备份、清档及其它维护操作 |

根目录 `saves` 是唯一权威存档目录；`build/saves` 属于废弃旧路径，不应创建或读取。

## 手动替换存档

1. 完全退出游戏和修改器
2. 打开 `工具.bat`，选择打开存档目录
3. 备份现有 `game_save.bin`
4. 复制你的 `game_save.bin` 覆盖进去
5. 重新启动游戏

## 注意

- 不要放到 `runtime/saves`
- 不要依赖 `.sol` / `flash-profile`
- `yagao.json`、`saves.db` 不是主存档
