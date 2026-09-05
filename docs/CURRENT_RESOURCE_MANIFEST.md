# 当前资源批准清单

`config/build/current-resource-manifest.sha256` 登记已批准、但不同于 1.26.2.1-BAT 黄金基线的当前资源哈希。

- `docs/baselines/1.26.2.1-BAT.sha256`：只读黄金/发行完整性验证。
- `config/build/current-resource-manifest.sha256`：当前开发与迁移资源的批准哈希。

`scripts/prepare_build_runtime.bat` 对已登记资源使用当前批准清单；未登记资源继续使用黄金清单。任一清单缺失、哈希不匹配或资源不存在都会停止准备阶段。

本次登记：`swf/arms1100.swf`，批准日期 2026-09-05，原因是火神炮四个形态统一使用一连装子弹，并将子弹本体缩放为约 2/3；此前的 soya 恢复动画迁移仍包含在该正式资源中。

本次登记（更新）：`swf/arms1100.swf`，批准日期 2026-09-05，原因是激光脉冲炮（传说）家族从 2.5 版本迁入开火闪光形状（四形态）与四张分级子弹本体形状，并为四个形态的开火时间轴补回闪光停留帧；新 Character ID 为 1635～1651，原 laserPulse_lv2/3/4_bullet 共用的子弹形状引用已按等级拆分。
