# 28 强袭者 · 文件索引与介绍

> 本夹档案：`强袭者-档案-20261003.md`（设计 Boss：1-1-9 夺取战舰＋2-1-1 精英副本）。本 README＝该怪全部相关文件的索引字典。
> 表名＝图鉴名"强袭者"（三名一致，无别名错位）；代码 id `Striker`（index 39）。

## 代码文件（仓库 `decompiled\`）

- `gamefile\scripts\enemy\striker\StrikerBody.as`（152 行）——身体类；**碰撞头复用电锯的 `ElectricSawAAHD`**（:24）；技能槽挂 `Normal_ExtraSkill`。
- `gamefile\scripts\enemy\striker\Striker_AI.as`（71 行）——AI：**30%/30%/40% 三分支**切三套斩击（:29）；**攻击后 50% 概率 vx+200 突进**（:52，带 extraSkill 门控）。
- `gamefile\scripts\enemy\striker\StrikerAnimation.as`（105 行）——动画控制：**move2 高速档阈值 |vx|＞210px/s**（:45）；跳跃双组态框架与 27 突击者同款。
- `gamefile\scripts\enemy\_normal\Normal_ExtraSkill.as`（26 行）——**空壳技能类**（init/FTimer/clear 全空）＝11.3 现状占位；⚠️ **历代原装是 `Striker_ExtraSkill`（双形态机制类），11.3 被整删**，考古详见档案"隐藏机制考古"节。
- **历代被删机制类（回植源）**：`D:\superalloy\原版\2.5（原版参考）\2.5版本代码库\game\scripts\enemy\striker\Striker_ExtraSkill.as`（INIT.FPS 版）；`D:\superalloy\原版\3.4（原版参考）\3.4代码库\game\scripts\enemy\striker\Striker_ExtraSkill.as` 与 `D:\superalloy\原版\4.0（原版参考）\4.0代码库\game\scripts\enemy\striker\Striker_ExtraSkill.as`（硬编码 30 版，与 2.5 逻辑逐字等价）；历代 StrikerBody.as:43 均挂载 `new Striker_ExtraSkill(this)`。
- 身体类映射：`gamefile\scripts\bodyGroup\BodyGroup.as:1126`（`addStriker()`）；:367（"强袭者"→addStriker）。
- 敌人表：`embedded-xml-assets\5_EmbedXml_xmlClass8_….bin` → **index 39, id=Striker**（表内 name=强袭者；含 6 段 attackHitData 判定明细）。
- 武器表现状：`embedded-xml-assets\4_EmbedXml_xmlClass9_….bin` → **`Striker` 字符串 0 处**——本怪无武器定义，伤害全在敌人表 attackHitData 判定层（motion 型）。
- **词条精英保护**：`gamefile\scripts\gameAll\GameDefine.as:214`（`nolyChampionList` 7 怪名单）；`gameAll\EventGroup.as:1364/1434`（bodyAdd super 掷骰跳过＋champion 随机精英随从逻辑）；`gameAll\level\LevelGroup.as:423`（randomSuper 池同样排除）。
- Boss 台词：`decompiled\dataMust\scripts\gameAll\define\DialogueDefine.as:24-26`（d2_3_1/2/3 三段）。
- 精英副本类：`gamefile\scripts\gameAll\level\extra\SpecialExtraLevel_11.as`（**空壳**，2-1-1 挂名无专属配置）。
- 图鉴：`gamefile\scripts\UI\book\BookUI.as:105`（顺序数组第 28 位"强袭者"）。
- 关卡表：`embedded-xml-assets\17_EmbedXml_xmlClass11_….bin` → 8 处（1-1-9 boss／1-1-20·1-2-8 champion superNum=1／1-1-24·1-1-26·1-2-4×5·1-2-7 普通／2-1-1 精英副本 boss）。
- **历代关卡数据（实装史证据）**：3.4＝`D:\superalloy\原版\3.4参照修改版\game.baseline.swf`（解压后敌人表 index 13＋1-1-9 boss＋**2-1-2"强袭者"精英单挑关** mothership_evening2 场景＋arms 表 151 条零 Striker）；2.5＝`D:\superalloy\原版\2.5（原版参考）\2.5版本游戏\assets\game.original-before-modifier.swf`＋`assets\swf\dataMust39.original.swf`（各仅 1 处"强袭者"＝名单常量，**怪不存在**）；4.0＝`D:\superalloy\原版\4.0（原版参考）\4.0游戏\embedded-xml\17_level280_xml$….bin`（2-1-2 强袭者 unit type=boss）＋`5_enemy25_xml$….bin`（id="Striker"）。swf 检索法：CWS 头 8 字节后接 zlib 流，解压后 utf-8 搜。

## 资源文件

- 当前仓：`swf\Striker.swf`（SHA-256 前 12 `9BCA5FADA1BC`）。
- 原版 2.5：`D:\superalloy\原版\2.5（原版参考）\2.5版本素材库\raw\swf\enemy\Striker.swf`（**三方字节全同**）。
- 原版 3.4：`D:\superalloy\原版\3.4（原版参考）\3.4素材库\raw\swf\enemy\Striker.swf`（同上）。
- 11.3 素材汇总：`D:\superalloy\原版\11.3超合金素材汇总\强袭者\`（**直配夹**：images 51/sounds 9/sprites 41 逐态 GIF/frames 1 空白帧）；形象核对用 `sprites\DefineSprite_208_stand\frames.gif` 等。
- 图鉴图标：`swf\BookUI760.swf` 内嵌 JPG（ffdec 导出 `C:\temp\bookui\b_out\36.jpg`，与实机涂装一致）。

## 文档与数据

- 图鉴文案（OCR 乱码照录＋第九舰队隶属）：`D:\superalloy\世界观开发\规整档案\原版资料\原版机器人，角色介绍\超合金机器人介绍（包含老版本存在，但新版本被删减的内容。）.docx`（段 148；纯文本版 `D:\superalloy\TMP\世界观资料提取-20260920\机器人介绍_分层提取.md` :255）。
- 关卡剧情（夺取战舰/战舰指挥官）：`D:\superalloy\TMP\世界观资料提取-20260920\guanqia.txt`（段 0032）。
- 三方比对数据：`D:\superalloy\TMP\敌人美术对比-20260928\`（CSV 行 index 39＝三方全同组）。
- 权威图鉴顺序：`..\图鉴顺序-BookUI.json`（第 28 位）。

## 家族关联

- `..\27，突击者\`（Charger——同底盘远程型：hitRect/imgList 跳跃框架相同，boom 防型与本章互为镜像教材；1-2-4 同框护卫先知）。
- `..\29，杀戮者\`（Slayer——三兄弟老三，addSlayer 直接借 `Charger_1` 火神炮定义；建档时互链）。
- 组件借用溯源：ElectricSawAAHD→`..\3，电锯机器人\`；cutter_hit_effect→`..\18，切割者\`（motion 攻击端首例 19 冲刺者亦用同款判定层）。
