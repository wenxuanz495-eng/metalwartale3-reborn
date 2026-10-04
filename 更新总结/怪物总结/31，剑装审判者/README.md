# 31 剑装审判者 · 文件索引与介绍

> 本夹档案：`剑装审判者-档案-20261003.md`（设计 Boss：1-1-21 突围而出＋历代 2-1-5/9 精英副本；陆空变形高达）。本 README＝该怪全部相关文件的索引字典。
> 表名＝图鉴名"剑装审判者"；代码 id `Gundam2`（index 11）。⚠️ 黑暗剑装审判者（index 12）＝**31.1 另档待建**（用户裁定编号，本档只留预告）。

## 代码文件（仓库 `decompiled\`）

- `gamefile\scripts\enemy\gundam\GundamBody2.as`（284 行）——身体类（**同类双用**：本怪＋31.1）：双运动系统（mot1 GroundMotion/mot2 SuspendGroundMotion 悬浮×2 速）＋land⇄fly 变形换判定框（hitRect1/2）＋**SpeedUpSkill 冲刺（maxSpeed×2）**＋shoot_2 判定框前移 hitRect_shoot2_1（bodyTimer 逐帧管理）＋双态 die 分流。
- `gamefile\scripts\enemy\gundam\Gundam2_AI.as`（218 行）——AI：常规分支四招等概率（shoot_1/2/3 近战＋shoot_missile 放浮游炮）＋attackOver 30% 变飞/70% 落地＋血<30% 每击升 AI 级；**openGundam3B 分支**（仅 31.1 用，3.4 起）：十步固定轮换＋shoot_3 隐身＋shoot_2 黑色炮（Stop_Laser）＋后坐滑步。
- `gamefile\scripts\enemy\gundam\GundamAnimation2.as`（90 行）——陆/空双形态动画控制。
- `gamefile\scripts\enemy\gundam\FunnelBody.as`（58 行）＋`FunnelAAHD.as`（28 行）——**浮游炮本体**（一次性无人机：播 missile 动画、4 段 energy 判定、hitHurtB=1 不可攻击、播完自毁）。
- `gamefile\scripts\enemy\gundam\Gundam_AI.as`——32 炮装审判者 AI（也调 addGundamFunnel——兄弟机共享浮游炮）。
- 身体类映射：`gamefile\scripts\bodyGroup\BodyGroup.as:386`（"剑装审判者"→addGundam2 :826）＋:838（addGundam3＝31.1，openGundam3B=true）＋:814（addGundamFunnel：读 XML"GundamFunnel"＋MC 从 `bullet`/`Gundam3` swf 键取）。
- 敌人表：`embedded-xml-assets\5_EmbedXml_xmlClass8_….bin` → **index 11 id=Gundam2**（levelGrow 10000,5000,60000 天量成长＋12 段 attackHitData）＋ **GundamFunnel 条目**（imgList 单态 missile、4 段 hurt 3/2/2/2）＋ index 12 id=Gundam3（31.1 的空壳位，另档）。
- 敌方武器表：`embedded-xml-assets\4_EmbedXml_xmlClass9_….bin` → Gundam 系六条（本怪直接相关：**Gundam3"高达的武器-黑色炮"** motion/hurt2/**specialType=Stop_Laser**；`Gundam_funnel` 空炮＝32 号用）；Stop_Laser 消费＝`body\bullet\SpecialAttack.as:65`（`setReduceMul(0,2)`＝定身减速 2 秒；LaserBody/OneBulletBody 两处分发）。
- **历代被删机制类（回植源，EMP 式删减第四例）**：`D:\superalloy\原版\2.5（原版参考）\2.5版本代码库\game\scripts\enemy\gundam\Gundam2_ExtraSkill.as`（3.4/4.0 同路径在）——**13 阶段精英战脚本**（强袭者双机血量链接小队＋七彩球+落雷＋定点雷/减速弹三槽＋最终演出锁玩家＋独狼战队指挥官 lightning3 锁链联合处刑＋bodyAdd 援军覆写）；历代 GundamBody2 挂载；11.3 换 Normal_ExtraSkill 空壳。
- 关卡表：`embedded-xml-assets\17_EmbedXml_xmlClass11_….bin` → 1-1-21 突围而出（boss）/1-1-29 四月行动（champion）/2-1-5 精英剑装审判者/1-1-999 Vip 专属地图（boss）；1-3-12＝黑暗剑装（31.1）。历代：2.5 `level16.xml` 2-1-9 剑装审判者（精英关）。
- 图鉴：`gamefile\scripts\UI\book\BookUI.as:105`（顺序数组第 31 位"剑装审判者"）。

## 资源文件

- 当前仓：`swf\Gundam2.swf`（SHA-256 前 12 `C6DD0DBE42A4`，1737834 字节，三方全同）；`swf\Gundam3.swf`（31.1 的，1,043,528 字节）。
- 原版 2.5/3.4：`D:\superalloy\原版\2.5（原版参考）\2.5版本素材库\raw\swf\enemy\Gundam2.swf`／3.4 同位；**Gundam3.swf＝当前=3.4（2.5 无此文件）**——黑暗版 3.4 时代加入。
- 11.3 素材汇总：`D:\superalloy\原版\11.3超合金素材汇总\剑装审判\`（直配夹）；`剑装审判2\`＝31.1 的素材夹（两夹都含 fly 组——31.1"搬了没搬全"的物证）。
- 图鉴图标：`swf\BookUI760.swf` 内嵌 JPG（`C:\temp\bookui\b_out\252.jpg`，红机绿刃）。

## 文档与数据

- 图鉴文案（成功的一批/近战指挥官/离体式自动浮游炮）：`D:\superalloy\世界观开发\规整档案\原版资料\原版机器人，角色介绍\超合金机器人介绍（包含老版本存在，但新版本被删减的内容。）.docx`（段 165-169；提取版 `机器人介绍_分层提取.md` :274 起）。
- 三方比对数据：`D:\superalloy\TMP\敌人美术对比-20260928\`（CSV 行 index 11＝三方全同；index 12＝当前=3.4 组）。
- 权威图鉴顺序：`..\图鉴顺序-BookUI.json`（第 31 位）。

## 家族关联

- `..\32，炮装审判者\`（待建——Gundam/index 10，兄弟机：共享陆空变形/浮游炮/飞船变形技能组（用户口径），历代 **Gundam_ExtraSkill** 亦在 2.5/3.4/4.0 代码库待考古）。
- `31.1 黑暗剑装审判者`（待用户指令建档——index 12/Gundam3，外包换色不完全版，1-3-12 老友重逢 boss；编号按图鉴外规则=父图鉴号.1）。
- 缺 SWF 六件关联：GundamFunnel.swf 定性修正（视觉在 bullet swf，缺件无碍）；SevenBall/闪电球在历代精英战脚本中被本怪使用——真缺失件。
