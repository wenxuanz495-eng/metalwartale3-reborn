# 多米诺家族（质子撞击炮）· 家族档案

> 立项日期：2026-09-10（副武器第八家族）
> 当前状态：✅ **2.5 回迁已构建入库待实测（2026-09-10，含追加批次：lv3/lv4 开火闪换 2.5 青白焰）**——先读 `多米诺家族2.5回迁执行总结-20260910.md`：lv1/lv2 本体时间轴（枪口火焰+蓄力层）＋lv1/lv2 子弹/烟雾回 2.5、lv3/lv4 补挂蓄力层（共享图）＋子弹配置复用、开火音/爆炸音内容回 2.5、attackType motion→mixed ×5；**射速 1.4 与一切战斗/经济字段按用户指令未动**。回迁后 lv1/lv2 本体/子弹/烟雾 vs 2.5 全帧像素一致；sub1130=0FA29E97（含追加批次）、config=B7A78A06、game.swf=40B6640F。前置：`多米诺家族2.5-3.4-11.3三版本对比总结-20260910.md`。

## 家族基本信息（已核实）

- **arms id**：`protonImpact`（subArms 配置 index=8）
- **攻击属性**：`attackType=motion`，`specialProperty=范围伤害`
- **形态（当前版四级）**：多米诺（lv1）/ 连锁闪电（lv2）/ 能量反冲（lv3）/ 闪电风暴（lv4），`commonLevel` 75/90/110/130，研发前置 `mustArms=chipped_lv4`
- **配置位置**：`decompiled\embedded-xml-assets\6_EmbedXml_xmlClass7_EmbedXml_xmlClass7.bin`（protonImpact 块约 1712~1880 行）
- **资源包**：`sub1130.swf`；导出名 `protonImpact_lv1~lv4`（本体）、`protonImpact_lv1~lv4_bullet`（子弹）、`protonImpact_effect`（范围伤害爆炸，6 帧）；**无 lv3/lv4 专属 `_smoke` 导出**——lv3/lv4 配置 `smokeImgLabel` 复用 `sub/protonImpact_lv2_smoke`
- **受击**：三版配置 `hitImgLabel` 同为 `sub/noBullet`（无常规受击特效调用）；`protonImpact_effect` 推测为范围伤害的爆炸表现，**引用入口待核实**（不在 hitImgLabel 上，可能走子弹时间轴或运行时代码）
- **数值现状（当前版四级统一）**：`attackGap=1.4`、`bulletSpeed=40`、`recoilValue=5`、`bulletNum=1`、`hurt=1876`、`bulletWidth=20`、`energyUse=10`

## 立项预检线索（只读核对 2.5 subArms37.xml / 3.4 subArms52 bin，未做全面对比）

- **形态演变（新增形态家族，正式对比时映射关系按用户安排，不自行推断）**：
  - 2.5：仅两形态——多米诺 / 连锁闪电（subArms37.xml 行 1318~1402）
  - 3.4：三形态——+能量反冲，且其 `imgLabel` 复用 `protonImpact_lv2`、子弹复用 `lv2_bullet`（subArms52 行 1322~1446）
  - 当前版：四形态——+闪电风暴（独立 `imgLabel=protonImpact_lv4`）
- **配置差异**：`attackGap` 2.5=3.4=`0.9` vs 当前=`1.4`（同电磁炮/响尾蛇/调皮/战殇"GH 射速改慢"方向）；`attackType` 2.5=`mixed` vs 3.4/当前=`motion`（主块+爆炸块同步）；当前版 lv4 独有 `bulletMaxV=40`/`bulletMaxVa=0`；`bulletWidth` 7/10/10/10 **三版一致**（初版误报"统一 20"系误读相邻 chipped_lv5 块，已更正）；`recoilValue`/`bulletSpeed`/`hurt` 三版一致（5/40/1876）
- **三版本 SWF 符号审计**（`tmp-soya-family-test\domino-visual-audit`，只读已完成）：
  - 本体 lv1/lv2 三版两两不同（各 29 帧，结构哈希互异）；lv3 仅 3.4 与当前版有（两者亦不同）；lv4 仅当前版有
  - 子弹/烟雾 lv1/lv2：2.5=3.4 逐字节相同，当前版不同；lv3/lv4 子弹仅当前版有
  - `protonImpact_effect`：**三版结构哈希一致**（`a8efa1a0347ce863`，2.5 ID=289 / 3.4 ID=301 / 当前 ID=736），受击/爆炸表现无版本差异
  - 本体开火音 StartSound：2.5 用音 299、3.4 用音 311、当前用音 692（ID 不同，音频内容是否一致未核实）
