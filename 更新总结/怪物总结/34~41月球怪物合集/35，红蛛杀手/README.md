# 35 红蛛杀手 · 文件索引与介绍

> 本夹档案：`红蛛杀手-档案-20261007.md`（普通怪·月球危机量产陆军，图鉴建制"月球空战队"）。本 README＝该怪全部相关文件的索引字典。
> 表名＝图鉴名"红蛛杀手"；代码 id `Spidkiller`（内嵌表块序 71 三代不变；index 属性 3.4/4.0=7→11.3=71）。⚠️ 与 4 号自爆蜘蛛机（Spider）同名蜘蛛、完全异构，勿混。

## 代码文件（仓库 `decompiled\`）

- **无专属类**（全 decompiled 仅 `UI\book\BookUI.as:105` 图鉴数组一处引用）——通用地面体系：`gamefile\scripts\enemy\_normal\Normal_Land_AI.as`（27 行）＋`Normal_FlyBody.as`（基类）＋`ElectricSawAnimation`（动画类）。
- 生成路径：`gamefile\scripts\bodyGroup\BodyGroup.as` getUnit **默认分支**（≈578 行起：getEnemyDefine_byCnName→非 isAir→`addNormal_Land("Spidkiller",1,…)`，trace"添加地面怪物"）；对照硬编码分支 `:305 if(str=="自爆蜘蛛机") return addSpider()`（4 号专属）。
- 敌人表：`embedded-xml-assets\5_EmbedXml_xmlClass8_….bin` → **index 71 id=Spidkiller**（imgList 4 态/baseLife 2 单倍奖赏/boom 防/jumpHeight 600+vy 600 跳跃型/hitRect 160×100/vx 240~300/nextAttackTime 六档；**块序 71 三代不变**，3.4/4.0 index 属性=7〔老表属性重复不可信〕；11.3 唯一实质改动 vy 150→600、4.0 改 tweenValue 1→0.1）。
- 敌方武器表：`embedded-xml-assets\4_EmbedXml_xmlClass9_….bin` → **arms index 100087 id=Spidkiller 单武器单级"横向攻击炮"**（boom/hurt 0.2/shootNum 5+shootGap 0.1 五连发/bulletSpeed 18/bulletAngle 5/弹体 `Spidkiller/bullet1`/命中特效 motion_hit_effect/近距侦测窗 grapRectIndex 0）。
- 关卡表：`embedded-xml-assets\17_EmbedXml_xmlClass11_….bin` → **73 关全 1-4（第十章~第十四章），164 单位行，个体 1904 只＝全库量产之最**（按中文名"红蛛杀手"引用，id 零直引）；首秀 1-4-1 champion×4；boss 行 3 处＝1-4-2 亮相（与拦截机2号同关双 boss）+1-4-22 trueName"小队长"+1-4-29 trueName"红色金子"；champion 4 关（1-4-1/8/12/27）；**17 关限时剧本 Level_2_5**；单关最多 1-4-84 生死绝境 72 只；扩编史 3.4 五关 83 只→4.0 七关 122 只→11.3 七十三关 1904 只。
- 掷骰名单：`gamefile\scripts\gameAll\GameDefine.as:212/214`——noSuperList/nolyChampionList 均不含（掷骰全开放）。
- 图鉴：`gamefile\scripts\UI\book\BookUI.as:105`（顺序数组第 35 位）；**游戏内图鉴面板文本＝BookUI760.swf 导出 text 673~677**（673 名字/675 设定原文/676 攻击属性行/677 生命防具行）——月球批未被 docx 转录，**面板即一手文案源**（2026-10-07 用户实机截图双源核验）。

## 资源文件

- 当前仓：`swf\Spidkiller.swf`（209887 字节 md5 `22ae5aad`；runtime 副本同哈希）——**与 4.0 库逐字节相同**。
- 3.4 库：`原版\3.4（原版参考）\3.4游戏\swf\enemy\Spidkiller.swf`（197577 字节 md5 `0f61d3ba`）＝**无声旧版**（DefineSound 0 个，die/stand/shoot1 cid 整体 −1）——补音效＋图像 cid 移位的对照物。
- 4.0 库：`原版\4.0（原版参考）\4.0游戏\swf\enemy\Spidkiller.swf`＝与当前仓逐字节同。
- 2.5 库：**全无**（数据层 `2.5版本游戏\assets\xml\enemy25.xml/enemyArms25.xml/level16.xml` 零命中＋素材层无 swf）。
- 11.3 素材汇总：`红蛛杀手\`＝**直配夹**（全量 FFDec 导出）——⚠️ `sprites\DefineSprite_*\frames.gif` 三态（stand/move/shoot1）**全空帧损坏**、die 仅特效点，勿直接引用；sounds 导出 0.wav/28.mp3(f459def8)/57.mp3(42f48872) 与审计一致。
- **档案辨认动图（ffdec 自导，2026-10-07）**：`D:\superalloy\TMP\红蛛杀手建档-20261007\辨认材料\`（四态 GIF 33ms/帧忠实原版 30fps＋连拍 PNG；TMP 不入仓）。
- 图鉴图标：**已定位**＝素材汇总`原版\11.3超合金素材汇总\百科ui\images\132.jpg`（90×90 红色蛛形机甲；色相占比全库第一＋用户截图面板同款双确认）。

## 文档与数据

- docx：**无条目**（`世界观开发\规整档案\原版资料\原版机器人，角色介绍\超合金机器人介绍….docx` 零命中——**月球批八怪均未被 docx 转录**，"资料不详"判定对本批失效，图鉴面板才是文案源）。
- 图鉴设定原文（BookUI760 文本）：攻击中等/生命中等/**爆炸（剪刀）攻/电磁干扰装甲（剪刀）防/远战/隶属部队：月球空战队**——"机器人空军配备的空中登陆部队，负责在太空中作战的登陆作战，装备一门近距离冲锋炮。"
- 三方比对数据：`D:\superalloy\TMP\敌人美术对比-20260928\敌人清单与三方硬比对.csv` 行 71（verdict"三方互异"；结构差异 tag14 +2＝补 2 音效）。
- 音频审计：`更新总结\月球噪声\工具\swf_sound_audit.py`；静音版清单口径差异（28=音效 cid vs 55=die 部件 cid）已闭合，见档案音频节。
- 权威图鉴顺序：`..\..\图鉴顺序-BookUI.json`（第 35 位）。

## 家族关联

- `..\..\4，自爆蜘蛛机\`（4 号 Spider）——**同名蜘蛛、完全异构对照**：专属 AI 四件套＋无武器扑击＋0.2/0.5 最低收益＋三方全同老怪 vs 本怪默认分支＋5 连发远程＋2/1 量产档＋3.4 新怪。
- `..\34，拦截机1号\`（同卷）——首秀 1-4-1 champion 成对出场、1-4-2 同关混编、同为"3.4 战役开头龙套→11.3 全程量产"扩编曲线（34=空军版/本怪=地面版）；34 的 boss 行 3 关与 champion 3 关口径互链。
- 同卷待建的混编伙伴：36 拦截机2号（1-4-2 双 boss 同关）/39 红色破袭者（1-4-22 同波 12+12）/40 月面观察者。
- 噪声案引用：`更新总结\月球噪声\月球噪声-结案报告与任务交接-20261006.md`（本怪出生/移动静音、刷新爆响＝归因偏移的结论在该报告第七节）。
