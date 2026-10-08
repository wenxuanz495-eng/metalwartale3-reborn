# 34 猎隼战机 · 路径索引

> 本夹档案：`猎隼战机-档案-20261009.md`（追加批建档第一号；用户三条一手裁定——第八军团空军指挥/图鉴"陆军"系错误实为空军/天隼游隼迭代款——全部坐实入档）。
> **AI 类**：`decompiled\gamefile\scripts\enemy\SakerFighter\SakerFighter_AI.as`（专属类：attackOver 50% 双武器切换＋rectLevel 换判定＋每 4 拍翻转）；注册=`BodyGroup.as` `addSakerFighter()`＋直名分支，入 Drilling_arr。
> **嵌入表锚点**：敌表 `5_EmbedXml_xmlClass8` 块序 20/idx=20（三隼连排 18/19/20）；武器表 `4_EmbedXml_xmlClass9` index **100024** 双档（电磁炮/曲线落弹）。
> **关卡表**（17_EmbedXml_xmlClass11，按中文名引用）：1-2-3"第八军团"（唯一 boss 行，台词钩子 k1_1_1/k1_1_2）／1-2-4/5/6/8/9；Vip 1-1-999；4-1-1；4-1-5。1-2-4 另含先知 boss 行（k1_2_1/k1_2_2）。
> **台词原文**：`decompiled\gamefile\scripts\gameAll\define\DialogueDefine.as:86-87`＝"我是第八军团空军指挥官，你无法击败我的！"/"荣耀归于我主！"。
> **素材**：`swf\SakerFighter.swf`（247,488B/06E19070…/无声）；11.3 素材汇总直配夹"猎隼战机"；辨认材料（四态 sprite 全量导出）＝`D:\superalloy\TMP\猎隼战机建档-20261009\sprites\`（不入仓）；收割脚本与输出在同 TMP 夹。
> **三代源**：2.5＝`原版\2.5（原版参考）\2.5版本游戏\assets\xml\enemy25.xml/enemyArms25.xml`（baseLife 2.4/奖赏 1.4×）；3.4/4.0＝各自 game.swf 内嵌 binaryData（5_enemy25_xml bin，bd 导出在 TMP）。
> **面板**：BookUI760 chid 470~474（470 名/471 攻击行/473 防御行"隶属部队：陆军"＝原版错误/474"资料不详。"）；图标＝内嵌 JPG 未单独定位（同游隼/天隼档惯例）。
> 交叉：5 游隼／6 天隼（迭代本体两档）／21 女妖战机（同章空军 boss 前辈）／11 警报塔（同批追加头三兄弟：猎隼/警报塔/圣堂）／0 经验战机（4-1-5 同关出勤）。