- **测试包先例**：`tmp-soya-family-test\domino-family-restore` 曾验证过一轮测试包回迁（9 个导出重映射；lv3/lv4 本体用"lv2 蓄力根+当前本体定义"混合模板），**未入正式仓库，仅作参考**
- ⚠️ **命名区隔**：`tmp-soya-family-test` 下 `positron-*` 工作区属于另一家族（正电子，index=10），与本家族无关；`sub/positron_hit_effect` 已被响尾蛇回迁占用为死名改绑目标，均勿混淆

## 关键符号 ID 速查（来自 domino-visual-audit，证据等级 B）

| 导出名 | 2.5 (sub37) | 3.4 (sub52) | 当前 (sub1130) | 帧数 | 三版关系 |
|---|---|---|---|---|---|
| protonImpact_lv1 | 317 | 333 | 724 | 29 | 三版两两不同 |
| protonImpact_lv2 | 315 | 331 | 720 | 29 | 三版两两不同 |
| protonImpact_lv3 | 无 | 327 | 716 | 29 | 3.4≠当前 |
| protonImpact_lv4 | 无 | 无 | 712 | 29 | 仅当前版 |
| lv1_bullet | 274 | 286 | 689 | 4 | 2.5=3.4≠当前 |
| lv2_bullet | 271 | 283 | 688 | 4 | 2.5=3.4≠当前 |
| lv3_bullet | 无 | 无 | 687 | 4 | 仅当前版 |
| lv4_bullet | 无 | 无 | 684 | 4 | 仅当前版 |
| lv1_smoke | 277 | 289 | 681 | 5 | 2.5=3.4≠当前 |
| lv2_smoke | 276 | 288 | 680 | 5 | 2.5=3.4≠当前 |
| protonImpact_effect | 289 | 301 | 736 | 6 | **三版相同** |

## 已知注意事项（沿副武器阶段通用教训）

- 副武器本体时间轴内的 `basePoint`/`shootPoint` 挂点实例与挂点标记不是美术，三版实机均隐藏，勿计入版本差异、勿作为回迁对象。
- 本家族 `hitImgLabel=sub/noBullet` 且 `specialProperty=范围伤害`："受击/爆炸"表现大概率走 `protonImpact_effect` 或运行时代码路径，对比时按元素键 A5/C 类排查，勿只盯配置字段。
- 若回迁涉及其内容，先全域核查 `protonImpact_effect` 的引用入口与共用情况，再决定原位替换或死名改绑。

## 本家族文档索引

| 文件/目录 | 内容 |
|---|---|
| 多米诺家族2.5-3.4-11.3三版本对比总结-20260910.md | 只读对比：配置全字段 diff、像素级比对、音频内容审计、形态演变事实（含 bulletWidth 误报更正记录） |
| 多米诺家族2.5回迁执行总结-20260910.md | 回迁执行：两批追加全部改动、验证链、哈希、**端到端工作流程梳理与管线坑沉淀** |
| 多米诺家族本体三版本对比图-20260910.png / 本体全帧序列对比图 / 子弹烟雾effect对比图 | 对比证据（红 ⊕ 为挂点标记，实机隐藏） |
| 备份-被替换的旧资源-20260910/ | 旧 sub1130（56EC1BF1）、旧配置 bin（AEAC01D3）、中间态（0BE4959A 橙焰版）|
| 工作区（不入库） | `tmp-soya-family-test\domino-3ver-pixel-audit\`（对比）、`domino-25-restore\`（回迁管线） |

## 归档规则

按 `副武器家族\README.md`：总结命名 `主题-YYYYMMDD.md`，必备四段（目标 / 实际修改 / 构建与验证 / 待实机确认项）；移除资源留 `备份-移除的孤儿资源-YYYYMMDD\`；归档后同步上级两级 README。
