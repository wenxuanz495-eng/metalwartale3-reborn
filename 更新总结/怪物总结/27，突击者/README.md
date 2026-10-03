# 27 突击者 · 文件索引与介绍

> 本夹档案：`突击者-档案-20261003.md`（设计 Boss：1-1-0 序章）。本 README＝该怪全部相关文件的索引字典。
> ⚠️ 武器名混写"突袭者"（=突击者）；1-1-3"突击者队长"为本怪再战关，非独立怪。

## 代码文件（仓库 `decompiled\`）

- `gamefile\scripts\enemy\charger\ChargerBody.as`（171 行）——身体类。
- `gamefile\scripts\enemy\charger\Charger_AI.as`（44 行）——AI：三分支**等概率**切换三武器（bilvArr=[1,1,1]）。
- `gamefile\scripts\enemy\charger\ChargerAnimation.as`（101 行）——专用动画（跳跃双组态）。
- `gamefile\scripts\enemy\charger\ChargerAAHD.as`（45 行）——碰撞头。
- `gamefile\scripts\enemy\charger\Charger_ExtraSkill.as`（37 行）——**敌方技能系统脚手架**：技能槽 [EMP_5, Slow_Missile(禁用), Plasma(禁用)]，phase_1/2/3 空置——TACTICAL_MODE 技能设计的前身证据。
- 敌人表：`embedded-xml-assets\5_EmbedXml_xmlClass8_….bin` → **index 8, id=Charger**（表内 name=突击者）。
- 敌方武器表：`embedded-xml-assets\4_EmbedXml_xmlClass9_….bin` → 三武器（后缀 id 模式，AI 三分支切换）：**index 100010 id=Charger_1**（火神炮：boom/angle 5/hurt 0.5/gap 0.9）＋ **index 100011 id=Charger_2**（迫击炮 LV1：boom/hurt 2/gap 0.7；**LV2=杀戮者的武器2-迫击炮** energy/hurt 1——跨怪共用）＋ **index 100012 id=Charger_3**（导弹：boom/angle 280 朝天/hurt 0.4/speed 10/bulletLife 4）。
- Boss 标记：关卡表 → 1-1-0 `boss="突击者"`＋unit `type="boss"`；1-1-3 队长关再战。
- 图鉴：`gamefile\scripts\UI\book\BookUI.as`（帧标签"突击者"，顺序数组第 27 位）。

## 资源文件

- 当前仓：`swf\Charger.swf`（SHA-256 前12 `9888d37a3d27`＝**11.3 原版音**）。
- 原版 2.5：`D:\superalloy\原版\2.5（原版参考）\2.5版本素材库\raw\swf\enemy\Charger.swf`（⚠️ 此份是 **audio-fix 修音版** `d91af184`，非原版音）；原版音在 `Charger.original-before-audio-fix.swf`（与当前仓逐字节相同）。
- 原版 3.4：`D:\superalloy\原版\3.4（原版参考）\3.4素材库\raw\swf\enemy\Charger.swf`。
- 11.3 素材汇总：无直配夹（`突击队长\` 夹疑为队长变体素材，待考）。
- 图鉴图标：`swf\BookUI760.swf` 内嵌 JPG。

## 文档与数据

- 图鉴文案（太空计划失败品/第9舰队/网页版 MK-II榴弹炮）：`D:\superalloy\世界观开发\规整档案\原版资料\原版机器人，角色介绍\超合金机器人介绍….docx`。
- 三方比对数据：`D:\superalloy\TMP\敌人美术对比-20260928\`（互异=纯音频，已破案）。
- 权威图鉴顺序：`..\图鉴顺序-BookUI.json`。

## 家族关联

- `..\29，杀戮者\`（Slayer——借用 Charger_2 LV2 迫击炮定义，建档时互链）。
- 1-1-3"突击者队长"＝本怪再战关（队长非独立怪）。
