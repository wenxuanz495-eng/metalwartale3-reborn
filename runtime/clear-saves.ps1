$ErrorActionPreference = "Stop"

$root = [System.IO.Path]::GetFullPath(
    (Split-Path -Parent $MyInvocation.MyCommand.Path)
).TrimEnd("\")
$saves = [System.IO.Path]::GetFullPath(
    (Join-Path $root "saves")
).TrimEnd("\")
$expected = ($root + "\saves").TrimEnd("\")

if ($saves -ne $expected -or $saves -eq $root) {
    throw "Save path validation failed."
}

$runningPlayer = Get-CimInstance Win32_Process |
    Where-Object {
        $_.Name -in @("FlashPlayer.exe", "flashplayer_32_sa_debug.exe") -and
        $_.CommandLine -like ("*" + $root + "*")
    }

if ($null -ne $runningPlayer) {
    throw "The game is running. Close it before clearing saves."
}

New-Item -ItemType Directory -Path $saves -Force | Out-Null
Get-ChildItem -LiteralPath $saves -Force |
    Remove-Item -Force -Recurse
