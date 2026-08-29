# BGM 功能与修复总结

## 当前模式

系统目前包含三种互斥的 BGM 模式：

- 原版默认 BGM：播放 Flash 内置音乐。
- 开发者推荐 BGM：按主界面和战斗场景分别使用已分配的开发者歌单。
- 玩家自定义 BGM：按主界面和战斗场景分别使用玩家歌单。

开发者歌单模式不会因为歌单名称而强制选择 `developer_main` 或 `developer_battle`。实际播放依据为：

```text
主界面 → mainPlaylistID
战斗 → battlePlaylistID
```

默认值仍为：

```text
mainPlaylistID = developer_main
battlePlaylistID = developer_battle
```

这两个默认值只用于初始化和无效配置回退，玩家重新分配后以保存的 ID 为准。

## 已修复问题

### 开发者歌单场景分配失效

修复前，开发者模式的播放函数会按场景固定读取 `developer_main` 或 `developer_battle`，导致“主界面使用”和“战斗使用”选项对开发者歌单不起作用。

现在播放函数使用实际保存的 `mainPlaylistID` 和 `battlePlaylistID`，并同时比较歌单 ID 与场景上下文，支持同一歌单同时用于主界面和战斗。

### 自定义歌单数量显示错误

修复前，歌单状态栏直接统计原始 `tracks` 数组长度。旧存档中若存在失效 ID、旧别名或重复 ID，就可能出现列表显示 1 首但状态栏显示已选 2 首。

现在会：

- 清理无效曲目 ID；
- 迁移旧别名到 canonical ID；
- 删除重复 ID；
- 保留有效的开发者和玩家曲目；
- 在曲库尚未加载完成时避免误清空；
- 使用清理后的有效数组显示数量。

新版本不依赖复杂的旧歌单自动恢复；旧版本异常歌单可以由玩家重新导入。

### 空歌单继续播放旧歌曲

当前场景没有有效歌单，或歌单曲目为空时，客户端会清空活动歌单状态并请求停止外置播放器。服务端在空歌单启动或更新时也会停止 native 播放器，并清空播放状态。

最终行为为：

```text
空歌单 = 暂停
未选择歌单 = 暂停
不会自动回退到上一个歌单
不会自动回退到其他场景歌单
```

### Flash Player 退出后 server/BGM 残留

新增本机关闭接口：

```text
POST /api/shutdown
```

该接口仅允许本机访问。Flash Player 退出后，正式启动器和 BAT 入口会请求关闭 server；server 随后按以下顺序退出：

```text
bgm.close()
→ native.shutdown()
→ HTTP 服务优雅退出
```

如果优雅退出超时，启动入口只针对本次启动记录的 server PID 做兜底清理，不会全局结束其他实例，也不使用 `taskkill /IM server.exe`。

## 特殊战斗场景

当前 `gaming` 和 `gaming2` 都归入 `battle` 上下文，因此普通关卡、竞技场、公会战等特殊战斗默认使用战斗歌单。

## 验证记录

已完成以下验证：

- 开发者主界面歌单用于主界面和战斗；
- 开发者战斗歌单用于主界面和战斗；
- 主界面与战斗使用不同开发者歌单时正确分流；
- 玩家主界面歌单与玩家战斗歌单正确分流；
- 空歌单通过 API 验证为 `playing=false`、`label=""`；
- `custom_...` 歌单异常数量经过清理后显示一致；
- 正式 Debug 入口加载当前仓库的 `build/game.swf`；
- HTTP 下载的 SWF 与本地构建产物 SHA-256 一致；
- 正式启动器和 Debug BAT 退出后 server 进程能够退出；
- 外置 BGM 播放器在退出链路中执行释放。

## 当前构建要求

涉及 ActionScript 修改时，需要重新构建：

```text
scripts\\build_swf.bat
```

涉及 Go 服务端修改时，需要重新构建：

```text
scripts\\build_server.bat
```

涉及启动器修改时，需要重新构建：

```text
scripts\\build_launcher.bat
```

验证时应使用当前仓库的正式入口，不要使用旧版原版参考包、3.4 参照修改版或旧 `runtime\\game.swf`。

## 当前已接受的产品行为

- 新版本不重点兼容复杂的旧歌单异常数据，玩家可以重新导入歌单；
- 不勾选任何歌单时保持暂停；
- 空歌单保持暂停，不自动猜测其他歌单；
- 特殊战斗默认使用普通战斗歌单；
- 多个历史自定义歌单 ID 可以共存，玩家可通过自定义名称区分。
