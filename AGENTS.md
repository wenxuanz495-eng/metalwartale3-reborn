# 协作与代理工作区规则（强制）

> 本文件约束所有在本项目中工作的开发者与 AI 代理（含 Codex）。

## 唯一工作区

- **唯一 Git 工作区 / 源码 SSOT**：以当前检出的本 Git 仓库根目录为准；通过 `git rev-parse --show-toplevel` 解析，禁止依赖机器特定的绝对路径
- **GitHub remote**：`https://github.com/wenxuanz495-eng/metalwartale3-reborn.git`
- 以后所有开发、提交、文档更新、功能合并，默认都在此仓库内进行。
- 不要把同名空壳目录、11.4 历史参考目录或 1.2 可玩发行样例当作主工程；它们仅可用于只读导出或对照

## 合并总策略（已确认）

| 维度 | 决策 |
|---|---|
| 玩法差异 | **以 1.2 海豹版为准** |
| 权威存档 | **采用 Git 路线**：`saves/game_save.bin` 为唯一权威；本地 Go 服务读写；不做 SharedObject/隐藏存储主路径 |
| 其它架构/运行壳 | **采用 1.2 发行体验**：根目录启动、修改器根目录、公告外置、火绒说明、端口冲突处理等 |
| 源码形态 | **尽可能使用本仓库可编译源码 SSOT**（`decompiled/` + `server/`），禁止长期只改发行目录二进制 |
| 主 SWF | **采用不可变基线加最小补丁**：禁止整库回编译；ActionScript 和 BinaryData 变更必须登记显式清单 |
| 公会 | **先用 Git 的本地单人公会模拟实现** |
| 定制/往期装备上架 | **放入商城**；**定制武器统一售价 20,000 M币** |
| 扩展修改器 UI | **全部迁入**（特殊功能、定制车辆/武器、研发卡、挑战卡、章节进度测试等） |
| 建议项 | 本仓库脚手架文档与脚本建议全部落地 |

## 目录职责

- `decompiled/`：ActionScript 源码与嵌入配置（游戏逻辑 SSOT）
- `server/`：Go 本地资源/存档/修改器 API（存档权威链路）
- `swf/`：原始/基线 SWF 输入资源
- `docs/`：规则、差异、架构、路线图
- `tools/`：构建与调试工具说明/脚本
- `runtime/`：可运行壳与部署目标（由构建产出，不把玩家存档提交进 Git）
- `scripts/`：构建、部署、发行体检脚本

## 备份策略

- 修改前备份必须放在仓库外；备份根目录由开发者按本机环境选择，禁止在项目规则或脚本中硬编码机器特定的绝对路径
- 备份目录名必须标注用途与日期，例如：`VIP地图时间与冷却修改前-20260721`
- **禁止**把备份、玩家存档、`saves/`、临时 verify 目录提交进 Git

## 开发流程（默认）

1. 在本仓库改 `decompiled/` 或 `server/` 或 `docs/`
2. 用 `scripts/dev.ps1 build` 执行 PowerShell 开发构建
3. 部署到 `runtime/`（或约定的本地运行目录）
4. 用 `flashplayer_32_sa_debug` 做最小回归
5. 更新 `docs/PROJECT_STATUS.md` / `docs/SEAL_RULES.md`
6. 在本仓库创建 Git 提交

## 明确禁止

- 禁止继续以 11.4 为主开发双写
- 禁止把“自动生成空白 4399小战士”带回主流程
- 禁止把隐藏 SharedObject 当作权威存档
- 禁止发行包夹带玩家存档/备份/备案/临时 SWF
- 禁止未读 `docs/FFDEC_CONTROL_FLOW_REGRESSION.md` 就大范围回编译复杂方法
- 禁止对 667 个反编译类执行整库 `importScript`；只允许使用 `config/build/` 的显式最小补丁清单
- 禁止把 `EmbedXml_xmlClass*.as` 作为脚本导入；嵌入 XML 必须按 BinaryData 字符 ID 替换
- `Game.as` 变更必须通过自动 P-code控制流检查，并完成 Debug Player回归

## 近期优先任务

1. 完成 `docs/MERGE_DIFF_1.2.md` 功能矩阵落地与源码映射
2. 将 1.2 玩法按模块移植进 `decompiled/`
3. 统一 runtime 启动壳与根目录修改器
4. 实现修改器“章节进度测试”
5. 定制武器商城 20k MB 上架
6. 接入 Git 本地公会

## 相关文档

- `docs/SEAL_RULES.md`：最终玩法规则
- `docs/MERGE_DIFF_1.2.md`：双版本差异与合并台账
- `docs/COLLAB_WORKSPACE.md`：工作区说明
- `docs/OFFLINE_ARCHITECTURE.md`：离线架构
- `docs/DEVELOPMENT.md`：开发与发布
- `docs/REPRODUCIBLE_BUILD.md`：PowerShell可复现构建与自动 P-code检查

## 开发启动

- 构建：`powershell -File scripts\dev.ps1 build`
- 运行：根目录 `启动游戏.bat`
- 快速验收：`powershell -File scripts\dev.ps1 verify -Mode quick`
- 完整验收：`powershell -File scripts\dev.ps1 verify -Mode full`
- 发行验收：`powershell -File scripts\dev.ps1 verify -Mode release`
- Go 模块与构建缓存使用 Go 默认环境，或由开发者通过标准 Go 环境变量显式配置；禁止依赖机器特定的绝对路径
- 不要以 `runtime/` 为主运行目录
