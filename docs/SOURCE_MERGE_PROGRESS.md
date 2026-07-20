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

- 2026-07-21：定制武器商城价统一 20000 MB，并允许购买（不再仅展示）。


## 修改器章节进度（已合并）


untime/modifier.html 已包含海豹 1.2 的「剧情进度测试（自由之心）」完整实现，无需再从外部拷贝：

- 171 关精确下拉（reeHeartLevels）
- pplyStoryProgressToLevel / saveChapterProgress
- 只改进度字段 
ewLevelData.p1.lockNum 与 scoreObj
- 下一关解锁、后续锁定
- 与特殊功能分离的「保存剧情进度」按钮

启动修改器时优先打开 /modifier.html（完整版），/editor 为服务端内置基础页，不含章节进度。
