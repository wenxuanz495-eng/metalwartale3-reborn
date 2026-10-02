# 22 攻城坦克 · 文件索引与介绍

> 本夹档案：`攻城坦克-档案-20261003.md`（设计 Boss：1-1-18）。本 README＝该怪全部相关文件的索引字典。
> ⚠️ Tank 家族 id/名错位：id Tank＝攻城坦克、id Tank2＝冲锋坦克（图鉴 20）。

## 代码文件（仓库 `decompiled\`）

- `gamefile\scripts\enemy\tank\TankBody.as`（160 行）——本怪身体类（疑，与 TankBody2 对应关系待逐行核）。
- `gamefile\scripts\enemy\tank\Tank_AI.as`（75 行）——本怪 AI（疑，同上）。
- `gamefile\scripts\enemy\tank\TankAnimation.as`（88 行）——坦克家族共用动画控制。
- 敌人表：`embedded-xml-assets\5_EmbedXml_xmlClass8_….bin` → **index 32, id=Tank**（表内 name=攻城坦克）。
- 敌方武器表：`embedded-xml-assets\4_EmbedXml_xmlClass9_….bin` → **index 100033 id=Tank_1**（`坦克-火神炮` energy/hurt 0.5/gap 1.2）＋ **index 100034 id=Tank_2**（`坦克-弧光弹` energy/hurt 4——docx"灭杀激光炮"实锤；⚠️ 后缀 id 模式，主 id 无定义）。
- Boss 标记：关卡表 `17_EmbedXml_xmlClass11_….bin` → 1-1-18 `boss="攻城坦克"` ＋ unit `type="boss"`。
- 图鉴：`gamefile\scripts\UI\book\BookUI.as`（帧标签"攻城坦克"，顺序数组第 22 位）。

## 资源文件

- 当前仓：`swf\Tank.swf`（SHA-256 前8 `5E8427F0`，三方全同）。
- 原版 2.5：`D:\superalloy\原版\2.5（原版参考）\2.5版本素材库\raw\swf\enemy\Tank.swf`。
- 原版 3.4：`D:\superalloy\原版\3.4（原版参考）\3.4素材库\raw\swf\enemy\Tank.swf`。
- 11.3 素材汇总：`攻击坦克2\` 夹疑相关（归属待考）。
- 图鉴图标：`swf\BookUI760.swf` 内嵌 JPG。

## 文档与数据

- 图鉴文案（含网页贴图补充"灭杀激光炮"）：`D:\superalloy\世界观开发\规整档案\原版资料\原版机器人，角色介绍\超合金机器人介绍….docx`。
- 三方比对数据：`D:\superalloy\TMP\敌人美术对比-20260928\`。
- 权威图鉴顺序：`..\图鉴顺序-BookUI.json`。

## 家族关联

- `..\20，冲锋坦克\`（Tank2，微型虎式量产版——与本怪成对）；SharkTank/LightningTank/K2LightTank 后续批次。
