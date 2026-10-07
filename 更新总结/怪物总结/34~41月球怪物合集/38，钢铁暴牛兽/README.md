# 38 钢铁暴牛兽 · 文件索引与介绍

> 本夹档案：`钢铁暴牛兽-档案-20261007.md`（设计 Boss·月球危机囚兽·判定层+跟踪弹幕型；用户指令重点查技能，本档二节为主体）。本 README＝该怪全部相关文件的索引字典。
> 表名＝图鉴名"钢铁暴牛兽"；代码 id `xiniu`（纯拼音；块序 77 三代不变；3.4/4.0 index 属性=7〔追加怪共槽〕→11.3=77）。

## 代码文件（仓库 `decompiled\`）

- **专属 AI＝Xiniu_AI（月球卷唯一）**：`gamefile\scripts\enemy\tiger\Xiniu_AI.as`（26 行，**寄存在机械剑齿虎 tiger 目录**——外包期文件摆放随意）——extends Normal_Land_AI＋唯一 override attackAI：shoot1 帧 1~13 强制 `mot.eVx=±vxmax` 满速前冲（与剑齿虎 shoot3 突进斩同款机制）；三代代码逐字同（2.5 代码库无此类）。
- 生成路径：`gamefile\scripts\bodyGroup\BodyGroup.as:544` **硬编码分支** `if(str=="钢铁暴牛兽") return this.addNormal_Land("xiniu",4,true,null,Xiniu_AI);`（armsNum=4＋**hitHurtB=true 本体接触伤**＋专属 AI）。
- 敌人表：`embedded-xml-assets\5_EmbedXml_xmlClass8_….bin` → **index 77 id=xiniu**（imgList 7 态 4 攻击标签/baseLife 12·奖赏 8/8/motion 爆炸反应装甲防/hitRect 362×149/vx 200/vy 600+jumpHeight 600/vy·jump 3.4=200→11.3=600/**nextAttackTime 五档 2~0.2 激进攻速**/双 grapRect 全远窗 -580 起步/**敌表自带 description＝"加特林车载重炮"车辆文案错挂（死数据，无代码消费）**/**attackHitData 12 段三标签**：shoot1 帧1~12 endFrame 跨帧段（全表首见 endFrame）3×225px 线 hurt1 energy＋shoot2 电光四射 7 段扩张矩形（456→599→861px）hurt1 motion＋shoot3 横扫 4 段渐长横线（800→981→1183px）hurt5 motion＋**shoot4 零判定段**；零 specialType 无破盾无控制）。
- 敌方武器表：`embedded-xml-assets\4_EmbedXml_xmlClass9_….bin` → **arms index 100093 id=xiniu 四把全 type=太阳炮**：LV0"空炮"（表内自名）→shoot1/LV1"电光四射"触发→shoot2/LV2"横扫前方"触发→shoot3/LV3"跟踪光弹"＝**实弹 hurt1×6 连发×2 弹=12 弹/轮 ±20° followB=1 跟踪自有弹体 xiniu/bullet4**（description=小黄豆 Z 系列太阳炮文案搬运，67 载体家族）；三代逐字同。
- 关卡表：`embedded-xml-assets\17_EmbedXml_xmlClass11_….bin` → ①主线 **1-4-7 钢铁之墓（第十章 8）** type=boss ×1（enemyLv 78/四系数缺=×1/**scene=base4（基地）**）——三代恒定；②**精英副本 2-1-16（11.3 新增）**：`specialClass=gameAll.level.extra.SpecialExtraLevel_11` 壳＋type=boss 行。
- 血量两套体系（`..\..\怪物分级与数值体系-20261005.md` 四.13 在案）：主线公式 407,920(Lv78)×12×10＝**4,895 万**（难度 1）；精英 extra 手调 **3.2 亿/hurt 400 万**（baseLife 与曲线被绕过）。
- 掷骰名单：GameDefine.as:212/214 不含（理论项，两处出场全 boss 行）。
- 图鉴：`gamefile\scripts\UI\book\BookUI.as:105`（数组第 38 位）；**游戏内图鉴面板文本＝BookUI760.swf 导出 text 697~701**（697 名字/699 设定原文/700 动能拳攻远战/701 爆炸反应装甲拳防·隶属部队未知）——docx 未转录，面板=一手文案源（用户截图双源）。

## 资源文件

- 当前仓：`swf\xiniu.swf`（839,388 字节 md5 `3f4d720d`）——**与 4.0 库逐字节相同**。
- 3.4 库：`原版\3.4（原版参考）\3.4游戏\swf\enemy\xiniu.swf`（818,024 字节 md5 `a189b63d`）＝**全静音旧版**。
- 4.0 库：`原版\4.0（原版参考）\4.0游戏\swf\enemy\xiniu.swf`＝与当前仓逐字节同。
- 2.5 库：**全无**（swf 与 enemy25.xml 双零命中；代码库亦无 Xiniu_AI）。
- 11.3 素材汇总：`钢铁爆牛\`＝直配夹（**夹名错别字"爆"**；sounds 0/25/27/82/125/129/165.mp3 与审计一致）——⚠️ `sprites\*\frames.gif` 七态全空帧损坏（同批病症），勿直接引用。
- **档案辨认动图（ffdec 自导，2026-10-07）**：`D:\superalloy\TMP\红蛛杀手建档-20261007\辨认材料38\`（七态 GIF＋连拍 PNG＋bullet4 弹体；TMP 不入仓）。
- 图鉴图标：**已定位**＝素材汇总`原版\11.3超合金素材汇总\百科ui\images\140.jpg`（90×90 黑钢四足兽；色相余弦 0.973＋目视双确认）。

## 文档与数据

- docx：**无条目**（暴牛/牛兽/钢铁野兽/失落全零——月球批未转录惯例）。
- 图鉴设定原文（BookUI760 697~701）："一头失落的钢铁野兽，被月球机器人军队关押在基地中……通通撕成碎片。"＋攻很高/血很高/动能（拳头）/爆炸反应装甲（拳头）/远战/**隶属部队：未知**（全图鉴独一份）。
- 数值侧总纲：`..\..\怪物分级与数值体系-20261005.md` 四.12（六怪数据表 xiniu 行/粪怪化样本判定）＋四.13（精英 extra 手调 3.2 亿/主线 4,895 万实算）——本档为其建档落地。
- 三方比对数据：`D:\superalloy\TMP\敌人美术对比-20260928\敌人清单与三方硬比对.csv` 行 77（三方互异；size 839,388/818,024）。
- 音频审计：`更新总结\月球噪声\工具\swf_sound_audit.py`；**die=cid27 b06eb75e 与大天使专属死亡音同文件（Boss 级共享死亡音第二例）**；脚步 cid25=5cce6525 与大天使同款；shoot1 冲锋音 cid165=1b0155ff；shoot2=cid82 20f6f711；shoot3=cid125 ef2fa3f8 激光族+cid129 bc215942。
- 权威图鉴顺序：`..\..\图鉴顺序-BookUI.json`（第 38 位）。

## 家族关联

- **机械剑齿虎**（Tiger，未独立建档，专项在 `..\..\怪物分级与数值体系-20261005.md` 四.16）——**同目录寄居关系**（Xiniu_AI 与 Tiger_AI 同住 enemy\tiger\；同为 3.4 加入的外包世代、同款 AI 突进机制）。
- `..\..\12，碾压者\` 等 motion 防系对照；月球 Boss 位交接链：大天使（1-4-3）→**钢铁暴牛兽（1-4-7）**→战虎系/机器上校（四.13 血量表）。
- 精英副本语境：2-1-16~22 六精英（四.12 批次：战虎掠夺者/战虎杀戮者/护卫统领/机器上校/机甲战神）。
- type=太阳炮死标签结论见 36 号档案；小黄豆文案搬运见 37 号档案勘误。
