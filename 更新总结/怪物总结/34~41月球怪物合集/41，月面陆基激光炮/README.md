# 41 月面陆基激光炮 · 文件索引与介绍

> 本夹档案：`月面陆基激光炮-档案-20261007.md`（第 41 号·被取消的固定炮台·数据僵尸）。本 README＝该怪全部相关文件的索引字典。
> 表名＝图鉴名"月面陆基激光炮"；代码 id `Ground_laser`（块序 76 三代不变；3.4/4.0 index 属性=7〔追加怪共槽〕→11.3=76）。
> ⚠️ 与 7 号地面自动防御炮台（LandFort）同家族（LandFort_arr 编队/LandFort_AI3），与 LandLaser（AI2，图鉴外）是三兄弟。

## 代码文件（仓库 `decompiled\`）

- **专属 AI＝LandFort_AI3**：`gamefile\scripts\enemy\landFort\LandFort_AI3.as`——直承 Enemy_AI；**followToPoint 重写为空＝禁止移动**；attackOrder→startAttackOnce_break；**shootPan 视野判定：锁屏期在视野内 hitHurtB=0（接触无害）/视野外 hitHurtB=1（接触有伤）＝防屏外偷袭**；aiTimer 驱动。
- 生成路径：`gamefile\scripts\bodyGroup\BodyGroup.as:494` **硬编码分支** `if(str=="Ground_laser") return this.addNormal_Land("Ground_laser",1,false,this.LandFort_arr,LandFort_AI3);`（入 LandFort_arr 编队）；`:490` LandLaser→LandFort_AI2（家族兄弟）。
- 敌人表：`embedded-xml-assets\5_EmbedXml_xmlClass8_….bin` → **index 76 id=Ground_laser**（imgList stand,move,shoot1,die/hitRect=hurtRect 同值 -35,-46,70,46/baseLife 2 单倍奖赏/**energy 复合装甲防**/**vx 0 零移动**/grapRect -441,-60,441,60 超长前向侦测窗/affterAttack=waitAndAttack 定点防御/**无 attackHitData（伤害全在激光武器）**/**无 description 字段**（38 那种加特林错挂文案不在它身上）；三代逐字同）。
- 敌方武器表：`embedded-xml-assets\4_EmbedXml_xmlClass9_….bin` → **arms index 100090 id=Ground_laser 单把"激光横扫"**（laser 类型＋**penetrationB=1 贯穿**/hurt 0.2/bulletLife 0.3 短命光束/水平 0°/attackGap 0.6 高频/energy_hit_effect/不带太阳炮标签）；三代逐字同。
- 关卡表：`embedded-xml-assets\17_EmbedXml_xmlClass11_….bin` → **11.3 零引用**；**3.4 曾排场 3 关 20 只**（1-4-5 天降神兵 2+2／1-4-6 突入基地 3+3／1-4-7 钢铁之墓 4+4——均因 swf 缺失加载失败）；**4.0 已摘除**。
- 图鉴：`gamefile\scripts\UI\book\BookUI.as:105`（nameArr 第 41 位**仍在**）；**BookUI760 时间轴帧已删**（怪名仅 UTF-8 ×2、缺 FrameLabel＝半删，四.12 定案）；面板文本字段已无；**3.4 的 BookUI340 文本在册**（bookui340_text 697.txt，用户截图双源）。
- 掷骰名单：GameDefine.as:212/214 不含（理论项——从未出场）。

## 资源文件

- **当前仓：无 swf**（全仓 find 零命中）。
- **4.0 库（唯一实物）**：`原版\4.0（原版参考）\4.0游戏\swf\enemy\Ground_laser.swf`（**84,824 字节** md5 `eeb5e506`）＝取消出场后补做的孤儿素材；SymbolClass 4（move/die/stand/shoot1）＋DefineSound 0（无声）。
- 3.4 库：`3.4游戏\swf\enemy\` 与 `3.4素材库\raw\swf\enemy\` 均**无**（素材未做过——用户"没准备好图片"推测的数据支撑）。
- 2.5 库：无。
- 11.3 素材汇总：**无直配夹**（从未进素材汇总）。
- **面板图标**：仅存于用户 3.4 截图（红色激光炮塔）；本仓无任何图标文件。
- 档案无动图（无可用素材；4.0 swf 的四符号如需可后续 ffdec 导出）。

## 文档与数据

- docx：**无条目**（零命中）。
- 图鉴设定原文（用户 3.4 截图）："布置在月球表面的防御机器人，能够防御从地面来的大部分攻击，能够发射较长的激光束攻击敌人。"＋攻中等/血中等/束能（布）/复合装甲（布）/远战/月球陆军。
- 数值侧总纲：`..\..\怪物分级与数值体系-20261005.md`（单倍奖赏量产档/energy 防）；总账 README"缺 SWF 六件现状"行——本怪已查证完毕（4.0 有 swf/11.3 缺/关卡 11.3 零引用），待总账行同步。
- 三方比对数据：`D:\superalloy\TMP\敌人美术对比-20260928\敌人清单与三方硬比对.csv` 行 76（verdict"当前缺 SWF"；三代 size 全空——⚠️ 该结论系素材库文件层口径，**4.0 游戏库实有 swf**，引用时注意）。
- 图鉴序考据：`..\..\怪物总结\README.md` 四.12（BookUI760 半删字节扫描定案）。
- 权威图鉴顺序：`..\..\图鉴顺序-BookUI.json`（第 41 位）。

## 家族关联

- **LandFort 防御炮台家族**：`..\..\7，地面自动防御炮台\`（LandFort，AI 主线教学版）＋LandLaser（LandFort_AI2，图鉴外）＋本怪（LandFort_AI3，月球版）——同入 LandFort_arr 编队、同 waitAndAttack 定点血统；7 号档案"家族扩写"从本怪继续成立。
- `..\38，钢铁暴牛兽\`——同为月球危机 1-4-7 关出场位（3.4 时代本怪也在该关排场 8 只，后被取消，位置让给钢铁暴牛兽 boss 战）。
- 缺 SWF 六件家族：闪电球/七彩球/高达-浮游炮/警报塔/SAX-14K（总账"缺 SWF 六件现状"行）——本怪为其中唯一"曾排场、swf 后补、再整体取消"的完整取消案例。
- type=太阳炮死标签：本怪武器不带（覆盖面收窄的补充样本）。
