# 存档目录说明

当前自构建启动的权威存档目录是：

```text
build/saves/
```

权威文件：

```text
build/saves/game_save.bin
```

## 玩家便捷脚本

| 脚本 | 作用 |
|---|---|
| `打开存档目录.bat` / `open-saves.bat` | 直接打开正确的存档目录 |

根目录 `saves` 链接指向 `build/saves`。

## 手动替换存档

1. 完全退出游戏和修改器
2. 双击 `打开存档目录.bat`
3. 备份现有 `game_save.bin`
4. 复制你的 `game_save.bin` 覆盖进去
5. 重新启动游戏

## 注意

- 不要放到 `runtime/saves`
- 不要依赖 `.sol` / `flash-profile`
- `yagao.json`、`saves.db` 不是主存档
