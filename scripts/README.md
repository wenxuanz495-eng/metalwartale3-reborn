# 开发与运行脚本

开发者只使用 `dev.ps1`：

```powershell
.\scripts\dev.ps1 build
.\scripts\dev.ps1 verify -Mode quick
.\scripts\dev.ps1 verify -Mode full
.\scripts\dev.ps1 verify -Mode release
.\scripts\dev.ps1 release -Version 版本号
.\scripts\dev.ps1 audit
.\scripts\dev.ps1 check-release -Path release\版本号
```

`runtime/` 中的四个 BAT 是发行运行链，由根目录中文入口调用。发行包不包含
开发构建或验收脚本。
