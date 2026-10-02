# 20 冲锋坦克 · 文件索引与介绍

> 本夹档案：`冲锋坦克-档案-20261003.md`。本 README＝该怪全部相关文件的索引字典。
> ⚠️ Tank 家族 id/名错位：id Tank2＝冲锋坦克、id Tank＝攻城坦克（图鉴 22）。

## 代码文件（仓库 `decompiled\`）

- `gamefile\scripts\enemy\tank\TankBody2.as`（161 行）——本怪身体类（与攻城坦克 TankBody.as 同目录，具体对应待逐行核）。
- `gamefile\scripts\enemy\tank\Tank_AI2.as`（36 行）——本怪 AI（疑，同上）。
- `gamefile\scripts\enemy\tank\TankAnimation.as`（88 行）——坦克家族共用动画控制。
- 敌人表：`embedded-xml-assets\5_EmbedXml_xmlClass8_….bin` → **index 33, id=Tank2**（表内 name=冲锋坦克）。
- 敌方武器表：`embedded-xml-assets\4_EmbedXml_xmlClass9_….bin` → **index 100036, id=Tank2**（`坦克-火神炮`，2 级：boom/bullet/angle 0/hurt 0.2/gap 1.2→0.6）。
- 图鉴：`gamefile\scripts\UI\book\BookUI.as`（帧标签"冲锋坦克"，顺序数组第 20 位）。

## 资源文件

- 当前仓：`swf\Tank2.swf`（SHA-256 前8 `14E83813`，三方全同）。
- 原版 2.5：`D:\superalloy\原版\2.5（原版参考）\2.5版本素材库\raw\swf\enemy\Tank2.swf`。
- 原版 3.4：`D:\superalloy\原版\3.4（原版参考）\3.4素材库\raw\swf\enemy\Tank2.swf`。
- 11.3 素材汇总：无直接对应夹（待考）。
- 图鉴图标：`swf\BookUI760.swf` 内嵌 JPG。

## 文档与数据

- 图鉴文案：`D:\superalloy\世界观开发\规整档案\原版资料\原版机器人，角色介绍\超合金机器人介绍….docx`（微型虎式坦克/替代主战，"冲锋克"笔误在档）。
- 三方比对数据：`D:\superalloy\TMP\敌人美术对比-20260928\`。
- 权威图鉴顺序：`..\图鉴顺序-BookUI.json`。

## 家族关联

- `..\22，攻城坦克\`（Tank，虎式后继者/指挥官版——与本怪成对）；`SharkTank 虎鲨坦克`（index 50）、`LightningTank 闪电坦克`（index 59）、`K2LightTank`（index 94）后续批次。
- 速度对照：冲刺者（Cutter2）450~650 ≫ 本怪 150~300（用户问询已在档回答）。
