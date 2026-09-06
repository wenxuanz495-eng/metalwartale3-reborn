# 感应炮 laserPoint 安全读取修复（ReferenceError #1069 刷屏）

> 修复日期：2026-09-07（凌晨）
> 修复类型：最小范围缺陷修复（不改任何玩法数值、不改任何 SWF 资源）
> 关联文档：《感应炮激光结构权威档案-20260907.md》第九节遗留事项第 1 条（敌方 AAHD laserPoint 属性排查）——本次已排查并修复，可勾选。
> 版本基准：`metalwartale3-reborn.git` 工作区（2.4.2 之后开发前沿，未提交批次）

---

## 一、故障现象

用户报告后台正在运行的 Flash 游戏（最小化）出现"卡顿"和"疑似重复播放"问题。诊断（只读排查，未动任何文件）发现：

- 游戏进程：`FlashPlayer.exe` PID 40776，2026-09-07 04:37:21 经 `超合金战记启动器.exe` 启动（server 端口 58100，单实例，非多开）；
- `build\saves\client_errors.log` 记录：**04:52:51 起（进入关卡 149、写盘 game_save.bin 之后 0.5 秒）每约 1.5 秒一条 `kind=uncaught message=ReferenceError: Error #1069 stack=null`，持续刷屏不停**（至诊断时已 160+ 条）；
- 04:37–04:52 主界面阶段十五分钟零错误，说明问题只在战斗内、由周期性开火行为触发；
- 正式版播放器（tools\runtime\FlashPlayer.exe 34.0.0.330）抑制错误详情，只有 "ReferenceError: Error #1069"；历史上 debug 会话的同类记录证明该错误沿 `attackTimer → bodyTimer → BodyGroupRefresh/refreshTimer(2) → XTimer/FTimer → Game/allTimer` 主定时器一路上抛。

## 二、根因

### 2.1 引入点（2026-09-06 批次，未提交）

为感应炮激光增加上管口出射点时，`ArmsAttack.shootNow()` 新增了分支：

```actionscript
var p0:Point = this.AAHD.shootPoint;
if(d.bulletType == "laser" && this.AAHD.laserPoint is Point)   // ← 新增读取
{
   p0 = this.AAHD.laserPoint;
}
```

`this.AAHD` 声明为无类型 `*`，属性在**运行时**对实例的实际类解析。AS3 中 **sealed 类（非 dynamic）读不存在的属性即抛 ReferenceError #1069**。`MovieClip` 是 dynamic（读缺失属性只会得到 undefined），但本项目相关类多数是 sealed 的普通类/Sprite 子类，所以会真实抛错。

### 2.2 断裂路径一：敌方激光武器 × 敌方 AAHD（本次刷屏的直接来源）

- 敌方武器配置 `decompiled\embedded-xml-assets\4_EmbedXml_xmlClass9_EmbedXml_xmlClass9.bin`（enemyArms）中有 **18 种 `bulletType=laser` 武器**：
  AirLaserFort（自动浮游激光炮）、LandLaser、Sula_Laser、AtomicTower2（原子塔-声波炮）、Gundam_land / Gundam3 / Gundam_fly_1 / Gundam_fly_2（高达玛格兰炮系）、TercelFighter（游隼战机）、Tank_3、Tires_2、Knowing / heianxianzhi（闪电球）、LoadKing2（爆炸球）、Skill_Laser / Skill_Laser2（激光十字架）、Interceptors_1（45对地炮）、Ground_laser（激光横扫）。
