# 18 切割者 · 文件索引与介绍

> 本夹档案：`切割者-档案-20261003.md`。本 README＝该怪全部相关文件的索引字典。

## 代码文件（仓库 `decompiled\`）

- `gamefile\scripts\enemy\cutter\CutterBody.as`（143 行）——本怪身体类（飞行锯盘）。
- `gamefile\scripts\enemy\cutter\CutterBody2.as`（156 行）——冲刺者（Cutter2）专属身体类（同目录共用）。
- `gamefile\scripts\enemy\cutter\Cutter_AI.as`（41 行）——两怪共用 AI。
- 敌人表：`embedded-xml-assets\5_EmbedXml_xmlClass8_….bin` → **index 16, id=Cutter**。
- 敌方武器表：**无定义**（旋转锯齿接触伤害，动画判定层）。
- 图鉴：`gamefile\scripts\UI\book\BookUI.as`（帧标签"切割者"，顺序数组第 18 位）。

## 资源文件

- 当前仓：`swf\Cutter.swf`（SHA-256 前8 `CD3F1458`，三方全同）。
- 原版 2.5：`D:\superalloy\原版\2.5（原版参考）\2.5版本素材库\raw\swf\enemy\Cutter.swf`。
- 原版 3.4：`D:\superalloy\原版\3.4（原版参考）\3.4素材库\raw\swf\enemy\Cutter.swf`。
- 11.3 素材汇总：`D:\superalloy\原版\11.3超合金素材汇总\切割者\`（27 帧）；同族夹 `切割者2\`（26 帧，归 19）、`切割机机器人\`（19 帧，归属待考——疑 Cutter_S/Cutter3 系）。
- 图鉴图标：`swf\BookUI760.swf` 内嵌 JPG。

## 文档与数据

- 图鉴文案：`D:\superalloy\世界观开发\规整档案\原版资料\原版机器人，角色介绍\超合金机器人介绍….docx`（陆军空中单位/巨大锯齿，含用户批注）。
- 三方比对数据：`D:\superalloy\TMP\敌人美术对比-20260928\`。
- 权威图鉴顺序：`..\图鉴顺序-BookUI.json`。

## 家族关联

- `..\19，冲刺者\`（Cutter2，同模地面版）；`Cutter3 冲刺者-2型`（index 89）、`Cutter_S 切割者-S`（index 86）——图鉴外/后续批次建档互链。
