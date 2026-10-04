# 33 判决者 · 文件索引与介绍

> 本夹档案：`判决者-档案-20261003.md`（**2026-10-05 按用户裁定重写为独立全量档**——判决者＝彻底的新形态非换色：结构级重建＋官方署名独立攻击组＋独立技能槽）。
> 表名＝图鉴名"判决者"；代码 id `Intercessor` index 41（空壳条目，历代如此——2.5 即 index 13 空壳；数值与机制走 index 40 共享条目，本 README 双列）。

## 代码文件（仓库 `decompiled\`）

- 与 30 共用三文件：`gamefile\scripts\enemy\intercessor\`（IntercessorBody/Intercessor_AI/IntercessorAnimation）——判决者视角的差异点：
  - `IntercessorBody.addSuper():62-65`：changeB 分支三槽 **[Skill_Laser, Energy_Boom, Clear_Energy]**（11.3 Clear_Energy 删空＝实效两技能，用户观测实锤；老版本真三技能含 EMP）；
  - `changeState():69-93`：变身演出（F_G=1.5＋hurtRectArr 三段小框替换＋**现场改名"判决者"**＋血条续用）；
  - `Intercessor_AI` adjudicator 分支：四招各 25%＋**距离自适应强制选招**（>350→shoot_4／<120→shoot_attack）＋rectLevel 0/1/2 切换；
  - `bodyTimer` 特效钩子：shoot_attack 25 帧震屏（**判决者踩地面**）＋die2 37 帧死亡大震。
- `BodyGroup.as:526`（"黑暗剑装审判者"分支见 31.1）；"判决者"分支：`addIntercessor()`＋`define.name="判决者"`＋`changeB=true`。
- 敌人表：`embedded-xml-assets\5_EmbedXml_xmlClass8_….bin` → **index 41 id=Intercessor（判决者空壳）＋index 40 id=Intercessor（共享数据 27 段）**——**index 40 内含形态署名注释（2026-10-05 新证，2.5 同款）**：`以下是仲裁者激光炮`（shoot_2）／`以下是判决者激光炮`（shoot_3）／`以下是判决者超级激光炮`（shoot_4）／`以下是判决者踩地面`（shoot_attack）——攻击段按形态官方分区。
- 敌方武器表：`embedded-xml-assets\4_EmbedXml_xmlClass9_….bin` → **id=Intercessor**（"仲裁者-拉屎"：energy/hurt 4/45°/shootNum 2）＋**id=Intercessor_jump**（同名，跳射用）。
- 技能挂载调用点：`gamefile\scripts\gameAll\EventGroup.as`（boss 分支 `b0.addSuper()`）。
- Boss 台词（**说话人已核**）：`decompiled\dataMust\scripts\gameAll\define\DialogueDefine.as:82-85`——d4_9_1（判决者"无须恐惧…"）/d4_9_2（**hero 玩家**"我来到这个战场…正义将引领我们走向胜利！"）/d4_9_3（判决者"解除无谓的幻象…机器人霸主的真面目"＝变身宣言）/d4_9_6（判决者"别高兴的太早…卷土重来"）。
- 关卡表：`embedded-xml-assets\17_EmbedXml_xmlClass11_….bin` → **1-1-30 决战月都（第四章 9，enemyLv 31）**：多波大军（女妖/攻城坦克/杀戮者三 champion 压阵）＋boss 判决者；台词链 `firstDialogue="self/0/d4_9_1,hero/5/d4_9_2,self/4/d4_9_3,change/3/,start/1/"`＋`dialogue="self/0/d4_9_6,die/5/"`——**change/3/＝变身触发点**。
- 图鉴：`gamefile\scripts\UI\book\BookUI.as:105`（顺序数组第 33 位"判决者"）。

## 资源文件

- 共享本体：`swf\Intercessor.swf`（`ADF8A377`，2615504 字节全表最大级＝**双形态双套动画**；比对 CSV index 40/41 同哈希）；人形组动画（stand2 25 帧/die2/shoot_3 十六帧扫线/shoot_4 五段 800 宽/shoot_attack 踩地）。
- 素材汇总夹（共享）：`D:\superalloy\原版\11.3超合金素材汇总\仲裁者\`（人形组精灵 `370_stand2`/`385___stand2`/`221_shoot_attack`/`555_attack_effect`）。
- 图鉴图标：第 33 位面板——**待定位**（`b_out\8.jpg` 为 30 号悬浮形态）。

## 文档与数据

- docx 段 154-162（第二形态/增强模式/K-III型热能射线冲击炮/**月都战役**临时第二方面军指挥官——原文"越都战役"经用户确认为笔误已改正）：`D:\superalloy\世界观开发\规整档案\原版资料\原版机器人，角色介绍\超合金机器人介绍（包含老版本存在，但新版本被删减的内容。）.docx`。
- 历代数据：2.5＝`assets\xml\enemy25.xml`（index 12＋13 双条目同构＋判决者署名注释）＋`level16.xml`（1-1-30 决战月都×1）；3.4＝`game.baseline.swf`（判决者×11）；4.0＝embedded-xml 17_level280_xml（1-1-30 同名）。
- 三方比对：`D:\superalloy\TMP\敌人美术对比-20260928\`（CSV 40/41 同哈希）。
- 权威图鉴顺序：`..\图鉴顺序-BookUI.json`（第 33 位）。

## 家族关联

- `..\30，仲裁者\`（变身源头机制档——70% changeState/悬浮形态数据；与本档互为镜像，本档为判决者视角全量展开）。
- `..\29，杀戮者\`（K 系列谱系：K/K-II/K-III）。
- Clear_Energy 删空考据：`..\精英词条技能对照-20261003.md`。
