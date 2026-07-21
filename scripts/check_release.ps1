param(
  [Parameter(Mandatory = $true)]
  [string]$Path
)

$ErrorActionPreference = "Stop"
if (-not (Test-Path -LiteralPath $Path)) {
  throw "Path not found: $Path"
}

$item = Get-Item -LiteralPath $Path
Write-Host "Release check:" $item.FullName

$bannedNamePatterns = @(
  "备份", "backup", "backups", "game_save.bin", "saves.db", "yagao.json",
  "flash-profile", ".sol", "before-", "verify", "tmp", "temp"
)

$problems = New-Object System.Collections.Generic.List[string]

if ($item.PSIsContainer) {
  $files = Get-ChildItem -LiteralPath $item.FullName -Recurse -File -Force
} elseif ($item.Extension -match '\.zip$') {
  Add-Type -AssemblyName System.IO.Compression.FileSystem
  $zip = [System.IO.Compression.ZipFile]::OpenRead($item.FullName)
  try {
    foreach ($entry in $zip.Entries) {
      $name = $entry.FullName
      $normalized = $name -replace '\\','/'
      if ($normalized -match '(^|/)saves/backups/?$' -or $normalized -match '(^|/)(一键备份存档|打开存档备份文件夹)\.bat$') {
        continue
      }
      foreach ($pat in $bannedNamePatterns) {
        if ($name -like "*$pat*") {
          # allow nested 可选修改器 documentation text mentioning backups? still flag real save-like names
          if ($name -match 'game_save\.bin|saves\.db|\.sol$|flash-profile|备份[/\\]|/backups/') {
            $problems.Add("banned entry: $name")
          }
        }
      }
    }
    Write-Host "Zip entries:" $zip.Entries.Count
  } finally {
    $zip.Dispose()
  }
  if ($problems.Count -gt 0) {
    $problems | ForEach-Object { Write-Host "[BAD]" $_ }
    exit 1
  }
  Write-Host "Zip basic ban-list check OK (heuristic)."
  exit 0
} else {
  throw "Unsupported path type. Provide a folder or .zip"
}

foreach ($f in $files) {
  $rel = $f.FullName.Substring($item.FullName.Length).TrimStart('\','/')
  if ($rel -match '^(一键备份存档|打开存档备份文件夹)\.bat$') {
    continue
  }
  if ($rel -match 'saves\\game_save\.bin|saves\.db|\.sol$|flash-profile|\\backups\\|备份') {
    $problems.Add($rel)
  }
}

if ($problems.Count -gt 0) {
  Write-Host "Found banned files:"
  $problems | ForEach-Object { Write-Host "[BAD]" $_ }
  exit 1
}

Write-Host "Folder release check OK. File count:" $files.Count
