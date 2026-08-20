param(
    [string]$RepoRoot = (Split-Path -Parent $PSScriptRoot)
)

$ErrorActionPreference = 'Stop'

function Get-CurrentStages {
    param([string]$Path)
    $text = [IO.File]::ReadAllText($Path, [Text.Encoding]::UTF8)
    $result = @{}
    foreach ($familyMatch in [regex]::Matches($text, '<arms\b(?<attrs>[^>]*)>(?<body>.*?)</arms>', 'Singleline')) {
        $idMatch = [regex]::Match($familyMatch.Groups['attrs'].Value, '\bid="(?<id>[^"]+)"')
        if (-not $idMatch.Success) { continue }
        $familyId = $idMatch.Groups['id'].Value
        $stage = [int[]](0)
        foreach ($levelMatch in [regex]::Matches($familyMatch.Groups['body'].Value, '<armsLevel\b[^>]*>.*?</armsLevel>', 'Singleline')) {
            $stage[0]++
            $speedMatch = [regex]::Match($levelMatch.Value, '<bulletSpeed>(?<value>.*?)</bulletSpeed>', 'Singleline')
            $result["$familyId|$($stage[0])"] = [pscustomobject]@{
                Speed = if ($speedMatch.Success) { $speedMatch.Groups['value'].Value.Trim() } else { '' }
            }
        }
    }
    return $result
}

$candidatePath = Join-Path $RepoRoot 'docs\baselines\当前版本独有玩家武器2.5倍降速候选名单.csv'
$candidateRows = @(Import-Csv $candidatePath)
$targets = @{}
foreach ($row in $candidateRows) {
    if ($row.'除以2.5目标' -eq '') { throw "Missing 2.5x target: $($row.类型) $($row.家族ID) stage $($row.阶段)" }
    $targets["$($row.类型)|$($row.家族ID)|$($row.阶段)"] = $row.'除以2.5目标'
}

$sets = @(
    [pscustomobject]@{ Type='主武器'; Path=(Join-Path $RepoRoot 'decompiled\embedded-xml-assets\2_EmbedXml_xmlClass3_EmbedXml_xmlClass3.bin') },
    [pscustomobject]@{ Type='副武器'; Path=(Join-Path $RepoRoot 'decompiled\embedded-xml-assets\6_EmbedXml_xmlClass7_EmbedXml_xmlClass7.bin') }
)

$totalChanged = 0
foreach ($set in $sets) {
    $bytes = [IO.File]::ReadAllBytes($set.Path)
    $hadBom = $bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF
    $text = [IO.File]::ReadAllText($set.Path, [Text.Encoding]::UTF8)
    $matched = @{}
    $changed = 0
    $updated = [regex]::Replace($text, '<arms\b(?<attrs>[^>]*)>(?<body>.*?)</arms>', {
        param($familyMatch)
        $idMatch = [regex]::Match($familyMatch.Groups['attrs'].Value, '\bid="(?<id>[^"]+)"')
        if (-not $idMatch.Success) { return $familyMatch.Value }
        $familyId = $idMatch.Groups['id'].Value
        $stage = [int[]](0)
        return [regex]::Replace($familyMatch.Value, '<armsLevel\b[^>]*>.*?</armsLevel>', {
            param($levelMatch)
            $stage[0]++
            $key = "$($set.Type)|$familyId|$($stage[0])"
            if (-not $targets.ContainsKey($key)) { return $levelMatch.Value }
            $speedMatch = [regex]::Match($levelMatch.Value, '<bulletSpeed>(?<value>.*?)</bulletSpeed>', 'Singleline')
            if (-not $speedMatch.Success) { throw "Target has no bulletSpeed: $key" }
            $target = $targets[$key]
            $matched[$key] = $true
            if ($speedMatch.Groups['value'].Value.Trim() -eq $target) { return $levelMatch.Value }
            $changed++
            return [regex]::Replace($levelMatch.Value, '<bulletSpeed>.*?</bulletSpeed>', "<bulletSpeed>$target</bulletSpeed>", 'Singleline')
        }, 'Singleline')
    }, 'Singleline')
    if ($updated -cne $text) { [IO.File]::WriteAllText($set.Path, $updated, [Text.UTF8Encoding]::new($hadBom)) }
    $missing = @($targets.Keys | Where-Object { $_ -like "$($set.Type)|*" -and -not $matched.ContainsKey($_) })
    if ($missing.Count -gt 0) { throw "Targets not found in $($set.Type): $($missing -join ', ')" }
    $totalChanged += $changed
}

Write-Output "Applied 2.5x speed reduction to $($targets.Count) current-only stages; changed this run: $totalChanged."
