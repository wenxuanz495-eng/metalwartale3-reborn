# 离线架构

## 运行关系

```text
启动脚本
  ├─ 启动 Go server.exe
  ├─ 检查 /api/status
  └─ FlashPlayer.exe 打开 http://127.0.0.1:52100/game.swf
                              │
                              ├─ 加载 swf/ 下的分包资源
                              ├─ 通过 /api/game-save 读写存档
                              └─ 调用本地化后的 4399/API 适配层
```

## 目录职责

### `decompiled/`

可维护的 ActionScript 源码和嵌入配置。修改游戏规则时以这里为源，不直接对正式 SWF 做不可追踪的二进制修改。

其中 `decompiled/embedded-xml-assets/` 的 `.bin` 文件实际是 XML 配置文本，因此需要进入 Git。

### `offline/`

完整运行和调试版本，包含：

- 旧 Python 后端参考实现；
- Flash 回归测试；
- 启动和构建脚本；
- 运行时生成但被 Git 忽略的 SWF、EXE、资源与存档。

### `server/`

正式 Go 后端的唯一源码目录，包含 HTTP 服务、AMF 编解码、存档、SQLite、修改器源码、测试和构建脚本。构建产物仍输出到 `offline/server.exe`，因此运行目录和存档位置不变。

### `portable/`

玩家使用的最小目录。包含启动、清档和修改器脚本；正式发布时还会放入被 Git 忽略的播放器、后端、SWF 和资源目录。

## 存档模型

权威数据流：

```text
Flash GameData
  └─ deflate(AMF)
       └─ saves/game_save.bin
            ├─ saves/yagao.json
            └─ saves/saves.db 历史记录
```

原则：

- 不读取 SOL，避免同一台机器出现两个互相覆盖的存档源。
- 修改器直接修改 Go 后端管理的数据。
- 游戏运行期间不要使用修改器，防止游戏自动保存覆盖人工修改。
- 每次修改前自动备份，并限制历史数量。

## Flash 构建

FFDec 使用 `decompiled/gamefile/scripts/` 覆盖基础 SWF 中的 ActionScript。编译成功后，同一产物复制到：

- `offline/game.swf`
- `portable/game.swf`

正式 SWF 和历史备份不进入 Git。Git 保存的是能够重新生成它们的源码。

## 联网功能处理原则

- 能转成本地状态的系统，使用主存档持久化，例如公会。
- 只需要静态返回值的接口，由本地服务或 ActionScript 适配层接管。
- 依赖真实其他玩家的功能明确标记不可用，不伪造复杂在线生态。
- M币不再依赖 4399 登录态，直接使用主存档余额。
