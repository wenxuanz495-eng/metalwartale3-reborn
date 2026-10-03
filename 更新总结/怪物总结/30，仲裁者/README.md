# 30 仲裁者 · 文件索引与介绍

> 本夹档案：`仲裁者-档案-20261003.md`（设计 Boss：1-1-13 全军覆没＋2-1-8 精英副本；双形态变身机，判决者=其第二形态）。本 README＝该怪全部相关文件的索引字典。
> 表名＝图鉴名"仲裁者"；代码 id `Intercessor`（index 40；index 41=判决者空壳条目）。⚠️ 图鉴 33"判决者"档案在 `..\33，判决者\`。

## 代码文件（仓库 `decompiled\`）

- `gamefile\scripts\enemy\intercessor\IntercessorBody.as`（233 行）——身体类；**addSuper()（:54）＝技能挂载核心**：非 changeB 挂 [Skill_Laser,Energy_Boom]、changeB 挂 [+Clear_Energy]；**changeState()（:69）＝变身机制**：换 hurtRectArr 三段小框＋`define.name="判决者"`＋bossBar 续用；AAHD=**RollingAAHD**（借碾压者）；**无 extraSkill 字段**（不走 ExtraSkill 类，与 27/28/29 不同路线）。
- `gamefile\scripts\enemy\intercessor\Intercessor_AI.as`（158 行）——AI 双形态状态机：intercessor 形态 50/50 两招＋attackOver 70% 变身（changeB 时）；adjudicator 形态四招各 25%＋**距离自适应强制选招**（>350→shoot_4、<120→shoot_attack）＋rectLevel 0/1/2 动态切判定组。
- `gamefile\scripts\enemy\intercessor\IntercessorAnimation.as`（139 行）——双形态动画控制。
- 身体类映射：`gamefile\scripts\bodyGroup\BodyGroup.as`（`addIntercessor()`；**"判决者"分支＝addIntercessor＋改名＋changeB=true**）。
- 敌人表：`embedded-xml-assets\5_EmbedXml_xmlClass8_….bin` → **index 40 id=Intercessor（仲裁者全数据）＋index 41 id=Intercessor（判决者空壳，仅 name）**。
- 敌方武器表：`embedded-xml-assets\4_EmbedXml_xmlClass9_….bin` → **id=Intercessor**（表名"**仲裁者-拉屎**"原版恶搞名：energy/hurt 4/speed 15/angle 45/shootNum 2）＋**id=Intercessor_jump**（同名，hurt 4/speed 30，跳射用）。
- 技能挂载调用点：`gamefile\scripts\gameAll\EventGroup.as`（boss 分支 `if(b0 is IntercessorBody || b0 is KnowingBody) b0.addSuper()`——**仅 type="boss" 出场时挂技能**）。
- Boss 台词：`decompiled\dataMust\scripts\gameAll\define\DialogueDefine.as:33-37`（d2_7 五段——全表最多段级）。
- 挑战任务：`gamefile\scripts\gameAll\define\TaskDefine.as:58`（challengeArr `"仲裁者,3,13,360,1"`）。
- 图鉴：`gamefile\scripts\UI\book\BookUI.as:105`（顺序数组第 30 位"仲裁者"）。
- 关卡表：`embedded-xml-assets\17_EmbedXml_xmlClass11_….bin` → 1-1-13 全军覆没（boss）／1-1-26 阻击援军（champion）／2-1-8 精英仲裁者（boss）／6-1-1 非洲区域（boss）。

## 资源文件

- 当前仓：`swf\Intercessor.swf`（SHA-256 前 12 `ADF8A3778B4F`，**2615504 字节＝全表最大级**；比对 CSV 中 index 40/41 两行同哈希＝一份 swf 供两图鉴号）。
- 原版 2.5/3.4：`D:\superalloy\原版\2.5（原版参考）\2.5版本素材库\raw\swf\enemy\Intercessor.swf`／3.4 同位（三方全同）。
- 11.3 素材汇总：`D:\superalloy\原版\11.3超合金素材汇总\仲裁者\`（直配夹：sprites 含 `221_shoot_attack`/`370_stand2`/`385___stand2`/`542_stand`/`555_attack_effect` 逐态）。
- 图鉴图标：`swf\BookUI760.swf` 内嵌 JPG（`C:\temp\bookui\b_out\8.jpg`——仲裁者形态形象；判决者形态无独立图标）。

## 文档与数据

- 图鉴文案（K-II型热能射线切割枪／隶属考据）：`D:\superalloy\世界观开发\规整档案\原版资料\原版机器人，角色介绍\超合金机器人介绍（包含老版本存在，但新版本被删减的内容。）.docx`（段 139-143；提取版 `机器人介绍_分层提取.md` :270）。
- **判决者"第二形态"官方明文**：同 docx 段 158-159（`..\33，判决者\` 主引）。
- 三方比对数据：`D:\superalloy\TMP\敌人美术对比-20260928\`（CSV 行 index 40/41＝同哈希三方全同组）。
- 权威图鉴顺序：`..\图鉴顺序-BookUI.json`（第 30 位）。

## 家族关联

- `..\33，判决者\`（同机第二形态：变身机制/三技能含删空 Clear_Energy/决战月都 Boss 战/K-III 型——差分档案）。
- `..\29，杀戮者\`（K 系列热能射线谱系：K 型＝杀戮者 shoot_3 激光线实锤 → K-II＝本怪 → K-III＝判决者）。
- `..\12，碾压者\`（RollingAAHD 碰撞头借源地）。
- 先知（图鉴 34，待建）：另一 addSuper 挂载者（[Skill_Laser, Energy_Boom, Hurt_Back]），1-2-4 同框。
