# 星爆家族（highEnergy）· 家族档案

> 立项日期：2026-09-11（副武器第十三家族）
> 当前状态：✅* **按用户方案回迁已构建入库待实测（2026-09-11）**——执行细节见 `星爆家族三版本对比与回迁执行总结-20260911.md`：子弹回 2.5（lv1/lv2←b1、lv3/lv4←b2、lv5←b3、**lv6/lv7←b3×1.15 衍生弹**）＋lv1/lv2 本体←3.4＋lv3/lv4/lv5 本体←2.5＋**lv6/lv7 保留红机体共用 2.5 lv3 特效层（深度重映射 2/6/8）**＋受击回 2.5（bullet.swf 死名 **pink_boom** 65→185 改绑，受击音免克隆挂 139）＋开火音回老版（#2649）；**11/11 组像素 0.00%**、双自检通过；sub1130=1A5108E0、bullet=A8F853B2、config=38EA3C12、game.swf=1696FF25。前置：`星爆家族三版本对比总结-20260911.md`。
> 第一形态：**星爆**（`highEnergy_lv1`）。
> ⚠️ 用户指定映射关键事实：**2.5 的 LV1（星爆）＝3.4 及之后的 LV3 形态**——与普罗米修斯家族同款"3.4 占用 2.5 基础 ID"错位（《火神炮总览》第七节三特殊家族之一）；完整 +2 平移是否存在、lv2/lv3 对应关系，正式对比时按用户安排逐一核实，不自行推断。

## 家族基本信息（已核实）

- **arms id**：`highEnergy`（subArms 配置 index=11；2.5 subArms37 与 3.4 subArms52 同 id 同 index）
- **类型 / 攻击属性**：`<type>高能粒子炮</type>`；`attackType`：2.5=**mixed** → 3.4 起=**boom**；`specialProperty=跟踪，成长型`（跟踪弹种）
- **武器描述（当前版 LV1）**：成长型武器。将宇宙中的大量高能粒子收集起来，通过发射装置将高能粒子发射出去。自带 5% 的控制训练加成，并且该武器的伤害将随着人物等级的提升而提升。
- **形态（当前版七级）**：

| 级 | 形态名 | imgLabel | 子弹 | commonLevel | 成长 specialType | 自带附魔 |
|---|---|---|---|---|---|---|
| LV1 | 星爆 | `highEnergy_lv1` | `sub/highEnergy_lv1_bullet` | 60 | Level_Growth_5 | subAdd:0.05 |
| LV2 | 星陨 | `highEnergy_lv2` | `sub/highEnergy_lv2_bullet` | 70 | Level_Growth_10 | subAdd:0.07 |
| LV3 | 星坠 | `highEnergy_lv3` | `sub/highEnergy_lv3_bullet` | 70 | Level_Growth_15 | subAdd:0.09 |
| LV4 | 星穹 | `highEnergy_lv4` | `sub/highEnergy_lv4_bullet` | 70 | Level_Growth_20 | subAdd:0.11 |
| LV5 | 星曜 | `highEnergy_lv5` | `sub/highEnergy_lv5_bullet` | 70 | Level_Growth_25 | subAdd:0.13 |
| LV6 | 星噬 | `highEnergy_lv6` | `sub/highEnergy_lv6_bullet` | 70 | Level_Growth_30 | subAdd:0.15 |
| LV7 | 星噬MK2 | `highEnergy_lv7` | `sub/highEnergy_lv7_bullet` | 70 | Level_Growth_35 | subAdd:0.17 |

- **配置位置**：`decompiled\embedded-xml-assets\6_EmbedXml_xmlClass7_EmbedXml_xmlClass7.bin`（highEnergy 块约 2403~2716 行，后接 index=12 `snake` 纳米号）
- **资源包**：`sub1130.swf`；导出名本体 `highEnergy_lv1~lv7`、子弹 `highEnergy_lv1~lv7_bullet`（见下方 ID 速查）
- **受击**：当前/3.4 七（五）级统一 `hitImgLabel=bullet/blue_boom`（bullet.swf）；**2.5 三级为 `sub/chipped_hit_effect`**——碎裂炮公共受击名，存在"同名异实物"风险（纳米号对比已记录该公共名 2.5 细线 vs 3.4/GH 宽线的先例），受击对比时必须先对 2.5 基准包核实内容
- **数值现状（当前版七级统一）**：`attackGap=0.9`、`attackDelay=0.25`、`bulletNum=1`、`bulletSpeed=30`、`recoilValue=6`、`hurt=1876`、`bulletWidth=15`、`bulletLife=5`（跟踪弹长寿命）、`energyUse=10`；LV1 独有 `price=100000`（G 币直购，Mprice 100）

## 形态演变（只读核对三版配置所得，正式对比未开始）

- **2.5**：三形态——星爆 / 星陨 / 星坠（subArms37.xml，highEnergy 块行 1705 起）；受击 `sub/chipped_hit_effect`、attackType=mixed
- **3.4**：五形态——+星穹 / 星曜（subArms52 bin，块行 1889 起）；受击已切 `bullet/blue_boom`、attackType=boom
- **当前版**：七形态——+星噬 / 星噬MK2（LV6/LV7 为 11.3 基底后续新增；2.4.2 公告"星噬系列速度统一"名单即指此家族后两级）
- **用户指定映射**：2.5 LV1 星爆＝3.4 及之后 LV3（即 3.4 命名里的"星坠"位）。若与普罗米修斯家族同规律则为整体 +2 平移（2.5 lv2→3.4 lv4、lv3→lv5），**此推测未经像素验证，正式对比时以用户安排逐一核实**
- 三版统一不变项：`attackGap=0.9`、`attackDelay=0.25`、`bulletSpeed=30`、`recoilValue=6`、`hurt=1876`（射速/弹速/伤害三版一致，与阳电子炮同为"3.4 未改手感"家族）

