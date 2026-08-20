param(
    [string]$RepoRoot = (Split-Path -Parent $PSScriptRoot)
)

$ErrorActionPreference = 'Stop'

function Read-CurrentStages {
    param([string]$Path)

    $text = [IO.File]::ReadAllText($Path, [Text.Encoding]::UTF8)
    $result = @{}
    foreach ($familyMatch in [regex]::Matches($text, '<arms\b(?<attrs>[^>]*)>(?<body>.*?)</arms>', 'Singleline')) {
        $idMatch = [regex]::Match($familyMatch.Groups['attrs'].Value, '\bid="(?<id>[^"]+)"')
        if (-not $idMatch.Success) { continue }
        $familyId = $idMatch.Groups['id'].Value
        $stage = 0
        foreach ($levelMatch in [regex]::Matches($familyMatch.Groups['body'].Value, '<armsLevel\b[^>]*>(?<body>.*?)</armsLevel>', 'Singleline')) {
            $stage++
            $body = $levelMatch.Groups['body'].Value
            $nameMatch = [regex]::Match($body, '<name>(?<value>.*?)</name>', 'Singleline')
            $speedMatch = [regex]::Match($body, '<bulletSpeed>(?<value>.*?)</bulletSpeed>', 'Singleline')
            $result["$familyId|$stage"] = [pscustomobject]@{
                Name = if ($nameMatch.Success) { $nameMatch.Groups['value'].Value.Trim() } else { '' }
                Speed = if ($speedMatch.Success) { $speedMatch.Groups['value'].Value.Trim() } else { '' }
            }
        }
    }
    return $result
}

function Join-Values {
    param([object[]]$Values)
    return (@($Values | Where-Object { $_ -ne '' } | Select-Object -Unique) -join '/')
}

function Add-FamilyTable {
    param(
        [Collections.Generic.List[string]]$Lines,
        [object[]]$Rows
    )

    $Lines.Add('| 类型 | 家族 ID | 中文形态 | 基准弹速 | 当前弹速 | 状态 |')
    $Lines.Add('|---|---|---|---|---|---|')
    foreach ($group in ($Rows | Group-Object Type, FamilyId | Sort-Object { $_.Group[0].Type }, { $_.Group[0].FamilyId })) {
        $items = @($group.Group | Sort-Object Stage)
        $Lines.Add(('| {0} | `{1}` | {2} | {3} | {4} | {5} |' -f
            $items[0].Type,
            $items[0].FamilyId,
            (($items | ForEach-Object { $_.Name }) -join ' / '),
            (Join-Values ($items | ForEach-Object { $_.TargetSpeed })),
            (Join-Values ($items | ForEach-Object { $_.CurrentSpeed })),
            (Join-Values ($items | ForEach-Object { $_.Status }))
        ))
    }
    $Lines.Add('')
}

$baselineDir = Join-Path $RepoRoot 'docs\baselines'
$mainCurrent = Read-CurrentStages (Join-Path $RepoRoot 'decompiled\embedded-xml-assets\2_EmbedXml_xmlClass3_EmbedXml_xmlClass3.bin')
$subCurrent = Read-CurrentStages (Join-Path $RepoRoot 'decompiled\embedded-xml-assets\6_EmbedXml_xmlClass7_EmbedXml_xmlClass7.bin')

$category25 = foreach ($row in (Import-Csv (Join-Path $baselineDir '2.5玩家武器弹速基线名单.csv'))) {
    $current = if ($row.类型 -eq '主武器') { $mainCurrent } else { $subCurrent }
    $key = "$($row.家族ID)|$($row.家族阶段)"
    $currentStage = $current[$key]
    $target = $row.'2.5弹速'
    $status = if ($target -eq '') { '不适用-无显式弹速' } elseif ($currentStage.Speed -eq $target) { '已完成' } else { '待处理' }
    [pscustomobject]@{ Type=$row.类型; FamilyId=$row.家族ID; Stage=[int]$row.家族阶段; Name=$currentStage.Name; TargetSpeed=$target; CurrentSpeed=$currentStage.Speed; Status=$status }
}

