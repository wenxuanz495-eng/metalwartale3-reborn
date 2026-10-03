# 29 杀戮者 · 文件索引与介绍

> 本夹档案：`杀戮者-档案-20261003.md`（设计 Boss：1-1-11 海神号沉没＋历代 2-1-5 精英副本）。本 README＝该怪全部相关文件的索引字典。
> 表名＝图鉴名"杀戮者"；代码 id `Slayer`（index 9）。⚠️ 1-4-11"杀戮者来袭"的 boss 是**战虎杀戮者**（图鉴 42 独立怪），勿混淆。

## 代码文件（仓库 `decompiled\`）

- `gamefile\scripts\enemy\slayer\SlayerBody.as`（170 行）——身体类；**三借**：`ChargerAnimation`（27 动画类）＋`ChargerAAHD`（27 碰撞头）＋`Normal_ExtraSkill` 空壳；持有 `armsDefine`（AI 动态换武器）；**11.3 无 Slayer_ExtraSkill 类**（历代原装被删）。
- `gamefile\scripts\enemy\slayer\Slayer_AI.as`（42 行）——AI：bilvArr=[1,1,1] 三分支，**attackOver 时换装武器**（Charger_1 LV0／Charger_2 LV2／Slayer_1 LV0）。
- 身体类映射：`gamefile\scripts\bodyGroup\BodyGroup.as:1151`（`addSlayer()`：装 Charger_1 初始＋**push 进 Charger_arr**＋**硬编码出生点 x=500,y=300**）。
- 敌人表：`embedded-xml-assets\5_EmbedXml_xmlClass8_….bin` → **index 9, id=Slayer**（含 attackHitData 2 段 shoot_3 激光线判定：hurt 0.7/energy/宽度 800）。
- 敌方武器表：`embedded-xml-assets\4_EmbedXml_xmlClass9_….bin` → **index 100013 id=Slayer_1**（"杀戮者的激光炮-空炮-只为控制shoot_3"：hurt 0/瞬消/借 Charger_bullet_1 弹体＝动画触发器）；**Charger_2 LV2**（index 100011 第二级"杀戮者的武器2-迫击炮"：energy/hurt 1/speed 35——定义挂 27 名下的跨怪共用）。
- **历代被删机制类（回植源）**：`D:\superalloy\原版\2.5（原版参考）\2.5版本代码库\game\scripts\enemy\slayer\Slayer_ExtraSkill.as`（3.4/4.0 代码库同路径逐字等价）——四阶段精英战：init 双槽 [Skill_Laser(CD 减半),Plasma]→phase_00 开护盾居中→phase_0 召援军→phase_1 清光援军（getAllEnemyNum()==1）开激光→phase_2 血 40% 攻×2 变色→**phase_3 每秒头顶量产自爆蜘蛛（难度 0：5000 血伤×5；难度+：10000 血伤×10）**；历代 SlayerBody:51 挂载。
- Boss 台词：`decompiled\dataMust\scripts\gameAll\define\DialogueDefine.as:27-28`（d2_5_1"杀戮，更多的杀戮！"／d2_5_2"你最终逃不过机器人大军的审判的！"）。
- 图鉴：`gamefile\scripts\UI\book\BookUI.as:105`（顺序数组第 29 位"杀戮者"）。
- 关卡表：`embedded-xml-assets\17_EmbedXml_xmlClass11_….bin` → 10 关（1-1-11 boss／1-1-20·1-1-30 champion／1-2-4×5／1-2-7 含显式 type="super"×1／1-2-8 unit boss／1-3-10×6·1-3-14×13·1-3-15×2／1-4-11=战虎杀戮者另案）。

## 资源文件

- 当前仓：`swf\Slayer.swf`（SHA-256 前 12 `264E8945561F`）。
- 原版 2.5：`D:\superalloy\原版\2.5（原版参考）\2.5版本素材库\raw\swf\enemy\Slayer.swf`（**三方字节全同**）；3.4 同位（`3.4素材库\raw\swf\enemy\Slayer.swf`）。
- 11.3 素材汇总：`D:\superalloy\原版\11.3超合金素材汇总\杀戮者\`（**直配夹**；⚠️ images 大件多为金橙爆炸特效帧，本体用 `sprites\DefineSprite_186_stand`（30 帧）／`144_shoot_3`（578×199 激光横扫 40 帧）核对）。
- 图鉴图标：`swf\BookUI760.swf` 内嵌 JPG（`C:\temp\bookui\b_out\104.jpg`，品红紫机甲＋能量光效）。

## 文档与数据

- 图鉴文案（太空计划第二批/K型热能射线切割枪）：`D:\superalloy\世界观开发\规整档案\原版资料\原版机器人，角色介绍\超合金机器人介绍（包含老版本存在，但新版本被删减的内容。）.docx`（段 152；纯文本版 `D:\superalloy\TMP\世界观资料提取-20260920\机器人介绍_分层提取.md` :262）。
- 关卡剧情（海神号航母指挥官）：`D:\superalloy\TMP\世界观资料提取-20260920\guanqia.txt`（段 0036）。
- 三方比对数据：`D:\superalloy\TMP\敌人美术对比-20260928\`（CSV 行 index 9＝三方全同组）。
- 历代精英副本数据：2.5＝`D:\superalloy\原版\2.5（原版参考）\2.5版本游戏\assets\xml\level16.xml`（2-1-5"杀戮者"单挑关 scene base3＋enemy_2 援军波 7 种×10 只）；3.4＝`3.4参照修改版\game.baseline.swf` 内嵌关卡表；4.0＝embedded-xml 17_level280_xml。
- 权威图鉴顺序：`..\图鉴顺序-BookUI.json`（第 29 位）。

## 家族关联

- `..\27，突击者\`（Charger——同底盘老大：本怪借其 ChargerAnimation/ChargerAAHD/Charger_1 火神炮/Charger_2 臂炮 LV2，判定层同入 Charger_arr；1-2-4 三兄弟同框）。
- `..\28，强袭者\`（Striker——同底盘老二：近战 motion 对本怪混合型；Slayer_ExtraSkill 与 Striker_ExtraSkill 同为 11.3 整删的精英战脚本）。
- `..\42，战虎杀戮者\`（待建：Tiger 家族独立怪，1-4-11 关 boss，同名异怪）。
- 援军波怪物（2.5 精英关 enemy_2）：悬浮自动激光炮台2号/追踪者/追猎者/天隼/游隼/鸵鸟/自动钻机——各档已建或待建。
