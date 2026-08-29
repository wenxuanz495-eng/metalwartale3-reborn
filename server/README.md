# Go 离线服务器源码

> ⚠️ **部分内容已过时**：下文提到的 `offline/` 目录与旧 Python 参考实现已不存在；现行产物统一输出到 `build/`，构建入口为根目录 `构建.bat`（2026-08 文档整理时标注）。

这是离线版正式使用的 Go 服务端独立源码目录。

主要文件：

- `main.go`：进程入口、参数和 HTTP 服务生命周期；
- `http.go`：静态资源、存档及本地 4399 兼容接口；
- `store.go`：权威存档、JSON 镜像和 SQLite 历史；
- `amf.go`：Flash AMF/deflate 编解码；
- `editor.go`、`editor_page.go`：存档修改器接口和页面；
- `server_test.go`：服务端回归测试。

## 测试

```powershell
cd server
go test ./...
```

## 构建

双击 `build-server.bat`。测试通过后，生成物会安全替换
`offline/server.exe`。服务端运行时仍以 EXE 所在的 `offline/`
作为静态资源和存档根目录。

`offline/build-server.bat` 是兼容入口，会转发到这里。

旧版 Python 参考实现仍位于 `offline/server.py`，不参与正式运行。
