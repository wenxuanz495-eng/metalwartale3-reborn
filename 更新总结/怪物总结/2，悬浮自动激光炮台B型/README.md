# 02 悬浮自动激光炮台B型 · 路径索引

> 本夹档案：`悬浮自动激光炮台B型-档案-20260929.md`。全部相关路径集中于此，便于直接调用。

## 代码（仓库 `decompiled\`）

- AI：与 A 型共用 `gamefile\scripts\enemy\airLaserFort\` 三件套（详见 `..\1，悬浮自动激光炮台A型\README.md`）
- 敌人表：`embedded-xml-assets\5_EmbedXml_xmlClass8_….bin` → **index 1, id=AirLaserFort_2**
- 敌方武器表：`embedded-xml-assets\4_EmbedXml_xmlClass9_….bin` → **index 10001, id=AirLaserFort_2**（连发弹 hurt 0.88/gap 0.25）
- 生成函数：`gamefile\scripts\bodyGroup\BodyGroup.as:269`（addAirLaserFort("AirLaserFort_2")）
- 图鉴：`gamefile\scripts\UI\book\BookUI.as`（帧标签"悬浮自动激光炮台B型"，顺序数组第 2 位）

## 资源

- 当前仓：`swf\AirLaserFort_2.swf`（SHA-256 前8 `4CFE96AA`，三方全同）
- 原版 2.5：`D:\superalloy\原版\2.5（原版参考）\2.5版本素材库\raw\swf\enemy\AirLaserFort_2.swf`
- 原版 3.4：`D:\superalloy\原版\3.4（原版参考）\3.4素材库\raw\swf\enemy\AirLaserFort_2.swf`
- 11.3 素材汇总（实机导出图）：`D:\superalloy\原版\11.3超合金素材汇总\悬浮机器人炮塔2\`
- 图鉴图标：BookUI760 内嵌（紫色涂装，内嵌号待考）；实机同样为绿色

## 文档与数据

- 图鉴文案：`D:\superalloy\世界观开发\规整档案\原版资料\原版机器人，角色介绍\超合金机器人介绍….docx`
- 三方比对数据：`D:\superalloy\TMP\敌人美术对比-20260928\`
- 权威图鉴顺序：`..\图鉴顺序-BookUI.json`

## 家族关联

- `..\1，悬浮自动激光炮台A型\`（兄弟机型，本怪只记差异：levelGrow 10vs0、武器 bullet vs laser）
