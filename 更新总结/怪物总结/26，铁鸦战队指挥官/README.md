# 26 铁鸦战队指挥官（达利安） · 文件索引与介绍

> 本夹档案：`铁鸦战队指挥官-档案-20261003.md`（设计 Boss · 敌方英雄系统，三连终战）。本 README＝该怪全部相关文件的索引字典。
> ⚠️ 无敌人表条目、无专属 swf——检索入口＝关卡表 `trueName="铁鸦战队指挥官"`。

## 代码文件（仓库 `decompiled\`）

- `gamefile\scripts\body\enemy\EnemyHeroCtrl.as`——**本怪"定义文件"**：第 74 行起 `trueName=="铁鸦战队指挥官"` 分支硬编码（主武器 soya_lv4/etcg_lv4/lightning_lv4/charged_lv4、副武器 hotline_lv4/lightningBall_lv4、skillNum [15,8,8]、战车 predator、四档难度伤害 0.076/0.63/4/11.5）。
- `gamefile\scripts\bodyGroup\BodyGroup.as:410`——出兵名"叛军"→`addEnemyHeroBody()`。
- 关卡表：`embedded-xml-assets\17_EmbedXml_xmlClass11_….bin` → **1-1-27** 铁鸦的末日：unit `type="boss" trueName="铁鸦战队指挥官"` ＋ `boss="铁鸦战队指挥官"` 属性。
- 图鉴：`gamefile\scripts\UI\book\BookUI.as`（帧标签"铁鸦战队指挥官"，顺序数组第 26 位）。

## 资源文件

- **战车**：predator——`swf\car1130.swf` 战车包内；仓根另有独立 `swf\Predator.swf`（对应关系待考）。
- **武器贴图**：复用玩家武器资源 `swf\arms1100.swf`／`sub1130.swf`。
- 11.3 素材汇总：无铁鸦相关夹。
- 图鉴图标：`swf\BookUI760.swf` 内嵌 JPG。

## 文档与数据

- 图鉴文案（达利安）：`D:\superalloy\世界观开发\规整档案\原版资料\原版机器人，角色介绍\超合金机器人介绍….docx`。
- 三方比对数据：不适用。
- 权威图鉴顺序：`..\图鉴顺序-BookUI.json`。

## 家族关联

- `..\24，铁鸦背叛者\`（系统首档）／`..\25，铁鸦战队队长\`（杰克）——铁鸦三连 24→25→26 复仇线，skillNum 8→10→15 递增。
- 剧情关联：突袭机械城（1-1 城市章节背景）→集体叛变→月都之战败亡（docx 泛称，败亡关实为 1-1-27）。
