# 21 女妖战机 · 文件索引与介绍

> 本夹档案：`女妖战机-档案-20261003.md`（设计 Boss：1-1-16 消灭副官）。本 README＝该怪全部相关文件的索引字典。

## 代码文件（仓库 `decompiled\`）

- `gamefile\scripts\enemy\bansheeFighter\BansheeFighterBody.as`（154 行）——身体类。
- `gamefile\scripts\enemy\bansheeFighter\BansheeFighter_AI.as`（42 行）——AI。
- `gamefile\scripts\enemy\bansheeFighter\BansheeFighterAAHD.as`（19 行）——碰撞头。
- 敌人表：`embedded-xml-assets\5_EmbedXml_xmlClass8_….bin` → **index 21, id=BansheeFighter**。
- 敌方武器表：`embedded-xml-assets\4_EmbedXml_xmlClass9_….bin` → **index 100027, id=BansheeFighter_1**（⚠️ 后缀 id 模式；`女妖战机-导弹`：boom/hurt 4/bulletNum 2——docx"猎杀飞弹"实锤）。
- Boss 标记：关卡表 `17_EmbedXml_xmlClass11_….bin` → 1-1-16 `boss="女妖战机"` ＋ unit `type="boss"`。
- 图鉴：`gamefile\scripts\UI\book\BookUI.as`（帧标签"女妖战机"，顺序数组第 21 位）。

## 资源文件

- 当前仓：`swf\BansheeFighter.swf`（SHA-256 前8 `2C327C2E`，三方全同）。
- 原版 2.5：`D:\superalloy\原版\2.5（原版参考）\2.5版本素材库\raw\swf\enemy\BansheeFighter.swf`。
- 原版 3.4：`D:\superalloy\原版\3.4（原版参考）\3.4素材库\raw\swf\enemy\BansheeFighter.swf`。
- 11.3 素材汇总：`D:\superalloy\原版\11.3超合金素材汇总\女妖战机\`；另有 `女妖战机2\`（＝BansheeFighter2，index 22，图鉴外候选）。
- 图鉴图标：`swf\BookUI760.swf` 内嵌 JPG。

## 文档与数据

- 图鉴文案（含网页贴图补充"猎杀飞弹"）：`D:\superalloy\世界观开发\规整档案\原版资料\原版机器人，角色介绍\超合金机器人介绍….docx`。
- 三方比对数据：`D:\superalloy\TMP\敌人美术对比-20260928\`。
- 权威图鉴顺序：`..\图鉴顺序-BookUI.json`。

## 家族关联

- `BansheeFighter2 女妖战机2`（index 22）——图鉴外候选，后续批次建档互链。
- 剧情关联：**先知**（1-2 章 Boss）的副官——关名"消灭副官"互文。
