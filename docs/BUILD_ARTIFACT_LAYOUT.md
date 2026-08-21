# 构建产物目录规则

源码唯一维护入口是 `decompiled/gamefile/scripts`。`build` 只保存当前运行产物、短期验证产物和历史归档，不再作为源码副本。

当前布局：

```text
build/
├─ current/       当前构建登记
├─ verify/        最近验证登记
├─ archive/       历史构建归档
├─ swf/           运行时资源
├─ saves/         运行时存档
├─ bgm/           运行时音乐
├─ tools/         运行时工具
└─ ui/            运行时 UI 资源
```

2026-08-21 已将 141 个非运行时历史目录移动到：

```text
build/archive/2026-08-21/legacy/
```

本次只移动、不删除。归档内的源码快照和日志仍可用于审计。后续构建不得在 `build` 下复制完整 `decompiled/scripts`；需要保存构建信息时，应添加 `manifest.json`、日志、差异报告和哈希。