$category34 = foreach ($row in (Import-Csv (Join-Path $baselineDir '3.4新增玩家武器弹速对照名单.csv'))) {
    $current = if ($row.类型 -eq '主武器') { $mainCurrent } else { $subCurrent }
    $key = "$($row.家族ID)|$($row.家族阶段)"
    $currentStage = $current[$key]
    $target = $row.'3.4弹速'
    $status = if ($target -eq '') { '不适用-无显式弹速' } elseif ($currentStage.Speed -eq $target) { '已完成' } else { '待处理' }
    [pscustomobject]@{ Type=$row.类型; FamilyId=$row.家族ID; Stage=[int]$row.家族阶段; Name=$currentStage.Name; TargetSpeed=$target; CurrentSpeed=$currentStage.Speed; Status=$status }
}

$categoryOther = foreach ($row in (Import-Csv (Join-Path $baselineDir '当前版本独有玩家武器2.5倍降速候选名单.csv'))) {
    $current = if ($row.类型 -eq '主武器') { $mainCurrent } else { $subCurrent }
    $key = "$($row.家族ID)|$($row.阶段)"
    $currentStage = $current[$key]
    $target = $row.'除以2.5目标'
    $status = if ($currentStage.Speed -eq $target) { '已完成-降速2.5倍' } else { '待处理' }
    [pscustomobject]@{ Type=$row.类型; FamilyId=$row.家族ID; Stage=[int]$row.阶段; Name=$currentStage.Name; TargetSpeed=$target; CurrentSpeed=$currentStage.Speed; Status=$status }
}

$done25 = @($category25 | Where-Object Status -eq '已完成').Count
$applicable25 = @($category25 | Where-Object Status -ne '不适用-无显式弹速').Count
$done34 = @($category34 | Where-Object Status -eq '已完成').Count
$applicable34 = @($category34 | Where-Object Status -ne '不适用-无显式弹速').Count
$doneOther = @($categoryOther | Where-Object Status -eq '已完成-降速2.5倍').Count

$lines = [Collections.Generic.List[string]]::new()
$lines.Add('# 玩家武器弹道速度分类与进度')
$lines.Add('')
$lines.Add('> 本文件是持续维护的速度调整清单。每完成一批武器调整后，必须重新运行 `pwsh -NoProfile -File .\tools\update_player_weapon_speed_catalog.ps1` 更新状态。')
$lines.Add('')
$lines.Add('## 当前进度')
$lines.Add('')
$lines.Add(('- [x] 2.5 已有武器：适用形态 {0}/{1} 已恢复到 2.5。' -f $done25, $applicable25))
$lines.Add(('- [x] 3.4 新增武器：适用形态 {0}/{1} 已恢复到 3.4。' -f $done34, $applicable34))
$lines.Add(('- [{0}] 其余武器：{1}/{2} 已完成 `bulletSpeed / 2.5`。' -f $(if ($doneOther -eq $categoryOther.Count) { 'x' } else { ' ' }), $doneOther, $categoryOther.Count))
$lines.Add('- [x] 加速弹道补充修正：感应炮 4 个形态、微波炮 5 个形态已恢复旧版最高速度与加速度；无畏的最高速度和加速度已同步按 2.5 倍缩减。')
$lines.Add('')
$lines.Add('分类优先级：先归入 2.5；不在 2.5 但在 3.4 的归入 3.4；两者都没有的归入其余武器。分类按家族 ID 与家族阶段确定，名称仅用于人工核对。')
$lines.Add('')
$lines.Add('## 1. 2.5 有的武器名单')
$lines.Add('')
Add-FamilyTable $lines $category25
$lines.Add('## 2. 3.4 有的武器名单')
$lines.Add('')
$lines.Add('此处只列出 3.4 相比 2.5 新增、且当前版本仍存在的形态。')
$lines.Add('')
Add-FamilyTable $lines $category34
$lines.Add('## 3. 其余武器名单')
$lines.Add('')
$lines.Add('此处列出 2.5 和 3.4 都没有、仅在更晚版本出现的玩家武器形态。目标弹速为调整前弹速除以 2.5。')
$lines.Add('')
Add-FamilyTable $lines $categoryOther

$outputPath = Join-Path $baselineDir '玩家武器弹道速度分类与进度.md'
[IO.File]::WriteAllLines($outputPath, $lines, [Text.UTF8Encoding]::new($true))
Write-Output "Updated: $outputPath"
