# 09 追踪者 · 路径索引

> 本夹档案：`追踪者-档案-20260929.md`。全部相关路径集中于此，便于直接调用。

## 代码（仓库 `decompiled\`）

- AI：`gamefile\scripts\enemy\tracker\`——**仅 TrackerBody.as 一个文件**（与 Tracker2 追猎者共用）
- 敌人表：`embedded-xml-assets\5_EmbedXml_xmlClass8_….bin` → **index 29, id=Tracker**
- 敌方武器表：`embedded-xml-assets\4_EmbedXml_xmlClass9_….bin` → **index 100031, id=Tracker**（追踪弹：bulletSpeed 0/MaxV 30/**MaxVa 50**/bulletLife 3/hurt 1.0/angle 0）
- 图鉴：`gamefile\scripts\UI\book\BookUI.as`（帧标签"追踪者"，顺序数组第 9 位）

## 资源

- 当前仓：`swf\Tracker.swf`（SHA-256 前8 `0252AA75`，三方全同）
- 原版 2.5：`D:\superalloy\原版\2.5（原版参考）\2.5版本素材库\raw\swf\enemy\Tracker.swf`
- 原版 3.4：`D:\superalloy\原版\3.4（原版参考）\3.4素材库\raw\swf\enemy\Tracker.swf`
- 11.3 素材汇总（实机导出图）：`D:\superalloy\原版\11.3超合金素材汇总\追踪者\`
- 图鉴图标：BookUI760 内嵌 JPG

## 文档与数据

- 图鉴文案（含用户批注"应该是等离子"）：`D:\superalloy\世界观开发\规整档案\原版资料\原版机器人，角色介绍\超合金机器人介绍….docx`
- 三方比对数据：`D:\superalloy\TMP\敌人美术对比-20260928\`
- 权威图鉴顺序：`..\图鉴顺序-BookUI.json`

## 家族关联

- `..\10，追猎者\`（Tracker2，同底盘进化对：粉色涂装/对空弹幕/energy 攻防）
