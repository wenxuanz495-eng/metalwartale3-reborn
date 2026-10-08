# 39 红色破袭者 · 文件索引与介绍

> 本夹档案：`红色破袭者-档案-20261007.md`（普通怪·月球危机量产陆军·出生即开火的散射突击者）。本 README＝该怪全部相关文件的索引字典。
> 表名＝图鉴名"红色破袭者"；代码 id `Redsabotager`（块序 75 三代不变；3.4/4.0 index 属性=7〔追加怪共槽〕→11.3=75）。⚠️ 夹名易混：素材夹叫"红蛛**破袭者**"（错别字），与 35 红蛛杀手、本怪三者名字互相纠缠，引用时认 id。

## 代码文件（仓库 `decompiled\`）

- **无专属类**（全 decompiled 零引用）——通用地面体系 `Normal_Land_AI`＋`Enemy_AI.chooseAttack` 随机二选一（armsNum=2）；掷骰双名单（GameDefine.as:212/214）不含＝量产怪掷骰全开放。
- 生成路径：`gamefile\scripts\bodyGroup\BodyGroup.as` getUnit **默认分支**（`addNormal_Land("Redsabotager",2,haveAttackRectB())`）。
- 敌人表：`embedded-xml-assets\5_EmbedXml_xmlClass8_….bin` → **index 75 id=Redsabotager**（**imgList `shoot1,shoot2,die,move,stand`＝shoot1 打头无 stand 开头＝出生即播 shoot1 出生即响**；hitRect=hurtRect 同值 -80,-100,160,100；baseLife 2 单倍奖赏/energy 复合装甲防/vx 200~400/vy 600+jumpHeight 600/tweenValue 0.1/hoverRect 800px 超宽巡逻带；**attackHitData 4 段全 shoot2**：帧 7/14/21/28、367→735→735→735px 光束 hurt1 energy；**三代关键差异＝3.4 带 airRange -100,-300（空军）→4.0 去 airRange+jumpHeight 600（改制陆军）→11.3 vy 150→600**＝月球批首个军种改制，imgList 等其余字段三代不变）。
- 敌方武器表：`embedded-xml-assets\4_EmbedXml_xmlClass9_….bin` → **arms index 100092 id=Redsabotager 两把**：LV0"多重散射"＝**实弹 boom hurt1×5 发 60° 扇形**（bulletSpeed 18/自有弹体 Redsabotager/bullet1/**attackGap 0.3 超短冷却**/不带太阳炮标签）；LV1"快速连击"＝空炮触发器（type=太阳炮死标签）→shoot2 四段光束；三代逐字同。
- 关卡表：`embedded-xml-assets\17_EmbedXml_xmlClass11_….bin` → **73 关 1764 只＝量产规模第二**（仅次于 35 红蛛杀手 1904）；**首秀 1-4-5 天降神兵＝champion×2+boss×1 三行全特型**、1-4-6 突入基地 boss×1（连续两关 boss 亮相）；champion 9 关 16 行；**17 关限时剧本（与红蛛杀手同单）**；单关峰值 84~85 只×5 关（1-4-39/48/51/74/99）；扩编史 3.4 三关 8 只→4.0 七关 21 只→11.3 七十三关 1764 只。
- 图鉴：`gamefile\scripts\UI\book\BookUI.as:105`（数组第 39 位）；**面板文本＝BookUI760 text 709~713**（709 名字/711 设定原文/712 束能布攻远战/713 复合装甲布防月球陆军）；**面板视觉段＝enemyContent sprite 775 帧 435~449**——⚠️ **段序排在月面观察者（40，帧 425~434）之后**且段后夹着从未进图鉴的"空袭战机"段（450~456）＝外包排版随意（按名跳帧不受影响）。

## 资源文件

- 当前仓：`swf\Redsabotager.swf`（120,545 字节 md5 `686a0436`）——**与 4.0 库逐字节相同**。
- 3.4 库：`原版\3.4（原版参考）\3.4游戏\swf\enemy\Redsabotager.swf`（101,955 字节 md5 `66035e33`）＝**全静音旧版（空军时代）**。
- 4.0 库：`原版\4.0（原版参考）\4.0游戏\swf\enemy\Redsabotager.swf`＝与当前仓逐字节同（改制陆军+补音效）。
- 2.5 库：**全无**（swf 与 enemy25.xml 双零命中）。
- 11.3 素材汇总：`红蛛破袭者\`＝直配夹（**夹名错别字"蛛"**；sounds 0/20/24/43/63.mp3 与审计一致）——⚠️ `sprites\*\frames.gif` 五态全空帧损坏（同批病症），勿直接引用。
- **档案辨认动图（ffdec 自导，2026-10-07）**：`D:\superalloy\TMP\红蛛杀手建档-20261007\辨认材料39\`（五态 GIF＋连拍 PNG＋bullet1 弹体＋面板帧图标实拍；TMP 不入仓）。
- **图鉴图标＝面板帧实拍**（sprite 775 帧 435：红色多足+顶部炮列，与实机一致）——百科ui\images 库内无独立整图定案（144.jpg=红色炮列特写疑同源；148/152 已排除；**色相匹配法红区失效案例**）。

## 文档与数据

- docx：**无条目**（破袭/佼佼者零命中；"突击者"命中为 27 号 Charger 无关）。
- 图鉴设定原文（BookUI760 709~713）："月球陆军中的佼佼者，是地面战斗中的强力突击者。"＋攻中等/血中等/束能（布）/复合装甲（布）/远战/月球陆军。
- 数值侧总纲：`..\..\怪物分级与数值体系-20261005.md`（单倍奖赏量产档/energy 防/防型三元）。
- 三方比对数据：`D:\superalloy\TMP\敌人美术对比-20260928\敌人清单与三方硬比对.csv` 行 75（三方互异；size 120,545/101,955）。
- 音频审计：`更新总结\月球噪声\工具\swf_sound_audit.py`；**出生即响音源=cid63 d2138b97（shoot1 帧1，与 37 大天使 shoot2 发射音同文件）**；四段光束音 cid43=bab9a60c（4368B 激光族第三根近亲）；脚步 cid20=5cce6525 共享件；die=f459def8 通用死亡爆炸（量产待遇）。
- 噪声案引用：`更新总结\月球噪声\月球噪声-结案报告与任务交接-20261006.md` 2.3 帧音普查（本怪＝两只"出生即响"实锤怪之一）。
- 权威图鉴顺序：`..\..\图鉴顺序-BookUI.json`（第 39 位）。

## 家族关联

- `..\68，红蛛杀手\`——**月球陆军双主力并列**（73 关 1904 vs 本怪 73 关 1764；红蛛=energy 五连发直弹/本怪=boom 散射——伤害类型互补；限时关同单 17 处；同音源家族 d2138b97 均有沾边）。
- `..\70，大天使\`——出生即响音源 d2138b97 与其 shoot2 导弹发射音同文件。
- `..\73，月面观察者\`（同卷待建）——面板帧序在本怪之前（40 在 39 前＝外包排版随意另一处）；同为"出生即响"实锤怪（激光音@shoot1 帧1）。
- 月球 Boss 亮相型对照：本怪 1-4-5/6 连续两关 boss 行 vs 35 红蛛杀手 1-4-2 单关——亮相型 boss 两手法样本。
