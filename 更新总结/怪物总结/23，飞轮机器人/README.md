# 23 飞轮机器人 · 文件索引与介绍

> 本夹档案：`飞轮机器人-档案-20261003.md`。本 README＝该怪全部相关文件的索引字典。

## 代码文件（仓库 `decompiled\`）

- `gamefile\scripts\enemy\tires\TiresBody.as`（189 行）——身体类（前段最厚的一份身体类）。
- `gamefile\scripts\enemy\tires\Tires_AI.as`（61 行）——AI（hoverAndAttack＋先锋警戒）。
- 敌人表：`embedded-xml-assets\5_EmbedXml_xmlClass8_….bin` → **index 34, id=Tires**（表内 name=飞轮机器人）。
- 敌方武器表：`embedded-xml-assets\4_EmbedXml_xmlClass9_….bin` → **index 100037 id=Tires_1**（⚠️ 后缀 id 模式；LV1 `轮胎怪-炮弹`：energy/20° 扇形 5 连/hurt 0.2/gap 0.2；LV2 `轮胎怪-散射炮弹`：energy/270° 朝天 230° 扇形 18 连/hurt 0.2/gap 1.3）＋ **index 100038 id=Tires_2**（`轮胎怪-玛格兰炮`：energy/**laser 贯穿**/hurt 0.5/gap 1.9）——三种攻击方式＝霰弹弧形散射＋霰弹全向散射＋激光炮（AI 三分支切换，Tires_AI.as:19/23/27）。
- 图鉴：`gamefile\scripts\UI\book\BookUI.as`（帧标签"飞轮机器人"，顺序数组第 23 位）。

## 资源文件

- 当前仓：`swf\Tires.swf`（SHA-256 前8 `20DF2CAE`，三方全同）。
- 原版 2.5：`D:\superalloy\原版\2.5（原版参考）\2.5版本素材库\raw\swf\enemy\Tires.swf`。
- 原版 3.4：`D:\superalloy\原版\3.4（原版参考）\3.4素材库\raw\swf\enemy\Tires.swf`。
- 11.3 素材汇总：`D:\superalloy\原版\11.3超合金素材汇总\飞轮\`。
- 图鉴图标：`swf\BookUI760.swf` 内嵌 JPG。

## 文档与数据

- 图鉴文案（docx＝图鉴完全一致）：`D:\superalloy\世界观开发\规整档案\原版资料\原版机器人，角色介绍\超合金机器人介绍….docx`。
- 三方比对数据：`D:\superalloy\TMP\敌人美术对比-20260928\`。
- 权威图鉴顺序：`..\图鉴顺序-BookUI.json`。

## 家族关联

- `..\19，冲刺者\`（Cutter2，docx 设定的护航单位——"为飞轮机器人配备支持"；速度反超本怪的趣味落差记录在双方档案）。
- 精英副本关联：2-1-6 精英飞轮机器人（`SpecialExtraLevel_11` 空壳波次关）。
