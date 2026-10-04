# 32 炮装审判者 · 文件索引与介绍

> 本夹档案：`炮装审判者-档案-20261003.md`（设计 Boss：1-1-28 终结审判者＋历代 2-1-7 精英副本；三形态变形高达）。本 README＝该怪全部相关文件的索引字典。
> 表名＝图鉴名"炮装审判者"；代码 id `Gundam`（index 10）。⚠️ 与 31 剑装审判者为兄弟机（本怪独占战机形态）；31.1 黑暗剑装与本怪无血缘。

## 代码文件（仓库 `decompiled\`）

- `gamefile\scripts\enemy\gundam\GundamBody.as`（322 行）——身体类：**三运动系统**（land=GroundMotion／fly=**SuspendMotion 纯悬浮×2 速**／plane=同悬浮）＋三态判定框切换（land/fly=hitRect1 立姿 58×124；**plane=hitRect2 140×45 宽扁**）＋按态预装武器＋**toLandPan 降落编排**（升 200px 再降）＋**die 三分支**（die/die_fly/die_plane）＋firstToPlane()（死接口，原精英战开场）＋speedUp()（死接口）。
- `gamefile\scripts\enemy\gundam\Gundam_AI.as`（159 行）——AI：attackOver **30/30/30 掷骰三形态轮换**＋形态-武器绑定（plane→Gundam_plane 跟踪弹/fly→fly_1 平射·fly_2 下射/land→Gundam_land 玛格兰炮或 Gundam_funnel 放浮游炮）＋rectLevel 0~3 四组判定＋**shootPan 开火全屏特效＋震屏 20**。
- `gamefile\scripts\enemy\gundam\GundamAnimation.as`（101 行）＋`GundamDefine.as`（14 行专属 define 子类）＋`GundamAAHD.as`（35 行）。
- 浮游炮共享：`FunnelBody.as`/`FunnelAAHD.as`（详见 31 档）＋`BodyGroup.addGundamFunnel()`。
- 身体类映射：`gamefile\scripts\bodyGroup\BodyGroup.as:382`（"炮装审判者"→addGundam）。
- 敌人表：`embedded-xml-assets\5_EmbedXml_xmlClass8_….bin` → **index 10 id=Gundam**（imgList 19 态、attackHitData 0 段、jumpNum 15、defenceType energy、levelGrow 10000,5000,60000）。
- 敌方武器表：`embedded-xml-assets\4_EmbedXml_xmlClass9_….bin` → Gundam 系六条：**Gundam_land"高达的武器-玛格兰炮"**（energy/0.8）＋Gundam_fly_1/fly_2（"玛格兰炮-空中1/2"，angle 0/30）＋**Gundam_plane"高达的跟踪弹"**（energy/1/speed25/3 连/弹体 `Gundam/plane_bullet`）＋Gundam_funnel（空炮触发器）。
- **历代被删机制类（回植源，EMP 式删减第五例）**：`D:\superalloy\原版\2.5（原版参考）\2.5版本代码库\game\scripts\enemy\gundam\Gundam_ExtraSkill.as`（290 行；3.4/4.0 同路径在）——init=firstToPlane 直入战机+无敌+锁形态+三槽 [Plasma,Skill_Curve,Skill_Drop2]；圣堂战机×3 护盾机（600 万血+Skill_Laser，全灭才落地）；钻机强化；强袭者火箭（800 万血，×3 速冲撞**撞中定身 2 秒**）；**警报塔×3 充能演出**（lightning3 连接 30 次）；bodyAdd 覆写（圣堂/天隼 setToBomb/强袭者）。
- Boss 台词：`decompiled\dataMust\scripts\gameAll\define\DialogueDefine.as:29-32`（d2_6 四段，缺 _2）。
- 关卡表：`embedded-xml-assets\17_EmbedXml_xmlClass11_….bin` → 1-1-28 终结审判者（boss＋firstDialogue）/1-1-29 四月行动（champion）/2-1-7 精英炮装审判者/1-1-999 Vip（boss）；⚠️ 1-1-0/1-1-3/1-1-6 的 `<extraEnemyName>炮装审判者</extraEnemyName>`＝死数据字段（全仓零代码引用，非真实出场）。
- 图鉴：`gamefile\scripts\UI\book\BookUI.as:105`（顺序数组第 32 位"炮装审判者"）。

## 资源文件

- 当前仓：`swf\Gundam.swf`（SHA-256 前 12 `D9DC8B150BC6`，1128919 字节，三方全同）。
- 原版 2.5/3.4：`D:\superalloy\原版\2.5（原版参考）\2.5版本素材库\raw\swf\enemy\Gundam.swf`／3.4 同位。
- 11.3 素材汇总：`D:\superalloy\原版\11.3超合金素材汇总\炮装审判\`（直配夹）。
- 图鉴图标：`swf\BookUI760.swf` 内嵌 JPG（`C:\temp\bookui\b_out\245.jpg`，红机黑炮蓝焰）。
- 帧验证产物（临时）：`D:\tmp\g1_plane_in2.png`（__plane 20 帧变形序列：站姿→后仰→蜷缩收拢头部盖入→展开楔形战机→蓝焰巡航）／`D:\tmp\g1_plane_loop.png`（无头战机巡航）。

## 文档与数据

- 图鉴文案（第二批成功品/多领域战斗/第九舰队指挥官/离体式自动浮游炮）：`D:\superalloy\世界观开发\规整档案\原版资料\原版机器人，角色介绍\超合金机器人介绍（包含老版本存在，但新版本被删减的内容。）.docx`（段 171-175；提取版 `机器人介绍_分层提取.md` :286 起）。
- 三方比对数据：`D:\superalloy\TMP\敌人美术对比-20260928\`（CSV 行 index 10＝三方全同组）。
- 权威图鉴顺序：`..\图鉴顺序-BookUI.json`（第 32 位）。

## 家族关联

- `..\31，剑装审判者\`（兄弟机——31 近战 motion 防/两态/精英召唤流 vs 本怪远程 energy 防/三态/护盾充能流；共享浮游炮 FunnelBody 与玛格兰炮谱系）。
- `31.1 黑暗剑装审判者`（31 的换色版，与本怪无关）。
- 缺 SWF 六件关联：**AlarmTower（警报塔）在历代精英战脚本中被本怪召唤**（600 万血×3＋充能演出）——真缺失件，回植精英战前需先回迁素材（对照 GundamFunnel.swf 缺件无碍）。
- 圣堂战机（待建，enemy 表 id=HavenFighter 系）/天隼（6 号）/强袭者（28 号）/钻机（14/15 号）——精英战 bodyAdd 覆写涉及各档。
