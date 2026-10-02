# 06 天隼战机 · 路径索引

> 本夹档案：`天隼战机-档案-20260929.md`。全部相关路径集中于此，便于直接调用。

## 代码（仓库 `decompiled\`）

- AI：`gamefile\scripts\enemy\falconFighter\`——FalconFighterBody.as / FalconFighter_AI.as（随机切换＋setToBomb 轰炸模式）
- 敌人表：`embedded-xml-assets\5_EmbedXml_xmlClass8_….bin` → **index 19, id=FalconFighter**
- 敌方武器表：`embedded-xml-assets\4_EmbedXml_xmlClass9_….bin` → **index 100022**（斜射 angle 45 hurt 0.2）＋ **index 100023, id=FalconFighter_2 "天隼战机的投弹"**（三连垂直投弹，specialType=Broken_Plasma）
- 特殊弹处理：`gamefile\scripts\body\bullet\BulletBody.as`（getBroken_PlasmaB）/ BulletLink.as:84 / body\define\OneArmsDefine.as:144
- 图鉴：`gamefile\scripts\UI\book\BookUI.as`（帧标签"天隼战机"，顺序数组第 6 位）

## 资源

- 当前仓：`swf\FalconFighter.swf`（SHA-256 前8 `758B9459`，三方全同）
- 原版 2.5：`D:\superalloy\原版\2.5（原版参考）\2.5版本素材库\raw\swf\enemy\FalconFighter.swf`
- 原版 3.4：`D:\superalloy\原版\3.4（原版参考）\3.4素材库\raw\swf\enemy\FalconFighter.swf`
- 11.3 素材汇总（实机导出图）：`D:\superalloy\原版\11.3超合金素材汇总\天隼战机\`
- 图鉴图标：BookUI760 内嵌 JPG

## 文档与数据

- 图鉴文案：`D:\superalloy\世界观开发\规整档案\原版资料\原版机器人，角色介绍\超合金机器人介绍….docx`
- 三方比对数据：`D:\superalloy\TMP\敌人美术对比-20260928\`
- 权威图鉴顺序：`..\图鉴顺序-BookUI.json`

## 家族关联（四隼）

- `..\5，游隼战机\`（制空搭档，含四隼总表）
- 猎隼战机 SakerFighter（index 20，1-2-3 Boss）/ 风隼战机 fengsunzhanji（index 90）——到各自图鉴号时立档互链
