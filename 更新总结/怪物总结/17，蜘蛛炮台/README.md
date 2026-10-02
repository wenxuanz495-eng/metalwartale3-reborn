# 17 蜘蛛炮台 · 文件索引与介绍

> 本夹档案：`蜘蛛炮台-档案-20261003.md`。本 README＝该怪全部相关文件的索引字典。

## 代码文件（仓库 `decompiled\`）

- `gamefile\scripts\enemy\spiderFort\SpiderFortBody.as`（155 行）——身体类：受击/死亡/动画状态。
- `gamefile\scripts\enemy\spiderFort\SpiderFort_AI.as`（68 行）——AI：按目标角度 atan2 自动选武器级（平射/斜射/对空）。
- `gamefile\scripts\enemy\spiderFort\SpiderFortAnimation.as`（61 行）——专用动画控制（跳跃双态等）。
- 敌人表：`embedded-xml-assets\5_EmbedXml_xmlClass8_….bin` → **index 35, id=SpiderFort**。
- 敌方武器表：`embedded-xml-assets\4_EmbedXml_xmlClass9_….bin` → **index 100039, id=SpiderFort_1**（⚠️ 挂 `_1` 后缀 id，主 id 无定义；3 级火神炮：平射/-35°/-90° 对空，hurt 0.3）。
- 图鉴：`gamefile\scripts\UI\book\BookUI.as`（帧标签"蜘蛛炮台"，顺序数组第 17 位）。

## 资源文件

- 当前仓：`swf\SpiderFort.swf`（SHA-256 前8 `2CCC7F7A`，三方全同）。
- 原版 2.5：`D:\superalloy\原版\2.5（原版参考）\2.5版本素材库\raw\swf\enemy\SpiderFort.swf`。
- 原版 3.4：`D:\superalloy\原版\3.4（原版参考）\3.4素材库\raw\swf\enemy\SpiderFort.swf`。
- 11.3 素材汇总：`D:\superalloy\原版\11.3超合金素材汇总\蜘蛛炮台\`。
- 图鉴图标：`swf\BookUI760.swf` 内嵌 JPG。

## 文档与数据

- 图鉴文案：`D:\superalloy\世界观开发\规整档案\原版资料\原版机器人，角色介绍\超合金机器人介绍….docx`（加特林冲锋炮/四足/特别任务）。
- 三方比对数据：`D:\superalloy\TMP\敌人美术对比-20260928\`。
- 权威图鉴顺序：`..\图鉴顺序-BookUI.json`。

## 家族关联

- `..\4，自爆蜘蛛机\`（Spider，同为蜘蛛系但独立怪）；`Bluespid 碧蓝蜘蛛战士`（index 93）后续批次。
