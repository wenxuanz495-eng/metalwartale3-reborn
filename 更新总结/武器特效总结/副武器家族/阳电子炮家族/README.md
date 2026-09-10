# 阳电子炮家族（positron）· 家族档案

> 立项日期：2026-09-10（副武器第十二家族）
> 当前状态：✅ **三点方案回迁游戏内实测通过，实机确认定稿，家族收口（2026-09-11）**——收口总入口 `阳电子炮家族工作总结-20260911.md`；执行细节 `阳电子炮家族2.5-3.4回迁执行总结-20260911.md`（13/13 组像素 0.00%、双自检通过；sub1130=D5509D51、bullet=F55496DE、config=53F2E1EE、game.swf=71EB9AB2）。前置：`阳电子炮家族2.5-3.4对比总结-20260910.md`＋`…-20260911补充.md`。
> 第一形态：**普罗米修斯**（`positron_lv1`）。
> ⚠️ 形态映射关键事实：**2.5 三形态在 3.4 中整体 +2 平移**（lv1→lv3、lv2→lv4、lv3→lv5，本体/子弹逐像素 0%），3.4 的 lv1/lv2 是插入的全新小形态并继承旧名。
> ⚠️ 蓄力关键事实：**2.5/3.4 全形态都有蓄力光球+开火闪光（f2~f7 渐强、f11 峰值）；当前版全六形态蓄力被删（f2~f5 逐字节静止，11.3 基底重绘 94~99% 不同）**。

## 家族基本信息（已核实）

- **arms id**：`positron`（subArms 配置 index=10；2.5 subArms37 与 3.4 subArms52 中同 id 同 index）
- **类型 / 攻击属性**：`<type>阳电子炮</type>`，`attackType=energy`，`specialProperty=成长型`
- **武器描述（当前版）**：成长型武器。自带 5%~15% 的控制训练。利用与目标构成物质中的电子产生反应时电子之间的湮灭来破坏目标。该武器的伤害将随着人物等级的提升而提升。
- **形态（当前版六级，希腊英雄命名）**：

| 级 | 形态名 | imgLabel | 子弹 | commonLevel | 成长 specialType | 自带附魔 |
|---|---|---|---|---|---|---|
| LV1 | 普罗米修斯 | `positron_lv1` | `sub/positron_bullet` | 65 | Level_Growth_10 | subAdd:0.05 |
| LV2 | 赫拉克勒斯 | `positron_lv2` | `sub/positron_bullet2` | 65 | Level_Growth_15 | subAdd:0.07 |
| LV3 | 阿喀琉斯 | `positron_lv3` | `sub/positron_bullet3` | 80 | Level_Growth_20 | subAdd:0.09 |
| LV4 | 奥德修斯 | `positron_lv4` | `sub/positron_bullet4` | 80 | Level_Growth_25 | subAdd:0.11 |
| LV5 | 喀戎 | `positron_lv5` | `sub/positron_bullet5` | 80 | Level_Growth_30 | subAdd:0.13 |
| LV6 | 珀尔修斯 | `positron_lv6` | `sub/positron_bullet6` | 80 | Level_Growth_30 | subAdd:0.15 |

- **配置位置**：`decompiled\embedded-xml-assets\6_EmbedXml_xmlClass7_EmbedXml_xmlClass7.bin`（positron 块约 2141~2402 行，后接 index=11 `highEnergy` 星爆）
- **资源包**：`sub1130.swf`；导出名本体 `positron_lv1~lv6`、子弹 `positron_bullet~positron_bullet6`，另有 2.5 风格受击导出 `positron_hit_effect`（当前配置未引用，见注意事项）
- **受击（当前版）**：六级统一 `hitImgLabel=bullet/red_energy`（bullet.swf）；**2.5 配置为 `positron_hit_effect`（无前缀，解析到 sub 组）**——受击体系两版不同，正式对比时按元素键 A5 核查
- **数值现状（当前版六级统一）**：`attackGap=1.4`、`bulletSpeed=40`、`recoilValue=6`、`bulletNum=1`、`bulletLife=1`、`bulletWidth=10`、`hurt=1876`、`energyUse=10`；LV1 独有 `price=2000000`（G 币直购，LV2+ 靠超合金研发，Mprice 100/200）

## 形态演变（只读核对三版配置所得，正式对比未开始）

- **2.5**：三形态——普罗米修斯 / 赫拉克勒斯 / 阿喀琉斯（subArms37.xml，positron 块行 1574 起）
- **3.4**：五形态——+奥德修斯 / 喀戎（subArms52 bin，positron 块行 1670 起）
- **当前版**：六形态——+珀尔修斯（LV6 为 11.3 基底后续新增；2.4.2 公告的"新增形态速度统一"名单含珀尔修斯）
- 各级形态名三版按等级一一对应（LV1 三版同名普罗米修斯），名称层面未见 ID 错位；但《火神炮修改与武器导入经验总览》第七节早已把**普罗米修斯**列为"3.4 会占用 2.5 基础 ID、需要先建映射"的三个特殊家族之一（另两个：异端审判、星爆）——**正式对比前映射关系以用户安排为准，不自行推断**

