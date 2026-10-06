# 调试插桩读 HeroCarDefine 未声明 name 致主武器命中 #1069（穿模无伤害+子弹不消失+卡顿）

> 建档日期：2026-10-07
> 状态：**已实施修复，待实机确认**
> 修复类型：最小范围缺陷修复（删除 4 行调试插桩，不改任何玩法数值、不改任何 SWF 资源）
> 事故定性：**插桩污染构建**——2026-10-06 凌晨排查会话留下的调试 trace 未清理，被 10-06 03:08 构建烤进 game.swf；属 2026-09-07 感应炮 laserPoint 事故（`武器家族内容\主武器家族\玄武家族（感应炮）\特效复古任务\感应炮laserPoint安全读取修复-20260907.md`）的**同型再发**，且再次验证其教训："空值检查防不了 sealed 类缺属性，必须 hasOwnProperty"。

---

## 一、现象与复现链

**用户报告（2026-10-07 早）**，metalwartale3-main 工作区（main 分支）的构建里：

1. **所有主武器打敌人直接穿过去**：命中特效照常播放，但零伤害、子弹不消失，"像给所有武器挂了贯穿（穿透）特殊属性，但没有伤害判定"；
2. **伴随卡顿**：持续射击时明显顿挫；
3. **只有主武器中招**：副武器（浮游战机 SubBody）完全正常——正常伤害、正常死亡、子弹正常消失；
4. **前兆**：当天早些时候打新手教程，**罗杰中尉的武器先短暂出现同样穿模**，一阵后消失，未引起注意；
5. **A/B 对照（用户实测）**：同机同日，`metalwartale3-reborn.git`（port/dev-chain-v2 分支，09-21 构建的 game.swf）**完全正常**——主副武器全部正常伤害与销毁。故该 bug 为 main 工作区特有；
6. **错误日志实锤**：`build\saves\client_errors.log` 在用户测试时段爆发 `ReferenceError: Error #1069`（属性不存在）风暴——02:51/02:53、05:18~05:21、05:43 三场，频率 1~2 秒一条＝射击节奏；**10-06 全天零记录**（插桩构建 03:08 才生成，02:51 是它第一次被游玩）。正式版播放器吞掉错误栈（stack=null），与 9-07 档案记载的观测一致。

**用户两个推测的裁定**（排查时提出）：

- ❌ "猛犸战神/激光战神苏拉的束能免疫触发"——时间巧合。两怪免疫束能造成 0 伤害是设计行为，但子弹应撞上即消失、从不穿模；且日志证明风暴始于 02:51，早于用户测两怪（档案提交 04:10 之后）。正常版里同场景不复现亦是佐证。
- ❌ "建支线提取时出了问题"——分支代码本身没问题。凶器是**从未提交到任何分支的工作区未提交改动**（见第三节）。

## 二、排查过程（证据链）

1. **错误日志定踞**：`client_errors.log` 按小时统计 #1069——历史上仅 08-19（67 条）与 09-07（413 条，即感应炮 laserPoint 事故）两场风暴，09-08 起一个月干净，**10-07 02:xx 重现**。10-06（旧构建最后一次游玩日）零记录→锁定 10-06 03:08 构建为嫌疑对象。
2. **A/B 全量 diff 定范围**：用 ffdec 把两个 game.swf 的**全部脚本**导出逐文件对比（损坏版＝main 工作区 10-06 03:08 构建；正常版＝reborn.git dev-chain-v2 09-21 构建）——差异**有且仅有 11 个文件**，恰为 main 工作区那批未提交插桩（见第三节清单）。FFDec 重编译回归排除（损坏版导出的 EventGroup/BodyGroupHit/GameData 与源码逐行一致）。
3. **11 文件逐一核对属性声明**：每帧/每命中会执行的插桩只有 `[hurt]`（EventGroup）/`[fx]`（EffectGroup）/`[anim]`（MultipleImage）三处。`[fx]` 只拼参数字符串、`[anim]` 读的 `SingleMovieclip.father/label` 均有声明——**唯一会炸的是 `[hurt]`**：它读 `b0.define.name` 与 `b1.define.name`。
4. **属性声明核查（根因闭合）**：
   - `EnemyDefine` 继承 `LifeBodyDefine`（**有 `name`**）→ 敌人受害/副武器攻击方均安全；
   - **`HeroCarDefine`（`body/hero/HeroCarDefine.as`）＝无父类 sealed 类，只有 `hitEffectImg` 一个字段，没有 `name`**；
   - **`ThingsDefine`（`scene/things/ThingsDefine.as`）＝同样无父类无 `name`**（场景物件受害时也会炸）。

