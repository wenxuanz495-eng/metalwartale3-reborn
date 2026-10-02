# 03 电锯机器人 · 路径索引

> 本夹档案：`电锯机器人-档案-20260929.md`。全部相关路径集中于此，便于直接调用。

## 代码（仓库 `decompiled\`）

- AI 五件套：`gamefile\scripts\enemy\electricSaw\`——ElectricSawBody.as（143 行）/ ElectricSaw_AI.as（42 行，挥击动画伤害）/ ElectricSawAAHD.as / ElectricSawMotion.as（45 行）/ ElectricSawAnimation.as（80 行）
- 敌人表：`embedded-xml-assets\5_EmbedXml_xmlClass8_….bin` → **index 4, id=ElectricSaw**
- 敌方武器表：**无定义**（纯近战，伤害在 AAHD 动画帧判定）
- 图鉴：`gamefile\scripts\UI\book\BookUI.as`（帧标签"电锯机器人"，顺序数组第 3 位）

## 资源

- 当前仓：`swf\ElectricSaw.swf`（SHA-256 前8 `7B000738`，三方全同）
- 原版 2.5：`D:\superalloy\原版\2.5（原版参考）\2.5版本素材库\raw\swf\enemy\ElectricSaw.swf`
- 原版 3.4：`D:\superalloy\原版\3.4（原版参考）\3.4素材库\raw\swf\enemy\ElectricSaw.swf`
- 11.3 素材汇总：**无直接对应夹**（"切割机机器人/切割者/切割者2"为 Cutter 家族，勿混用）
- 图鉴图标：BookUI760 内嵌 JPG（实机=绿黄机身，与图标一致）

## 文档与数据

- 图鉴文案：`D:\superalloy\世界观开发\规整档案\原版资料\原版机器人，角色介绍\超合金机器人介绍….docx`
- 三方比对数据：`D:\superalloy\TMP\敌人美术对比-20260928\`
- 权威图鉴顺序：`..\图鉴顺序-BookUI.json`

## 家族关联

- `ElectricSaw2`（表 index 5）＝**SAX-DJ机器人**（复用本家族 AI 类的独立怪，非第二形态）：素材夹 `..\..\..\原版\11.3超合金素材汇总\sax-dj机器人\`，到其图鉴号（第 70 位）时立档互链
