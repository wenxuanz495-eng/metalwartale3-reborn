# 超合金战记 · 离线版（metalwartale3-reborn）

把 4399 Flash 网游《超合金战记》（原版 11.3 原型）改造成**可长期保存、可维护的单机离线版**：
本地 Go 服务承载静态资源与权威存档，Flash Player 34 本地运行，登录/支付/远程存档全部离线化，
并持续从原版 2.5 / 3.4 回迁老武器特效。

> 当前处于 **3.0 前瞻开发期**；最新完结发行：**2.4.2 内测版**（玩家可见变更见发行包 `公告.txt`）。
> 开发前沿 = 本仓库 main 分支。

## 运行架构

```text
Flash Player SA 34（仓库自带，SHA-256 校验）
   │  加载 http://127.0.0.1:{port}/game.swf
   ▼
本地 Go 服务（server/）── 静态资源 + API 桩 + 权威存档读写（bin + JSON + SQLite 历史）
   ▲
启动器（launcher/ + scripts/）── 端口探测、服务健康检查、资源校验、播放器校验
```

## 快速开始

| 身份 | 入口 |
|---|---|
| 玩家 | 双击 [`启动游戏-flashplayer_sa.bat`](启动游戏-flashplayer_sa.bat)（自动准备资源、寻找端口、校验播放器后启动），或运行 `超合金战记启动器.exe`（x86 机型用 `-x86` 版） |
| 开发调试 | `启动游戏-flashplayer_sa_debug.bat`；全量构建运行 [`构建.bat`](构建.bat) |
| 修改器 | `启动修改器.bat` → [`modifier.html`](modifier.html)（便携版，自动定位存档） |

