# Go 离线服务器源码

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

从仓库根目录运行 `scripts/dev.ps1 build`。生成物为
`build/server.exe`，运行时以仓库或发行包根目录作为静态资源和权威存档
根目录。
