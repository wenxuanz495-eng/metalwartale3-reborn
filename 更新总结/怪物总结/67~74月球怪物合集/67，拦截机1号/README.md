# 34 拦截机1号 · 文件索引与介绍

> 本夹档案：`拦截机1号-档案-20261005.md`（普通怪·月球危机量产空军；2026-10-05 全量复核重写）。本 README＝该怪全部相关文件的索引字典。
> 表名＝图鉴名"拦截机1号"；代码 id `Interceptors_1`（3.4/4.0 index 7 → 11.3 index 70）。⚠️ 与 36 拦截机2号（Interceptors_2）为同名异构对，勿混。
> 归属：`67~74月球怪物合集\` 战役卷分档（2026-10-05 用户裁定月球 8 怪单独立卷、押后队尾；战役总纲见 `..\README.md`）。

## 代码文件（仓库 `decompiled\`）

- **无专属类**——通用空军体系：`gamefile\scripts\enemy\_normal\Normal_FlyBody.as`（208 行）＋`Normal_Fly_AI.as`（29 行，followToPoint 每 2 tick followFilp 蛇行翻转）＋`Normal_AAHD.as`/`Normal_Animation.as`。
- **双武器选招＝通用逻辑**：`gamefile\scripts\enemy\AI\Enemy_AI.as` chooseAttack（`Math.random()*armsNum` 每次攻击随机二选一，选中后 rectLevel=grapRectIndex 切侦测窗）——与游隼 05 双武器切换同族。
- 生成路径：`gamefile\scripts\bodyGroup\BodyGroup.as` getUnit **默认分支**（全文无"拦截机"字样→`getEnemyDefine_byCnName`→`isAir`→`addNormal_Fly`）。
- 敌人表：`embedded-xml-assets\5_EmbedXml_xmlClass8_….bin` → **index 70 id=Interceptors_1**（imgList 4 态/baseLife 2/单倍奖赏/energy 防/vx 240~300/hitRect+双 hurtRect+双 grapRect+hoverRect/affterAttack=hoverAndAttack/nextAttackTime 六档；**3.4/4.0 内嵌表同条目＝index 7，与 11.3 逐字节相同**）。
- 敌方武器表：`embedded-xml-assets\4_EmbedXml_xmlClass9_….bin` → **arms index 100086 id=Interceptors_1，两个 armsLevel＝双武器**：①"45对地炮"（energy/hurt 0.2/45° 上抛/shootNum 2+shootGap 0.2 两连发/弹体 `Interceptors_1/bullet1`/grapRectIndex 0 朝天窗）；②"自动浮游激光炮的武器"（借名/laser/水平/penetrationB=1 贯穿/hurt 0.1/grapRectIndex 1 前向 365 宽窗）。
- 关卡表：`embedded-xml-assets\17_EmbedXml_xmlClass11_….bin` → **24 关全在 1-4（第十章~第十四章），个体总数 218 只**；champion＝1-4-0（3 线 4 只）/1-4-1（×2）/1-4-12（×1）；单关最多 1-4-2 声东击西 32 只；number=16 同屏峰值＝1-4-8/1-4-53/1-4-69；**8 关 specialClass=`gameAll.level.Level_2_5`＝12 分钟限时闯关剧本**（禁复活水晶）＝1-4-24/38/50/53/69/75/77/98。
- 掷骰名单：`gamefile\scripts\gameAll\GameDefine.as:212/214`——noSuperList/nolyChampionList 均不含本怪（量产怪掷骰全开放）。
- **无专属音效来源**：音效全在本体 swf（3 段 MP3：die/shoot1 对地炮/shoot2 激光）；**登场"巨大噪声"＝全局公共音效对**，音源＝`swf\sound.swf`（23 标签公共音效库）：`enemy_coming_larm`（锁屏报警 0.39s，触发＝`gameAll\level\Levels.as:228`）＋`enemy_coming_first`（解锁大音 2.87s，触发＝`scene\OneSence.as:502` unLockView）——全怪共用，2 号同款。SoundGroup 按标签取音（`sound\SoundGroup.as` playSound→`Game.swfLoaderManager.getResource("sound",label)`）。
- 音频样本导出：`D:\superalloy\TMP\拦截机音效对比\`（两机全部 MP3＋两段公共登场音，待用户试听指认）。
- 图鉴：`gamefile\scripts\UI\book\BookUI.as:105`（顺序数组第 34 位"拦截机1号"）；面板内容＝BookUI760.swf 内 enemyContent（**sprite 775，82 怪×6 帧一节，帧标签即怪名**，本怪标签在第 386 帧）。

## 资源文件

- 当前仓：`swf\Interceptors_1.swf`（152843 字节）。
- 4.0 库：`原版\4.0（原版参考）\4.0游戏\swf\enemy\Interceptors_1.swf`——**与当前仓逐字节相同**（md5 `b32187c52cd3a61cec623fd31cd60130`）；素材史＝3.4 数据在册素材缺件（3.4 swf/enemy 71 文件独缺它、Interceptors_2 在）→4.0 补装→11.3 沿用。
- 2.5/3.4 库：**均无此 swf**（`原版\2.5（原版参考）\2.5版本游戏\assets\`、`原版\3.4（原版参考）\3.4游戏\swf\enemy\`）——但 3.4 的 game.swf 内嵌数据层有它（⚠️ 勿据文件缺席断言怪物不存在）。
- 11.3 素材汇总：**无直配夹**（`拦截机二号\` 夹属 36 号）。
- 图鉴图标：**已定位**＝素材汇总`原版\11.3超合金素材汇总\百科ui\images\134.jpg`（90×90 蓝黄炮艇，与实机涂装一致；百科ui 夹＝BookUI760 图像导出库，定位法＝fly 帧色相直方图匹配）。

## 文档与数据

- docx：**无条目**（`世界观开发\规整档案\原版资料\原版机器人，角色介绍\超合金机器人介绍….docx` 全文部件词放宽复核零命中——资料不详）。
- 三方比对数据：`D:\superalloy\TMP\敌人美术对比-20260928\`（CSV 行 index 70＝"仅当前存在"系**文件层**结论，数据层 3.4 已在册——引用时注意口径）。
- 权威图鉴顺序：`..\..\图鉴顺序-BookUI.json`（第 34 位）。

## 家族关联

- `..\69，拦截机2号\`（**同卷待建**——Interceptors_2/index 72，**三方互异 7 怪之一**＝11.3 补音效工程对象；武器"45度切割"hurt 0 空炮；声东击西（第十章 3）亮相型 boss；素材夹"拦截机二号"；3.4 swf 在库）。两机代际互补：1 号数据先行素材迟到／2 号素材齐全 11.3 动刀。
- 同为月球危机量产空军语境：天隼（6 号，setToBomb 轰炸模式）/游隼（5 号）——1-4 章空军组合的成员。
