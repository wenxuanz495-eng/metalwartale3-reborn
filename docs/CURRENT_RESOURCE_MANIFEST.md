# 当前资源批准清单

`config/build/current-resource-manifest.sha256` 登记已批准、但不同于 1.26.2.1-BAT 黄金基线的当前资源哈希。

- `docs/baselines/1.26.2.1-BAT.sha256`：只读黄金/发行完整性验证。
- `config/build/current-resource-manifest.sha256`：当前开发与迁移资源的批准哈希。

`scripts/prepare_build_runtime.bat` 对已登记资源使用当前批准清单；未登记资源继续使用黄金清单。任一清单缺失、哈希不匹配或资源不存在都会停止准备阶段。

本次登记：`swf/arms1100.swf`，批准日期 2026-08-29，原因是 soya 恢复动画迁移，依据报告：`tmp-soya-family-test/github-soya-candidate/report/soya-migration-final-report.md`（候选静态验证报告）。
