# 35 警报塔 · 路径索引

> 本夹档案：`警报塔-档案-20261009.md`（半删影子怪定谳档——图鉴全留/出兵行注释式半删/swf 掉件，2026-10-07 用户三端复原、10-09 实机确认）。
> **AI/Body 类**：`decompiled\gamefile\scripts\enemy\alarmTower\AlarmTowerBody.as`（自建 Body：hitHurtB 可受击门＋ChargerAAHD 借用＋死亡震屏）＋`AlarmTower_AI.as`（禁移动/startAttackOnce_break/开火置可受击）；注册＝`BodyGroup.as` `addAlarmTower()`＋直名分支。
> **嵌入表锚点**：敌表 `5_EmbedXml_xmlClass8` idx=7；武器表 `4_EmbedXml_xmlClass9` index **100026**"警报塔声波"单档（纯伤害 6 发/轮，type 太阳炮死标签＋小黄豆文案搬运——与 07 地防炮 10007 同血统）。
> **关卡表**（17_EmbedXml_xmlClass11）：1-1-21"突围而出"enemy1/enemy2 各 1 只（2026-10-07 取消注释复活；原表备份 `.original-backup-20261007.bak`）。原版分布残留＝2-1-10/2-1-11 extraEnemyName（2.5/3.4/4.0 在册、11.3 已删、全仓零代码引用死字段）＋Gundam_ExtraSkill 脚本召唤（32 档语境，11.3 整删）。
> **名单/特判**：`GameDefine.noSuperList`（checkSuper=false＝不可抽 super 词条）／`LifeBodyDefine.getUnit` 按名权重=1／`EventOrderDefine(.Group)` 三炮台白名单（地面自动炮台/警报塔/防御激光炮——07 档生成机制定案）。
> **素材**：`swf\enemy\AlarmTower.swf`（45,660B/C34DE794…，与 2.5/4.0 逐字节同＝回填件）；有声 1 处（sprite59 帧 2 StartSound≈0.76s）；辨认材料＝`D:\superalloy\TMP\警报塔建档-20261009\`（sprites 全量导出＋三轮 dump 脚本与输出，不入仓）。
> **实装文档**：`更新总结\功能性更新总结\警报塔出场实装-三端恢复原版安排-20261007.md`（改动清单/构建验证/踩坑三条/回滚步骤）。
> **三代源**：2.5＝`原版\2.5（原版参考）\2.5版本游戏\assets\xml\enemy25.xml`（baseLife 3.2/奖赏 2×，level16.xml 已取消注释）＋`enemyArms25.xml`；3.4/4.0＝game.swf 内嵌 binaryData（TMP\猎隼战机建档-20261009\bd_34/bd_40 复用导出）。
> **面板**：BookUI760 chid 463~467（名/攻行/防行"隶属部队：陆军"/lore 467）；图标＝内嵌 JPG 未单独定位。
> 交叉：07 地面自动防御炮台（家族：可受击门/白名单/超宽警戒/startAttackOnce_break）／11 原子塔（声波炮塔前辈【推测】）／32 炮装审判者（ExtraSkill 召唤语境）／74 月面陆基激光炮（镜像案例：同"曾经有过被删"，彼图鉴删此图鉴留）／31 剑装审判者（1-1-21 关主）。
