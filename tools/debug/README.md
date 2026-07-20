# Flash Debug 测试

`flashplayer_sa_debug.exe` 是 CleanFlash 34.0.0.330 的独立 Debug Player，
用于捕获 ActionScript 异常、调用栈和脚本超时。

从仓库根目录启动：

```powershell
.\tools\debug\run-debug.ps1 http://127.0.0.1:8765/game.swf
```

Debug 日志默认写入：

```text
%APPDATA%\Macromedia\Flash Player\Logs\flashlog.txt
```
