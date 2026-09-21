Set-StrictMode -Version Latest

# 原生链(2b/2c): AIR SDK 自带 AS3 编译器(mxmlc/compc)全量编译 decompiled 源码树,
# 产出 patch.swf(全部 668 类);运行时 DesktopLoader 先加载 patch 再加载纯基线
# game-baseline.swf,同名类定义先加载者胜,基线只承担资产与符号绑定.
# FFDec 在本链中不再参与构建(仅 BinaryData 回读校验仍借其导出).
# 背景: docs/build/DEV_CHAIN_V2.md 原生链一节;可行性 spike: TMP\air-compile-spike-20260921.

function Get-NativeTools {
  param([Parameter(Mandatory)][string]$RepoRoot)
  $workspaceRoot = Split-Path -Parent $RepoRoot
  $airSdk = $env:AIR_SDK
  if ([string]::IsNullOrWhiteSpace($airSdk)) {
    $airSdk = Join-Path (Join-Path $workspaceRoot "air-mobile-tools") "airsdk-50.2.4.1"
  }
  $jdk = Join-Path (Join-Path $workspaceRoot "air-mobile-tools") "jdk8\jdk8u502-b07"
  $compc = Join-Path (Join-Path $airSdk "bin") "compc.bat"
  $mxmlc = Join-Path (Join-Path $airSdk "bin") "mxmlc.bat"
  foreach ($required in @($compc, $mxmlc, $jdk)) {
    if (-not (Test-Path -LiteralPath $required)) { throw "Native tool missing: $required (set AIR_SDK to override SDK path)" }
  }
  return @{
    AirSdk = $airSdk
    Compc = $compc
    Mxmlc = $mxmlc
    JavaHome = $jdk
  }
}

