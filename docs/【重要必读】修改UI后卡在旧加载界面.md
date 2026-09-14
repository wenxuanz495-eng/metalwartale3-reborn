# 【重要】修改 UI 后卡在旧加载界面

修改 UI、构造函数或启动期初始化代码后，如果游戏一直停在旧加载界面，优先检查 **ActionScript 运行时异常**。

> 构建成功只代表脚本能够编译，不代表游戏能够正常启动。UI 初始化期间的异常会中断完成事件，使画面永久停在加载界面。

## 必做检查

1. 使用 `启动游戏-flashplayer_sa_debug.bat` 启动游戏。
2. 检查：

   `%APPDATA%\Macromedia\Flash Player\Logs\flashlog.txt`

3. 同时检查：

   `build\saves\client_errors.log`

4. 重点搜索：

   `boot-fail`、`Error #1009`、`Error #2008`、`TypeError`、`ArgumentError`、`RangeError`、`VerifyError`

5. 确认日志中同时出现：

   `uiLoader_complete start`

   `uiLoader_complete done`

如果只有 `start`、出现 `boot-fail`，或者异常调用栈经过 `UIGroup.init()`，应先修复异常，不要继续修改加载动画或资源服务器。

## 最近一次实际案例

赞助界面的 `DouwaUI.showSupportPanel()` 创建 `TextFormat` 时参数错位，把 `"_blank"` 当成了 `align`，触发：

`ArgumentError: Error #2008: 参数 align 必须是某个可接受的值。`

异常发生在 `UIGroup.init()` 中，所以游戏停在旧加载界面。修正参数顺序后，必须使用 Debug Player 验证 `uiLoader_complete done`，不能只看 FFDec 或 BAT 的构建成功提示。

完整排查记录见：[docs/postmortems/FLASH_LOADING_SCREEN_FAILURES.md](docs/postmortems/FLASH_LOADING_SCREEN_FAILURES.md)
