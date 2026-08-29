# AGENTS.md — 协作与代理工作规则

> 本文件是 AI Agent 与协作者的项目宪法：动手前先读这里。文档全量索引见 [docs/README.md](docs/README.md)。
> 约定：使用中文交流与注释；不确定就先问，不要猜。

## 1. 项目介绍

《超合金战记》（Metal Wartale）民间重制版：把原本依赖 4399 页面、登录、支付与远程存档的 Flash 网游，改造成可长期保存、可维护、可扩展的单机/合作版。

- 游戏本体：Flash/ActionScript。可维护源码在 `decompiled/`；构建以 `swf/baselines/1.26.2.1-BAT.game.swf` 为不可变基线，仅打显式最小补丁。
- 服务端：Go（`server/`），本地 HTTP + AMF + SQLite 存档；另有 Go 启动器（`launcher/`）。
- 构建与启动：全部由根目录 `.bat` 脚本驱动的「纯 BAT 链」完成，不依赖 PowerShell。

## 2. 项目结构

```text
AGENTS.md          本文件：协作红线（AI 必读）
docs/              文档索引与分区（build/runtime/gameplay/status/postmortems/guides/baselines）
decompiled/        ActionScript 源码与嵌入 XML 配置；改游戏规则以这里为源
swf/               SWF 资源 SSOT（含 baselines/ 不可变基线）
server/            Go 后端唯一源码目录
launcher/          启动器源码（Go）
config/            构建输入：补丁清单、BGM、资源覆盖
scripts/           构建与启动内部脚本（build_all.bat、launch_game.bat 等）
tools/             本地工具链（Flash Player SA、Debug Player、FFDec CLI 等）
build/             构建产物输出目录（git 忽略，本地重建）
runtime/           已弃用为主运行路径；保留玩家说明文档与旧入口
archive/           旧构建脚本归档（只读）
功能总结/           功能开发记录（已完成/未完成事项）
*.bat / *.exe      玩家入口，见红线 §3.2
```

## 3. 红线（按优先级）

1. **构建唯一入口**：`构建.bat`（内部为 `scripts\build_all.bat`）。禁止运行旧 `scripts\build_swf.ps1`，禁止从任何发行目录复制 `game.swf`。见 [docs/build/BUILD_SOURCE_OF_TRUTH.md](docs/build/BUILD_SOURCE_OF_TRUTH.md)。
2. **根目录 .bat 与 exe 是玩家入口**：不移动、不重命名、不合并、不「整理」。`.bat` 文件保持 CRLF 行尾与 ASCII 内容（`.gitattributes` 强制 `*.bat text eol=crlf`）。
3. **修改武器弹速字段前必读** [docs/guides/AI武器弹速维护提示.md](docs/guides/AI武器弹速维护提示.md)：不能只改 `bulletSpeed`，改后必须同步 [docs/baselines/](docs/baselines/) 名单，并从最终 `build\game.swf` 导出 BinaryData 核对。
4. **改 UI / 构造函数 / 启动期初始化后卡在旧加载界面 = AS 运行时异常**：按根目录[【重要必读】修改UI后卡在旧加载界面.md](【重要必读】修改UI后卡在旧加载界面.md) 排查（flashlog.txt 与 `build\saves\client_errors.log`，搜 `boot-fail`、`Error #2008`），完整手册见 docs/postmortems/。
5. **FFDec 重编译存在已知控制流回归**（ch1-5 卡死）：复杂控制流先读 [docs/postmortems/FFDEC_CONTROL_FLOW_REGRESSION.md](docs/postmortems/FFDEC_CONTROL_FLOW_REGRESSION.md)，高风险类完成 P-code 审批。
6. **改动与文档同步**：修改行为必须同步更新对应 docs 文档；只改代码不更文档视为未完成。
7. **只读与谨慎区**：`archive/` 只读（旧构建遗留）；`decompiled/` 谨慎修改，必须走 FFDec 重编译流程并验证；`swf/` 是资源 SSOT，禁止不可追踪的二进制修改。
8. **日志与产物不入库**：`logs/`、`build/` 已在 .gitignore；各 AI 工具的会话留痕与本地缓存目录（如 `.zcode/`、`.codex/`、`.claude/`、`.agents/cache/`）一律不要提交。
9. **存档路径 [待维护者裁定]**：[docs/gameplay/SEAL_RULES.md](docs/gameplay/SEAL_RULES.md)（`saves/game_save.bin`）与根目录《发布装包规范.txt》（根目录 `saves`）同 docs/runtime/ 下 SAVES、DEV_RUN、BAT_RUNTIME（`build/saves/`）表述不一致。裁定前以 SEAL_RULES.md 为准；禁止引入第三处存档路径，相关修复随裁定结果统一进行。
10. **机器本地路径警告**：旧文档中的 `D:\superalloy\...`（黄金基线、发行目录等）仅原作者电脑有效，对任何其他克隆无效，不要在代码或脚本中引用。

