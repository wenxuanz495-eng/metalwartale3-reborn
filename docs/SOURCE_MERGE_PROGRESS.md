# 源码合并进度（海豹 1.2 → Git SSOT）

日期：2026-07-21

## 方法

1. 用 FFDec 从 `超合金离线优化海豹版1.2/game.swf` 导出 667 个脚本。
2. 与 `decompiled/gamefile/scripts` 对比：文件集合完全一致。
3. 过滤反编译噪声后，识别约 39 个有功能意义的差异文件。
4. 将海豹关键玩法脚本覆盖进仓库 SSOT；保留 Git 独有的“自选强化礼包”等实现。

## 已迁入（海豹 → 仓库）

- 通关首通 MB / VIP 最后解锁：`EventGroup.as`
- VIP 时长/冷却/永久 Buff/3h 礼包：`VipData.as` `VipUI.as`
- 任务并行/冷却/挑战卡：`TaskData.as` `ChallengeTaskData.as` `CollectTaskData.as` 及对应 UI
- 精英挑战卡与无奖励模式：`ExtraData.as` `ExtraUI.as` `FlipCardDefine.as` `TaskDefine.as`
- 登录礼包 / 累计获得 MB 礼包文案与逻辑：`FirstPayGiftUI.as` `PayGiftUI.as` `GiftDefine.as` 等
- 研发升级卡 UI：`ArmsResearchUI.as`；背包点击提示已并入 `ItemsController.as`
- 存档本地链路：`LocalSave.as` `SaveAPI.as`（`api/game-save`）
- 本地公会：`Union_API.as`（海豹版离线公会实现）
- 背包扩容相关：`ArmsItemsData*.as` `CarItemsDataGroup.as`
- 关卡数据相关：`NewLevelData.as`

## 有意保留仓库版

- `items/ItemsController.as` / `ItemsDefineGroup.as`：**自选强化礼包** + 批量核心（并已插入研发卡不可直接使用提示）
- `goods/GoodsDefineGroup.as`：仓库更大，含商城整理；道具 id 可能来自 dataMust（两边 dataMust 哈希一致）
- `UI/union/UnionShop.as`：仓库版更大，先保留

## 主 SWF 判断

- 仓库 `swf/gamefile.swf` 与 1.2 `game.swf` 不同哈希/大小。
- 正确路径：改 `decompiled` → FFDec importScript 重编译 → runtime 部署。
- 下一步需要完整构建流水线与行为回归，而不是覆盖二进制。

## 备份

- 覆盖前脚本备份：`D:\superalloy\1.2文件备份\repo-scripts-before-seal-merge-20260721`
- 1.2 导出：`D:\superalloy\1.2文件备份\seal12_export_scripts_20260721`


## 后续增量

- 2026-07-22：VIP 通用兼容修复
  - `VipData.inData_byObj` 自动把旧修改器误写的 `vipCard_111..114` 迁移为标准 `vipCard_11..14`；所有玩家旧 BIN 存档在进入角色时均可恢复，后续正常保存会固化标准值。
  - `VipUI` 对已拥有及被高等级覆盖的 VIP 隐藏购买按钮，并在点击入口增加拥有等级保护，不再错误提示仍需通关对应关卡。
  - 外置修改器改为只写标准编号，同时识别旧错误编号并在下次保存时修正。
- 2026-07-22：战斗核心批量拆解奖励汇总改为自动分页，每页最多显示 6 类奖励；多页时点击确定继续查看，分页提示紧接奖励文本以避开确定按钮，最后一页保留背包已满、拆解器不足等停止原因。只修改专用拆解结果流程，不改变全局确认框。
- 2026-07-22：普通、优质、稀有战斗核心卡池移除斯巴达；其原有概率完整合并给黄金深渊，黄金深渊概率分别调整为 1%、1%、3%，其他奖励概率不变，并同步更新道具说明。
- 2026-07-22：玩家副本失败或主动退出时保存 Boss 当前血量并立即写入存档，不进入冷却；只有击杀成功后才开始 30 分钟冷却。旧存档中 `winB=false` 却残留未来 `readyAt` 的错误失败冷却会自动清除，Boss 剩余血量继续保留。
- 2026-07-21：定制武器商城价统一 20000 MB，并允许购买（不再仅展示）。
- 2026-07-21：虚空档清理收尾
  - 客户端 `LocalSave.as`：保存前清理内存槽；读档过滤虚空槽并回写；判定改为等级<=1 且主/副武器与车辆皆空（字段缺失也算空），不再只认默认名。
  - 服务端 `store.go`：`savePrimary` 改为剥离虚空槽后保存，而不是整包拒绝。
  - 测试：`server_test.go` 覆盖改名虚空槽剥离、真实角色保留、有武器的 0 级角色不误删。
  - 构建：`build/server.exe` + `build/game.swf` 已产出并同步到 `runtime/`。
  - `scripts/build_swf.ps1`：FFDec 使用隔离 APPDATA/flashlib，避免配置 NPE。


## 修改器章节进度（已合并）


untime/modifier.html 已包含海豹 1.2 的「剧情进度测试（自由之心）」完整实现，无需再从外部拷贝：

- 171 关精确下拉（reeHeartLevels）
- pplyStoryProgressToLevel / saveChapterProgress
- 只改进度字段 
ewLevelData.p1.lockNum 与 scoreObj
- 下一关解锁、后续锁定
- 与特殊功能分离的「保存剧情进度」按钮

启动修改器时优先打开 /modifier.html（完整版），/editor 为服务端内置基础页，不含章节进度。
