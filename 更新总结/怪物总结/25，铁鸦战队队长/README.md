# 25 铁鸦战队队长（杰克） · 文件索引与介绍

> 本夹档案：`铁鸦战队队长-档案-20261003.md`（设计 Boss · 敌方英雄系统）。本 README＝该怪全部相关文件的索引字典。
> ⚠️ 无敌人表条目、无专属 swf——检索入口＝关卡表 `trueName="铁鸦队长"`。

## 代码文件（仓库 `decompiled\`）

- `gamefile\scripts\body\enemy\EnemyHeroCtrl.as`（敌方英雄控制器）——**本怪"定义文件"**：第 51 行起 `trueName=="铁鸦队长"` 分支硬编码（主武器 soya_lv3/shotgun_lv4/induction_lv4/wave_lv4、副武器 laser_lv4/cutter_lv4、skillNum [10,5,5]、战车 fireDemon、四档难度伤害 0.047/0.72/2.4/12）。
- `gamefile\scripts\bodyGroup\BodyGroup.as:410`——出兵名"叛军"→`addEnemyHeroBody()`。
- 关卡表：`embedded-xml-assets\17_EmbedXml_xmlClass11_….bin` → **1-1-19** 乘胜追击：unit `type="boss" trueName="铁鸦队长"` ＋ `boss="铁鸦队长"` 属性。
- 图鉴：`gamefile\scripts\UI\book\BookUI.as`（帧标签"铁鸦战队队长"，顺序数组第 25 位）。

## 资源文件

- **战车**：fireDemon——`swf\car1130.swf` 战车包内。
- **武器贴图**：复用玩家武器资源 `swf\arms1100.swf`／`sub1130.swf`。
- 11.3 素材汇总：无铁鸦相关夹。
- 图鉴图标：`swf\BookUI760.swf` 内嵌 JPG。

## 文档与数据

- 图鉴文案（杰克，含 docx 笔误"主角租相遇"）：`D:\superalloy\世界观开发\规整档案\原版资料\原版机器人，角色介绍\超合金机器人介绍….docx`。
- 三方比对数据：不适用。
- 权威图鉴顺序：`..\图鉴顺序-BookUI.json`。

## 家族关联

- `..\24，铁鸦背叛者\`（同系统首档，含系统级说明）；`..\26，铁鸦战队指挥官\`（达利安，car predator，三连终战）。