function Get-NativeSourceFingerprint {
  # 全树指纹: 源码与嵌入资产的每文件 SHA256(排序拼接后再哈希),任何字节变动即失效缓存
  param([Parameter(Mandatory)][string]$RepoRoot)
  $sourceRoot = Join-Path $RepoRoot "decompiled\gamefile\scripts"
  $lines = New-Object System.Collections.Generic.List[string]
  $prefix = $sourceRoot.TrimEnd('\') + '\'
  foreach ($file in (Get-ChildItem -LiteralPath $sourceRoot -Recurse -File | Sort-Object FullName)) {
    $relative = $file.FullName.Substring($prefix.Length)
    $lines.Add("$relative|$(Get-Sha256 $file.FullName)")
  }
  if ($lines.Count -eq 0) { throw "Native source tree is empty: $sourceRoot" }
  return Get-StringSha256 ($lines -join "`n")
}

function Get-NativeDefineValue {
  param([switch]$Mobile)
  if ($Mobile) { "true" } else { "false" }
}

function Build-NativePatch {
  param(
    [Parameter(Mandatory)][string]$RepoRoot,
    [switch]$Mobile,
    [switch]$NoCache
  )
  $RepoRoot = Initialize-ProjectEnvironment $RepoRoot
  $tools = Get-NativeTools $RepoRoot
  $sourceRoot = Join-Path $RepoRoot "decompiled\gamefile\scripts"
  $buildDir = Join-Path $RepoRoot "build"
  $nativeDir = $buildDir
  $cacheRoot = Join-Path (Join-Path $buildDir "cache") "native"
  $output = Join-Path $nativeDir "patch.swf"
  $define = Get-NativeDefineValue -Mobile:$Mobile
  $cacheVersion = "native-patch-v1"
  $swcName = "patch.swc"

  New-Item -ItemType Directory -Force -Path $nativeDir | Out-Null
  $compcJar = Join-Path (Join-Path $tools.AirSdk "lib") "compiler.jar"
  $inputs = @(
    $cacheVersion
    "define|CONFIG::MOBILE=$define"
    "source-tree|$(Get-NativeSourceFingerprint $RepoRoot)"
    "compc|$(Get-Sha256 $tools.Compc)"
  )
  if (Test-Path -LiteralPath $compcJar) { $inputs += "compiler-jar|$(Get-Sha256 $compcJar)" }
  $key = Get-SwfCacheKey $inputs
  $cacheDir = Join-Path $cacheRoot "patch\$key"
  if (-not $NoCache -and (Test-SwfCacheEntry $cacheDir $key "patch.swf")) {
    Install-SwfArtifact (Join-Path $cacheDir "patch.swf") $output
    Write-Host "[CACHE] Native patch hit: $key"
    Write-Host "[OK] Native patch: $(Get-Sha256 $output)"
    return
  }
  Write-Host "[CACHE] Native patch miss: $key"

  $temporaryDir = Join-Path $buildDir (".native-patch-" + [Guid]::NewGuid().ToString("N"))
  New-Item -ItemType Directory -Force -Path $temporaryDir | Out-Null
  try {
    $swcPath = Join-Path $temporaryDir $swcName
    $logPath = Join-Path $temporaryDir "compc.log"
    $previousJava = $env:JAVA_HOME
    $env:JAVA_HOME = $tools.JavaHome
    # PS5.1 会把 native 命令的 stderr(编译警告)包装成终止错误,编译处局部降级,以退出码为准
    $previousEap = $ErrorActionPreference
    $ErrorActionPreference = "Continue"
    try {
      & $tools.Compc `
        -actionscript-file-encoding=UTF-8 `
        "-define+=CONFIG::MOBILE,$define" `
        "-source-path=$sourceRoot" `
        "-include-sources+=$sourceRoot" `
        "-output=$swcPath" *> $logPath
    } finally {
      $ErrorActionPreference = $previousEap
      $env:JAVA_HOME = $previousJava
    }
    if ($LASTEXITCODE -ne 0) {
      Get-Content -LiteralPath $logPath | Select-Object -Last 40 | Write-Host
      throw "Native patch compile failed (exit $LASTEXITCODE); full log: $logPath"
    }
    Add-Type -AssemblyName System.IO.Compression.FileSystem
    $zip = [IO.Compression.ZipFile]::OpenRead($swcPath)
    try {
      $entry = $zip.GetEntry("library.swf")
      if ($null -eq $entry) { throw "patch.swc does not contain library.swf" }
      [IO.Compression.ZipFileExtensions]::ExtractToFile($entry, (Join-Path $temporaryDir "patch.swf"), $true)
    } finally {
      $zip.Dispose()
    }
    Publish-SwfCacheEntry $cacheDir $key (Join-Path $temporaryDir "patch.swf") "patch.swf"
    Install-SwfArtifact (Join-Path $temporaryDir "patch.swf") $output
    Write-Host "[OK] Native patch: $(Get-Sha256 $output)"
  } finally {
    Remove-Item -LiteralPath $temporaryDir -Recurse -Force -ErrorAction SilentlyContinue
  }
}

function Build-NativeLoader {
  param(
    [Parameter(Mandatory)][string]$RepoRoot,
    [switch]$Mobile,
    [switch]$NoCache
  )
  $RepoRoot = Initialize-ProjectEnvironment $RepoRoot
  $tools = Get-NativeTools $RepoRoot
  $loaderSource = Join-Path (Join-Path $RepoRoot "native") "loader\DesktopLoader.as"
  $buildDir = Join-Path $RepoRoot "build"
  $nativeDir = $buildDir
  $cacheRoot = Join-Path (Join-Path $buildDir "cache") "native"
  $output = Join-Path $nativeDir "loader.swf"
  $define = Get-NativeDefineValue -Mobile:$Mobile
  $cacheVersion = "native-loader-v1"

  New-Item -ItemType Directory -Force -Path $nativeDir | Out-Null
  $key = Get-SwfCacheKey @(
    $cacheVersion
    "define|CONFIG::MOBILE=$define"
    "source|$(Get-Sha256 $loaderSource)"
    "mxmlc|$(Get-Sha256 $tools.Mxmlc)"
  )
  $cacheDir = Join-Path $cacheRoot "loader\$key"
  if (-not $NoCache -and (Test-SwfCacheEntry $cacheDir $key "loader.swf")) {
    Install-SwfArtifact (Join-Path $cacheDir "loader.swf") $output
    Write-Host "[CACHE] Native loader hit: $key"
    return
  }

  $temporaryDir = Join-Path $buildDir (".native-loader-" + [Guid]::NewGuid().ToString("N"))
  New-Item -ItemType Directory -Force -Path $temporaryDir | Out-Null
  try {
    $loaderPath = Join-Path $temporaryDir "loader.swf"
    $logPath = Join-Path $temporaryDir "mxmlc.log"
    $previousJava = $env:JAVA_HOME
    $env:JAVA_HOME = $tools.JavaHome
    $previousEap = $ErrorActionPreference
    $ErrorActionPreference = "Continue"
    try {
      & $tools.Mxmlc `
        -debug=true `
        -actionscript-file-encoding=UTF-8 `
        "-define+=CONFIG::MOBILE,$define" `
        "-source-path=$(Split-Path $loaderSource)" `
        $loaderSource `
        "-output=$loaderPath" *> $logPath
    } finally {
      $ErrorActionPreference = $previousEap
      $env:JAVA_HOME = $previousJava
    }
    if ($LASTEXITCODE -ne 0) {
      Get-Content -LiteralPath $logPath | Select-Object -Last 40 | Write-Host
      throw "Native loader compile failed (exit $LASTEXITCODE); full log: $logPath"
    }
    Publish-SwfCacheEntry $cacheDir $key $loaderPath "loader.swf"
    Install-SwfArtifact $loaderPath $output
    Write-Host "[OK] Native loader: $(Get-Sha256 $output)"
  } finally {
    Remove-Item -LiteralPath $temporaryDir -Recurse -Force -ErrorAction SilentlyContinue
  }
}

function Test-NativeBinaryRoundtrip {
  # 21 份嵌入 XML 从 patch.swf 回读,与源 .bin 逐份字节比对(新链对 EmbedXml 21 类的等价性证明)
  param([Parameter(Mandatory)][string]$RepoRoot)
  $RepoRoot = Initialize-ProjectEnvironment $RepoRoot
  $ffdec = Join-Path $RepoRoot "tools\packaging\ffdec\ffdec-cli.exe"
  $patch = Join-Path (Join-Path $RepoRoot "build") "patch.swf"
  $assets = Join-Path (Join-Path $RepoRoot "decompiled\gamefile\scripts") "_assets"
  $exportDir = Join-Path (Join-Path (Join-Path $RepoRoot "build") "cache") "native\roundtrip"
  if (-not (Test-Path -LiteralPath $patch)) { throw "Native patch missing: $patch" }
  Remove-Item -LiteralPath $exportDir -Recurse -Force -ErrorAction SilentlyContinue
  New-Item -ItemType Directory -Force -Path $exportDir | Out-Null
  Invoke-External $ffdec @("-onerror", "abort", "-export", "binaryData", $exportDir, $patch)
  # mxmlc 的 SymbolClass 命名与源文件名不同,按内容哈希集合比对
  $sourceHashes = @(Get-ChildItem -LiteralPath $assets -Filter *.bin | ForEach-Object { Get-Sha256 $_.FullName })
  $exportedHashes = @(Get-ChildItem -LiteralPath $exportDir -Filter *.bin | ForEach-Object { Get-Sha256 $_.FullName })
  $missing = @($sourceHashes | Where-Object { $exportedHashes -notcontains $_ })
  if ($sourceHashes.Count -ne 21) { throw "Expected 21 embedded assets in source, found $($sourceHashes.Count)" }
  if ($exportedHashes.Count -ne $sourceHashes.Count -or $missing.Count -gt 0) {
    throw "Native BinaryData roundtrip failed: exported=$($exportedHashes.Count) expected=$($sourceHashes.Count) missing-by-content=$($missing.Count)"
  }
  Write-Host "[OK] Native BinaryData roundtrip: $($sourceHashes.Count)/$($sourceHashes.Count) byte-identical"
}

function Build-Native {
  param(
    [Parameter(Mandatory)][string]$RepoRoot,
    [switch]$Mobile,
    [switch]$NoCache
  )
  $RepoRoot = Initialize-ProjectEnvironment $RepoRoot
  $buildDir = Join-Path $RepoRoot "build"
  $baseline = Join-Path $RepoRoot "swf\baselines\1.26.2.1-BAT.game.swf"
  $hashFile = Join-Path $RepoRoot "config\build\swf-baseline.sha256"
  if (-not (Test-Path -LiteralPath $baseline)) { throw "Missing baseline: $baseline" }
  $expected = ((Get-Content -LiteralPath $hashFile -First 1) -split "\s+")[0]
  $actual = Get-Sha256 $baseline
  if ($actual -ne $expected) { throw "Immutable SWF baseline hash mismatch. Expected=$expected Actual=$actual" }

  Build-NativePatch $RepoRoot -Mobile:$Mobile -NoCache:$NoCache
  Build-NativeLoader $RepoRoot -Mobile:$Mobile -NoCache:$NoCache
  Test-NativeBinaryRoundtrip $RepoRoot

  $baselineTarget = Join-Path $buildDir "game-baseline.swf"
  Install-SwfArtifact $baseline $baselineTarget
  $define = Get-NativeDefineValue -Mobile:$Mobile
  $info = [ordered]@{
    version = 1
    chain = "native-2b"
    mobile = [bool]$Mobile
    define = "CONFIG::MOBILE=$define"
    baseline = $expected
    patch = Get-Sha256 (Join-Path (Join-Path $buildDir "native") "patch.swf")
    loader = Get-Sha256 (Join-Path (Join-Path $buildDir "native") "loader.swf")
    builtAt = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
  }
  $info | ConvertTo-Json | Set-Content -LiteralPath (Join-Path $buildDir "native-build-info.json") -Encoding utf8
  Write-Host "[OK] Native chain ready: build\{patch.swf,loader.swf,game-baseline.swf} (CONFIG::MOBILE=$define)"
}

Export-ModuleMember -Function Get-NativeTools, Build-NativePatch, Build-NativeLoader, Test-NativeBinaryRoundtrip, Build-Native
