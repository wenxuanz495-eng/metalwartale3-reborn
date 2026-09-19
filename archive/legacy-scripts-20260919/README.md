# 遗留 PowerShell 脚本归档（2026-09-19）

> 归档原因：这批脚本属于被纯 BAT 构建链取代的旧 PowerShell 入口（见 `docs\build\BUILD_SOURCE_OF_TRUTH.md`），
> 且内部引用早已不存在的机器本地路径（如 `D:\superalloy\超合金离线优化海豹版1.2.x（内测）`）。
> 只读存档，不再维护；如需考古按 git 历史追溯。

| 文件 | 原用途 | 废弃原因 |
|---|---|---|
| `build_all.ps1` | 旧 PS 全量构建入口（串 build_server.ps1 + build_swf.ps1） | 被 `构建.bat`（`scripts\build_all.bat`）取代 |
| `build_server.ps1` | 旧 PS 服务端构建 | 被 `scripts\build_server.bat` 取代 |
| `run_dev.ps1` | 开发启动（构建+多播放器对照） | 被 `启动游戏-flashplayer_sa*.bat` 取代；引用的海豹版 1.2.3 目录已不存在 |
| `prepare_runtime.ps1` | 旧运行时资源准备 | 被 `scripts\prepare_build_runtime.bat`（清单校验复制）取代 |
| `build_and_deploy.ps1` | 旧 runtime 壳直接拼 SWF 的构建流 | 早期方案；现行为基线+最小补丁链 |

相关说明：`scripts\build_swf.ps1` 未归档——按 `docs\build\BUILD_SOURCE_OF_TRUTH.md` 保留为保护性拒绝入口（正文已清空为 throw 桩，原版在 `archive\legacy-build\build_swf.ps1`）。
