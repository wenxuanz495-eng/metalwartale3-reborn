[CmdletBinding()]
param(
  [ValidateSet("build", "verify", "audit")]
  [string]$Command = "build",
  [ValidateSet("quick", "full")]
  [string]$Mode = "quick",
  [switch]$NoSwfCache
)

# v2 开发加速链入口（与纯 BAT 链共存，见 docs/build/DEV_CHAIN_V2.md）。
# 发布装包现阶段仍归 BAT 链（scripts\build_release.bat 等），v2 不提供 release 命令。

$ErrorActionPreference = "Stop"
$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
Import-Module (Join-Path $PSScriptRoot "lib\Build.psm1") -Force
Import-Module (Join-Path $PSScriptRoot "lib\Verify.psm1") -Force

switch ($Command) {
  "build" {
    Build-All $repoRoot -NoSwfCache:$NoSwfCache
  }
  "verify" {
    switch ($Mode) {
      "quick" { Test-Quick $repoRoot }
      "full" { Test-Full $repoRoot }
    }
  }
  "audit" {
    Invoke-SourceBaselineAudit $repoRoot
  }
}
