# 24 铁鸦背叛者 · 文件索引与介绍

> 本夹档案：`铁鸦背叛者-档案-20261003.md`（设计 Boss · 敌方英雄系统首档）。本 README＝该怪全部相关文件的索引字典。
> ⚠️ 本怪无敌人表条目、无专属 swf——检索入口＝关卡表 `trueName` 属性。

## 代码文件（仓库 `decompiled\`）

- `gamefile\scripts\body\enemy\EnemyHeroCtrl.as`（敌方英雄控制器）——**本怪的真正"定义文件"**：第 28 行起 `trueName=="铁鸦背叛者"` 分支硬编码全部配置（主武器 soya_lv2/fireFairy_lv4/cannon_lv4/laserPulse_lv4、副武器 missile_lv4/elastic_lv4、skillNum [8,4,3]、战车 nightrider、四档难度伤害 0.038/0.9/3.8/16）。
- `gamefile\scripts\body\define\LifeBodyDefine.as:15`——`trueName` 字段定义。
- `gamefile\scripts\bodyGroup\BodyGroup.as:410`——出兵名"叛军"→`addEnemyHeroBody()`。
- 关卡表：`embedded-xml-assets\17_EmbedXml_xmlClass11_….bin` → **1-1-12** 至急救援：unit `type="boss" trueName="铁鸦背叛者"`（出兵名"叛军"）＋ `boss="铁鸦背叛者"` 属性。
- 图鉴：`gamefile\scripts\UI\book\BookUI.as`（帧标签"铁鸦背叛者"，顺序数组第 24 位）。

## 资源文件

- **战车**：nightrider——`swf\car1130.swf` 战车包内（无独立 swf）。
- **武器贴图**：复用玩家武器资源 `swf\arms1100.swf`／`sub1130.swf`（所持武器对应的既有符号）。
- 11.3 素材汇总：**无**铁鸦相关夹。
- 图鉴图标：`swf\BookUI760.swf` 内嵌 JPG。

## 文档与数据

- 图鉴文案（含网页介绍说明）：`D:\superalloy\世界观开发\规整档案\原版资料\原版机器人，角色介绍\超合金机器人介绍….docx`。
- 三方比对数据：不适用（无独立 swf，未进入比对）。
- 权威图鉴顺序：`..\图鉴顺序-BookUI.json`。

## 家族关联

- `..\25，铁鸦战队队长\`（trueName="铁鸦队长"，car fireDemon）、`..\26，铁鸦战队指挥官\`（trueName="铁鸦战队指挥官"，car predator）——同系统，建档时互链。
- 同系统另一支：**玩家副本 12 Boss**（Vincent/炮王/叫兽…，配置走 weekExtra 定义＋600 万~4000 万血）——系统级说明见 24 档三节。
