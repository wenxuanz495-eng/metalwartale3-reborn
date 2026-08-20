param(
    [string]$RepoRoot = (Split-Path -Parent $PSScriptRoot),
    [string]$ReferenceRoot = 'D:\superalloy\原版\2.5（原版参考）\2.5版本素材库\raw\xml'
)

$ErrorActionPreference = 'Stop'

function Get-WeaponStages {
    param([string]$Text)

    $families = @{}
    foreach ($armsMatch in [regex]::Matches($Text, '<arms\b(?<attrs>[^>]*)>(?<body>.*?)</arms>', 'Singleline')) {
        $idMatch = [regex]::Match($armsMatch.Groups['attrs'].Value, '\bid="(?<id>[^"]+)"')
        if (-not $idMatch.Success) {
            continue
        }

        $stages = @()
        $stageNumber = 0
        foreach ($levelMatch in [regex]::Matches($armsMatch.Groups['body'].Value, '<armsLevel\b[^>]*>(?<body>.*?)</armsLevel>', 'Singleline')) {
            $stageNumber++
            $body = $levelMatch.Groups['body'].Value
            $nameMatch = [regex]::Match($body, '<name>(?<value>.*?)</name>', 'Singleline')
            $speedMatch = [regex]::Match($body, '<bulletSpeed>(?<value>.*?)</bulletSpeed>', 'Singleline')
            $stages += [pscustomobject]@{
                Stage = $stageNumber
                Name = if ($nameMatch.Success) { $nameMatch.Groups['value'].Value.Trim() } else { '' }
                Speed = if ($speedMatch.Success) { $speedMatch.Groups['value'].Value.Trim() } else { $null }
            }
        }
        $families[$idMatch.Groups['id'].Value] = $stages
    }
    return $families
}

function Write-Utf8PreservingBom {
    param(
        [string]$Path,
        [string]$Text,
        [bool]$HadBom
    )

    $encoding = [Text.UTF8Encoding]::new($HadBom)
    [IO.File]::WriteAllText($Path, $Text, $encoding)
}

$sets = @(
    [pscustomobject]@{
        Type = '主武器'
        Reference = Join-Path $ReferenceRoot 'arms_35.xml'
        Current = Join-Path $RepoRoot 'decompiled\embedded-xml-assets\2_EmbedXml_xmlClass3_EmbedXml_xmlClass3.bin'
    },
    [pscustomobject]@{
        Type = '副武器'
        Reference = Join-Path $ReferenceRoot 'subArms37.xml'
        Current = Join-Path $RepoRoot 'decompiled\embedded-xml-assets\6_EmbedXml_xmlClass7_EmbedXml_xmlClass7.bin'
    }
)

$report = @()
$totalChanged = 0