要求：Windows。仓库自带非 Debug Flash Player 34 运行时（`tools\runtime\`，启动前做固定哈希校验；禁止 FP29 与 Debug 版出货）。

## 目录导航

| 区域 | 条目 | 说明 |
|---|---|---|
| 启动与维护脚本 | `启动游戏-flashplayer_sa.bat`（调试加 `_debug`）、`超合金战记启动器*.exe`、`启动修改器.bat`、`一键备份存档.bat`、`清除存档.bat`、`打开存档*.bat`、`打开公告.bat`、`清理后台残留.bat` | 一键入口：游戏、修改器、存档维护、公告 |
| 游戏源码（SSOT） | [`decompiled/`](decompiled/) | 反编译 ActionScript 源码，游戏逻辑唯一真源；改动需同步登记 `config\build\swf-script-patches.txt` 由构建重新编译导入 |
| 服务端 | [`server/`](server/) | Go 本地服务：静态资源、API 桩、权威存档 |
| 启动器 | [`launcher/`](launcher/) | Go 编写的 GUI 启动器（amd64 / x86 双构建） |
| 资源 | [`swf/`](swf/)、`runtime/` | 分包 SWF 源资源与运行时；`build\` 为本地生成的运行副本（不入库） |
| 配置与清单 | [`config/`](config/) | 构建基线（`swf\baselines\`）、脚本/二进制补丁清单、资源哈希清单 |
| 构建与装包 | [`构建.bat`](构建.bat)（全量构建：服务端+启动器+game.swf+运行时）、[`scripts/`](scripts/)（含 `build_player_packages.bat` 发布装包、`check_release.bat` 发布校验） | 构建自检一条龙 |
| 工程文档 | [`docs/`](docs/) | 架构、规则、路线图、构建规范（建议阅读顺序见 [`docs/README.md`](docs/README.md)） |
| 更新与 bug 记录 | [`更新总结/`](更新总结/) | 按版本/家族归档的更新总结、武器特效回迁专项、bug 维护（建议先读 [`更新总结/README.md`](更新总结/README.md)） |
| 存档 | `build\saves\` | 权威存档区（本地生成），五件套：`game_save.bin` 权威档、`game_save.last-good.bin` 最后良好档（新档解析失败自动回滚到它）、`yagao.json` 可读 JSON 镜像、`saves.db` SQLite 历史版本库、`backups\` 修改器/兼容迁移前自动快照；首跑无档时从 `build\swf\empty-save-template.bin` 播种空白档。根目录 `saves\` 为 1.x 时代旧存档位（已停用仅留存）：现存 7 月历史快照与 2026-09-15 验证会话的 `build\saves\` 完整副本 |
| 历史与杂项 | `archive/`（含 `root-legacy-20260915\`：根目录历史重复/废弃脚本与校验残留归档）、`assets/`（装包 UI 素材）、`AGENTS.md`（AI 协作规则，自身已标注过时） | 历史产物归档 |

## 音乐系统（BGM 歌单引擎）

游戏音乐不是 Flash 内置音轨一条路，而是一套**三模式互斥的歌单引擎**：

- **原版默认 BGM**：Flash 内置音乐；
- **开发者推荐 BGM**：按「主界面 / 战斗」场景分别绑定歌单（默认 `developer_main` / `developer_battle`，可重新分配）；
- **玩家自定义 BGM**：与开发者歌单同套场景机制，玩家自行勾选曲目。

组成与位置：

- 客户端状态机：`decompiled\gamefile\scripts\sound\`（`SoundGroup.as` / `OneMusic.as`）——模式互斥、场景上下文（gaming/gaming2 归入 battle）、单曲循环、无效曲目清理与旧 ID 迁移；
- 服务端 BGM 模块（`server/`）：驱动**外置 native 播放器**播放曲库文件（因此支持 FLAC 无损），提供歌单与播放状态 API；空歌单 = 暂停（不回退猜歌）；Flash 退出后经 `/api/shutdown` 走 `bgm.close() → native.shutdown()` 优雅退出；
- 曲库源（不入库）：工作区 `相关素材\歌单\曲库\`（`developer-playlists.json` 统一定义 + 分类曲目文件夹；仓库根 BAT 按 `.playlist-root` 标记自动定位）。

机制细节与修复史详见 [`docs/BGM功能与修复总结.md`](docs/BGM功能与修复总结.md)。

## 文档导航

1. [`docs/PROJECT_STATUS.md`](docs/PROJECT_STATUS.md) —— 已实现能力与现状
2. [`docs/OFFLINE_ARCHITECTURE.md`](docs/OFFLINE_ARCHITECTURE.md) —— Flash + Go 服务 + 存档如何配合
3. [`docs/SEAL_RULES.md`](docs/SEAL_RULES.md) —— 海豹版最终玩法规则（SSOT）
4. [`docs/GAMEPLAY_RULES.md`](docs/GAMEPLAY_RULES.md) / [`docs/ROADMAP.md`](docs/ROADMAP.md) / [`docs/DEVELOPMENT.md`](docs/DEVELOPMENT.md)
5. [`更新总结/README.md`](更新总结/README.md) —— 所有更新的任务总结索引（版本 / 武器家族 / bug 维护）

## 维护约定（摘要）

- 总结归档与代码修改**同一次提交推送**，保证代码到了 GitHub、总结也到了。
- 游戏逻辑改动两步走：改 `decompiled` 源码 + 登记 `config\build\swf-script-patches.txt`（清单驱动补丁构建，漏登记不生效）。
- 构建可复现：基线 SWF + 清单驱动导入，产物哈希入档；启动前 175 项运行时资源校验。
- 玩家包规范：非 Debug Flash Player SA 34.0.0.330 固定哈希，详见 `发布装包规范.txt`。

## 感谢公告

游戏主界面「游戏公告」面板展示的官方感谢公告（`runtime\游戏公告.txt`，随包发布）：

**本游戏特别感谢：金色未来酱、龙咲咲**

## 版权声明

原游戏《超合金战记》版权归原权利方所有。本项目为非商业的学习与保存性质的离线化改造，
不包含任何付费内容破解，仅限学习交流使用。
