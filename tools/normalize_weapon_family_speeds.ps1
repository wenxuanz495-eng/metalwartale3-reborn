param(
    [string]$AssetPath = (Join-Path (Split-Path -Parent $PSScriptRoot) 'decompiled\embedded-xml-assets')
)

$ErrorActionPreference = 'Stop'
$targets = @{
    amplitude = 30
    banger = 20
    highEnergy = 30
    magneticTrack = 40
    phaseTransfer = 25
    plasma = 30
    positron = 40
    protonImpact = 40
    snow = 30
}

foreach ($entry in Get-ChildItem -LiteralPath $AssetPath -File -Filter '*.bin') {
    $text = Get-Content -LiteralPath $entry.FullName -Raw -Encoding UTF8
    $changed = $false
    foreach ($id in $targets.Keys) {
        $blockPattern = '(?s)(<arms\b[^>]*\bid="' + [regex]::Escape($id) + '"[^>]*>)(.*?)(</arms>)'
        $text = [regex]::Replace($text, $blockPattern, {
            param($match)
            $body = $match.Groups[2].Value
            $speed = [string]$targets[$id]
            $body = [regex]::Replace($body, '(?s)(<armsLevel\b[^>]*>.*?</armsLevel>)', {
                param($levelMatch)
                $level = $levelMatch.Groups[1].Value
                $newLevel = [regex]::Replace($level, '<bulletSpeed>\s*[^<]*\s*</bulletSpeed>', "<bulletSpeed>$speed</bulletSpeed>")
                if ($newLevel -eq $level) { return $level }
                $newLevel = [regex]::Replace($newLevel, '<bulletMaxV>\s*[^<]*\s*</bulletMaxV>', "<bulletMaxV>$speed</bulletMaxV>")
                if ($newLevel -notmatch '<bulletMaxV>') {
                    $newLevel = $newLevel -replace '(<bulletSpeed>[^<]*</bulletSpeed>)', "`$1`r`n`t`t`t<bulletMaxV>$speed</bulletMaxV>"
                }
                $newLevel = [regex]::Replace($newLevel, '<bulletMaxVa>\s*[^<]*\s*</bulletMaxVa>', '<bulletMaxVa>0</bulletMaxVa>')
                if ($newLevel -notmatch '<bulletMaxVa>') {
                    $newLevel = $newLevel -replace '(<bulletMaxV>[^<]*</bulletMaxV>)', "`$1`r`n`t`t`t<bulletMaxVa>0</bulletMaxVa>"
                }
                return $newLevel
            })
            if ($body -ne $match.Groups[2].Value) { $script:changed = $true }
            return $match.Groups[1].Value + $body + $match.Groups[3].Value
        })
    }
    if ($changed) {
        [System.IO.File]::WriteAllText($entry.FullName, $text, [System.Text.UTF8Encoding]::new($false))
        Write-Output "Updated $($entry.Name)"
    }
}
