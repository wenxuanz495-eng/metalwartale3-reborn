# 超合金战记 3 离线版源码

本仓库保存 Flash 反编译源码、原始 SWF 输入资源、Go 模拟服务端，以及构建和 Debug 测试工具。

## 目录

- `decompiled/`：ActionScript 源码、嵌入 XML、符号表和提取资源。
- `swf/`：未经修改的主游戏 SWF、提取出的内嵌 SWF 和全部原始资源 SWF。
- `server/`：Go 本地资源、存档和接口模拟服务端。
- `tools/packaging/ffdec/`：构建 SWF 使用的 FFDec CLI。
- `tools/debug/`：CleanFlash SA Debugger 和启动脚本。
- `docs/`：架构、规则、问题记录和开发文档。

## 仓库边界

原始 SWF、源码资源、服务端源码和开发工具需要同步。
重新编译生成的 SWF、发行 ZIP、服务端 EXE、存档、日志和构建缓存不进入 Git。

Flash 代码重新编译前，应阅读 `docs/FFDEC_CONTROL_FLOW_REGRESSION.md`，并对复杂方法比较原始与构建后 P-code，避免反编译控制流回归。
