$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..\..")).Path
$module = Import-Module (Join-Path $repoRoot "scripts\lib\Build.psm1") -Force -PassThru
$testRoot = Join-Path $repoRoot "build\tests\swf-cache"

try {
  Remove-Item -LiteralPath $testRoot -Recurse -Force -ErrorAction SilentlyContinue
  New-Item -ItemType Directory -Force -Path $testRoot | Out-Null

  & $module {
    param($testRoot)

    $key = Get-SwfCacheKey @("one", "two")
    if ($key -ne (Get-SwfCacheKey @("one", "two"))) { throw "Stable inputs produced different cache keys" }
    if ($key -eq (Get-SwfCacheKey @("two", "one"))) { throw "Cache key ignored input order" }
    if ($key -eq (Get-SwfCacheKey @("one", "changed"))) { throw "Cache key ignored input content" }

    $artifact = Join-Path $testRoot "source.swf"
    $report = Join-Path $testRoot "source-report.txt"
    [IO.File]::WriteAllBytes($artifact, [byte[]](1, 2, 3, 4))
    [IO.File]::WriteAllText($report, "verified")
    $entry = Join-Path $testRoot "entry"

    Publish-SwfCacheEntry $entry $key $artifact "game.swf" $report
    if (-not (Test-SwfCacheEntry $entry $key "game.swf" "pcode-report.txt")) {
      throw "Published final cache entry did not validate"
    }

    [IO.File]::AppendAllText((Join-Path $entry "pcode-report.txt"), "tampered")
    if (Test-SwfCacheEntry $entry $key "game.swf" "pcode-report.txt") {
      throw "Tampered P-code report was accepted"
    }

    Publish-SwfCacheEntry $entry $key $artifact "game.swf" $report
    if (-not (Test-SwfCacheEntry $entry $key "game.swf" "pcode-report.txt")) {
      throw "Corrupted cache entry was not repaired"
    }
  } $testRoot

  Write-Host "[OK] SWF cache key, integrity, and repair tests passed."
} finally {
  Remove-Item -LiteralPath $testRoot -Recurse -Force -ErrorAction SilentlyContinue
}
