param(
    [string]$RepoRoot = (Split-Path -Parent $PSScriptRoot)
)

$ErrorActionPreference = 'Stop'
$path = Join-Path $RepoRoot 'decompiled\embedded-xml-assets\2_EmbedXml_xmlClass3_EmbedXml_xmlClass3.bin'
$targets = @{
    'induction|1' = @{ bulletMaxV='30'; bulletMaxVa='0'; followB='3' }
    'induction|2' = @{ bulletMaxV='30'; bulletMaxVa='0'; followB='3' }
    'induction|3' = @{ bulletMaxV='30'; bulletMaxVa='0'; followB='3' }
    'induction|4' = @{ bulletMaxV='30'; bulletMaxVa='0'; followB='3' }
    'microwave|1' = @{ bulletMaxV='35'; bulletMaxVa='0' }
    'microwave|2' = @{ bulletMaxV='35'; bulletMaxVa='0' }
    'microwave|3' = @{ bulletMaxV='35'; bulletMaxVa='0' }
    'microwave|4' = @{ bulletMaxV='35'; bulletMaxVa='0' }
    'microwave|5' = @{ bulletMaxV='35'; bulletMaxVa='0' }
    'ioncanon|1' = @{ bulletMaxV='20'; bulletMaxVa='4' }
}

$bytes = [IO.File]::ReadAllBytes($path)
$hadBom = $bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF
$text = [IO.File]::ReadAllText($path, [Text.Encoding]::UTF8)
$matched = @{}
$updated = [regex]::Replace($text, '<arms\b(?<attrs>[^>]*)>(?<body>.*?)</arms>', {
    param($familyMatch)
    $idMatch = [regex]::Match($familyMatch.Groups['attrs'].Value, '\bid="(?<id>[^"]+)"')
    if (-not $idMatch.Success) { return $familyMatch.Value }
    $familyId = $idMatch.Groups['id'].Value
    $stage = [int[]](0)
    return [regex]::Replace($familyMatch.Value, '<armsLevel\b[^>]*>.*?</armsLevel>', {
        param($levelMatch)
        $stage[0]++
        $key = "$familyId|$($stage[0])"
        if (-not $targets.ContainsKey($key)) { return $levelMatch.Value }
        $level = $levelMatch.Value
        foreach ($field in $targets[$key].Keys) {
            $fieldMatch = [regex]::Match($level, "<$field>.*?</$field>", 'Singleline')
            if (-not $fieldMatch.Success) { throw "Missing $field on $key" }
            $value = $targets[$key][$field]
            $level = [regex]::Replace($level, "<$field>.*?</$field>", "<$field>$value</$field>", 'Singleline')
        }
        $matched[$key] = $true
        return $level
    }, 'Singleline')
}, 'Singleline')

$missing = @($targets.Keys | Where-Object { -not $matched.ContainsKey($_) })
if ($missing.Count -gt 0) { throw "Targets not found: $($missing -join ', ')" }
if ($updated -cne $text) { [IO.File]::WriteAllText($path, $updated, [Text.UTF8Encoding]::new($hadBom)) }
Write-Output "Updated complete motion parameters for $($targets.Count) weapon stages."
