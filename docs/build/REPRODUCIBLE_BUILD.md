# 可复现纯 BAT 构建

日期：2026-07-23

## 目标与边界

合作版以仓库为唯一源码和构建资源来源，不读取或修改 `D:\superalloy\1.26.2.1-BAT`。黄金版只由 `docs/baselines/1.26.2.1-BAT.sha256` 做只读完整性验证。

主 SWF 的不可变输入是：

```text
swf\baselines\1.26.2.1-BAT.game.swf
SHA256 F54B78B5F3DC57101C62556B2D3830B051F686304D12C13B1DB8ABD0F833A37E
```

构建先在 `build/swf-build-stage` 生成候选文件，全部步骤成功后才替换 `build/game.swf`。失败不会破坏上一次成功产物。

## 构建入口

```bat
构建.bat
scripts\build_all.bat
scripts\verify_reproducible_build.bat
scripts\verify_phase3.bat
```

`build_all.bat` 构建 Go 服务端、主 SWF，再从仓库跟踪文件准备 175 个运行资源。正式链路不调用 PowerShell。

## 最小补丁清单

ActionScript 变更写入 `config/build/swf-script-patches.txt`，每行是相对于 `decompiled/gamefile/scripts` 的路径：

```text
UI\_new\change\CtrlListCtrl.as
```

嵌入 XML 不能导入对应包装类，必须写入 `config/build/swf-binary-patches.txt`：

```text
19|decompiled\embedded-xml-assets\19_EmbedXml_xmlClass12_EmbedXml_xmlClass12.bin
```

注释行以 `#` 开头。不要把未修改的类或 XML 加入清单，也不要执行整库 `importScript`。

## 风险规则

逐类审计 667 个 ActionScript 类的结果是：645 个精确一致、22 个不同、0 个编译失败。22 个不同项包括 21 个 `EmbedXml_xmlClass*.as` 包装类和 `Game.as`。

- 21 个包装类列在 `swf-forbidden-script-patches.txt`，构建会拒绝导入；对应数据只能走 BinaryData 替换。
- `Game.as` 列在 `swf-risky-script-patches.txt`。修改后必须比较基线和候选 P-code，并用 Debug Player 完成人工回归。
- 高风险类通过后，在 `swf-risk-approvals.txt` 登记 `路径|当前源码SHA256`。源码再次变化时旧审批自动失效。
- `audit_source_baseline.bat` 可重新执行逐类审计，结果写入 `build/source-baseline-audit/results.tsv`。

## 修改流程

1. 修改 `decompiled/` 或 `server/` 中的源码。
2. AS 类加入脚本补丁清单；嵌入 XML 加入 BinaryData 补丁清单。
3. 复杂控制流先阅读 `../postmortems/FFDEC_CONTROL_FLOW_REGRESSION.md`；高风险类完成 P-code 审批。
4. 运行 `scripts\verify_phase3.bat`。
5. 用 Debug Player 进入受影响玩法做人工回归，再提交源码、清单与文档。

`verify_reproducible_build.bat` 会连续构建两次并做字节比较，导出并核对全部 21 份 BinaryData。补丁清单为空时，还要求最终 SWF 与不可变基线完全相同。
