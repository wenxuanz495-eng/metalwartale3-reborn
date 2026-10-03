# 33 判决者 · 文件索引与介绍

> 本夹档案：`判决者-档案-20261003.md`（设计 Boss：1-1-30 决战月都；**仲裁者第二形态**——本档只记差异，机体/机制主体见 `..\30，仲裁者\`）。
> 表名＝图鉴名"判决者"；代码 id `Intercessor` index 41（**空壳条目**，实际生成走 addIntercessor＋改名＋changeB=true）。

## 代码文件（仓库 `decompiled\`）

- 与 30 共用三文件：`gamefile\scripts\enemy\intercessor\`（IntercessorBody/Intercessor_AI/IntercessorAnimation）——差异点：`IntercessorBody.addSuper():62-65`（changeB 分支三槽 [Skill_Laser,Energy_Boom,**Clear_Energy**]）；`changeState():69-93`（变身：换判定组＋**现场改名"判决者"**＋血条续用）；`Intercessor_AI.adjudicator 分支`（四招＋距离自适应＋rectLevel）。
- `BodyGroup.as`"判决者"分支：`addIntercessor()`＋`define.name="判决者"`＋`changeB=true`。
- 敌人表：index 41 id=Intercessor（**仅 name"判决者"**，无 imgList/数值/判定——数据全继承 index 40）。
- Boss 台词：`decompiled\dataMust\scripts\gameAll\define\DialogueDefine.as:82-84`（d4_9 三段；"解除无谓的幻象…机器人霸主的真面目"＝变身剧情文案）。
- 关卡表：1-1-30 决战月都（**第四章 9**，boss="判决者"＋unit type="boss"）。
- 图鉴：`BookUI.as:105` 顺序数组第 33 位"判决者"。

## 资源文件

- 与 30 完全同源：`swf\Intercessor.swf`（比对 CSV index 40/41 同哈希 `ADF8A377`＝同一份 swf）；素材汇总夹共用 `仲裁者\`（stand2/__stand2 人形形态精灵在 `370_stand2`/`385___stand2`）。
- 图鉴图标：无独立核对（BookUI 仅仲裁者形态图标 `b_out\8.jpg`）。

## 文档与数据

- docx 段 154-162（**"仲裁者的第二形态/增强模式"官方明文＋K-III型热能射线冲击炮＋月都战役临时第二方面军指挥官**）：`D:\superalloy\世界观开发\规整档案\原版资料\原版机器人，角色介绍\超合金机器人介绍（包含老版本存在，但新版本被删减的内容。）.docx`（提取版 `机器人介绍_分层提取.md` :277 起）。
- 权威图鉴顺序：`..\图鉴顺序-BookUI.json`（第 33 位）。

## 家族关联

- `..\30，仲裁者\`（**本体档案**——本怪是其变身形态，双档互链）。
- `..\29，杀戮者\`（K 系列谱系：K 型/K-II/K-III）。
- Clear_Energy 删空考据：`..\精英词条技能对照-20261003.md`（老版本判决者=真三技能含 EMP 的结论在案）。