## 三、根因（完整因果链）

### 3.1 插桩从哪来

2026-10-06 00:00~02:43，某排查会话为音乐/等离子护盾/噪声考问题在 11 个文件里植入调试 trace 与行为改动（`git status` 一直未提交）：

| 文件 | 改动 | 每命中会执行且不安全？ |
|---|---|---|
| **gameAll/EventGroup.as** | **`hurt()` 顶部新增 `[hurt]` 伤害日志** | **★是——本次事故直接根因** |
| scene/things 无关；body/hero/HeroCarBody.as | `[plasma]` trace＋`new Error().getStackTrace()` | 否（开盾才触发；有性能开销） |
| body/image/MultipleImage.as | `[anim]` trace（新登记补丁清单） | 否（father/label 有声明） |
| effect/EffectGroup.as | `[fx]` trace | 否（仅参数拼接） |
| body/key/KeysGroup.as | `[key]` trace | 否（仅 keycode） |
| bodyGroup/BodyGroup.as | prewarm 的 `gotoAndStop(1)` 改为 trace | 否（行为差异，非抛错） |
| gameAll/level/Levels.as、gameAll/order/EventOrderDefine.as、sound/SoundGroup.as | `[wave]`/`[spawn]`/`[snd]` trace | 否（EventOrderUnit.name/type 有声明） |
| Game.as、net/SWFLoaderManager.as | 音乐空判/静音/SoundMixer.stopAll | 否（功能改动） |

`config\build\swf-script-patches.txt` 同批新增 `MultipleImage.as`、`EventOrderDefine.as` 两项登记；**10-06 03:08 `构建.bat` 将上述全部烤进 build\game.swf**——插桩从未经用户确认，也未走"试玩→清理→再构建"流程，直接进了游玩产物。

### 3.2 抛错点与三症状机理（与 9-07 档案同型）

主武器（战车炮）子弹的 `attackBody`＝`HeroCarBody`（`HeroCarBody.as:89` 创建唯一 ArmsAttack；`ArmsAttack.as:92` 赋给子弹）。命中结算链：

```text
BodyGroupHit.bulletHit_body → 命中判定成立
  → BodyGroupHit.bulletHited:496  生成命中特效            ← 用户看得到 ✓
  → bulletHited:505  eventGroup.hurt(b0=敌人, b1=HeroCarBody, …)
      → EventGroup.hurt 顶部插桩（当时 :872-875）读 b1.define.name
        → b1.define 是 HeroCarDefine（sealed，无 name）→ ReferenceError #1069 ✗
      → 异常上抛：:1103 敌人扣血 b0.define.nowLife -= hurt0 永远执行不到 ← 无伤害 ✗
  → 回到 bulletHit_body:325  bullet0.toDie() 被异常跳过      ← 子弹永生 ✗
  → 刷新循环（BodyGroupRefresh）无 try/catch → 每帧中断/子弹堆积反复碰撞 ← 卡顿 ✗
```

`!= null` 空值检查挡不住 sealed 类缺属性——必须 `hasOwnProperty("name")`（9-07 教训原文）。

### 3.3 主/副武器不对称的机理（本 bug 最烧脑处的解释）

| 攻击方 | b1（attackBody） | b1.define 类 | 有无 `name` | 结果 |
|---|---|---|---|---|
| 主武器（战车炮，所有主武器） | HeroCarBody | **HeroCarDefine** | **无** | **每炮必炸** |
| 罗杰中尉（LieutenantBody，`LieutenantBody.as:26`） | LieutenantBody | **HeroCarDefine** | **无** | **必炸**（教程前兆） |
| 副武器浮游战机（SubBody，`SubBody.as:16`） | SubBody | EnemyDefine→LifeBodyDefine | 有 | 正常 |

用户"不知道是不是所有的主武器"——答案：**全部主武器都中招**（存档实证：灾变巨刃 magneticTrack_lv5、小黄豆 soya_lv1 两个槽位的主武器全炸，两武器 bulletType 均为 bullet，与武器个体无关）；副武器体系（SubBody）天然免疫。罗杰中尉"出现一阵又消失"＝教程初期他自动开火且场景内有路障/物件（ThingsDefine 同样无 `name`，命中物件也炸），进入后续阶段后目标/场景变化，观感上"消失了"。

## 四、修复方案与决策点

