[CmdletBinding()]
param(
    [string] $RootPath = '.'
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Resolve-LocalPath {
    param([Parameter(Mandatory)][string] $Path)

    if ([System.IO.Path]::IsPathRooted($Path)) {
        return [System.IO.Path]::GetFullPath($Path)
    }

    return [System.IO.Path]::GetFullPath((Join-Path (Get-Location) $Path))
}

function Get-CoreTextFiles {
    param([Parameter(Mandatory)][string] $Root)

    $relativeFiles = [System.Collections.Generic.List[string]]::new()
    foreach ($path in @(
        'README.md',
        '.codex-plugin\plugin.json',
        '.agents\plugins\marketplace.json',
        'assets\demo-screenshot.svg',
        'skills\babygear-risk-radar\SKILL.md',
        'reports\MAS_QA_REPORT.md',
        'reports\FINAL_REPORT.md'
    )) {
        $relativeFiles.Add($path) | Out-Null
    }

    foreach ($directory in @('docs', 'examples', 'templates', 'mockups')) {
        $fullDirectory = Join-Path $Root $directory
        if (Test-Path -LiteralPath $fullDirectory) {
            Get-ChildItem -LiteralPath $fullDirectory -File -Recurse |
                Where-Object { $_.Extension -in @('.md', '.html', '.json', '.svg', '.txt') } |
                ForEach-Object {
                    $relativeFiles.Add([System.IO.Path]::GetRelativePath($Root, $_.FullName)) | Out-Null
                }
        }
    }

    return $relativeFiles | Sort-Object -Unique
}

$root = Resolve-LocalPath $RootPath
if (-not (Test-Path -LiteralPath $root)) {
    throw "Root path not found: $RootPath"
}

$checks = @(
    [PSCustomObject]@{
        Kind = 'affiliate link'
        Pattern = 'https?://[^\s\)]+amazon\.[^\s\)]*[?&]tag='
    },
    [PSCustomObject]@{
        Kind = 'affiliate marker'
        Pattern = '(?i)\b(rewardstyle|shopstyle|rstyle\.me|affiliate\s+link)\b'
    },
    [PSCustomObject]@{
        Kind = 'tracking campaign parameter'
        Pattern = '(?i)[?&](utm_source|utm_medium|utm_campaign|affid|affiliate)='
    },
    [PSCustomObject]@{
        Kind = 'unsupported specific-brand danger/safety claim'
        Pattern = '(?i)\b(Philips|Avent)(?:\s+Avent)?\s+(?:is|are|was|were)\s+(?:definitively\s+|definitely\s+)?(?:dangerous|unsafe|safe)\b'
    },
    [PSCustomObject]@{
        Kind = 'frontend runtime drift'
        Pattern = '(?i)\b(npm\s+run|localhost:\d+|vite|next\s+dev|docker\s+run)\b'
    }
)

$files = Get-CoreTextFiles -Root $root
$scanned = 0
foreach ($relativeFile in $files) {
    $path = Join-Path $root $relativeFile
    if (-not (Test-Path -LiteralPath $path)) {
        continue
    }

    $text = Get-Content -LiteralPath $path -Raw
    $scanned += 1
    foreach ($check in $checks) {
        if ([regex]::IsMatch($text, $check.Pattern)) {
            throw "Content safety violation: $($check.Kind) in $relativeFile"
        }
    }
}

[PSCustomObject]@{
    Status = 'PASS'
    RootPath = $root
    FilesScanned = $scanned
    Checks = @($checks.Kind)
}
