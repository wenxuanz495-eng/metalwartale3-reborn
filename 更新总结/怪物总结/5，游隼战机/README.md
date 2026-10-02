# 05 游隼战机 · 路径索引

> 本夹档案：`游隼战机-档案-20260929.md`。全部相关路径集中于此，便于直接调用。

## 代码（仓库 `decompiled\`）

- AI：`gamefile\scripts\enemy\tercelFighter\`——TercelFighterBody.as / TercelFighter_AI.as（双武器 50% 随机切换）
- 敌人表：`embedded-xml-assets\5_EmbedXml_xmlClass8_….bin` → **index 18, id=TercelFighter**
- 敌方武器表：`embedded-xml-assets\4_EmbedXml_xmlClass9_….bin` → **index 100020**（激光 angle 0 hurt 1.0）＋ **index 100021, id=TercelFighter_2**（连发 hurt 0.3/gap 0.3）
- 图鉴：`gamefile\scripts\UI\book\BookUI.as`（帧标签"游隼战机"，顺序数组第 5 位）

## 资源

- 当前仓：`swf\TercelFighter.swf`（SHA-256 前8 `05B20B7D`，三方全同）
- 原版 2.5：`D:\superalloy\原版\2.5（原版参考）\2.5版本素材库\raw\swf\enemy\TercelFighter.swf`
- 原版 3.4：`D:\superalloy\原版\3.4（原版参考）\3.4素材库\raw\swf\enemy\TercelFighter.swf`
- 11.3 素材汇总：**无对应夹**（天隼/猎隼/风隼均有夹，独缺游隼——素材汇总收集不全，实机图需自 swf 导出）
- 图鉴图标：BookUI760 内嵌 JPG

## 文档与数据

- 图鉴文案（含用户批注"介绍应该是错的，实机是对空空优"）：`D:\superalloy\世界观开发\规整档案\原版资料\原版机器人，角色介绍\超合金机器人介绍….docx`
- 三方比对数据：`D:\superalloy\TMP\敌人美术对比-20260928\`
- 权威图鉴顺序：`..\图鉴顺序-BookUI.json`

## 家族关联（四隼）

- `..\6，天隼战机\`（FalconFighter，对地支援搭档）
- 猎隼战机 SakerFighter（表 index 20，1-2-3 关卡 Boss；素材夹 `..\..\..\原版\11.3超合金素材汇总\猎隼战机\`）
- 风隼战机 fengsunzhanji（表 index 90，11.3 新怪；素材夹 `..\..\..\原版\11.3超合金素材汇总\风隼战机\`）——到各自图鉴号时立档互链
