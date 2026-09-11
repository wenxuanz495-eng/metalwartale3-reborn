# 黄金恶魔牙家族（黄金飞刃炮） · 家族档案（番外）

> 立项日期：2026-09-12（番外家族，随本体家族"恶魔牙（飞刃炮）"同日立项）
> 当前状态：🆕 **立项建档，正式工作未开始**——本文收录已核实事实与 20260905 前期实验教训；对比范围与回迁映射**一律按用户届时安排**。
> 家族定位：`黄金飞刃炮` 型副武器，当前版独有的黄金变体（2.5/3.4 均无），与"黄金鞭炮（Goldbanger）"同一模式；本体家族见 `..\恶魔牙家族（飞刃炮）\README.md`。

## 家族基本信息（已核实）

- **arms id**：`goldflyBlade`（subArms 配置 index=9，与 flyBlade 同 index 分立 arms 节点）
- **武器类型**：`黄金飞刃炮`；`attackType=motion`
- **形态（当前版 2 级）**：黄金恶魔牙（lv1）/ 黄金撒旦之力（lv2），本体 `imgLabel=goldflyBlade_lv1~lv2`
- **版本独有性**：2.5 `subArms37.xml`、3.4 `subArms52` 均**无** goldflyBlade 节点——纯当前版（11.3 基底后）新增
- **配置位置**：`decompiled\embedded-xml-assets\6_EmbedXml_xmlClass7_EmbedXml_xmlClass7.bin`（goldflyBlade 块）
- **资源包**：`sub1130.swf`
- **子弹**：`bulletImgLabel=sub/goldflyBlade_bullet`（两级共用；SWF 内另有 `goldflyBlade_bullet2` 导出（审计副本 char 396），配置未引用，用途待查）
- **受击**：`hitImgLabel=bullet/blue_motion`（两级统一，与本体家族当前版一致）
- **关键数值（两级统一）**：`attackGap=1.4`、`bulletSpeed=50`、`recoilValue=6`

## 符号 ID 速查（证据等级 B，来源审计副本）

| 导出名 | 当前 (sub1130.swf，审计副本) | 备注 |
|---|---|---|
| goldflyBlade_lv1 | 391 | 11 帧可达（前期实验实测） |
| goldflyBlade_lv2 | 399 | |
| goldflyBlade_bullet | 394 | 配置引用 |
| goldflyBlade_bullet2 | 396 | 配置未引用 |

- 2.5/3.4 无黄金专用资源可迁——**老特效素材只能来自普通 flyBlade 家族或公共资源组**，不存在"2.5 黄金恶魔牙原版特效"。

## 前期实验教训（20260905，测试包内，正式仓库未动）

来源：`tmp-soya-family-test\黄金恶魔牙特效问题总结.md`、`gold-flyblade-25-restore\`

1. 曾三次（v1~v3）把 2.5 普通 `flyBlade_lv1/lv2` 时间轴（含深度 1 逐帧对象 502/465/470/475/480/485）复制进黄金本体，FFDec 回读全部成功，**游戏内枪口烟雾均未恢复**；测试包 sub1130 已回退（回退后 SHA-256 `A5028135DA5F...26A95`），回退前副本存 `gold-flyblade-25-restore\backup\`。
2. **结论**：黄金本体与普通恶魔牙不能按导出名直接一一替换；枪口表现可能不是本体时间轴直接播放，而是开火代码在 `shootPoint` 处运行时创建的对象。
3. **正式工作前置任务**（按前期总结建议）：追踪开火代码中黄金恶魔牙的发射特效创建入口 → 记录 shootPoint 生成对象的实际导出名与所属 SWF → 分版本渲染开火帧定位截图所示五阶段动画的真实 Symbol → 只替换该引用后实测。

## 已知注意事项

- 挂点通用教训适用（`basePoint`/`shootPoint` 为功能锚点非美术）。
- 金色外观是当前版设计资产，若做"老特效回迁"，按黄金鞭炮先例通常**保留金色本体、只回迁特效层**——具体范围听用户安排。
- 受击/子弹如涉及公共名改绑，沿用死名改绑规则（全域扫描配置 bins＋脚本＋存档＋动态拼接后再动手）。

## 本家族文档索引

| 文件/目录 | 内容 |
|---|---|
| （本 README） | 家族档案：基本信息、符号速查、前期实验教训 |
| `..\..\..\..\tmp-soya-family-test\黄金恶魔牙特效问题总结.md` | **先读**：前期实验全过程与未确认清单 |
| `..\..\..\..\tmp-soya-family-test\goldflyblade-audit\`、`goldflyblade-lv1-charge-fix\` | 前期审计与蓄力修复工作区 |
| `..\恶魔牙家族（飞刃炮）\README.md` | 本体家族档案（2.5 素材与三版本对照在本体档案） |

## 归档规则

按 `..\README.md`：总结命名 `主题-YYYYMMDD.md`，必备四段（目标 / 实际修改 / 构建与验证 / 待实机确认项）；移除资源留 `备份-移除的孤儿资源-YYYYMMDD\`；归档后同步上级两级 README 与 `..\..\各家族变更档案.md`。
