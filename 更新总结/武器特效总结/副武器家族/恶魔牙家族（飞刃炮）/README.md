# 恶魔牙家族（飞刃炮） · 家族档案

> 立项日期：2026-09-12（副武器第十五家族，最后一个启动的武器家族）
> 当前状态：🆕 **立项建档，正式对比未开始**——本文只收录已核实的配置/符号事实与前期实验线索；对比范围、版本取舍与形态映射**一律按用户届时安排**，不自行推断、不先行修改。
> 家族定位：`飞刃炮` 型副武器，lv1 中文名"恶魔牙"；附属番外家族 `goldflyBlade`（黄金恶魔牙）分立档案，见 `..\黄金恶魔牙家族（黄金飞刃炮）\README.md`。

## 用户指令边界（2026-09-12）

- 家族以"恶魔牙飞刃炮"指认立项；附属家族"黄金恶魔牙（黄金飞刃炮）"单独建档；
- 对比按既定协议执行：**版本由用户指定、对比过程禁止修改**，重点为 ①射速/散布/弹速 ②子弹贴图/受击特效 ③待机与开火状态/枪口火焰 ④新增形态与中间版本映射（听用户安排）。

## 家族基本信息（已核实）

- **arms id**：`flyBlade`（subArms 配置 index=9；2.5 `subArms37.xml` 同 id 同 index=9；3.4 `subArms52` 同 index=9）
- **武器类型**：`飞刃炮`（三版 `<type>` 一致）；当前 `attackType=motion`
- **形态（名称三版前四级一一对应，无 ID 错位迹象）**：
  - **2.5：4 级**——恶魔牙 / 撒旦之力 / 地狱之触 / 深渊之刃
  - **3.4：5 级**——+灭世之手（lv5）
  - **当前版：6 级**——+诸神之殁（lv6），本体 `imgLabel=flyBlade_lv1~lv6`
- **配置位置**：`decompiled\embedded-xml-assets\6_EmbedXml_xmlClass7_EmbedXml_xmlClass7.bin`（flyBlade 块）
- **资源包**：`sub1130.swf`（副武器体系）；2.5 参考 `sub37.swf`；3.4 参考 `sub52.swf`
- **子弹**：`bulletImgLabel=sub/flyBlade_bullet`（三版全部形态共用一枚弹）
- **受击（当前版）**：`hitImgLabel=bullet/blue_motion`（六级统一；3.4 同）
- **2.5 受击**：裸名 `chipped_hit_effect`（⚠️ 与碎裂炮 2.5 受击同名，见"注意事项"）

## 三版本配置对照（预检，字段级已核对）

| 字段 | 2.5 | 3.4 | 当前 GH |
|---|---|---|---|
| 形态数 | 4 | 5（+灭世之手） | 6（+诸神之殁） |
| type | 飞刃炮 | 飞刃炮 | 飞刃炮 |
| attackType | **mixed** | motion | motion |
| attackGap | **0.9** | **0.55** | **1.4** |
| bulletSpeed | 50 | 50 | 50（2.4.1 公告曾统一家族速度=50） |
| recoilValue | 6 | 6 | 6 |
| hitImgLabel | **裸名 chipped_hit_effect** | bullet/blue_motion | bullet/blue_motion |
| bulletImgLabel | sub/flyBlade_bullet 共用 | 同 | 同 |

候选差异（**待正式对比核实与用户决策**）：①attackType 2.5 `mixed`→3.4/当前 `motion`（同碎裂炮 mixed→boom 的方向性改动，行为字段非纯视觉）；②attackGap 演进 0.9/0.55→1.4（同响尾蛇/调皮/战殇/多米诺/碎裂炮"GH 射速改慢"模式）；③受击整套更换（2.5 裸名→`bullet/blue_motion`）。

## 符号 ID 速查（证据等级 B）

| 导出名 | 2.5 (sub37.swf) | 当前 (sub1130.swf，审计副本) | 备注 |
|---|---|---|---|
| flyBlade_lv1 | 523 | 2902 | lv1 为 11 帧 MovieClip |
| flyBlade_lv2 | 498 | 2877 | |
| flyBlade_lv3 | 495 | 2874 | |
| flyBlade_lv4 | 492 | 2871 | |
| flyBlade_lv5 | 无 | 885 | 3.4起新增 |
| flyBlade_lv6 | 无 | 882 | 当前版新增 |
| flyBlade_bullet | 449 | 2828 | 全形态共用 |

- 2.5 侧 `flyBlade_lv1` 时间轴含深度 1 逐帧对象 f2~f7 → Character 502/465/470/475/480/485（外观接近枪口发射烟雾/能量变化，**是否即目标特效未确认**）。
- 当前侧 ID 来自 `tmp-soya-family-test\demon-tooth-audit\work\sym\symbols.csv`（审计副本，正式对比时对正式 `sub1130.swf` 复核）。

## 立项预检线索（前期实验，均在测试包，正式仓库未动）

- `tmp-soya-family-test\黄金恶魔牙特效问题总结.md`：20260905 前期曾把 2.5 普通恶魔牙时间轴套用黄金本体（v1~v3），**未恢复目标枪口烟雾**，已全部回退——"FFDec 回读成功≠游戏内正确"的实证案例；黄金枪口表现的真实来源（本体时间轴 vs 开火代码在 shootPoint 运行时创建）**尚未定位**。正式进入黄金家族工作前，先按该文建议追踪开火代码发射特效入口。
- 相关工作区：`demon-tooth-audit`（sub1130 符号审计）、`demon-offset-fix` / `demon-offset-fix2`（恶魔牙偏移修复实验）。

## 已知注意事项

- **`chipped_hit_effect` 同名不同物**：2.5 裸名指向 8 帧（sub37 char 1632）；当前 `sub1130.swf` #1424 为 3.4 版 7 帧。该名同时是碎裂炮家族 2.5 侧受击名、被多家族共用的公共受击特效名——若做受击回迁，**严禁原位替换，须死名改绑**（先例：碎裂炮改绑 `bullet/blueness_energy`、星爆改绑 `pink_boom`）。2.5 受击逐帧基准见 `..\..\2.5受击特效提取-20260909.zip`。
- 挂点通用教训适用：本体时间轴内 `basePoint`/`shootPoint` 命名实例及挂点标记是功能锚点不是美术，三版实机均被 `SWFLoaderManager` 隐藏，勿计入差异、勿作回迁对象。
- `attackType` 属行为字段（HurtCount 克制表联动），是否随特效回迁需用户单独决策。
- 新增形态（lv5/lv6）按既有家族规律通常沿用上一形态特效，**实际映射以正式对比＋用户安排为准**。

## 本家族文档索引

| 文件/目录 | 内容 |
|---|---|
| （本 README） | 家族档案：基本信息、三版本预检、符号速查、注意事项 |
| `..\..\..\..\tmp-soya-family-test\黄金恶魔牙特效问题总结.md` | 前期黄金实验教训（跨家族，黄金档案为主引用） |
| `..\..\2.5受击特效提取-20260909.zip` | 2.5 受击特效全量逐帧基准包 |

## 归档规则

按 `..\README.md`：总结命名 `主题-YYYYMMDD.md`，必备四段（目标 / 实际修改 / 构建与验证 / 待实机确认项）；移除资源留 `备份-移除的孤儿资源-YYYYMMDD\`；归档后同步上级两级 README 与 `..\..\各家族变更档案.md`。
