# 战殇家族（激光棱束炮）· 家族档案

> 立项日期：2026-09-09（副武器第四家族）
> 当前状态：✅ **射速 2.5 回迁已构建入库待实测（2026-09-09）**——先读 `战殇家族射速2.5回迁执行总结-20260909.md`；前置审计见 `战殇家族2.5-3.4-11.3三版本对比总结-20260909.md`（受击三态与 bulletLink 死配置为决策保持项）

## 家族基本信息（已核实）

- **arms id**：`laser`（subArms 配置 index=6）
- **攻击属性**：`attackType=energy`，武器描述"以一定频率发射高能激光脉冲"（截图：武器属性 束能）
- **形态**：四级 `laser_lv1~lv4`——战殇 / 破邪 / 星痕 / 无幻（用户截图可见前三级，第四级"无幻"来自配置）
- **配置位置**：`decompiled\embedded-xml-assets\6_EmbedXml_xmlClass7_EmbedXml_xmlClass7.bin`
- **本体资源**：`sub1130.swf`（导出名 `laser_lv1~lv4`）
- **受击**：三版配置同用 `sub/laser_hit_effect`
- **子弹**：配置无 `bulletImgLabel`（energy 型，激光脉冲表现待 SWF/代码层核实）
- **数值现状**（当前版，四级统一）：`attackGap=2.4`、`attackDelay=0`、`bulletWidth` 10/15/20/27、`bulletLife=1`、`hurt` 24/33/41/63、`energyUse=10`

## 立项预检线索（只读核对 2.5 subArms37.xml / 3.4 subArms52 bin，未做全面对比）

- 三版同为四形态战殇/破邪/星痕/无幻，`imgLabel`、`hitImgLabel`、`attackDelay=0`、`hurt` 24/33/41/63、`bulletWidth` 10/15/20/27、`bulletLife=1` 逐级一致。
- 立项即见的配置差异（待正式对比确认全貌）：
  - `attackGap`：2.5=3.4=`1.5`，当前版=`2.4`（与电磁炮/响尾蛇/调皮"GH 射速改慢"同方向；面板 1.2 发/秒 ≈ 1/0.83？需实机核实口径）。
- 仅登记不处理（成长线，按惯例禁改）：`commonLevel` 2.5=3.4 为 21/26/30/40，当前版 24/29/33/43（+3）。

## 已知注意事项（沿副武器阶段通用教训）

- `sub/laser_hit_effect` 为本家族受击特效，若回迁涉及其内容，先全域核查共用引用（敌方/其他武器），禁止原位重建共用资源。
- 副武器本体时间轴内的 `basePoint`/`shootPoint` 挂点实例与挂点标记不是美术，三版实机均隐藏，勿计入版本差异、勿作为回迁对象。
- energy 型武器无 `bulletImgLabel`，"子弹"表现可能在本体时间轴（A2 内嵌）或运行时代码生成，对比时按元素键 A1/A2 与 C 类排查。

## 归档规则

按 `副武器家族\README.md`：总结命名 `主题-YYYYMMDD.md`，必备四段（目标 / 实际修改 / 构建与验证 / 待实机确认项）；移除资源留 `备份-移除的孤儿资源-YYYYMMDD\`；归档后同步上级两级 README。
