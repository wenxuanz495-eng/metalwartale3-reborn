# v2 开发加速链（与纯 BAT 链共存）

> 来源：`liangfen` 分支 `8f8b1d3`（重构开发构建并加入 SWF 增量缓存），移植适配到
> 2026-09 的 main 布局。移植期间**未修改任何现有文件**，纯新增。

## 定位

当前仓库同时存在两条构建链，读取**同一批输入**：

| | 纯 BAT 链（权威） | v2 开发加速链（本链） |
|---|---|---|
| 入口 | `构建.bat` / `scripts\build_all.bat` | `scripts\dev.ps1` |
| SWF 构建 | `scripts\build_swf.bat`，每次从基线全量重建 | `scripts\lib\Build.psm1`，多级内容寻址增量缓存 |
| P-code 门禁 | 无（靠风险脚本人工审批兜底） | 每次真实构建后自动导出 Game 类 P-code 做控制流校验 |
| 运行时装配 | `scripts\prepare_build_runtime.bat` | 同左（直接委托，不维护第二套） |
| 启动器构建 | `scripts\build_launcher.bat` | 同左（直接委托） |
| 发布装包 | `scripts\build_release.bat` 等 | 不提供（迁移完成前归 BAT 链） |
| 启动/入口 | 根目录 `启动游戏-*.bat` 等 | 不提供 |

权威链认定见 [BUILD_SOURCE_OF_TRUTH.md](BUILD_SOURCE_OF_TRUTH.md)，本文件不改变其结论。

## 共用输入（两链一致，改一处两链同时生效）

- 基线：`swf\baselines\1.26.2.1-BAT.game.swf` + `config\build\swf-baseline.sha256`（哈希门禁两链都做）
- 清单：`config\build\swf-script-patches.txt`、`swf-binary-patches.txt`、
  `swf-forbidden-script-patches.txt`、`swf-risky-script-patches.txt`、`swf-risk-approvals.txt`
- 源码：`decompiled\gamefile\scripts`、`decompiled\embedded-xml-assets`
- 工具：`tools\packaging\ffdec\ffdec-cli.exe`、node.exe

v2 的缓存键覆盖上述全部输入（含每份风险审批、每个补丁源文件的 SHA256），
任何输入变动都会自动失效对应缓存层级，不存在"改了源码但构建用了旧产物"的窗口。

## 命令

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File scripts\dev.ps1 build              # server + 启动器 + SWF(缓存) + 运行时
powershell -NoProfile -ExecutionPolicy Bypass -File scripts\dev.ps1 build -NoSwfCache  # 忽略缓存全量重建
powershell -NoProfile -ExecutionPolicy Bypass -File scripts\dev.ps1 verify -Mode quick # 测试 + 构建 + Go 测试 + 修改器检查
powershell -NoProfile -ExecutionPolicy Bypass -File scripts\dev.ps1 verify -Mode full  # quick + 两次无缓存构建字节一致 + 21 项嵌入 XML 校验
powershell -NoProfile -ExecutionPolicy Bypass -File scripts\dev.ps1 audit              # 逐源文件对照基线重编译审计
```

缓存位于 `build\cache\swf\`（`as\`、`binary\`、`final\` 三级，gitignore 内），可整目录删除。

## v2 相对 BAT 链多做的检查

1. **风险脚本审批**：与 `build_swf.bat` 同语义——清单内的风险脚本必须能在
   `swf-risk-approvals.txt` 找到 `路径|源文件SHA256` 审批行，否则拒绝构建。
   审批清单哈希参与缓存键，审批变更即失效缓存。
2. **P-code 控制流校验**：真实构建（缓存未命中）后用 ffdec 导出 Game 类
   P-code，`scripts\check_pcode.js` 校验跳转标签可达、无不可达返回、无无出口
   闭环，防 ffdec 重编译产出坏字节码。缓存命中时复用已校验的报告。

## 现阶段边界（迁移完成前 v2 不碰的事）

- 不改 `config\build\*.txt` 清单内容（liangfen 版曾把 BinaryData 扩成 21 项全量
  显式替换以强化可复现性；那会改变 BAT 链当前输出字节，留到迁移阶段统一决策）。
- 不动 `.gitattributes`（liangfen 版对 `*.as`/嵌入 `.bin` 强制 LF，同属迁移阶段事项）。
- 不提供发布装包与启动入口；验证入口归 `verify_phase4.bat` 管。

## 迁移计划（后续分三步）

1. **并行期（当前）**：两链并存，日常 SWF 迭代可用 v2；BAT 链保持权威与发布职责。
2. **切换期**：确认 v2 输出与 BAT 链字节一致后，把 `build_swf.bat` 改为薄壳调用
   Build.psm1（或保留 BAT 链并在 CI 用 v2 做门禁），BinaryData 21 项显式替换与
   `.gitattributes` 归一化在此一次性切换。
3. **收尾期**：移植 `Release.psm1` 发布链并替换 `build_release.bat` 一族，
   归档旧的 verify_phase*.bat 中被 v2 覆盖的部分。