- 敌方炮台/战机单位共 **11 个 AAHD 类**（`decompiled\gamefile\scripts\enemy\` 下 airLaserFort / atomicTower / bansheeFighter / charger / drilling / electricSaw / gundam×2 / rolling / spider 等），全部继承 `AttackAndHurtData`（sealed），**全都没有 laserPoint 属性**。
- 于是敌方激光单位**每开一炮**：`d.bulletType == "laser"` 为真 → 读 `this.AAHD.laserPoint` → #1069。本次关卡 149 里的激光敌人攻击间隔约 1.5 秒，与刷屏节奏完全吻合。

### 2.3 断裂路径二：激光副武器 × SubImage（本次未触发，但结构上同样会炸）

- 副武器 `SubBody`（`body\hero\SubBody.as:47`）也使用 `HeroCarAAHD`；
- `HeroCarAAHD.laserPoint` getter 原实现是 `return this.baba.img.laserPoint;`，而 SubBody 的 `img` 是 **`SubImage`（`extends Sprite`，sealed，没有 laserPoint）** → 同样抛 #1069；
- 副武器配置 `6_EmbedXml_xmlClass7_EmbedXml_xmlClass7.bin`（sub）中有两种 laser 副武器：`laser`（战殇）、`hotline`（炽天使）。当前存档未装备副武器所以本次没踩，但一旦装备开火必炸。

### 2.4 两个症状的机理（同根因）

- **卡顿**：`BodyGroupRefresh.refreshTimer/refreshTimer2`（`bodyGroup\BodyGroupRefresh.as:27-56`）循环内**没有 try/catch**，一个单位抛异常会中断当帧整个刷新循环——排在其后的所有单位、以及主定时器 `Game.allTimer` 里排在刷新之后的任务（能量回复等）全部跳过。每 ~1.5 秒丢一帧 = 周期性顿挫。
- **重复播放**：敌方激光单位的攻击动画/音效（`imgAttackOnce` 先触发）每周期照常播放，但 `shoot()` 因异常未执行——激光永远打不出来，炮口动画和音效反复重播；主定时器被打断也会让部分动画/UI 重置重播。

### 2.5 未断裂的路径（修复不能破坏）

玩家自己的感应炮链路完整且正常：`HeroCarBody → HeroCarAAHD（有 getter）→ HeroCarImage.laserPoint → ArmsImage.laserPoint_rotation/_migration → SingleMovieclip.laserPoint`；敌方英雄 `EnemyHeroBody` 与 VIP 托管 `LieutenantBody` 的 img 均为 `HeroCarImage`，其子类 `NewHeroCarAAHD`/`LieutenantAAHD` 继承 getter，同样正常。

## 三、修复内容（两处最小修改）

### 3.1 `decompiled\gamefile\scripts\body\attack\ArmsAttack.as` — shootNow 加属性存在性守卫（L455）

修复前：

```actionscript
if(d.bulletType == "laser" && this.AAHD.laserPoint is Point)
```

修复后：

```actionscript
if(d.bulletType == "laser" && this.AAHD.hasOwnProperty("laserPoint") && this.AAHD.laserPoint is Point)
```

- 敌方 11 个 AAHD（无该属性）→ `hasOwnProperty` 为假 → 短路跳过，回落到 `shootPoint`，行为与加入 laserPoint 功能之前完全一致；
- `HeroCarAAHD` 系（getter）→ `hasOwnProperty` 为真 → 原逻辑不变；
- 玩家感应炮出射点不受影响。

### 3.2 `decompiled\gamefile\scripts\body\hero\HeroCarAAHD.as` — laserPoint getter 加 img 类型守卫（L38-46）

修复前：

```actionscript
public function get laserPoint() : Point
{
   return this.baba.img.laserPoint;
}
```

修复后：

```actionscript
public function get laserPoint() : Point
{
   if(!(this.baba.img is HeroCarImage))
   {
      return this.shootPoint;
   }
   return this.baba.img.laserPoint;
}
```

- `baba` 为 `SubBody`（img 是 `SubImage`）时回落 `shootPoint`（SubImage 自带 shootPoint，原 shootNow 无条件读取它一直正常），战殇/炽天使等 laser 副武器开火不再抛错；
- `HeroCarImage` 与 `HeroCarAAHD` 同包 `body.hero`，无需新增 import；
- 玩家/敌方英雄/VIP 托管的 img 均为 `HeroCarImage`，原路径不变。

### 3.3 设计取舍说明

- 未选择给 11 个敌方 AAHD 和 SubImage 逐个补属性：改动面大（12+ 文件）、易漏（未来新增敌方类仍会踩），违背"最小范围"原则；
- 未选择 try/catch 吞错：会掩盖未来真实的属性链错误；`hasOwnProperty` + `is` 白名单把回落语义写明在代码里；
- 两处守卫互补：3.1 挡住"AAHD 自己没有属性"（敌方），3.2 挡住"AAHD 有 getter 但 img 链断"（副武器），合起来覆盖全部已知的 #1069 路径。

## 四、构建与验证记录（2026-09-07 05:0x）

| 步骤 | 命令 | 结果 |
|---|---|---|
| 重构 game.swf | `scripts\build_swf.bat` | 退出码 0；118 脚本导入、7 BinaryData 替换；新 `build\game.swf` SHA-256 = `5253ED10FDE7BEBDF09EBA735D01FB5BD124D2CF6D2C5CD9A02F6D68C6722793`（1165190 字节） |
| 同步运行时 | `scripts\prepare_build_runtime.bat` | `[OK] Runtime resources prepared: 175` |
| 启动自检 | `scripts\launch_game.bat --check sa` | `[OK] Pure BAT game prerequisites are ready.` |
| 产物回读验证 | `ffdec-cli -selectclass body.attack.ArmsAttack,body.hero.HeroCarAAHD -export script build\verify-fix-20260907 build\game.swf` | 两类导出成功，`shootNow` 含 `hasOwnProperty("laserPoint")` 守卫、getter 含 `is HeroCarImage` 守卫，均已编入正式 SWF |

- 两个文件此前已登记在 `config\build\swf-script-patches.txt`（L65 `body\attack\ArmsAttack.as`、L114 `body\hero\HeroCarAAHD.as`），本次修改无需改登记；
- 因用户会话正在运行、`build\server.exe` 被锁定，本次跳过了 server/launcher 重编译（与本次修复无关），只执行 SWF 构建链；
- 回读验证产物保留于 `build\verify-fix-20260907\`。

## 五、影响面清单

**被修复（不再抛 #1069、不再中断主定时器）：**

- 18 种敌方 laser 武器的所有携带单位（关卡中每 ~1.5 秒一次的刷屏与顿挫消失）；
- laser 副武器"战殇"（`laser`）与"炽天使"（`hotline`）装备开火（此前一旦装备必炸，属预防性修复）。

**行为变化：**

- 敌方激光武器与 laser 副武器的**出射点回落为 shootPoint**（与 laserPoint 功能加入前的原行为一致）；它们本来就没有上管口语义，不构成视觉回归；
- 玩家感应炮四形态、敌方英雄 AI 感应炮、VIP 托管的激光出射点**完全不变**（仍走上管口 laserPoint）。

## 六、遗留事项与建议

- [ ] **实机验证**（建议按《感应炮激光结构权威档案》第六节清单一并做）：进入关卡 149 或任意含浮游激光炮/原子塔/高达的关卡，确认：① `build\saves\client_errors.log` 不再新增 #1069；② 敌方激光武器能正常射出激光（回落 shootPoint 出射，视觉上激光从其本来的炮口出发）；③ 无周期性顿挫；④ 装备战殇/炽天使开火无异常；
- [ ] 诊断时正在运行的旧实例（04:37 启动，PID 40776）内存中仍是旧 game.swf，**需关闭并重新启动游戏**才会加载修复版；
- [ ] 《感应炮激光结构权威档案-20260907.md》第九节第 1 条"敌方 AAHD laserPoint 属性排查（#1069）"已由本次完成，可勾选并补注指向本文；
- [ ] 本次修复属于感应炮批次未提交改动的一部分，随批次一起提交（勿单独 `git reset --hard`，红线 #9）。

## 七、快速定位索引

```text
现象证据   build\saves\client_errors.log（2026-09-07T04:52:51 起每 ~1.5s 一条 #1069）
根因代码   decompiled\gamefile\scripts\body\attack\ArmsAttack.as:455
           decompiled\gamefile\scripts\body\hero\HeroCarAAHD.as:38-46
扩异常路径  decompiled\gamefile\scripts\bodyGroup\BodyGroupRefresh.as:27-56（无 try/catch 的刷新循环）
敌方配置   decompiled\embedded-xml-assets\4_EmbedXml_xmlClass9_...bin（18 种 laser）
副武器配置 decompiled\embedded-xml-assets\6_EmbedXml_xmlClass7_...bin（laser/hotline 两种）
敌方 AAHD  decompiled\gamefile\scripts\enemy\*\*AAHD.as（11 个，均无 laserPoint）
副武器断点 decompiled\gamefile\scripts\body\hero\SubBody.as:47 + SubImage.as（sealed Sprite）
构建产物   build\game.swf（SHA-256 前缀 5253ED10，2026-09-07 05:06）
回读验证   build\verify-fix-20260907\scripts\...
```
