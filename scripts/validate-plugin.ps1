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

function Assert-File {
    param(
        [Parameter(Mandatory)][string] $Root,
        [Parameter(Mandatory)][string] $RelativePath
    )

    $path = Join-Path $Root $RelativePath
    if (-not (Test-Path -LiteralPath $path)) {
        throw "Required file missing: $RelativePath"
    }

    $item = Get-Item -LiteralPath $path
    if ($item.Length -le 0) {
        throw "Required file is empty: $RelativePath"
    }
}

function Assert-RelativeManifestPath {
    param(
        [Parameter(Mandatory)][string] $Field,
        [AllowNull()][object] $Value
    )

    foreach ($path in @($Value)) {
        if ($null -eq $path) {
            continue
        }

        $text = [string] $path
        if (-not $text.StartsWith('./')) {
            throw "Manifest path must start with ./: $Field"
        }

        if ($text.Contains('..')) {
            throw "Manifest path must not escape plugin root: $Field"
        }
    }
}

function Assert-TextContains {
    param(
        [Parameter(Mandatory)][string] $Text,
        [Parameter(Mandatory)][string] $Needle,
        [Parameter(Mandatory)][string] $Label
    )

    if (-not $Text.Contains($Needle)) {
        throw "$Label missing expected text: $Needle"
    }
}

$root = Resolve-LocalPath $RootPath
if (-not (Test-Path -LiteralPath $root)) {
    throw "Root path not found: $RootPath"
}

$requiredFiles = @(
    '.codex-plugin\plugin.json',
    'skills\babygear-risk-radar\SKILL.md',
    '.agents\plugins\marketplace.json',
    'assets\demo-screenshot.svg',
    'examples\avent-pacifier-risk-brief.md',
    'examples\sample-output.md',
    'scripts\validate-plugin.ps1',
    'docs\ASSUMPTIONS.md',
    'docs\MAS_DECISIONS.md',
    'docs\ACCEPTANCE_CRITERIA.md',
    'docs\COMMIT_LOG.md',
    'docs\FINAL_REPORT.md',
    'docs\DEMO_SCRIPT.md',
    'reports\MAS_QA_REPORT.md',
    'reports\FINAL_REPORT.md',
    'README.md',
    'LICENSE',
    '.gitignore'
)

foreach ($relativePath in $requiredFiles) {
    Assert-File -Root $root -RelativePath $relativePath
}

$manifestPath = Join-Path $root '.codex-plugin\plugin.json'
$manifest = Get-Content -LiteralPath $manifestPath -Raw | ConvertFrom-Json -Depth 32
if ($manifest.name -ne 'babygear-risk-radar') {
    throw "Unexpected plugin name: $($manifest.name)"
}

if ($manifest.repository -ne 'https://github.com/procloudkim/2026-06-07-harness-baby') {
    throw "Plugin manifest repository URL is missing or incorrect."
}

foreach ($unsupportedField in @('hooks', 'mcpServers', 'apps')) {
    if ($null -ne $manifest.PSObject.Properties[$unsupportedField]) {
        throw "Manifest must not include $unsupportedField for this Ralphthon package."
    }
}

Assert-RelativeManifestPath -Field 'skills' -Value $manifest.skills
Assert-RelativeManifestPath -Field 'interface.screenshots' -Value $manifest.interface.screenshots

$skillPath = Join-Path $root 'skills\babygear-risk-radar\SKILL.md'
$skillText = Get-Content -LiteralPath $skillPath -Raw
Assert-TextContains -Text $skillText -Needle 'name: babygear-risk-radar' -Label 'Skill front matter'
Assert-TextContains -Text $skillText -Needle 'MAS-QA Checklist' -Label 'Skill workflow'
Assert-TextContains -Text $skillText -Needle 'not medical advice' -Label 'Skill safety boundary'

$marketplacePath = Join-Path $root '.agents\plugins\marketplace.json'
$marketplace = Get-Content -LiteralPath $marketplacePath -Raw | ConvertFrom-Json -Depth 32
$entry = @($marketplace.plugins) | Where-Object { $_.name -eq 'babygear-risk-radar' } | Select-Object -First 1
if ($null -eq $entry) {
    throw "Marketplace entry missing: babygear-risk-radar"
}

if ($entry.source.source -ne 'local' -or $entry.source.path -ne './') {
    throw "MarketplacePath must be ./"
}

if ($entry.policy.installation -ne 'AVAILABLE' -or $entry.policy.authentication -ne 'ON_INSTALL') {
    throw "Marketplace policy is incorrect."
}

$readme = Get-Content -LiteralPath (Join-Path $root 'README.md') -Raw
Assert-TextContains -Text $readme -Needle '# BabyGear Risk Radar Codex Plugin' -Label 'README'
Assert-TextContains -Text $readme -Needle '![Demo screenshot](./assets/demo-screenshot.svg)' -Label 'README'
Assert-TextContains -Text $readme -Needle 'https://github.com/procloudkim/2026-06-07-harness-baby' -Label 'README'

$finalReport = Get-Content -LiteralPath (Join-Path $root 'reports\FINAL_REPORT.md') -Raw
Assert-TextContains -Text $finalReport -Needle 'https://github.com/procloudkim/2026-06-07-harness-baby' -Label 'FINAL_REPORT'
Assert-TextContains -Text $finalReport -Needle 'Validation: PASS' -Label 'FINAL_REPORT'

$masQa = Get-Content -LiteralPath (Join-Path $root 'reports\MAS_QA_REPORT.md') -Raw
Assert-TextContains -Text $masQa -Needle 'MAS-QA Result: PASS' -Label 'MAS_QA_REPORT'

$trackedSecretPatterns = @(
    '\.env($|\.)',
    '\.pem$',
    '\.key$',
    '\.p12$',
    '\.pfx$',
    'auth\.json$'
)

if ((Split-Path -Leaf $root) -eq (Split-Path -Leaf (Get-Location))) {
    $trackedFiles = & git ls-files
    foreach ($trackedFile in $trackedFiles) {
        foreach ($pattern in $trackedSecretPatterns) {
            if ([regex]::IsMatch($trackedFile, $pattern, [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)) {
                throw "Tracked secret-like file found: $trackedFile"
            }
        }
    }
}

[PSCustomObject]@{
    Status = 'PASS'
    PluginName = $manifest.name
    MarketplacePath = $entry.source.path
    Screenshot = './assets/demo-screenshot.svg'
    SkillPath = 'skills/babygear-risk-radar/SKILL.md'
    GitHubUrl = $manifest.repository
    RequiredFileCount = $requiredFiles.Count
}
