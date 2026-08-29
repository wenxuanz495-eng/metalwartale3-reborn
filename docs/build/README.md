# docs/build — 构建与发布

构建入口、可复现构建规则、产物布局与历史基线。

| 文档 | 目标 | 说明 |
|---|---|---|
| [BUILD_SOURCE_OF_TRUTH.md](BUILD_SOURCE_OF_TRUTH.md) | Human+AI | 构建唯一入口：`构建.bat` / `scripts\build_all.bat`；旧 PowerShell 构建已归档，禁止使用 |
| [REPRODUCIBLE_BUILD.md](REPRODUCIBLE_BUILD.md) | Human+AI | 可复现纯 BAT 构建规则：不可变基线 + 显式最小补丁、P-code 审批边界 |
| [BUILD_ARTIFACT_LAYOUT.md](BUILD_ARTIFACT_LAYOUT.md) | Human+AI | `build/` 目录里该有什么、不该有什么 |
| [BASELINE_1.26.2.1.md](BASELINE_1.26.2.1.md) | Human+AI | 2026-07-23 冻结的黄金基线说明（只读参考；其中的 `D:\superalloy` 路径仅原作者电脑有效） |
| [DEVELOPMENT.md](DEVELOPMENT.md) | Human | Git/测试/发布约定。**部分内容已过时**（`offline/` Python 回归、`portable/` 产物已不存在），见顶部横幅 |

> 注：装包规范《[发布装包规范.txt](../../发布装包规范.txt)》保留在仓库根目录——装包脚本 `scripts\build_player_packages.bat` 按根目录路径复制它进玩家包，故不迁入 docs。其版本号停留在 2.0 合作内测版，规则大部分仍有效。