## 4. 注意事项（代码导航）

- 运行链路（启动脚本 → Go server → FlashPlayer HTTP）：[docs/runtime/OFFLINE_ARCHITECTURE.md](docs/runtime/OFFLINE_ARCHITECTURE.md)（注意其过时部分标注）。
- 玩家入口与自检/冒烟命令：[docs/runtime/BAT_RUNTIME.md](docs/runtime/BAT_RUNTIME.md)。
- 构建补丁与审批流程：[docs/build/REPRODUCIBLE_BUILD.md](docs/build/REPRODUCIBLE_BUILD.md)。
- 已知坑集中地：[docs/postmortems/](docs/postmortems/README.md)——改 UI、改启动链、动 SWF 前先扫一遍。
- 玩法规则唯一权威：[docs/gameplay/SEAL_RULES.md](docs/gameplay/SEAL_RULES.md)。

## 5. 对话要求

- 不确定先问：涉及玩法数值、存档、发布包的动作先确认再动手。
- 先说方案再改代码；方案获认可后按方案执行，执行中不临时换方案。
- 默认排除 `archive/` 与 `runtime/` 旧脚本，不在其中寻找「现行实现」。
- 提交信息用简短中文，一批修改一个提交。

## 6. 参考文档

- [docs/README.md](docs/README.md)：全量文档索引（含阅读顺序）。
- [docs/guides/AI武器弹速维护提示.md](docs/guides/AI武器弹速维护提示.md)：改弹速必读。
- 各发行包根目录的 `公告.txt`：版本与更新进度的权威来源。

## 7. 行为准则（Code of Conduct for AI）

Behavioral guidelines to reduce common LLM coding mistakes.

**Tradeoff:** These guidelines bias toward caution over speed. For trivial tasks, use judgment.

### 1. Think Before Coding

**Don't assume. Don't hide confusion. Surface tradeoffs.**

Before implementing:
- State your assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them - don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- If something is unclear, stop. Name what's confusing. Ask.

### 2. Simplicity First

**Minimum code that solves the problem. Nothing speculative.**

- No features beyond what was asked.
- No abstractions for single-use code.
- No "flexibility" or "configurability" that wasn't requested.
- No error handling for impossible scenarios.
- If you write 200 lines and it could be 50, rewrite it.

Ask yourself: "Would a senior engineer say this is overcomplicated?" If yes, simplify.

### 3. Surgical Changes

**Touch only what you must. Clean up only your own mess.**

When editing existing code:
- Don't "improve" adjacent code, comments, or formatting.
- Don't refactor things that aren't broken.
- Match existing style, even if you'd do it differently.
- If you notice unrelated dead code, mention it - don't delete it.

When your changes create orphans:
- Remove imports/variables/functions that YOUR changes made unused.
- Don't remove pre-existing dead code unless asked.

The test: Every changed line should trace directly to the user's request.

### 4. Goal-Driven Execution

**Define success criteria. Loop until verified.**

Transform tasks into verifiable goals:
- "Add validation" → "Write tests for invalid inputs, then make them pass"
- "Fix the bug" → "Write a test that reproduces it, then make it pass"
- "Refactor X" → "Ensure tests pass before and after"

For multi-step tasks, state a brief plan:
```
1. [Step] → verify: [check]
2. [Step] → verify: [check]
3. [Step] → verify: [check]
```

Strong success criteria let you loop independently. Weak criteria ("make it work") require constant clarification.

**Project-specific verification**: this repo is verified through the pure-BAT chain — build via `构建.bat`, then static self-checks and smoke tests per [docs/runtime/BAT_RUNTIME.md](docs/runtime/BAT_RUNTIME.md).

---

**These guidelines are working if:** fewer unnecessary changes in diffs, fewer rewrites due to overcomplication, and clarifying questions come before implementation rather than after mistakes.

---

## 附：遗留说明（自旧版 AGENTS.md 保留）

- 黄金基线 `D:\superalloy\1.26.2.1-BAT` 是早期只读参考版，仅用于完整性校验与行为对照，**不是**源码工作区，且仅存在于原作者电脑；仓库内的对应校验数据在 [docs/baselines/](docs/baselines/)。
- 本仓库是唯一源码工作区（SSOT）。
