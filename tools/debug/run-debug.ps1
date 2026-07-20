param(
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$Game
)

$ErrorActionPreference = "Stop"
$toolRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$playerPath = Join-Path $toolRoot "flashplayer_sa_debug.exe"

if (-not (Test-Path -LiteralPath $playerPath -PathType Leaf)) {
    throw "CleanFlash SA Debugger is missing: $playerPath"
}

Start-Process -FilePath $playerPath -ArgumentList @($Game) -WorkingDirectory $toolRoot
