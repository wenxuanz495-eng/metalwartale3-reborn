# Go environment for this repo: keep module/build caches on D:
$RepoRoot = if ($PSScriptRoot) { (Resolve-Path (Join-Path $PSScriptRoot "..")).Path } else { (Get-Location).Path }
if (-not (Test-Path "C:\Program Files\Go\bin\go.exe")) {
  throw "Go not found at C:\Program Files\Go\bin\go.exe"
}
$env:Path = "C:\Program Files\Go\bin;" + $env:Path
$GoWorkspace = "D:\superalloy\.gopath"
$env:GOPATH = Join-Path $GoWorkspace "gopath"
$env:GOMODCACHE = Join-Path $GoWorkspace "pkg\mod"
$env:GOCACHE = Join-Path $GoWorkspace "cache"
$env:GOTMPDIR = Join-Path $GoWorkspace "tmp"
if (-not $env:GOPROXY) { $env:GOPROXY = "https://goproxy.cn,direct" }
New-Item -ItemType Directory -Force -Path $env:GOPATH, $env:GOMODCACHE, $env:GOCACHE, $env:GOTMPDIR | Out-Null

$env:GOPROXY = "https://goproxy.cn,direct"