foreach ($set in $sets) {
    $referenceText = [IO.File]::ReadAllText($set.Reference, [Text.Encoding]::UTF8)
    $currentBytes = [IO.File]::ReadAllBytes($set.Current)
    $hadBom = $currentBytes.Length -ge 3 -and $currentBytes[0] -eq 0xEF -and $currentBytes[1] -eq 0xBB -and $currentBytes[2] -eq 0xBF
    $currentText = [IO.File]::ReadAllText($set.Current, [Text.Encoding]::UTF8)
    $referenceFamilies = Get-WeaponStages $referenceText
    $currentFamiliesBefore = Get-WeaponStages $currentText

    $excludedFamilies = @{}
    foreach ($familyId in $referenceFamilies.Keys) {
        $explicitSpeeds = @($referenceFamilies[$familyId] | Where-Object { $null -ne $_.Speed } | Select-Object -ExpandProperty Speed -Unique)
        if ($explicitSpeeds.Count -eq 0) {
            $excludedFamilies[$familyId] = if ($explicitSpeeds.Count -eq 0) {
                '2.5无显式弹速-待处理'
            }
        }
    }

    foreach ($familyId in $referenceFamilies.Keys) {
        if (-not $currentFamiliesBefore.ContainsKey($familyId)) {
            throw "$($set.Type) family '$familyId' is missing from the current version."
        }
        if ($currentFamiliesBefore[$familyId].Count -lt $referenceFamilies[$familyId].Count) {
            throw "$($set.Type) family '$familyId' has fewer stages than the 2.5 reference."
        }
    }

    $updatedText = [regex]::Replace(
        $currentText,
        '<arms\b(?<attrs>[^>]*)>(?<body>.*?)</arms>',
        {
            param($armsMatch)
            $idMatch = [regex]::Match($armsMatch.Groups['attrs'].Value, '\bid="(?<id>[^"]+)"')
            if (-not $idMatch.Success -or -not $referenceFamilies.ContainsKey($idMatch.Groups['id'].Value)) {
                return $armsMatch.Value
            }

            $familyId = $idMatch.Groups['id'].Value
            if ($excludedFamilies.ContainsKey($familyId)) {
                return $armsMatch.Value
            }
            $referenceStages = $referenceFamilies[$familyId]
            $stageNumber = [int[]](0)
            return [regex]::Replace(
                $armsMatch.Value,
                '<armsLevel\b[^>]*>.*?</armsLevel>',
                {
                    param($levelMatch)
                    $stageNumber[0]++
                    if ($stageNumber[0] -gt $referenceStages.Count) {
                        return $levelMatch.Value
                    }

                    $referenceSpeed = $referenceStages[$stageNumber[0] - 1].Speed
                    if ($null -eq $referenceSpeed) {
                        return $levelMatch.Value
                    }

                    $speedMatches = [regex]::Matches($levelMatch.Value, '<bulletSpeed>(?<value>.*?)</bulletSpeed>', 'Singleline')
                    if ($speedMatches.Count -ne 1) {
                        throw "$($set.Type) family '$familyId' stage $($stageNumber[0]) does not contain exactly one bulletSpeed."
                    }

                    $previousSpeed = $speedMatches[0].Groups['value'].Value.Trim()
                    if ($previousSpeed -eq $referenceSpeed) {
                        return $levelMatch.Value
                    }

                    return [regex]::Replace(
                        $levelMatch.Value,
                        '<bulletSpeed>.*?</bulletSpeed>',
                        "<bulletSpeed>$referenceSpeed</bulletSpeed>",
                        'Singleline'
                    )
                },
                'Singleline'
            )
        },
        'Singleline'
    )

    $currentFamiliesAfter = Get-WeaponStages $updatedText
    $changedInSet = 0
    foreach ($familyId in $referenceFamilies.Keys) {
        $beforeStages = $currentFamiliesBefore[$familyId]
        $afterStages = $currentFamiliesAfter[$familyId]
        for ($index = 0; $index -lt $referenceFamilies[$familyId].Count; $index++) {
            if ($beforeStages[$index].Speed -ne $afterStages[$index].Speed) {
                $changedInSet++
            }
        }
    }
    if ($updatedText -cne $currentText) {
        Write-Utf8PreservingBom -Path $set.Current -Text $updatedText -HadBom $hadBom
    }
    $totalChanged += $changedInSet

    foreach ($familyId in ($referenceFamilies.Keys | Sort-Object)) {
        $referenceStages = $referenceFamilies[$familyId]
        $beforeStages = $currentFamiliesBefore[$familyId]
        $afterStages = $currentFamiliesAfter[$familyId]
        for ($index = 0; $index -lt $referenceStages.Count; $index++) {
            $referenceStage = $referenceStages[$index]
            $beforeStage = $beforeStages[$index]
            $afterStage = $afterStages[$index]
            $status = if ($excludedFamilies.ContainsKey($familyId)) {
                $excludedFamilies[$familyId]
            } elseif ($afterStage.Speed -ne $referenceStage.Speed) {
                '校验失败'
            } elseif ($beforeStage.Speed -eq $referenceStage.Speed) {
                '原本一致'
            } else {
                '已恢复'
            }

            $report += [pscustomobject]@{
                类型 = $set.Type
                家族ID = $familyId
                家族阶段 = $referenceStage.Stage
                '2.5名称' = $referenceStage.Name
                当前名称 = $beforeStage.Name
                '2.5弹速' = $referenceStage.Speed
                修改前弹速 = $beforeStage.Speed
                修改后弹速 = $afterStage.Speed
                当前家族总阶段数 = $afterStages.Count
                状态 = $status
            }
        }
    }
}

$reportPath = Join-Path $RepoRoot 'docs\baselines\2.5玩家武器弹速基线名单.csv'
$report | Export-Csv -LiteralPath $reportPath -NoTypeInformation -Encoding utf8BOM

$failed = @($report | Where-Object 状态 -eq '校验失败')
if ($failed.Count -gt 0) {
    throw "Verification failed for $($failed.Count) weapon stages."
}

Write-Output "Restored bulletSpeed on $totalChanged player weapon stages."
Write-Output "Baseline report: $reportPath"
