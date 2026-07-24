[CmdletBinding()]
param(
  [ValidateSet("build", "verify", "release", "audit", "check-release")]
  [string]$Command = "build",
  [ValidateSet("quick", "full", "release")]
  [string]$Mode = "quick",
  [string]$Version = "",
  [string]$Path = "",
  [switch]$NoSwfCache
)

$ErrorActionPreference = "Stop"
$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
Import-Module (Join-Path $PSScriptRoot "lib\Build.psm1") -Force
Import-Module (Join-Path $PSScriptRoot "lib\Verify.psm1") -Force
Import-Module (Join-Path $PSScriptRoot "lib\Release.psm1") -Force

switch ($Command) {
  "build" {
    Build-All $repoRoot -NoSwfCache:$NoSwfCache
  }
  "verify" {
    switch ($Mode) {
      "quick" { Test-Quick $repoRoot }
      "full" { Test-Full $repoRoot }
      "release" { Test-Release $repoRoot }
    }
  }
  "release" {
    if (-not $Version) { throw "-Version is required for release" }
    New-PlayerRelease -RepoRoot $repoRoot -Version $Version
  }
  "audit" {
    Invoke-SourceBaselineAudit $repoRoot
  }
  "check-release" {
    if (-not $Path) { throw "-Path is required for check-release" }
    Test-ReleaseFolder (Resolve-Path -LiteralPath $Path).Path
  }
}
