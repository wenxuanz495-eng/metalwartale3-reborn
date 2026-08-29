# 项目文档索引

新协作者与 AI Agent 的文档入口。先读根目录 [AGENTS.md](../AGENTS.md)（协作红线），再按下表按需查阅。
每个子目录有各自的 README.md 索引；新增、移动或废弃文档必须同步更新所属索引与本文（红线，见 AGENTS.md §3）。

## 分区结构

| 文档或路径 | 目标 | 说明 |
|---|---|---|
| [build/](build/README.md) | Human+AI | 构建入口、可复现构建、产物布局、黄金基线 |
| [runtime/](runtime/README.md) | Human+AI | 运行入口、开发启动、存档 |
| [gameplay/](gameplay/README.md) | Human+AI | 玩法规则（SSOT：SEAL_RULES）、路线图、长期设计 |
| [status/](status/README.md) | Human+AI | 项目状态、1.2 合并进度与差异台账 |
| [postmortems/](postmortems/README.md) | Human+AI | 事故复盘与排查手册 |
| [guides/](guides/README.md) | AI | AI 操作规程（弹速字段维护等） |
| [baselines/](baselines/) | Human+AI | 校验数据：sha256 清单、弹速名单 CSV 与核对说明（原位保留） |
| [COLLAB_WORKSPACE.md](COLLAB_WORKSPACE.md) | Human | （遗留）原作者机器本地工作区角色划分，路径仅原作者电脑有效 |
| 根目录[发布装包规范.txt](../发布装包规范.txt) | Human | 装包规范（玩家包内也随包附带；由装包脚本从根目录复制，故留在根目录） |

## 阅读顺序

1. 根目录 [AGENTS.md](../AGENTS.md)：红线与协作规则（AI 必读）。
2. [status/PROJECT_STATUS.md](status/PROJECT_STATUS.md)：现在完成了什么、还有哪些限制。
3. [runtime/BAT_RUNTIME.md](runtime/BAT_RUNTIME.md)：合作版如何被构建、启动与自检。
4. [gameplay/SEAL_RULES.md](gameplay/SEAL_RULES.md)：现行玩法规则定稿。
5. [postmortems/](postmortems/README.md)：改 UI、改启动链、动 SWF 前先看已知坑。
6. [gameplay/ROADMAP.md](gameplay/ROADMAP.md)：后续优先级与明确不采用的方向。

## 文档状态约定

- **已实现**：代码已进入正式 SWF，并通过至少一项检查。
- **已决定**：方向确定，可能尚未全部实现。
- **候选**：值得实验，先做原型验证。
- **暂缓**：工作量或风险高，暂不实现。
- **不采用**：与离线版目标、平衡或技术结构冲突。

讨论形成新结论后，先更新对应文档，再改代码；实现与文档不一致时，以新提交中同步更新后的文档为准。
