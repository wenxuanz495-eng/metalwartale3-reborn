# 手游HeroCarKey重写丢skillEnabled声明致教程技能教学卡死-20260920

> 记录日期：2026-09-20
> 归属：手游仓 `54ccbe6`（VIP托管AI反重力补全，HeroCarKey 采端游 AirGravity 版重写）引入的教程回归；端游仓留档（更新总结唯一归档区）。
> 状态：**已实施修复（构建回读 FOUND + 双自检 0 + 已装机），待真机确认**
> 用户报告：新手教程罗杰中尉介绍技能时卡住；用户事先怀疑反重力装置更新——判断方向正确，坏点随反重力/AI 批次进入，但不在次数制逻辑本身。

---

## 一、现象与复现链

- 手游真机（Redmi TCQCQOCYKJ9HCAMJ，新档）新手教程：罗杰中尉对话「你的超合金战车拥有2种特殊功能！我来帮你激活它们！」弹出后，技能图标栏弹出，随后**全场冻结**——对话无法推进、无技能提示、点击与摇杆无响应、镜头停死；音乐仍在播（TweenLite 独立时钟）。
- MIUI AppScout 全天多次记录该包 APP_SCOUT_HANG/WARNING（08:35/08:49/09:12/11:28 等），为同一 bug 反复复现。
- 设备 logcat（PID 31985）：业务 trace 于 14:16:45 整体停止（最后三条为 `没找到这个车身的数据：subCar_blue`×3 与 `敌人进去区域，开始碰撞`），此后仅剩输入事件/GC/音频；主线程无 ANR 抓栈（每帧异常风暴非死循环）。
- PC 端无法复现：桌面 Flash SA `Capabilities.playerType == "StandAlone"`，`Dialogbox2.show` 对技能提示走早退分支，且端游仓**完全不存在** `skillEnabled`（全库 grep 为零），端游 Level_0 不写该属性。

## 二、根因（代码级）

1. `54ccbe6` 将 `body\hero\HeroCarKey.as` 以端游版为底重写（端游无 skillEnabled 概念），「回植手游 skillEnabled 门控」只回植了**读取**（`useSkillName` 内 `if(!this.skillEnabled)`，HeroCarKey.as:232），**丢失了手游版的声明** `public var skillEnabled:Boolean = true;`（旧版 1332443 第 35 行）。
2. `HeroCarKey` 为密封类（非 dynamic）：密封类访问未声明属性，**赋值抛 #1056、读取抛 #1069**。
3. 引爆链（Level_0.as 教程队列，`FunGroup.FTimer` 串行延时队列）：
   - 教程开头 `hero.key.skillEnabled = false`（Level_0.as:43）→ #1056 被 try/catch 吞掉（只留 mobile-prologue 客户端日志）→ 行走/遇敌全正常；
   - 罗杰对话后 `skillShow()`（Level_0.as:351）：`showSkillIcon()` 先执行（图标弹出）、`setFullSkillArr` 正常，至 `hero.key.skillEnabled = true`（Level_0.as:355）**无 try/catch → #1056 裸抛**；
   - 抛点在 `FunGroup.FTimer`（FunGroup.as:85）队头：`f0.fun()` 抛出后 `shift()` 永不执行，同一回调**每帧重跑每帧抛**；
   - `Game.allTimer`（Game.as:1136）在 `timer1.FTimer()` 处每帧中断 → 其后镜头 `oneScene.inTargetMiddle`、`LG.level.hitArea`、stage.focus 全部停摆 → 全场冻结，`skillTeach/skillTeach2/lieuTalk2/super.unlockView` 永不执行（截图定格证据：图标已弹出、提示未出现、对话悬停）。

## 三、修复方案与执行

一行修复：`HeroCarKey.as` 第 32 行 `public var enabled:Boolean = true;` 后补回声明：

```actionscript
public var skillEnabled:Boolean = true;
```

- `config\build\swf-script-patches.txt` 无需新增（`body\hero\HeroCarKey.as` 已登记，第 85 行）；
- 编辑按 F-8 沉淀规范走 Python 字节级替换 + 锚点断言（该文件混合行尾，锚点行为裸 LF）。

## 四、实际修改文件

1. `decompiled\gamefile\scripts\body\hero\HeroCarKey.as`：+1 行声明。
2. 端游仓 `更新总结\bug 维护\README.md`：索引追加本条。

## 五、构建与验证证据

- `构建.bat`（135 补丁 + 7 BinaryData）退出正常，`build\game.swf` SHA-256 = `97A122C738CA7925E2901EBA20F75F609CED99DCEA29C84189DF1D89DF394C2C`；
- FFDec 反导出回读 `build\game.swf` 的 `body.hero.HeroCarKey`：第 33 行 `public var skillEnabled:Boolean = true;`（FOUND）、第 232 行门控读取在位；
- `scripts\launch_game.bat --check sa` / `--check sa_debug` 双自检退出码均 0；
- APK 重打（armv8 debug，`MOBILE-APK-READY\SuperAlloy-Mobile-Test-armv8-debug.apk`，14:44）并 `adb install -r` 装机 Success。

## 六、待实机确认项

1. 新档教程全流程：罗杰技能介绍两段提示正常弹出、对话可推进、镜头解锁、`lieuTalk2` 后罗杰 AI 恢复；
2. 反重力图标点击（GamingUI.startMobileGravity 读 `hero.key.skillEnabled`）不再异常；
3. VIP托管 AI（useSkillName 门控路径）不再异常；
4. 教程中途退出/关卡结束（restoreTutorialSkills 写路径）不再异常；
5. 回归：链式跳跃 0.4s 间隔行为不变。
