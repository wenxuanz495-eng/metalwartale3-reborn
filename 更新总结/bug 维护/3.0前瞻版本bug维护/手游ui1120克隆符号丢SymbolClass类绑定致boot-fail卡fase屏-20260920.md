# 手游ui1120克隆符号丢SymbolClass类绑定致boot-fail卡fase屏-20260920

> 记录日期：2026-09-20
> 归属：手游端 F-8 gpu着色清扫第二刀（战斗三色条烘焙）引入的启动回归；端游仓留档（更新总结唯一归档区），手游仓同步记录见其 `移植台账.md` F-8。
> 状态：**已实施修复（PC boot-step 复验通过），待真机确认**
> 关联文档：[docs/postmortems/FLASH_LOADING_SCREEN_FAILURES.md](../../docs/postmortems/FLASH_LOADING_SCREEN_FAILURES.md)（卡加载界面=AS初始化异常的通用手册，本次为其新增一例与一条真机诊断路径）。

---

## 一、现象与复现链

- 手游真机（vivo V2452A）安装 F-8 第二刀构建后，启动卡在 4399 预载画面（"您正在进入4399特等奖金牌游戏"），无进度、无按钮、无崩溃。
- 同一构建在 PC Debug Player 复现：boot 停在 `当前命令：fase`，无任何异常 trace。
- 第一刀构建（仅确认键烘焙）同流程启动正常——差异锁定在第二刀对 `swf/ui1120.swf` 的追加编辑。

## 二、根因（代码级）

F-8 烘焙流水线（FFDec swf2xml → 矩阵烘入像素克隆 → xml2swf 回写）为战斗三色条克隆了 LifeBar 子树：

- `decompiled/gamefile/scripts/UI/gaming/GamingUI.as:64` 声明 `public var life_bar:LifeBar`（强类型）；
- 原符号 `1274` 在 SymbolClass 中绑定 `UI.gaming.LifeBar`；克隆体 `2110`（life_bar）/`2116`（exp_bar）**没有继承该绑定**，实例化时是纯 `flash.display::MovieClip`；
- `GamingUI.init()` 按实例名把子对象赋给强类型字段时抛 `TypeError: Error #1034: 无法将 flash.display::MovieClip 转换为 UI.gaming.LifeBar`；
- 异常发生在 `Game.uiLoader_complete` 的 try 内，被 boot-fail 分支吞掉：`uiGroup.show("fase")` 照常执行但**按钮监听在 try 尾部尚未挂上**——表现为 fase 屏（4399 画面）无按钮可点，像"卡加载"。

完整栈（PC 复现所获）：

```text
TypeError: Error #1034: 无法将 flash.display::MovieClip 转换为 UI.gaming.LifeBar。
  at UI.gaming::GamingUI/init()
  at UI::UIGroup/init()
  at Game/uiLoader_complete()
  at net::SWFLoaderManager/loadCompleteHandler()
```

第一刀未踩坑的原因：其克隆的按钮皮肤符号（94/69 一支）本就无类绑定。

## 三、修复方案与执行

给两个克隆体补 SymbolClass 绑定（同一 AS3 类允许绑定多个 symbol，运行时各自实例化，按实例名回填 `cover`/`txt` 子对象）：

- `swf/ui1120.swf` SymbolClass 追加：`2110 → UI.gaming.LifeBar`、`2116 → UI.gaming.LifeBar`；
- 哈希清单 `docs/baselines/1.26.2.1-BAT.sha256`（手游仓）同步。

**沉淀规则（F-8 流水线新增铁律）**：烘焙克隆任何带 SymbolClass 类绑定的 symbol 时，必须为新 id 追加同类绑定；流水线校验器须同时核对"克隆 id 均有绑定、绑定名单与克隆清单一致"。

## 四、真机诊断路径（本次沉淀的可复用方法）

真机 release 包无 flashlog、非 debuggable 无 run-as、AS 异常不上 logcat，按老方法拿不到栈。本次走通：

1. logcat 按 pid 过滤业务 trace，定位最后一条业务日志：`swf全部加载完成`（`SWFLoaderManager.as:143`）→ 异常在其后的同步 dispatch 链上；
2. 同一构建在 PC Debug Player 必然复现（手游构建不依赖真机）；
3. boot-fail 通过 `Game.reportClientError` POST 到内嵌 Go 服务器，PC 侧直接读：

```text
GET http://127.0.0.1:<port>/api/client-logs   # build/saves/client_errors.log
```

`boot-fail` 条目自带完整 AS 栈。服务器缺省端口 52100，设备侧可 `adb forward` 后访问。

## 五、构建与验证证据

- 手游仓 `构建.bat` 退出码 0，175/175 资源校验通过（ui1120 哈希同步 `b6ce3c51…`）；
- FFDec 回读归一化全等（含 SymbolClass 追加项）；
- PC Debug Player 复验：`boot-step: uiLoader_complete start` → `uiLoader_complete done`，无 #1034（client_errors.log 为证），boot 走到 fase 且按钮监听挂载完成；
- 附带既有噪音（与本 bug 无关，不处理）：`Error #2036 save-data-up/over.png`（缺失的按钮图）、boot 完成后 `#1009 findTopVisibleReturnButton`（手游"返回主界面"逻辑既有问题，另行挂账）。

## 六、待实机确认项

1. 真机安装新构建后能通过 4399 预载页进入主界面（不再卡 fase）；
2. 进入战斗：血条=红、能量条=蓝、经验条=黄（截屏像素采样）；
3. 回归：确认弹窗确定键仍为棕橙（第一刀成果）；
4. boss_bar 显示正常（未改动，走查确认）。
