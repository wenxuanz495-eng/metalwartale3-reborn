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
| 启动与维护脚本 | `启动游戏-*.bat`、`超合金战记启动器*.exe`、`一键备份存档.bat`、`清除存档.bat`、`打开*.bat`、`清理后台残留.bat` 等根目录 BAT | 一键入口：游戏、修改器、存档维护、公告 |
| 游戏源码（SSOT） | [`decompiled/`](decompiled/) | 反编译 ActionScript 源码，游戏逻辑唯一真源；改动需同步登记 `config\build\swf-script-patches.txt` 由构建重新编译导入 |
| 服务端 | [`server/`](server/) | Go 本地服务：静态资源、API 桩、权威存档 |
| 启动器 | [`launcher/`](launcher/) | Go 编写的 GUI 启动器（amd64 / x86 双构建） |
| 资源 | [`swf/`](swf/)、`runtime/` | 分包 SWF 源资源与运行时；`build\` 为本地生成的运行副本（不入库） |
| 配置与清单 | [`config/`](config/)、`sp_check.xml` | 构建基线、脚本/二进制补丁清单、资源哈希清单 |
| 构建与自检 | [`scripts/`](scripts/)、`build.bat` | 构建、发布装包、启动自检、资源校验全套脚本 |
| 工程文档 | [`docs/`](docs/) | 架构、规则、路线图、构建规范（建议阅读顺序见 [`docs/README.md`](docs/README.md)） |
| 更新与 bug 记录 | [`更新总结/`](更新总结/) | 按版本/家族归档的更新总结、武器特效回迁专项、bug 维护（建议先读 [`更新总结/README.md`](更新总结/README.md)） |
| 存档 | `saves/`、`build\saves\` | 权威存档 `game_save.bin`（本地生成） |
| 历史与杂项 | `archive/`、`assets/`、`bd_check/`、根目录部分 BAT | 历史审计产物与一次性维护脚本 |

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

## 版权声明

原游戏《超合金战记》版权归原权利方所有。本项目为非商业的学习与保存性质的离线化改造，
不包含任何付费内容破解，仅限学习交流使用。
