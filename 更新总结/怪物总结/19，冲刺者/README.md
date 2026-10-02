# 19 冲刺者 · 文件索引与介绍

> 本夹档案：`冲刺者-档案-20261003.md`。本 README＝该怪全部相关文件的索引字典。
> ⚠️ 勿与"突击者"（Charger，index 8）混淆；素材夹按"切割者2"命名。

## 代码文件（仓库 `decompiled\`）

- `gamefile\scripts\enemy\cutter\CutterBody2.as`（156 行）——**本怪专属身体类**（地面车体，同目录与切割者共用 AI）。
- `gamefile\scripts\enemy\cutter\Cutter_AI.as`（41 行）——共用 AI。
- 敌人表：`embedded-xml-assets\5_EmbedXml_xmlClass8_….bin` → **index 17, id=Cutter2**（表内 name=冲刺者）。
- 敌方武器表：`embedded-xml-assets\4_EmbedXml_xmlClass9_….bin` → **index 100030, id=Cutter2**（`冲刺者的武器`，**attackType=motion 全表首例**/bullet/angle 0/hurt 0.5/gap 0.3/speed 25）。
- 图鉴：`gamefile\scripts\UI\book\BookUI.as`（帧标签"冲刺者"，顺序数组第 19 位）。

## 资源文件

- 当前仓：`swf\Cutter2.swf`（SHA-256 前8 `66645B6B`，三方全同）。
- 原版 2.5：`D:\superalloy\原版\2.5（原版参考）\2.5版本素材库\raw\swf\enemy\Cutter2.swf`。
- 原版 3.4：`D:\superalloy\原版\3.4（原版参考）\3.4素材库\raw\swf\enemy\Cutter2.swf`。
- 11.3 素材汇总：`D:\superalloy\原版\11.3超合金素材汇总\切割者2\`（26 帧）。
- 图鉴图标：`swf\BookUI760.swf` 内嵌 JPG。

## 文档与数据

- 图鉴文案：`D:\superalloy\世界观开发\规整档案\原版资料\原版机器人，角色介绍\超合金机器人介绍….docx`（为飞轮机器人配备支持/高速/激光炮——激光炮与 motion 实弹错位在档）。
- 三方比对数据：`D:\superalloy\TMP\敌人美术对比-20260928\`。
- 权威图鉴顺序：`..\图鉴顺序-BookUI.json`。

## 家族关联

- `..\18，切割者\`（Cutter，同模空中版）；`..\23，飞轮机器人\`（docx 设定的护航对象，建档时互链）；`Cutter3 冲刺者-2型`（index 89）后续批次。
