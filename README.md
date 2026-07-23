# 超合金战记 3 离线版源码

本仓库保存 Flash 反编译源码、原始 SWF 输入资源、Go 本地服务端，以及构建和 Debug 测试工具。

## 唯一工作区

```text
D:\superalloy\metalwartale3-reborn.git
```

GitHub：`https://github.com/wenxuanz495-eng/metalwartale3-reborn.git`

强制协作规则见根目录 [`AGENTS.md`](AGENTS.md)。

> `D:\superalloy\metalwartale3-reborn` 是空目录，不要在那里开发。
> `D:\superalloy\1.26.2.1-BAT\1.26.2.1` 是只读黄金参考版，不是源码工作区。

## 开发运行

玩家运行入口已改为纯 BAT，不再调用 PowerShell。构建链将在第三阶段改造成可复现的纯 BAT 构建；当前构建入口仍沿用原脚本。

1. `构建.bat`：构建服务端和游戏 SWF。
2. `启动游戏.bat`：纯 BAT 启动普通 SA 播放器。
3. `启动游戏-flashplayer_sa.bat`：普通 SA 对照入口。
4. `启动游戏-flashplayer_sa_debug.bat`：Debug Player 入口。
5. `启动修改器.bat`：纯 BAT 启动修改器。

纯 BAT 运行细节见 [`docs/BAT_RUNTIME.md`](docs/BAT_RUNTIME.md)。根目录游戏入口直接启动已有的 `build/server.exe` 与 `build/game.swf`，自动准备资源、寻找端口、等待健康检查，并在播放器退出后清理本次服务端。

权威开发存档：

```text
build\saves\game_save.bin
```

## 目录

- `decompiled/`：ActionScript 源码、嵌入 XML、符号表和提取资源。
- `swf/`：主游戏 SWF、提取出的内嵌 SWF和原始资源 SWF。
- `server/`：Go 本地资源、存档和修改器 API 源码。
- `runtime/`：运行壳模板、公告和修改器页面。
- `scripts/`：纯 BAT 运行工具及现有构建、部署和发行体检脚本。
- `tools/packaging/ffdec/`：构建 SWF 使用的 FFDec CLI。
- `tools/debug/`：CleanFlash SA Debugger。
- `docs/`：架构、规则、问题记录和开发文档。

## 合并决策

| 维度 | 决策 |
|---|---|
| 玩法 | 以现成版进度为当前黄金行为 |
| 权威存档 | 本仓库 Go + `build/saves/game_save.bin` |
| 运行壳 | 纯 BAT |
| 源码 | 本仓库 `decompiled/` + `server/` SSOT |
| 公会 | 本仓库本地单人公会 |
| 定制武器商城价 | 统一 20,000 MB |

完整规则见 [`docs/SEAL_RULES.md`](docs/SEAL_RULES.md)，黄金基准见 [`docs/BASELINE_1.26.2.1.md`](docs/BASELINE_1.26.2.1.md)。

## 仓库边界

源码、配置、运行脚本和必要的原始资源需要同步。重新编译生成的 SWF、发行压缩包、服务端 EXE、存档、日志和历史备份不进入 Git。

Flash 代码重新编译前，应阅读 [`docs/FFDEC_CONTROL_FLOW_REGRESSION.md`](docs/FFDEC_CONTROL_FLOW_REGRESSION.md)，并对复杂方法比较原始与构建后 P-code。

备份统一放在仓库外的约定目录；禁止将玩家存档或临时验证目录提交进 Git。
