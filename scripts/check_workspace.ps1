param(
  [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
)

$ErrorActionPreference = "Stop"
Write-Host "Workspace check:" $RepoRoot

$required = @(
  "AGENTS.md",
  "docs\README.md",
  "docs\gameplay\SEAL_RULES.md",
  "docs\status\MERGE_DIFF_1.2.md",
  "docs\COLLAB_WORKSPACE.md",
  "decompiled",
  "server",
  "swf",
  "runtime",
  "scripts"
)

$failed = $false
foreach ($rel in $required) {
  $p = Join-Path $RepoRoot $rel
  if (Test-Path -LiteralPath $p) {
    Write-Host "[OK] $rel"
  } else {
    Write-Host "[MISSING] $rel"
    $failed = $true
  }
}

if ((Split-Path -Leaf $RepoRoot) -ne "metalwartale3-reborn.git") {
  Write-Host "[WARN] Repo folder name is not metalwartale3-reborn.git: $RepoRoot"
}

$node = Get-Command node -ErrorAction SilentlyContinue
$modifier = Join-Path $RepoRoot "runtime\modifier.html"
if ($node -and (Test-Path -LiteralPath $modifier)) {
  & $node.Source (Join-Path $PSScriptRoot "check_modifier.js") $modifier
  if ($LASTEXITCODE -ne 0) { $failed = $true }
} else {
  Write-Host "[WARN] Modifier JavaScript check skipped (node or modifier.html missing)."
}

if ($failed) { exit 1 }
Write-Host "Workspace OK."
