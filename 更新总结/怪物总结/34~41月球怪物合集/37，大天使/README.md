# 37 大天使 · 文件索引与介绍

> 本夹档案：`大天使-档案-20261007.md`（设计 Boss·月球危机首个大 Boss·判定层转圈扫射型）。本 README＝该怪全部相关文件的索引字典。
> 表名＝图鉴名"大天使"；代码 id `Archangel`（块序 73 三代不变；3.4/4.0 index 属性=7〔追加怪共槽〕→11.3=73）。
> ⚠️ 拼写口径（2026-10-07 用户裁定）：战舰名统一记**达代罗斯号**（用户文件主流写法）；图鉴面板原文"达代罗斯/代达罗斯"两写并存系原版错别字，引用原文时如实保留并标注。

## 代码文件（仓库 `decompiled\`）

- **无专属类**（全 decompiled 仅 `UI\book\BookUI.as:105` 图鉴数组一处引用）——通用地面体系 `Normal_Land_AI`＋`Enemy_AI.chooseAttack` 随机 4 攻（`Math.random()*armsNum`，与猛犸固定轮换对照的极简流）。
- 生成路径：`gamefile\scripts\bodyGroup\BodyGroup.as` getUnit **默认分支**（`addNormal_Land("Archangel",4,haveAttackRectB())`）；掷骰双名单（GameDefine.as:212/214）不含（理论项——全游戏唯一出场为 boss 行不走掷骰）。
- 敌人表：`embedded-xml-assets\5_EmbedXml_xmlClass8_….bin` → **index 73 id=Archangel**（imgList 7 态 4 攻击标签/baseLife 10·奖赏 2/2 倒挂/energy 复合装甲防/hitRect 290×300 巨型/vx 200~400/双 grapRect 近远窗/**attackHitData 17 段**：shoot1 踩地板 4 段矩形 0.8＋shoot3 连射 4 段 680px 线 hurt10＋shoot4 转圈 **9 段 735px 线 hurt100＝判定层全表最高表值伤害**；**3.4→11.3 四处改动**：vy 150→600+新增 jumpHeight/jumpNum+shoot1 判定帧后移+shoot3 hurt 1→10）；三代块序 73 不变。
- 敌方武器表：`embedded-xml-assets\4_EmbedXml_xmlClass9_….bin` → **arms index 100089 id=Archangel 四把全带 type=太阳炮死标签**：LV0 踩地板（空炮→shoot1）/LV1 跟踪导弹（**唯一实弹** mixed hurt1 followB=1 自有弹体 Archangel/bullet2/带 description"利用能源转换器将太阳能转换成能量球发射出去。"）/LV2 连射（空炮→shoot3）/LV3 转圈（空炮→shoot4）；三代逐字同。
- 关卡表：`embedded-xml-assets\17_EmbedXml_xmlClass11_….bin` → **全游戏仅 1-4-3 天使陨落（第十章 4）×1 type=boss**（enemyLv 74/scene ruins_morning/loopMusic Smash_Sketch/**四系数全缺=×1**/开场提示"前方发现不明巨型机器人，我想一定是他们所谓的'大天使'了。"/护卫群=红蛛杀手 14+拦截机2号 9+拦截机1号）；三代恒定 1 关 1 只。
- 血量实算：曲线 Lv74 基数 371,925（`GameDefine.test_getEnemyLife_byLevel`，公式锚点 Lv78=407,920 复算吻合）×10×bossAllRa 10＝**≈3,719 万**（难度 1）。
- 图鉴：`gamefile\scripts\UI\book\BookUI.as:105`（数组第 37 位）；**游戏内图鉴面板文本＝BookUI760.swf 导出 text 691~695**（691 名字/693 设定原文/694 束能布攻远战/695 复合装甲布防月球陆军）——docx 未转录，面板=一手文案源。

## 资源文件

- 当前仓：`swf\Archangel.swf`（**1,930,812 字节**＝月球八怪最大 swf，md5 `e237539d`）——**与 4.0 库逐字节相同**。
- 3.4 库：`原版\3.4（原版参考）\3.4游戏\swf\enemy\Archangel.swf`（1,900,150 字节 md5 `7e5e62f6`）＝**全静音旧版**（DefineSound 0；部件 cid 排布与当前完全不同）。
- 4.0 库：`原版\4.0（原版参考）\4.0游戏\swf\enemy\Archangel.swf`＝与当前仓逐字节同。
- 2.5 库：**全无**（swf 与 `assets\xml\enemy25.xml` 双零命中）。
- 11.3 素材汇总：`大天使\`＝直配夹（sounds 0.wav/28/30/93/99/307.mp3 与审计一致）——⚠️ `sprites\*\frames.gif` 七态全空帧损坏（同批病症），勿直接引用。
- **档案辨认动图（ffdec 自导，2026-10-07）**：`D:\superalloy\TMP\红蛛杀手建档-20261007\辨认材料37\`（七态 GIF＋连拍 PNG＋bullet2 弹体；TMP 不入仓）。
- 图鉴图标：**已定位**＝素材汇总`原版\11.3超合金素材汇总\百科ui\images\138.png`（90×90 黑巨机红纹；色相余弦 0.999＋目视双确认；⚠️ png 后缀）。

## 文档与数据

- docx：**无条目**（机器人介绍/关卡介绍两 docx 对"大天使/天使/达代罗斯/代达罗斯"全零命中——月球批未转录；面板=唯一文案源）。
- 图鉴设定原文（BookUI760 691~695）："月球陆军突击队的指挥官，负责对达代罗斯号进行拦截……最后被及时赶到的超合金战队击败。"＋攻高/血高/束能（布）/复合装甲（布）/远战/月球陆军。
- 数值侧总纲：`..\..\怪物分级与数值体系-20261005.md` 四.5 外包批普查（大天使行：baseLife 10/奖赏 2/2/17 段/倒挂定性）＋二遍补全（前作遗产重定性/用户研究剧情）——本档为其建档落地。
- 三方比对数据：`D:\superalloy\TMP\敌人美术对比-20260928\敌人清单与三方硬比对.csv` 行 73（三方互异；size 1,930,812/1,900,150）。
- 音频审计：`更新总结\月球噪声\工具\swf_sound_audit.py`；**专属死亡音 cid30=b06eb75e**（月球批首例非 f459def8）；cid93=d485df5f 孪生起手音；cid99=ef2fa3f8 12 家共享激光音 ×12 段配音；cid307=d2138b97（红色破袭者 shoot1 同款）；cid28=5cce6525 脚步音。
- 权威图鉴顺序：`..\..\图鉴顺序-BookUI.json`（第 37 位）。

## 家族关联

- `..\34，拦截机1号\`／`..\35，红蛛杀手\`／`..\36，拦截机2号\`——1-4-3 天使陨落的护卫群三怪（空军开路、指挥官压阵＝图鉴叙事的关卡层互文）。
- `..\38，钢铁暴牛兽\`（同卷待建）——下一场设计 Boss（1-4-7 钢铁之墓，baseLife 12 超越大天使）。
- 空军组合语境参照 34 档；月球 Boss 位交接链：大天使（1-4-3）→钢铁暴牛兽（1-4-7）→战虎系/机器上校等（四.13 的 Boss 战血量表）。
- type=太阳炮死标签结论见 36 号档案（编辑器分类非功能钩子）。
