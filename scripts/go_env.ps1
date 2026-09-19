# Go environment for this repo: keep module/build caches beside the repository (workspace .gopath).
$RepoRoot = if ($PSScriptRoot) { (Resolve-Path (Join-Path $PSScriptRoot "..")).Path } else { (Get-Location).Path }
if (Test-Path "C:\Program Files\Go\bin\go.exe") {
  $env:Path = "C:\Program Files\Go\bin;" + $env:Path
} elseif (-not (Get-Command go.exe -ErrorAction SilentlyContinue)) {
  throw "Go not found at C:\Program Files\Go\bin\go.exe or on PATH"
}
$GoWorkspace = Join-Path (Split-Path $RepoRoot -Parent) ".gopath"
$env:GOPATH = Join-Path $GoWorkspace "gopath"
$env:GOMODCACHE = Join-Path $GoWorkspace "pkg\mod"
$env:GOCACHE = Join-Path $GoWorkspace "cache"
$env:GOTMPDIR = Join-Path $GoWorkspace "tmp"
if (-not $env:GOPROXY) { $env:GOPROXY = "https://goproxy.cn,direct" }
New-Item -ItemType Directory -Force -Path $env:GOPATH, $env:GOMODCACHE, $env:GOCACHE, $env:GOTMPDIR | Out-Null

$env:GOPROXY = "https://goproxy.cn,direct"


