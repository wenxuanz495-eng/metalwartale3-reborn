# 16 蓝光飞碟 · 路径索引

> 本夹档案：`蓝光飞碟-档案-20260929.md`。全部相关路径集中于此，便于直接调用。
> 家族归属（用户裁定）：美术血统＝追踪者/追猎者家族（穹顶同款脑壳）；代码层仅共用生成函数。

## 代码（仓库 `decompiled\`）

- 生成函数：`gamefile\scripts\bodyGroup\BodyGroup.as:273`（"蓝光飞碟"→`addAirLaserFort("ufo")`，共用 AirLaserFortBody 类，数据独立）
- 敌人表：`embedded-xml-assets\5_EmbedXml_xmlClass8_….bin` → **index 3, id=ufo**
- 敌方武器表：`embedded-xml-assets\4_EmbedXml_xmlClass9_….bin` → **index 10005**（`飞碟的火炮`，energy/bullet/bulletSpeed 25 直线弹/hurt 0.2/gap 0.4，无追踪）
- 图鉴：`gamefile\scripts\UI\book\BookUI.as`（帧标签"蓝光飞碟"，顺序数组第 16 位）

## 资源

- 当前仓：`swf\ufo.swf`（SHA-256 前8 `EF28E91D`，三方全同）
- 原版 2.5：`D:\superalloy\原版\2.5（原版参考）\2.5版本素材库\raw\swf\enemy\ufo.swf`（已验证存在）
- 原版 3.4：`D:\superalloy\原版\3.4（原版参考）\3.4素材库\raw\swf\enemy\ufo.swf`（已验证存在）
- 11.3 素材汇总（实机导出图）：`D:\superalloy\原版\11.3超合金素材汇总\飞碟1、\`（夹名带顿号；含蓝/粉双穹顶涂装 4.png/7.png）；另有 `飞碟\` 夹并存（内容分配待考）
- 图鉴图标：BookUI760 内嵌 JPG

## 文档与数据

- 图鉴文案：`D:\superalloy\世界观开发\规整档案\原版资料\原版机器人，角色介绍\超合金机器人介绍….docx`（有条目但介绍文原版即缺，含用户备注）
- 三方比对数据：`D:\superalloy\TMP\敌人美术对比-20260928\`（三方全同 `EF28E91D`——2.5/3.4 原件实际存在，仅路径分类待核）
- 权威图鉴顺序：`..\图鉴顺序-BookUI.json`

## 家族关联

- **美术血统**：`..\9，追踪者\`（蓝穹顶源）／`..\10，追猎者\`（粉穹顶源）
- **代码邻居**：`..\1，悬浮自动激光炮台A型\`（共用生成函数与 Body 类，非美术同族——01 档案已修正此口径）