## 关键符号 ID 速查（来自时点快照，证据等级 B，回迁前须重新导出核对）

| 导出名 | 2.5 (sub37) | 3.4 (sub52) | 当前 (sub1130) |
|---|---|---|---|
| highEnergy_lv1 | 376 | 618 | 785 |
| highEnergy_lv2 | 373 | 585 | 782 |
| highEnergy_lv3 | 370 | 549 | 776 |
| highEnergy_lv4 | — | 486 | 773 |
| highEnergy_lv5 | — | 423 | 770 |
| highEnergy_lv6 | — | — | 767 |
| highEnergy_lv7 | — | — | 764 |
| lv1~lv7_bullet | 356/349/341 | 353/351/349/347/345 | 750/748/746/744/742/740/739 |

## 已知注意事项

- ⚠️ **2.5 受击走 `sub/chipped_hit_effect`（碎裂炮公共名）**：与阳电子炮的 `positron_hit_effect` 不同，本家族 2.5 受击是**公共名**——同名异实物风险（纳米号对比记录过该名 2.5 细线 173×13 vs 3.4/GH 宽线 221×25 的先例）。对比受击时必须直接对 2.5 sub37 #356 前后的实际内容取证，不能按名字推定。
- ⚠️ **`bullet/blue_boom` 为 3.4 起当前配置的受击**（bullet.swf #110，与其他家族共用）——受击若回 2.5 需走死名改绑或克隆路线，且不得动 blue_boom 本体（他家族共用）。
- **跟踪弹种**：`specialProperty=跟踪`，子弹行为含追踪逻辑——美术对比时注意弹道表现与直线弹不同；跟踪相关字段（如 bulletVra 等）按用户既往红线不动。
- **测试包先例 ≠ 正式仓库现状**：`tmp-soya-family-test` 下有五处 star 系先期工作（见文档索引），其中 `star-closure-import` 已做过七级时间轴闭包实验——均未入正式仓库，仅作参考。
- 副武器通用教训适用：本体时间轴内 `basePoint`/`shootPoint` 挂点实例与挂点标记（红⊕，starburst-restore 报告实测 2.5 lv3 挂点 shootPoint=(2049,487)）是功能锚点不是美术，勿计入差异、勿回迁。
- 成长型（`Level_Growth_*`）＋自带附魔随等级递增（0.05~0.17）：对比/回迁只谈视觉表现层，伤害/成长/经济字段按既往红线不动。

## 本家族文档索引

| 文件/目录 | 内容 |
|---|---|
| （家族档案本体）本 README.md | 基础信息、形态演变、符号 ID 速查、注意事项（2026-09-11 立项） |
| 星爆家族工作总结-20260911.md | **任务总入口**：四阶段脉络、终态产物、关键决策与发现、经验沉淀、待实机项 |
| 星爆家族三版本对比与回迁执行总结-20260911.md | 回迁执行：改动明细、验证链、哈希（✅* 待实测） |
| 星爆家族三版本对比总结-20260911.md | 三版只读对比：重绘继承式 +2 平移、当前红系重绘+删蓄力、子弹三段演进、音频 2.5=3.4≠当前、星噬/MK2 专项（A 级） |
| 星爆家族三版本血统对比图-20260911.png | 2.5/3.4/当前 全形态血统对照（含 lv6 vs lv7 放大） |
| 星爆家族本体形态映射对比图-20260911.png | 六行对照：2.5 lv1~lv3 与 3.4 lv1~lv5（f1 待机＋f9 开火） |
| 星爆家族子弹对比图-20260911.png | 2.5 七帧动画弹 vs 3.4 五档单帧静态弹 |
| 星爆家族开火段对比图-20260911.png | 2.5 lv1 与 3.4 lv3 开火段 f4~f11 并排（青白火焰同款、细节差异） |
| `tmp-soya-family-test\star-audit-20260828\` | star 系早期审计工作区 |
| `tmp-soya-family-test\starburst-audit\` | starburst 审计工作区 |
| `tmp-soya-family-test\star-closure-import\` | 七级时间轴闭包导入实验（closure-manifest/import_closure.py/seven-level-timelines 等） |
| `tmp-soya-family-test\star-config-25\` | 2.5 配置提取与 game.swf 补丁实验 |
| `tmp-soya-family-test\starburst-restore\` | 测试包回迁实验（含 2.5 lv3 逐帧 PlaceObject 解析，挂点坐标在案）；均未入正式仓库 |

## 归档规则

按 `副武器家族\README.md`：总结命名 `主题-YYYYMMDD.md`，必备四段（目标 / 实际修改 / 构建与验证 / 待实机确认项）；移除资源留 `备份-移除的孤儿资源-YYYYMMDD\`；归档后同步上级两级 README 与 `..\..\各家族变更档案.md`。
