# 34 拦截机1号 · 文件索引与介绍

> 本夹档案：`拦截机1号-档案-20261005.md`（普通怪·月球危机量产空军）。本 README＝该怪全部相关文件的索引字典。
> 表名＝图鉴名"拦截机1号"；代码 id `Interceptors_1`（index 70）。⚠️ 与 36 拦截机2号（Interceptors_2）为同名异构对，勿混。
> 归属：`34~41月球怪物合集\` 战役卷分档（2026-10-05 用户裁定月球 8 怪单独立卷、押后队尾，本档自根目录迁入；战役总纲见 `..\README.md`）。

## 代码文件（仓库 `decompiled\`）

- **无专属类**——通用空军体系：`gamefile\scripts\enemy\_normal\Normal_FlyBody.as`（208 行）＋`Normal_Fly_AI.as`（29 行，followFilp 每 2 tick 蛇行翻转＋chooseAttack 按武器数选招）＋`Normal_AAHD.as`/`Normal_Animation.as`。
- 生成路径：`gamefile\scripts\bodyGroup\BodyGroup.as` getUnit **默认分支**（`getEnemyDefine_byCnName`→`isAir`→`addNormal_Fly(e_d0.id,...)`——无中文名 switch 项的怪都走此路径）。
- 敌人表：`embedded-xml-assets\5_EmbedXml_xmlClass8_….bin` → **index 70 id=Interceptors_1**（imgList 4 态/baseLife 2/单倍奖赏/energy 防/vx 240~300）。
- 敌方武器表：`embedded-xml-assets\4_EmbedXml_xmlClass9_….bin` → **index 内 id=Interceptors_1"45对地炮"**（energy/hurt 0.2/angle 45/shootNum 2/弹体 `Interceptors_1/bullet1`）。
- 关卡表：`embedded-xml-assets\17_EmbedXml_xmlClass11_….bin` → **24 关全在 1-4（第十章~第十四章）**；1-4-0/1-4-1/1-4-12 champion 亮相；1-4-8/1-4-69 峰值 16 架。
- 图鉴：`gamefile\scripts\UI\book\BookUI.as:105`（顺序数组第 34 位"拦截机1号"）。

## 资源文件

- 当前仓：`swf\Interceptors_1.swf`（152843 字节；**仅当前存在**——2.5/3.4 库无此文件）。
- 11.3 素材汇总：**无直配夹**（`拦截机二号\` 夹属 36 号）。
- 图鉴图标：BookUI760 内嵌 JPG——**待定位**。

## 文档与数据

- docx：**无条目**（机器人介绍零提及拦截机系——资料不详）。
- 三方比对数据：`D:\superalloy\TMP\敌人美术对比-20260928\`（CSV 行 index 70＝**仅当前存在组**）。
- 权威图鉴顺序：`..\..\图鉴顺序-BookUI.json`（第 34 位）。

## 家族关联

- `..\36，拦截机2号\`（**同卷待建**——Interceptors_2/index 72，**三方互异 7 怪之一**＝11.3 补音效工程对象；武器"45度切割"hurt 0 空炮；声东击西（第十章 3）亮相型 boss；素材夹"拦截机二号"）。
- 同为月球危机量产空军语境：天隼（6 号，setToBomb 轰炸模式）/游隼（5 号）——1-4 章空军组合的成员。
