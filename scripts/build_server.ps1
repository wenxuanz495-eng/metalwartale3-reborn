param(
  [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
)
$ErrorActionPreference = "Stop"
. (Join-Path $PSScriptRoot "go_env.ps1")
$outDir = Join-Path $RepoRoot "build"
New-Item -ItemType Directory -Force -Path $outDir | Out-Null
$out = Join-Path $outDir "server.exe"
Write-Host "GOPATH=$env:GOPATH"
Write-Host "GOMODCACHE=$env:GOMODCACHE"
Write-Host "GOCACHE=$env:GOCACHE"
Write-Host "Building server -> $out"
Push-Location (Join-Path $RepoRoot "server")
try {
  go version
  go mod download
  if ($LASTEXITCODE -ne 0) { throw "go mod download failed: $LASTEXITCODE" }
  go test ./...
  if ($LASTEXITCODE -ne 0) { throw "go test failed: $LASTEXITCODE" }
  go build -o $out .
  if ($LASTEXITCODE -ne 0) { throw "go build failed: $LASTEXITCODE" }
}
finally { Pop-Location }
Write-Host "OK $out"
Write-Host ("SHA256=" + (Get-FileHash $out -Algorithm SHA256).Hash)
