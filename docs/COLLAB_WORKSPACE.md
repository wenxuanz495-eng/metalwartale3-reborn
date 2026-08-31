# 协作工作区说明

## 唯一仓库

以后请只在下面这个目录开发：

```text
D:\superalloy\metalwartale3-reborn.git
```

GitHub：

```text
https://github.com/wenxuanz495-eng/metalwartale3-reborn.git
```

## 其它目录角色

| 路径 | 角色 |
|---|---|
| `D:\superalloy\metalwartale3-reborn.git` | 源码与文档 SSOT，唯一开发仓库 |
| `D:\superalloy\超合金离线优化海豹版1.2` | 已验证玩法与发行壳参考；导出目标之一 |
| `D:\superalloy\11.4` | 历史开发盘，只读参考 |
| `D:\superalloy\1.2文件备份` | 仓库外备份根目录 |
| `D:\superalloy\metalwartale3-reborn` | 空目录，勿使用 |

## 决策摘要

- 玩法：1.2
- 权威存档：Git / `game_save.bin` + 本地 Go 服务
- 运行体验与修改器：1.2
- 源码：本仓库 `decompiled/`
- 公会：Git 本地模拟
- 定制武器商城价：统一 20,000 MB
- 扩展修改器：全部迁入

详细规则见 `gameplay/SEAL_RULES.md`，差异见 `status/MERGE_DIFF_1.2.md`。