## 关键符号 ID 速查（来自 positron-family-audit 的 symbolscur 快照，证据等级 B，回迁前须重新导出核对）

| 导出名 | 当前 (sub1130) ID | 备注 |
|---|---|---|
| positron_lv1~lv6 | 875 / 862 / 859 / 856 / 853 / 850 | 本体 |
| positron_bullet~bullet6 | 794 / 790 / 788 / 793 / 791 / 826 | 子弹（lv3/4/5 与本体 ID 顺序交错） |
| positron_hit_effect | 824 | 2.5 风格受击导出；**内容已被响尾蛇回迁改绑（见下）** |

## 已知注意事项

- ⚠️ **`positron_hit_effect` 已被响尾蛇家族回迁占用为死名改绑目标**（多米诺家族档案"命名区隔"条目明确记载）：当前 sub1130 中该导出的内容**可能已不是阳电子炮原版受击特效**。任何受击回迁前必须重新导出当前 sub1130 核对该 Character ID 的实际内容，并对 2.5 基准包确认来源；不能按上表 ID 直接取用。
- ⚠️ **测试包先例 ≠ 正式仓库现状**：`tmp-soya-family-test` 下有四轮 positron 先期工作（见文档索引），其中 `positron-family-restore` 的 verification 记录过一轮 SymbolClass 重映射（positron_lv3~lv5、bullet3~5、positron_hit_effect 改配新 ID 2778~2821；lv3~lv5 本体 23 帧、子弹 1 帧、旧受击 15 帧）——**该实验未入正式仓库**，仅作流程与帧数参考；且其实验后状态与上表"审计快照 ID"分属不同时点，引用时注意区分。
- 家族为**成长型**（`Level_Growth_*`，伤害随人物等级成长）：对比/回迁时按用户既往红线，伤害、成长、经济字段一律不动，只谈视觉与表现层。
- 副武器通用教训适用：本体时间轴内的 `basePoint`/`shootPoint` 挂点实例及挂点标记是功能锚点不是美术，三版实机均隐藏，勿计入差异、勿回迁。
- 2.5 受击参考资源：`更新总结\武器特效总结\2.5受击特效提取-20260909.zip`（12 种受击特效逐帧 PNG＋两版 ID/帧数对照）中应含 positron 受击，正式对比时优先取用。

## 本家族文档索引

| 文件/目录 | 内容 |
|---|---|
| 阳电子炮家族工作总结-20260911.md | **收口总入口**：任务脉络、终态产物、关键决策与发现、经验沉淀、全量索引 |
| 阳电子炮家族2.5-3.4回迁执行总结-20260911.md | 回迁执行：改动明细、验证链、哈希（✅ 实测通过） |
| 阳电子炮家族2.5-3.4对比总结-20260910.md | 只读对比：+2 平移映射像素级验证（A 级）、受击/音效一致性、配置 B 类差异、待安排项 |
| 阳电子炮家族2.5-3.4对比总结-20260911补充.md | 蓄力核查＋当前版定点核查＋用户决策（受击回 2.5） |
| 阳电子炮家族本体三版形态对比图-20260910.png | 六行对照：2.5 lv1、3.4 新 lv1/lv2、3.4 lv3~lv5（f1 待机＋f10 开火峰值） |
| 阳电子炮家族子弹对比图-20260910.png | 2.5 三弹与 3.4 五弹对照（+2 平移＋新增小弹） |
| 阳电子炮家族受击特效对比图-20260910.png | `positron_hit_effect` 两版 15 帧逐像素相同（f1/f4/f8/f12） |
| `tmp-soya-family-test\positron-25v34-audit\` | 本次对比工作区（cfg25/cfg34、spr25/spr34 逐帧图、XML、compare.py；不入库） |
| `tmp-soya-family-test\positron-family-audit\` | 更早的三版本符号审计（symbols25/34/cur）＋ lv1/lv2 帧预览 |
| `tmp-soya-family-test\positron-family-restore\` 等 | 测试包回迁实验（未入正式仓库，仅流程与帧数参考） |

## 归档规则

按 `副武器家族\README.md`：总结命名 `主题-YYYYMMDD.md`，必备四段（目标 / 实际修改 / 构建与验证 / 待实机确认项）；移除资源留 `备份-移除的孤儿资源-YYYYMMDD\`；归档后同步上级两级 README 与 `..\..\各家族变更档案.md`。
