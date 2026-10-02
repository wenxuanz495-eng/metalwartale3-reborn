# 07 地面自动防御炮台 · 路径索引

> 本夹档案：`地面自动防御炮台-档案-20260929.md`。全部相关路径集中于此，便于直接调用。
> ⚠️ 三名并存：图鉴/docx"地面自动防御炮台"＝敌人表"地面自动炮台"＝素材汇总夹"陆地防御者"。

## 代码（仓库 `decompiled\`）

- AI：`gamefile\scripts\enemy\landFort\\`
- 敌人表：`embedded-xml-assets\5_EmbedXml_xmlClass8_….bin` → **index 26, id=LandFort**（表内 name=地面自动炮台）
- 敌方武器表：`embedded-xml-assets\4_EmbedXml_xmlClass9_….bin` → **index 10007**（地面自动炮台-火神炮，boom/bullet/angle 0/hurt 0.2/gap 0.4）
- 图鉴：`gamefile\scripts\UI\book\BookUI.as`（帧标签"地面自动防御炮台"，顺序数组第 7 位）

## 资源

- 当前仓：`swf\LandFort.swf`（SHA-256 前8 `2F8F8197`，三方全同）
- 原版 2.5：`D:\superalloy\原版\2.5（原版参考）\2.5版本素材库\raw\swf\enemy\LandFort.swf`
- 原版 3.4：`D:\superalloy\原版\3.4（原版参考）\3.4素材库\raw\swf\enemy\LandFort.swf`
- 11.3 素材汇总（实机导出图）：`D:\superalloy\原版\11.3超合金素材汇总\陆地防御者\`（夹名第三套）
- 图鉴图标：BookUI760 内嵌 JPG

## 文档与数据

- 图鉴文案：`D:\superalloy\世界观开发\规整档案\原版资料\原版机器人，角色介绍\超合金机器人介绍….docx`
- 三方比对数据：`D:\superalloy\TMP\敌人美术对比-20260928\`
- 权威图鉴顺序：`..\图鉴顺序-BookUI.json`

## 家族关联

- 相邻防守型怪：`LandLaser 防御激光炮`（表 index 55，图鉴第 59 位；素材夹 `..\..\..\原版\11.3超合金素材汇总\陆地激光\`）——到其图鉴号时立档互链
