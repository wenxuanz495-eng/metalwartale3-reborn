param([Parameter(Mandatory=$true)][string]$RepoRoot,[Parameter(Mandatory=$true)][string]$Manifest)
$ErrorActionPreference='Stop'
if(!(Test-Path -LiteralPath $Manifest)){throw 'current manifest missing'}
$lines=Get-Content -LiteralPath $Manifest | Where-Object { $_ -notmatch '^\s*(#|$)' }
if(!$lines -or $lines.Count -eq 0){throw 'current manifest empty'}
$seen=@{}
foreach($line in $lines){
  $p=$line -split '\s+',3
  if($p.Count -ne 2 -or $p[0] -notmatch '^[0-9A-Fa-f]{64}$' -or $p[1] -notmatch '^\*[^ ]+$'){throw "invalid manifest line: $line"}
  $rel=$p[1].Substring(1) -replace '/','\'
  if([IO.Path]::IsPathRooted($rel) -or $rel -match '(^|\\)\.\.(\\|$)'){throw "unsafe path: $rel"}
  $full=[IO.Path]::GetFullPath((Join-Path $RepoRoot $rel)); if(!$full.StartsWith([IO.Path]::GetFullPath($RepoRoot),[StringComparison]::OrdinalIgnoreCase)){throw "path escape: $rel"}
  if($seen.ContainsKey($full)){throw "duplicate path: $rel"}; $seen[$full]=$true
  if(!(Test-Path -LiteralPath $full)){throw "missing resource: $rel"}
  $sha=[Security.Cryptography.SHA256]::Create(); try { $actual=(([BitConverter]::ToString($sha.ComputeHash([IO.File]::ReadAllBytes($full)))) -replace '-','') } finally { $sha.Dispose() }
  if($actual -ine $p[0]){throw "hash mismatch: $rel"}
  Write-Output "[CHECK] $rel (current manifest)"
}
