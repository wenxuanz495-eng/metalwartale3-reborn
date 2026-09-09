# 当前资源批准清单

`config/build/current-resource-manifest.sha256` 登记已批准、但不同于 1.26.2.1-BAT 黄金基线的当前资源哈希。

- `docs/baselines/1.26.2.1-BAT.sha256`：只读黄金/发行完整性验证。
- `config/build/current-resource-manifest.sha256`：当前开发与迁移资源的批准哈希。

`scripts/prepare_build_runtime.bat` 对已登记资源使用当前批准清单；未登记资源继续使用黄金清单。任一清单缺失、哈希不匹配或资源不存在都会停止准备阶段。

本次登记：`swf/arms1100.swf`，批准日期 2026-09-05，原因是火神炮四个形态统一使用一连装子弹，并将子弹本体缩放为约 2/3；此前的 soya 恢复动画迁移仍包含在该正式资源中。

本次登记（更新）：`swf/arms1100.swf`，批准日期 2026-09-05，原因是激光脉冲炮（传说）家族从 2.5 版本迁入开火闪光形状（四形态）与四张分级子弹本体形状，并为四个形态的开火时间轴补回闪光停留帧；新 Character ID 为 1635～1651，原 laserPulse_lv2/3/4_bullet 共用的子弹形状引用已按等级拆分。

本次登记（更新）：`swf/arms1100.swf`，批准日期 2026-09-06，原因是电热化学炮（etcg，毁灭/湮灭/绝灭/幻灭/恒灭）家族从 2.5 版本整体迁入五级本体与五级子弹资源（含开火特效停留帧、2.5 枪口闪光形状、lv1~lv3 逐级小号子弹与恒灭无冗余开火结构），新 Character ID 为 1652～1708；受击特效维持 GitHub 现状 `bullet/purple_motion`，配置文件未改动。

本次登记（更新）：`swf/sub1130.swf`，批准日期 2026-09-10，原因是炽天使家族（hotline，热能射线切割枪五形态）执行 2.5 全项回迁：lv1~lv5 本体时间轴整段换 2.5 模板（找回全部 blend=8 待机/炮身光斑层与第二份脉冲扫掠系列，62 项同美术复用映射+264 项闭包导入，新 Character ID 2030～2293），hot_hit_effect 受击时间轴换 2.5 六帧六态（补入第 2/4/6 态三张 JPEG3 及包裹形状）；挂点映射 110→104 矩阵强制当前值；SymbolClass 全表 253 项不变。回迁后五级本体全 30 帧与受击 6 帧 vs 2.5 渲染逐像素 0 差异。同批配置 `6_EmbedXml_xmlClass7` hotline 块 attackGap 2.4→1.5 ×5（E5F1DB0E，字节等长）。

本次登记（更新）：`swf/sub1130.swf`，批准日期 2026-09-10，原因是碎裂炮家族（chipped，挑战者/粉碎者/征服者/终结者/主宰者五级）执行 2.5 真实差异层回迁（用户批准范围；attackType=boom 按用户决策保留）：lv1~lv5 本体时间轴整段换 2.5 模板（恢复 2.5 蓄力发光层——lv1 f4 起 1~2 层、lv2 f2~f6 十层序列、lv3~5 f2 起多层；83 项闭包导入，新 Character ID 2338~2420），开火音 562 克隆为 DefineSound 2421 并按炽天使铁律挂第 4 帧（2.5 原挂 f2），挂点 110→104 引用改绑；SymbolClass 全表 253 项不变。回迁后五级本体全 75 帧 vs 2.5 渲染逐像素 0 差异。同批配置 `6_EmbedXml_xmlClass7` chipped 块 attackGap 1.4→0.9 ×5（等长）＋hitImgLabel blue_boom→blueness_energy ×5（变长 +30B，块外 11 处 blue_boom 属 jiguangjishupao/highEnergy 原样保留）；受击走聚能轰击炮轮已入库的 `bullet/blueness_energy` 零资源改绑。
