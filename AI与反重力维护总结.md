# 超合金战记 3 维护总结

更新时间：2026-08-19

代码库：`D:\superalloy\metalwartale3-reborn.git`

这份文件用于把本次反重力重构和 AI 维护所需的上下文交接给后续对话。除非明确需要，不要恢复旧的 `OneSkill` 跳跃时间分支，也不要把玩家、托管 AI、罗杰中尉和敌方单位的跳跃逻辑混为一谈。

## 当前反重力模型

当前版本采用独立的充能型反重力状态，状态放在已有的 `HeroCarBody` 中，没有启用新的 `AirGravitySkill` ABC 类注入。

主要文件：

- `decompiled/gamefile/scripts/body/hero/HeroCarBody.as`
- `decompiled/gamefile/scripts/body/hero/HeroCarKey.as`
- `decompiled/gamefile/scripts/body/motion/BodyMotion.as`
- `decompiled/gamefile/scripts/UI/gaming/SkillIcon.as`
- `decompiled/gamefile/scripts/UI/gaming/SkillIconBox.as`
- `decompiled/gamefile/scripts/body/skill/SkillGroup.as`
- `decompiled/gamefile/scripts/body/skill/SkillDefine.as`

### 两种不同的次数限制

1. **最大储备次数**

   `HeroCarBody.configureAirGravitySkill()` 从跳跃技能等级的 `levelDefine.maxNum` 读取最大储备次数。技能等级最高为 20 时，最多储备 20 次。这个值不能被错误地改成 10。

2. **单次浮空使用次数**

   `BodyMotion.airJumpNow` 只记录本次离地后的反重力推进次数。

   - `BodyMotion.toAirGravity()` 每调用一次就递增 `airJumpNow`。
   - `HeroCarBody.canUseAirGravity()` 要求 `airJumpNow < 10`，所以一次浮空最多使用 10 次。
   - `BodyMotion.motionTimer()` 检测到落地时把 `airJumpNow` 清零。
   - 地面起跳使用 `mot.toJump()`，不消耗反重力储备，也不计入这 10 次。

3. **恢复机制**

   `HeroCarBody.airGravityTimer()` 每 30 FPS 运行一次，每次消耗后按独立恢复时间逐次恢复储备次数。恢复的是储备次数，不会改变一次浮空最多 10 次的限制。

4. **图标显示**

   `SkillIconBox.fleshData()` 对 `jump` 单独调用 `SkillIcon.inAirGravityData()`：

   - 数字显示当前储备次数，而不是浮空剩余次数。
   - 储备未满时显示恢复扇形。
   - 储备满时隐藏恢复扇形。

## AI 入口与罗杰中尉

### 普通玩家和托管 AI

普通战车 `HeroCarBody` 同时创建：

- `Hero_AI`
- `HeroLevel_AI`
- `HeroArena_AI`
- `HeroCarKey`

这些 AI 的跳跃调用最终可能进入 `HeroCarKey.toJump()` 或 `HeroCarKey.useSkillName("jump")`，因此会受到 `HeroCarBody.consumeAirGravity()` 和单次浮空 10 次限制的影响。

需要重点检查的文件：

- `decompiled/gamefile/scripts/body/hero/Hero_AI.as`
- `decompiled/gamefile/scripts/body/hero/HeroLevel_AI.as`
- `decompiled/gamefile/scripts/body/hero/HeroArena_AI.as`
- `decompiled/gamefile/scripts/body/hero/HeroCarKey.as`

托管 AI 目前仍可能在多个条件分支中重复请求跳跃。后续维护时应先记录每个调用点的触发条件、冷却/计时器和 `mot.vy`/障碍检测，再决定是否降低调用频率；不要直接修改公共反重力充能代码来掩盖 AI 判定问题。

### 罗杰中尉

罗杰中尉使用另一套类，不等同于普通玩家：

- `decompiled/gamefile/scripts/body/lieutenant/LieutenantBody.as`
- `decompiled/gamefile/scripts/body/lieutenant/LieutenantKey.as`
- `decompiled/gamefile/scripts/body/lieutenant/Lieutenant_AI.as`

当前事实：

- `LieutenantBody` 构造时创建 `LieutenantKey` 和 `Lieutenant_AI`。
- `LieutenantBody` 初始化技能等级为 `[4,4,4,0,0]`，其中跳跃技能等级为 4。
- `LieutenantKey.toJump()` 在地面调用 `mot.toJump()`；空中仍使用旧的 `mot.jumpNow < 2` 判断，然后再次调用 `mot.toJump()`。
- `Lieutenant_AI.toJump()` 根据 `mot.jumpNow` 和旧的 `skill.jump.nowNum` 决定是否继续跳跃，并带有随机的 `jumpNum` 行为。
- 这套中尉逻辑目前没有直接调用玩家 `HeroCarBody.consumeAirGravity()`，也没有自动继承玩家的 `airJumpNow < 10` 限制。

因此，后续如果要修复“罗杰中尉不断向上飞”或 VIP 托管反重力调用过密，必须先决定是：

1. 让中尉迁移到统一的独立反重力接口；或
2. 在 `LieutenantKey`/`Lieutenant_AI` 内单独增加与其角色规则匹配的浮空次数和落地重置。

不要只修改 `HeroCarBody`，否则对罗杰中尉不会生效。

## 2.5 版本参考结论

参考目录：`D:\superalloy\原版\2.5（原版参考）\2.5版本代码库`

2.5 的关键结构是：

- 技能对象的 `jump.maxNum` / `jump.nowNum` 管理可用储备和恢复。
- 运动体的 `jumpNow` 管理当前跳跃序列，在重新落地时清零。
- 地面跳跃与空中追加跳跃通过运动体状态区分。
- 中尉和敌方单位有各自的 `Key`、`AI`、`Body`，不能仅凭玩家逻辑推断其行为。

当前版本使用 `airJumpNow` 复现“当前浮空序列计数”的概念，但没有把 2.5 的整套旧 `OneSkill` 跳跃实现恢复回来。

## 构建与验证

最近一次成功构建：

```text
Scripts imported : 97
BinaryData patched: 6
SHA256=a662221390d621be3c844a834059873bec67a8cc5a339cecedb1842e00d1d347
```

启动级 smoke test 已通过。此前出现过的两个问题已经处理：

- 新增 ABC 类会导致 `VerifyError #1014`，因此独立状态放回已有类。
- `BodyMotion.toAirGravity()` 未加入脚本补丁清单会导致 `ReferenceError #1069`，当前已加入 `config/build/swf-script-patches.txt`。

构建命令：

```text
scripts\build_swf.bat
scripts\launch_game.bat --smoke sa_debug
```

## 后续 AI 维护建议

1. 先分别画出 `Hero_AI`、`HeroLevel_AI`、`HeroArena_AI`、`Lieutenant_AI` 的跳跃调用图，不要先改公共运动代码。
2. 为每个调用点记录：是否检测 X/Z（或对应平面坐标）、是否把敌人误判为障碍物、是否检测 `mot.vy`、是否有延迟/重复定时器。
3. 单独验证过场动画、VIP 托管、序章平地和普通关卡四种场景。
4. 任何 AI 频率调整都应保持反重力储备、单次浮空 10 次限制和地面跳跃互不影响。
5. 修改 UI 时阅读根目录的 `【重要必读】修改UI后卡在旧加载界面.md`，避免重新引入旧加载界面问题。
6. 端游验证稳定后，再把经过确认的对应逻辑移植到 `D:\superalloy\metalwartale3-reborn-mobile`，不要直接复制未验证的 SWF 补丁。

