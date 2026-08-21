param(
    [string]$RepoRoot = (Split-Path -Parent $PSScriptRoot)
)

$ErrorActionPreference = 'Stop'
$assetRoot = Join-Path $RepoRoot 'decompiled\embedded-xml-assets'
if (-not (Test-Path -LiteralPath $assetRoot)) {
    throw "Missing current embedded XML asset directory: $assetRoot"
}

$allowedTypes = @('bullet', 'missile', 'laser')
$records = 0
$types = @{}
$errors = [System.Collections.Generic.List[string]]::new()

foreach ($file in Get-ChildItem -LiteralPath $assetRoot -File -Filter '*.bin') {
    $text = Get-Content -LiteralPath $file.FullName -Raw -Encoding UTF8
    foreach ($match in [regex]::Matches($text, '(?s)<arms\b[^>]*>.*?</arms>')) {
        $records++
        $chunk = $match.Value
        $idMatch = [regex]::Match($chunk, '<arms\b[^>]*\bid="([^"]+)"')
        $id = if ($idMatch.Success) { $idMatch.Groups[1].Value } else { '<unknown>' }

        $typeMatch = [regex]::Match($chunk, '<bulletType>\s*([^<\s]+)\s*</bulletType>')
        if (-not $typeMatch.Success) { continue }
        $type = $typeMatch.Groups[1].Value
        if (-not $types.ContainsKey($type)) { $types[$type] = 0 }
        $types[$type]++
        if ($allowedTypes -notcontains $type) {
            $errors.Add("$($file.Name): $id has unsupported bulletType '$type'")
        }

        foreach ($field in @('bulletSpeed', 'bulletMaxV', 'bulletMaxVa', 'bulletLife')) {
            $fieldMatch = [regex]::Match($chunk, "<$field>\s*([^<\s]+)\s*</$field>")
            if ($fieldMatch.Success -and $fieldMatch.Groups[1].Value -notmatch '^-?(?:\d+\.?\d*|\.\d+)$') {
                $errors.Add("$($file.Name): $id has non-numeric $field '$($fieldMatch.Groups[1].Value)'")
            }
        }
    }
}

Write-Output "Current embedded bullet records: $records"
Write-Output ("Bullet types: " + (($types.GetEnumerator() | Sort-Object Name | ForEach-Object { "$($_.Name)=$($_.Value)" }) -join ', '))

if ($records -eq 0) { throw 'No weapon records were found in current embedded XML assets.' }
if ($errors.Count -gt 0) {
    $errors | ForEach-Object { Write-Error $_ }
    exit 1
}

Write-Output 'Current embedded bullet data validation passed.'
