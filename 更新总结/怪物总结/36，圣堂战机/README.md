# 36 圣堂战机 · 路径索引

> 本夹档案：`圣堂战机-档案-20261009.md`（追加批第 3 号；用户四条口径——素材复用两处/2.5 外批资料不详/第八方面军【推测】/轰炸+激光扫射——攻击印象已在数据层双双坐实，归属维持推测标注）。
> **AI 类**：`decompiled\gamefile\scripts\enemy\havenFighter\HavenFighter_AI.as`（50% 掷骰双攻击：武器通道/判定层扫线通道＋每 4 拍翻转）；注册＝`BodyGroup.as` `addHavenFighter()`＋直名分支。
> **嵌入表锚点**：敌表 `5_EmbedXml_xmlClass8` idx=23；**attackHitData shoot_1 帧 5~13＝5 段 600px hitLine 扫线**（同块内）；武器表 `4_EmbedXml_xmlClass9` index **10006**"圣堂"单档（垂直 90° followB 跟踪弹）。
> **关卡表**：1-2-1（champion 首秀）/1-2-2（champion+superNum 词条精英）/1-2-4/5/6/8/**9**（Level_2_9 脚本：友军天隼 addFalconFighter("we")＋圣堂出场触发 k1_7_4 台词）/1-2-11/1-3-7/8/9；4-1-1/4-1-5/4-1-9。
> **台词**：`DialogueDefine.as:94-96`（k1_7_3"他们的防线太坚固了，空军部队，轰炸他们。"/k1_7_4"敌人又上来了，天隼战机，起飞迎敌。"/k1_7_5"你们的防御无法阻止我！！"）。
> **素材**：`swf\HavenFighter.swf`（299,120B/20F02BC6…/有声 3 处：f459def8 通用死亡＋d4e314de 切割音族＋cid15 d974012b 首见）；素材汇总"圣堂"＋"圣堂战机"双夹；辨认材料与三 swf 位图导出＝`D:\superalloy\TMP\圣堂战机建档-20261009\`（img_haven/img_charger/img_gundam2 哈希交集脚本在内，不入仓）。
> **素材复用考据数据**：与 Gundam2 共享 8 张位图（全为爆炸/碎片特效件）；与 Charger 位图 0 共享——机体复用为止于形制级。
> **三代源**：2.5＝enemy25.xml（baseLife 2.4/奖赏 2×，index 0）＋enemyArms25.xml；3.4/4.0＝game.swf 内嵌 binaryData（TMP 复用导出）。
> **面板**：BookUI760 chid 477~483（名 477/防行 479"隶属部队：空军"/攻行 482/lore 483"资料不详。"）；图标＝内嵌 JPG 未单独定位。
> 交叉：34 猎隼/6 天隼/5 游隼（空军迭代链近亲）／32 炮装审判者（Gundam_ExtraSkill 圣堂×3 护盾机）／31 剑装审判者（机翼形制对照源）／27 突击者（座舱形制对照源）／圣堂II型战机 PinkTemplar（图鉴外勿混，待后建）／28 强袭者（noSuperList 同单语境）。
