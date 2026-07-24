# 发布装包规范

## 原则

- 仓库是发布输入的唯一来源。装包不得从下载目录、历史发行目录或其他个人路径复制文件。
- 发布脚本只读取仓库内受 Git 管理的源码、资源、播放器和启动脚本。
- 发布目录是构建产物，不是开发输入；不得在旧发行目录上手工增删文件后重新压缩。
- 玩家存档的唯一位置是游戏根目录 `saves/`。`build/saves/` 不是正式或兼容存档路径。

## 入口

在仓库根目录运行：

```powershell
powershell -File scripts\dev.ps1 release -Version <版本名>
```

版本名由发布者传入，不在脚本中绑定某个合作版名称。产物写入：

```text
release\<版本名>\
```

脚本拒绝覆盖已存在的同名目录。需要重做时，先由发布者明确处理旧产物，再重新执行。

## Flash Player

正常玩家版使用仓库跟踪的：

```text
tools\runtime\flashplayer_sa.exe
```

装包脚本直接复制该文件，不读取任何仓库外路径，也不使用手写 SHA-256 判断它是不是“正确版本”。播放器升级应作为普通仓库变更提交并接受代码审查；Git 提交记录就是版本来源。

发布后可以生成整个发布物的校验清单，供传输完整性检查，但该清单不反过来决定构建输入。

包内使用34版 `tools\runtime\flashplayer_sa.exe`。实际文件版本和 SHA-256
记录在发行目录 `版本信息.txt`，仅用于追溯，不作为构建门禁。Debug Player
只用于开发回归，不进入玩家包。

## 玩家包结构

必要结构由 `scripts/lib/Release.psm1` 定义。核心文件包括：

```text
<版本名>\
  启动游戏.bat
  启动修改器.bat
  工具.bat
  modifier.html
  scripts\runtime\...
  tools\runtime\flashplayer_sa.exe
  build\
    .release-ready
    game.swf
    server.exe
    modifier.html
    swf\...
  saves\
    backups\
```

内部开发文档（包括本规范）、Debug Player、源码和构建工具不进入玩家包。

## 存档与临时文件

- 新包中的根目录 `saves/` 与 `saves/backups/` 必须为空。
- 包内不得出现 `build/saves/`。
- 不得包含 `game_save.bin`、`game_save.last-good.bin`、`.sol`、备份、日志或临时文件。
- 游戏和修改器都以游戏根目录作为服务端 `-root`，并共用根目录 `saves/`。

## 验收

发布后运行 `scripts/dev.ps1 check-release -Path <发布目录>`。检查至少覆盖：

- 必要文件和稳定运行路径存在；
- 创建流程直接复制仓库中的正常播放器；独立目录检查确认运行路径存在；
- Debug Player 不在玩家包中；
- 根存档目录存在且为空；
- `build/saves/` 不存在；
- 没有存档、备份、日志和临时文件。

压缩与分发属于发布产物处理。若生成压缩包，应对最终压缩包做完整性测试，并可附带本次产物生成的 SHA-256 清单；不得使用个人机器上的固定目录或旧哈希作为装包前提。
