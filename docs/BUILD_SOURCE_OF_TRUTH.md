# 当前构建来源与旧版本隔离规则

## 唯一有效构建链

当前端游只能使用以下入口：

```text
构建.bat
scripts\build_all.bat
```

该链路以仓库内 `swf\baselines\1.26.2.1-BAT.game.swf` 为只读基线，使用当前 `decompiled\` 源码、`config\build\` 清单和 `decompiled\embedded-xml-assets\` BinaryData 生成 `build\game.swf`。

## 禁止使用

- 不要直接运行旧的 `scripts\build_swf.ps1`。
- 不要从 `D:\superalloy\2.4内测版`、`1.26.2.1-BAT` 或其他发行目录复制 `game.swf`。
- 不要把 `runtime\game.swf` 或旧内测包中的 SWF 当作当前构建输入。

旧 PowerShell 构建脚本原件已归档到：

```text
archive\legacy-build\build_swf.ps1
```

现有 `scripts\build_swf.ps1` 仅保留为保护性入口，执行时会拒绝构建并提示使用纯 BAT 构建链。

## 构建产物规则

`build\game.swf` 是本地构建产物，不由 Git 跟踪。每次源码或 BinaryData 修改后必须重新运行当前构建链，并通过：

```text
scripts\verify_reproducible_build.bat
```

验证两次构建一致且嵌入 XML 与源码一致。启动游戏前应确认 `build\game.swf` 是刚刚生成的文件。
