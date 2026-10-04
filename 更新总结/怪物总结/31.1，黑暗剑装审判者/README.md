# 31.1 黑暗剑装审判者 · 文件索引与介绍

> 本夹档案：`黑暗剑装审判者-档案-20261003.md`（设计 Boss：1-3-12 老友重逢；31 剑装审判者换色版）。本 README＝该怪全部相关文件的索引字典。
> 归档编号 31.1（用户裁定）；⚠️ 游戏图鉴 82 条名单内实际位列**第 74 位**。代码 id `Gundam3`（index 12）。

## 代码文件（仓库 `decompiled\`）

- 与 31 **共用三文件**：`gamefile\scripts\enemy\gundam\GundamBody2.as`（双运动系统/判定框组/SpeedUpSkill）＋`GundamAnimation2.as`＋`Gundam2_AI.as`——31.1 的差异全在 **Gundam2_AI 的 `openGundam3B` 分支**（:14 旗标、:32 shootPan 后坐滑步、:56-80 十步轮换+shoot_2 黑色炮+shoot_3 隐身、:176-193 攻击后强制 land+轮换推进+shoot_3 回合隐身）。
- 身体类映射：`gamefile\scripts\bodyGroup\BodyGroup.as:526`（"黑暗剑装审判者"→addGundam3 :838：XML" Gundam3"＋MC"Gundam3"＋**openGundam3B=true**＋push 进 Gundam2_arr）。
- 敌人表：`embedded-xml-assets\5_EmbedXml_xmlClass8_….bin` → **index 12 id=Gundam3（全数据条目）**：baseLife 5／motion 防／levelGrow 10000,5000,60000／imgList 与 31 同（含未用的 fly 组）／attackHitData 14 段（shoot_3 六段加长）。
- 敌方武器表：`embedded-xml-assets\4_EmbedXml_xmlClass9_….bin` → **id=Gundam3"高达的武器-黑色炮"**（motion/hurt 2/bulletLife 0.1/弹体 `sub/skill_laser_bullet`/**specialType=Stop_Laser**）。
- 定身特效消费：`gamefile\scripts\body\bullet\SpecialAttack.as:65`（`Stop_Laser()`＝英雄 `setReduceMul(0,2)` 定身减速 2 秒；分发点 LaserBody.as:42＋OneBulletBody.as:124；同族 Stop_Missile/Slow_Effect/UnableAttack_Missile）。
- 隐身实现：`Gundam2_AI.as` attackOrder `baba.img.visible=true`（每回合恢复）↔ openGundam3B shoot_3 回合 `img.visible=false`＋`lifeBar.visible=false`（attackOver 设定，下回合才现身）。
- 关卡表：`embedded-xml-assets\17_EmbedXml_xmlClass11_….bin` → **1-3-12 老友重逢（第八章 3，index 11，type="boss"）＝全表唯一出场**。
- 图鉴：`gamefile\scripts\UI\book\BookUI.as:108`（扩展段 concat 数组含"黑暗剑装审判者"，:110 reverse 后＝**第 74 位**）；权威清单 `..\图鉴顺序-BookUI.json`（82 条内）。

## 资源文件

- 当前仓：`swf\Gundam3.swf`（SHA-256 前 12 `C017BD351609`，1,043,528 字节；**2.5 无此文件＝3.4 加入**，比对 CSV"当前=3.4"组）。
- 原版 3.4：`D:\superalloy\原版\3.4（原版参考）\3.4素材库\raw\swf\enemy\Gundam3.swf`。
- 11.3 素材汇总：`D:\superalloy\原版\11.3超合金素材汇总\剑装审判2\`（**直配夹**，196 sprites——含 `538_fly__`/`539_fly`/`541___fly`/`549_stand` 等 fly 组＝AI 不使用的"搬了没搬全"物证）。
- 图鉴图标：第 74 位 BookUI760 内嵌 JPG——**未定位**（待补）。

## 文档与数据

- docx：**无本怪条目**（机器人介绍从剑装审判者段 165 直接跳炮装审判者段 171）。
- 三方比对数据：`D:\superalloy\TMP\敌人美术对比-20260928\`（CSV 行 index 12＝当前=3.4 组）。
- 权威图鉴顺序：`..\图鉴顺序-BookUI.json`（第 74 位）。

## 家族关联

- `..\31，剑装审判者\`（**本体档案**——换色源机：数值逐字段同、共用 GundamBody2 类；31 有悬浮态而 31.1 强制陆行）。
- `..\32，炮装审判者\`（待建——高达系三台唯一有真·战机形态者）。
- 定身系特效家族与回植注记见 `..\精英词条技能对照-20261003.md`（池外 label 体系）。
