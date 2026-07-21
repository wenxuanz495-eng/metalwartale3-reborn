# 超合金战记 3 离线版源码

本仓库保存 Flash 反编译源码、原始 SWF 输入资源、Go 本地服务端，以及构建和 Debug 测试工具。

## 唯一工作区

```text
D:\superalloy\metalwartale3-reborn.git
```

GitHub：`https://github.com/wenxuanz495-eng/metalwartale3-reborn.git`

**强制协作规则见根目录 [`AGENTS.md`](AGENTS.md)。**

> 注意：`D:\superalloy\metalwartale3-reborn` 是空目录，不要在那里开发。  
> `超合金离线优化海豹版1.2` 是已验证玩法与发行壳参考，不是源码 SSOT。

## 开发启动（当前）

## 启动脚本（按播放器区分）

1. `构建.bat`：只构建
2. `启动游戏-flashplayer_sa.bat`：`flashplayer_sa.exe`
3. `启动游戏-flashplayer_sa_debug.bat`：`flashplayer_sa_debug.exe`


见 [docs/DEV_RUN.md](docs/DEV_RUN.md)。根目录 启动游戏.bat 会：

1. go build server（缓存到 D:\\superalloy\\.gopath）
2. FFDec 构建 uild/game.swf`n3. 用 	ools/debug/flashplayer_sa_debug.exe 打开

> 不要再把 
untime/ 当作主运行路径。

## 目录

- `decompiled/`：ActionScript 源码、嵌入 XML、符号表和提取资源。
- `swf/`：主游戏 SWF、提取出的内嵌 SWF 和全部原始资源 SWF。
- `server/`：Go 本地资源、存档和接口模拟服务端（**权威存档链路**）。
- `runtime/`：可运行壳部署目录（启动脚本、公告、修改器入口等；由构建填充）。
- `scripts/`：构建、部署、发行体检脚本。
- `tools/packaging/ffdec/`：构建 SWF 使用的 FFDec CLI。
- `tools/debug/`：CleanFlash SA Debugger 和启动脚本。
- `docs/`：架构、规则、问题记录和开发文档。

## 合并决策（摘要）

| 维度 | 决策 |
|---|---|
| 玩法 | 以海豹 1.2 为准 |
| 权威存档 | 本仓库 Go + `saves/game_save.bin` |
| 运行壳/修改器体验 | 以 1.2 为准 |
| 源码 | 本仓库 `decompiled/` SSOT |
| 公会 | 本仓库本地单人公会 |
| 定制武器商城价 | 统一 20,000 M币 |

完整规则：[`docs/SEAL_RULES.md`](docs/SEAL_RULES.md)  
差异台账：[`docs/MERGE_DIFF_1.2.md`](docs/MERGE_DIFF_1.2.md)

## 仓库边界

原始 SWF、源码资源、服务端源码和开发工具需要同步。  
重新编译生成的 SWF、发行 ZIP、服务端 EXE、存档、日志和构建缓存不进入 Git。

Flash 代码重新编译前，应阅读 [`docs/FFDEC_CONTROL_FLOW_REGRESSION.md`](docs/FFDEC_CONTROL_FLOW_REGRESSION.md)，并对复杂方法比较原始与构建后 P-code，避免反编译控制流回归。

备份统一放在仓库外：`D:\superalloy\1.2文件备份\`。