- **方案A（采纳，用户 2026-10-07 拍板）**：整块删除 `EventGroup.as` 的 `[hurt]` 插桩 4 行。该文件相对 HEAD 仅有此一处改动，删除后与 HEAD 完全一致（`git diff` 为空），等于精确回滚污染源。
- 方案B（未采纳）：按 9-07 修法加 `hasOwnProperty("name")` 守卫保留日志——用户不需要这条日志，最小改动原则下选 A。
- **遗留清理项（本轮不动，待后续批次）**：其余 10 个文件的插桩已逐一核验类型安全（不会抛错），本轮保留；但①`[plasma]` 的 `getStackTrace()` 每次开盾构造栈字符串有性能开销；②插桩本不该进游玩构建——"插桩必须随排查会话结束清理、未经确认不构建进产物"应作为纪律执行（见第七节）。

## 五、实际修改文件

| 文件 | 修改 |
|---|---|
| `decompiled\gamefile\scripts\gameAll\EventGroup.as` | 删除 `hurt()` 顶部 `[hurt]` 插桩 4 行（原 :872-875），文件恢复与 HEAD 一致；补丁清单登记不变（原有 L4） |

## 六、构建与验证证据

| 步骤 | 结果 |
|---|---|
| 源码回核 | `git diff EventGroup.as` 为空＝与 HEAD 逐字一致；`grep -c "\[hurt\]"` ＝ 0 |
| 构建 | `构建.bat`（唯一构建入口）退出正常，`[OK] Pure BAT build completed`，`[OK] Runtime resources prepared: 175`，产物核验 `[OK] Core build artifacts validated` |
| 新产物 | `build\game.swf` 1,168,466 字节，2026-10-07 06:30，SHA-256＝`1ABDEEB5F4CDCD565AAD875AA1D6F4523DDDFBF1D93C528AB98A6B5F64CD4759` |
| ffdec 回读 | `-selectclass gameAll.EventGroup -export`：`[hurt]` 出现次数 **0**；伤害结算行 `b0.define.nowLife -= hurt0` 在位（:1098） |
| 对照证据链 | 损坏版（10-06 03:08，1,168,559 字节）与正常版（dev-chain-v2 09-21 构建）全量脚本 diff＝11 个插桩文件；本修复移除其中唯一抛错源 |

## 七、待实机确认项

- [ ] 进入任意有敌人关卡（建议 149 或新手教程），**主武器**射击：① 敌人正常掉血死亡；② 命中后子弹正常消失、不再穿模；③ 无周期性卡顿；
- [ ] 罗杰中尉武器（新手教程）射击正常；
- [ ] 打一场含**可破坏物件**（路障/箱子）的关卡，确认子弹撞物件正常消失；
- [ ] 副武器（浮游战机）回归正常（本就正常，回归确认）；
- [ ] `build\saves\client_errors.log` 打开错误报告后游玩一段，**不再新增 #1069**。

## 八、教训沉淀（写给我们自己）

1. **调试插桩三纪律**：①排查会话结束必须清理插桩，或显式移交；②未确认的插桩不得构建进游玩产物（本次 10-06 03:08 构建直接带伤上岗）；③读对象属性前用 `hasOwnProperty` 而非 `!= null`——sealed 类缺属性抛 #1069，与值是否为 null 无关。
2. **#1069 排查路径已两次验证**：`client_errors.log` 风暴节奏对齐触发频率（本次＝射击节奏，9-07＝敌方激光攻击节奏）→ 正式版无栈，按"sealed 类读未声明属性"枚举命中链属性读取→核对每个类的声明（含父类）。
3. **同型事故二连**（9-07 laserPoint / 本次 [hurt] trace）说明：命中结算链（`BodyGroupHit → bulletHited → EventGroup.hurt`）是全游戏对"属性存在性"最敏感的路径，任何新代码进这条链前先过一遍属性声明核对。

## 九、快速定位索引

```text
现象证据   build\saves\client_errors.log（10-07 02:51/05:18/05:43 三场 #1069 风暴，10-06 全天零记录）
根因代码   decompiled\gamefile\scripts\gameAll\EventGroup.as（[hurt] 插桩，已删；原 :872-875）
缺属性类   decompiled\gamefile\scripts\body\hero\HeroCarDefine.as（无 name）
           decompiled\gamefile\scripts\scene\things\ThingsDefine.as（无 name）
有属性对照 body\define\LifeBodyDefine.as:13（name，EnemyDefine 继承自此）
断裂机理   BodyGroupHit.as:496（特效）→ :505（hurt）→ EventGroup.hurt 顶部抛错 → :1103 扣血不执行 → BodyGroupHit.as:325 toDie 被跳过
同型前案   更新总结\武器家族内容\主武器家族\玄武家族（感应炮）\特效复古任务\感应炮laserPoint安全读取修复-20260907.md
修复产物   build\game.swf SHA-256 前缀 1ABDEEB5（2026-10-07 06:30）
```
