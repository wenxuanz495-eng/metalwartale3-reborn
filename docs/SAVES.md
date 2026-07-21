# 存档目录说明

当前自构建启动的权威存档目录是：

```text
build/saves/
```

权威文件：

```text
build/saves/game_save.bin
```

## 玩家便捷脚本（仓库根目录）

| 脚本 | 作用 |
|---|---|
| `打开存档目录.bat` / `open-saves.bat` | 直接打开正确的存档目录 |
| `导入存档.bat` / `import-saves.bat` | 把外部存档复制进正确目录（自动备份旧档） |

## 手动导入

1. 完全退出游戏和修改器
2. 备份现有 `build/saves/game_save.bin`
3. 用你的 `game_save.bin` 覆盖
4. 重新启动游戏

## 注意

- 不要放到 `runtime/saves`
- 不要依赖 `.sol` / `flash-profile`
- `yagao.json`、`saves.db` 不是主存档
- 根目录如果有 `saves` 链接，它只是指向 `build/saves` 的快捷入口
