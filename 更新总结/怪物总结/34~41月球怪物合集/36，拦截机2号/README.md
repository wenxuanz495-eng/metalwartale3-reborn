# 36 拦截机2号 · 文件索引与介绍

> 本夹档案：`拦截机2号-档案-20261007.md`（普通怪·月球危机空军·判定层切割型）。本 README＝该怪全部相关文件的索引字典。
> 表名＝图鉴名"拦截机2号"；代码 id `Interceptors_2`（块序 72 三代不变；3.4/4.0 index 属性=7〔追加怪共槽〕→11.3=72）。⚠️ 与 34 拦截机1号（Interceptors_1）为同名异构对，勿混。

## 代码文件（仓库 `decompiled\`）

- **无专属类**（全 decompiled 仅 `UI\book\BookUI.as:105` 图鉴数组一处引用）——通用空军体系：`gamefile\scripts\enemy\_normal\Normal_FlyBody.as`＋`Normal_Fly_AI.as`（followToPoint 每 2 tick 蛇行）。
- 生成路径：`gamefile\scripts\bodyGroup\BodyGroup.as` getUnit **默认分支**（isAir→`addNormal_Fly("Interceptors_2",1,haveAttackRectB())`，armsNum=1）。
- 敌人表：`embedded-xml-assets\5_EmbedXml_xmlClass8_….bin` → **index 72 id=Interceptors_2**（imgList `fly,shoot1,die` 三态/baseLife 2 单倍奖赏/energy 复合装甲防/airRange -400,-600/hitRect+hurtRect 双组+grapRect+hoverRect+vx 三档 **与 34 号逐字同=同底盘**；**attackHitData 7 段 13 线=真伤所在**：shoot1 帧 14/20/23/25/32/35/38、energy hurt 0.3/段、hitLine 604px、hitImgLabel sub/cutter_hit_effect；**三代除 index 逐字同**）。
- 敌方武器表：`embedded-xml-assets\4_EmbedXml_xmlClass9_….bin` → **arms index 100088 id=Interceptors_2 单武器"45度切割"＝空炮**（hurt 0/bulletSpeed 0/bulletLife 0.01/shootPoint -1000,-80007 屏幕外/借 Charger_bullet_1 弹体图/attackGap 1.8；**type=太阳炮＝死数据字段**，全表 189 处代码零引用）；功能=触发 shoot1 消费判定层（29 杀戮者空炮同款模式）。
- 关卡表：`embedded-xml-assets\17_EmbedXml_xmlClass11_….bin` → **14 关 80 只全 1-4**（中文名引用，id 零直引）；亮相 1-4-2（champion×2＋boss×1，与红蛛杀手 boss 同关双 boss）；1-4-3 天使陨落 9/1-4-4 强行登陆 8；6 关限时剧本 Level_2_5（1-4-24/38/50/75/77/98）；终章 1-4-98 攻占大厅上 ×6（与 34 号 ×8 同关收尾）；扩编史 3.4 三关 20 只→4.0 六关 34 只→11.3 十四关 80 只。
- 掷骰名单：`gamefile\scripts\gameAll\GameDefine.as:212/214`——双名单均不含（掷骰全开放）。
- 图鉴：`gamefile\scripts\UI\book\BookUI.as:105`（数组第 36 位）；**游戏内图鉴面板文本＝BookUI760.swf 导出 text 685~689**（685 名字/687 设定原文"拦截机1号的进化机型…"/688 束能布攻远战/689 复合装甲布防月球空军）——docx 未转录，面板=一手文案源。

## 资源文件

- 当前仓：`swf\Interceptors_2.swf`（142427 字节 md5 `313b93e1`）——**与 4.0 库逐字节相同**。
- 3.4 库：`原版\3.4（原版参考）\3.4游戏\swf\enemy\Interceptors_2.swf`（130430 字节 md5 `ee026b12`）＝**无声旧版**（DefineSound 0 个；部件 cid 23/24/54，补音插入 cid 9/43 致 +1/+2 分段移位）。
- 4.0 库：`原版\4.0（原版参考）\4.0游戏\swf\enemy\Interceptors_2.swf`＝与当前仓逐字节同。
- 2.5 库：**无此 swf**（`2.5版本游戏\assets\` 零命中）。
- 11.3 素材汇总：`拦截机二号\`＝直配夹（sounds 0.wav/9.mp3/43.mp3 与审计一致）——⚠️ `sprites\*\frames.gif` die/fly/shoot1 **全空帧损坏**（同 35 夹病害），勿直接引用。
- **档案辨认动图（ffdec 自导，2026-10-07）**：`D:\superalloy\TMP\红蛛杀手建档-20261007\辨认材料36\`（fly/shoot1/die GIF 33ms/帧＋连拍 PNG＋光束素材 42 单帧；TMP 不入仓）。
- 图鉴图标：**已定位**＝素材汇总`原版\11.3超合金素材汇总\百科ui\images\136.png`（90×90 红青炮艇；**注意 .png 后缀**；fly 色相余弦 0.999＋目视双确认）。

## 文档与数据

- docx：**无条目**（"拦截/二号/2号"三词零命中——拦截机系 docx 缺位同 34 号；面板=唯一文案源）。
- 图鉴设定原文（BookUI760 685~689）：**"拦截机1号的进化机型，拥有非常强大的对地攻击能力。"**＋束能（布）攻/复合装甲（布）防/远战/月球空军。
- 三方比对数据：`D:\superalloy\TMP\敌人美术对比-20260928\敌人清单与三方硬比对.csv` 行 72（verdict"三方互异"；结构差异 **{14:+2, 45:+1}＝纯补音无他改**）。
- 音频审计：`更新总结\月球噪声\工具\swf_sound_audit.py`；死亡音 f459def8（与 1 号逐字节同文件）；切割音 d4e314de=12 家共享库音（与 1 号激光音 ef2fa3f8 同字节 4368B 近亲非同文件）。
- 权威图鉴顺序：`..\..\图鉴顺序-BookUI.json`（第 36 位）。

## 家族关联

- `..\34，拦截机1号\`——**同名异构对收官**：1 号数据先行素材迟到/双武器随机切换/蓝黄涂装 vs 2 号素材齐全无声→4.0 补音/空炮+判定层切割/红青涂装；运动/判定参数组逐字同=同底盘改型；死亡音同文件、切割/激光音同字节近亲；表内相邻（index 70/72）。
- `..\35，红蛛杀手\`——1-4-2 声东击西同关：两怪 boss 行同关双 boss＋本怪 champion×2；同关混编 34 号 32 只＋红蛛杀手 32 只＋风暴战士/闪电坦克。
- 空军组合语境：天隼（6 号）/游隼（5 号）/风隼（6.1）/拦截机 1/2 号——1-4 章空军成员。
- 借用链：弹体图借 27 突击者（Charger_bullet_1）；hitImgLabel `cutter_hit_effect`＝**全游戏通用判定线命中特效**（敌表 415 处引用，2026-10-07 用户纠正口径：非 18 号切割者专属物，标签名仅含"cutter"字样）。
