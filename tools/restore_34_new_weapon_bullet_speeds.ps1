param(
    [string]$RepoRoot = (Split-Path -Parent $PSScriptRoot)
)

$ErrorActionPreference = 'Stop'
$path = Join-Path $RepoRoot 'decompiled\embedded-xml-assets\2_EmbedXml_xmlClass3_EmbedXml_xmlClass3.bin'
$targets = @{
    'arc|1' = '30'
    'conAquarius|1' = '35'
    'conAries|1' = '35'
    'conCancer|1' = '35'
    'conCapricornus|1' = '35'
    'conGemini|1' = '35'
    'conLeo|1' = '35'
    'conLibra|1' = '35'
    'conPisces|1' = '35'
    'conSagittarius|1' = '35'
    'conScorpio|1' = '35'
    'conTaurus|1' = '35'
    'conVirgo|1' = '35'
    'magneticTrack|1' = '40'
    'magneticTrack|2' = '40'
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
        $speedMatches = [regex]::Matches($levelMatch.Value, '<bulletSpeed>(?<value>.*?)</bulletSpeed>', 'Singleline')
        if ($speedMatches.Count -ne 1) { throw "Target $key does not contain exactly one bulletSpeed." }
        $matched[$key] = $true
        return [regex]::Replace($levelMatch.Value, '<bulletSpeed>.*?</bulletSpeed>', "<bulletSpeed>$($targets[$key])</bulletSpeed>", 'Singleline')
    }, 'Singleline')
}, 'Singleline')

$missing = @($targets.Keys | Where-Object { -not $matched.ContainsKey($_) })
if ($missing.Count -gt 0) { throw "Target stages not found: $($missing -join ', ')" }
if ($updated -cne $text) {
    [IO.File]::WriteAllText($path, $updated, [Text.UTF8Encoding]::new($hadBom))
}
Write-Output "Restored 3.4 bulletSpeed on $($targets.Count) main-weapon stages."
