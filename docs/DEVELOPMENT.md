# 开发与发布

## Git

- 主分支为 `main`。
- 完成一批可独立说明和验证的修改后自动创建提交。
- 提交前运行相关测试。
- 提交原始 SWF、源码资源和 `tools/debug/` 下的测试播放器。
- 不提交构建生成的 SWF、发行包、存档、日志和历史二进制备份。
- ActionScript 源码、Go/Python 源码、脚本、嵌入 XML 配置和文档需要提交。

建议提交消息使用简短中文，例如：

```text
实现本地公会商店规则
增加战斗核心批量开启
整理战术模式设计文档
```

## 测试

### Python回归

在 `offline/` 中运行：

```powershell
python -m unittest -v test_offline_regressions.py
```

测试覆盖关键源码约束、存档协议和历史问题，主要防止测试模式绕过、SOL回退、奖励索引错误和离线规则回归。

### Go后端

```powershell
cd server
..\.tools\go\bin\go.exe test ./...
```

或安装 Go 后直接运行：

```powershell
cd server
go test ./...
```

### ActionScript编译

```powershell
tools\packaging\ffdec\ffdec-cli.exe -onerror abort `
  -importScript portable\game.swf `
  offline\game.build.tmp.swf `
  decompiled\gamefile\scripts
```

必须检查退出码。成功编译并测试后，才能替换正式 SWF。

Debug Player 位于 `tools/debug/flashplayer_sa_debug.exe`，用于捕获 ActionScript
异常和脚本超时。第三方 FFDec 本体仍作为本地工具链使用，不提交到仓库。

## 发布检查

1. Python回归测试通过。
2. Go测试通过。
3. ActionScript重新编译成功。
4. `offline/game.swf` 与 `portable/game.swf` 哈希一致。
5. Go服务 `/api/status` 返回正常。
6. `game.swf` 经 HTTP 请求返回 200。
7. 人工进入游戏测试本批修改涉及的实际流程。
8. 更新 `docs/PROJECT_STATUS.md` 和相关规则文档。
9. 创建 Git 提交。

## 文档维护

- 已实现功能写入 `PROJECT_STATUS.md`。
- 已确定的长期规则写入 `GAMEPLAY_RULES.md`。
- 尚未实施的工作写入 `ROADMAP.md`。
- 大型玩法设计进入独立文档，不与当前事实混写。
- 讨论被推翻时应修改原条目，不继续保留互相矛盾的结论。
