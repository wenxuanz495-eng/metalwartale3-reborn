# 磁轨炮家族 · 家族档案

> 立项日期：2026-09-11（主武器第十八家族）
> 当前状态：✅ **任务完成收口（2026-09-12）**——先读 `磁轨炮家族工作总结-20260912.md`（家族总入口：全流程叙事与经验沉淀）。蓄力辉光 A/B/C 回迁＋射点三轮实机微调定稿（tx 1646/2140/2563/2822/3140），arms1100=E108B33B；数值/材料/子弹/受击按用户口径维持新版。参数细节见 `磁轨炮蓄力特效回迁执行总结-20260912.md`：flashA/B/C 三层辉光闭包（新 ID 1801~1809，源=4.0）插入五形态时间轴（f2=开火+枪口火焰D+A+B、f3=+C、4 帧制），arms1100=D1184767→11963E07，三处同步＋manifest＋`--check sa` 通过；数值/材料/子弹/受击按用户口径全部未动。前置：`磁轨炮家族3.4-4.0-当前版对比总结-20260912.md`（错位映射像素级证实；本体三方全等无需迁移）。

## 用户指令边界（2026-09-11）

- 以 LV1 形态名指认家族：**恐惧镰刀**（用户口述"磁轨炮武器"）；
- 2026-09-12 追加：完成 3.4/4.0/当前版三版本对比；用户已定回迁映射——**新版 LV4/LV5 ← 3.4 LV1/LV2，新版 LV1~LV3 ← 4.0 LV1~LV3**；特效口径＝枪口火焰留新版、**蓄力特效回老版**；数值口径＝战斗力数值与材料一律维持新版（attackGap=0/recoil=4/reduceRa=0.7/材料价格不动），子弹维持新版。

## 家族基本信息（已核实）

- **arms id**：`magneticTrack`（主武器配置 index=15）
- **武器类型**：`磁轨炮`；`attackType=motion`；`specialProperty=穿透`（两版一致；两版配置均**无** `penetrationB` 字段、无 `smokeImgLabel`、无 `imgLoopTime`→ 默认 playOnce 单闪路径）
- **形态**：
  - **3.4：2 形态**——恐惧镰刀（LV1）/ 恐惧先驱（LV2，`bulletImgLabel` 复用 `lv1_bullet`）
  - **当前版：5 形态**——恐惧镰刀（LV1）/ 恐惧先驱（LV2）/ 炼狱使者（LV3）/ 噬魂之指（LV4）/ 灾变巨刃（LV5），每级独立 `_lvN_bullet`；`commonLevel` 90/110/120/130/140
- **配置位置**：
  - GitHub：`decompiled\embedded-xml-assets\2_EmbedXml_xmlClass3_EmbedXml_xmlClass3.bin` 的 `<arms index="15" id="magneticTrack">` 块
  - 3.4 参考：`原版\3.4（原版参考）\3.4代码库\reference-binary-data\12_arms61_xml$….bin` 同名块
- **资源包**：`arms1100.swf`（主武器体系）
- **受击**：两版配置 `hitImgLabel` 同为 `bullet/blue_motion`
- **关键数值（当前版五级统一）**：`attackGap=0`（⚠️ 3.4=0.1）、`bulletSpeed=40`、`hurt=2210`、`recoilValue=4`（⚠️ 3.4=1）、`bulletWidth=10`、`bulletNum=1`、`energyUse=24`
- **3.4 合成参考（LV1）**：`mustItems=thorn_5_num2000,superalloy_num1000,superalloy_Z_num500,superalloy_X_num200`，`price=10000000`
- **3.4 类源码**：`3.4代码库\assets\scripts\magneticTrack_lv1.as / magneticTrack_lv1_bullet.as / magneticTrack_lv2.as`

## 符号 ID 速查（证据等级 B）

| 导出名 | 3.4 (arms52.swf) | 当前 (arms1100.swf) | 备注 |
|---|---|---|---|
| magneticTrack_lv1 | 48 | 582 | LV1 恐惧镰刀 |
| magneticTrack_lv2 | 43 | 575 | LV2 恐惧先驱 |
| magneticTrack_lv3 | 无 | 568 | LV3 炼狱使者（3.4 无） |
| magneticTrack_lv4 | 无 | 561 | LV4 噬魂之指（3.4 无） |
| magneticTrack_lv5 | 无 | 556 | LV5 灾变巨刃（3.4 无） |
| magneticTrack_lv1_bullet | 28 | 550 | 3.4 LV1/LV2 共用；当前版各级独立弹 |
| magneticTrack_lv2~lv5_bullet | 无 | 549/547/545/544 | 当前版独有 |

- 3.4 侧资源来源：`原版\3.4（原版参考）\3.4游戏\swf\arms52.swf`；素材检索入口 `3.4素材库\export\weapons\主武器\`

## 初步认识与注意事项

- 形态演变方向与微波炮家族类似：**当前版在 3.4 两形态基础上新增 lv3/lv4/lv5**，且 LV2 起改用独立弹（3.4 LV2 复用 LV1 弹）——正式对比时形态映射关系按用户安排，不自行推断。
- 配置层已见三处候选差异（待正式对比核实）：`attackGap`（3.4=0.1 → 当前=0，射速节奏）、`recoilValue`（1 → 4）、LV2 弹独立化。
- 受击名 `bullet/blue_motion` 与本家族其他资产引用情况、是否与他族共用，**待正式对比时全域核查**。
- 挂点通用教训适用：`basePoint`/`shootPoint` 是功能锚点不是美术，不构成版本差异、不作回迁对象。

## 工作区与文档索引

| 文件/目录 | 内容 |
|---|---|
| 磁轨炮蓄力特效回迁执行总结-20260912.md | **先读（最新）**：蓄力辉光 A/B/C 闭包回迁执行记录、帧序设计、验证链与哈希 |
| **磁轨炮家族工作总结-20260912.md** | **家族总入口**：立项·三版对比·错位证实·口径决策·蓄力回迁·射点三轮微调全流程与经验沉淀 |
| 磁轨炮蓄力特效回迁执行总结-20260912.md | 蓄力辉光 A/B/C 闭包回迁＋射点三轮微调执行记录、帧序设计、验证链与哈希台账 |
| 磁轨炮家族3.4-4.0-当前版对比总结-20260912.md | 三版本对比：配置 diff、5帧vs3帧结构、位图像素表、4.0 lv5 f2 异常、迁移含义 |
| 备份-被替换的旧资源-20260912/ | 旧 arms1100（D1184767）与回滚说明 |
| `tmp-soya-family-test\magnetic-track-audit-20260912\` | 对比证据工作区（arms400/bullet 导出、位图像素比对、音效 MD5） |

## 归档规则

按 `..\README.md`：总结命名 `主题-YYYYMMDD.md`，必备四段（目标 / 实际修改 / 构建与验证 / 待实机确认项）；移除资源留 `备份-移除的孤儿资源-YYYYMMDD\`；归档后同步上级两级 README。
