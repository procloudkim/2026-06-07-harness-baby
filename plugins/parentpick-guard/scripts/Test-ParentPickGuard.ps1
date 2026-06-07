[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$pluginRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..'))
$repoRoot = [System.IO.Path]::GetFullPath((Join-Path $pluginRoot '..\..'))

$requiredFiles = @(
    (Join-Path $repoRoot 'README.md'),
    (Join-Path $repoRoot '.agents\plugins\marketplace.json'),
    (Join-Path $repoRoot 'docs\FINAL_REPORT.md'),
    (Join-Path $repoRoot 'docs\DEMO_SCRIPT.md'),
    (Join-Path $pluginRoot '.codex-plugin\plugin.json'),
    (Join-Path $pluginRoot 'skills\parentpick-guard\SKILL.md'),
    (Join-Path $pluginRoot 'examples\avent-pacifier-case.json'),
    (Join-Path $pluginRoot 'templates\report-template.html'),
    (Join-Path $pluginRoot 'scripts\New-ParentPickReport.ps1'),
    (Join-Path $pluginRoot 'scripts\New-ParentPickDemoScreenshot.ps1')
)

foreach ($path in $requiredFiles) {
    if (-not (Test-Path -LiteralPath $path)) {
        throw "Required file missing: $path"
    }
}

$manifest = Get-Content -LiteralPath (Join-Path $pluginRoot '.codex-plugin\plugin.json') -Raw | ConvertFrom-Json -Depth 16
if ($manifest.name -ne 'parentpick-guard') {
    throw "Unexpected plugin name: $($manifest.name)"
}

if ($manifest.repository -ne 'https://github.com/procloudkim/2026-06-07-harness-baby') {
    throw "Plugin manifest repository URL is missing or incorrect."
}

$marketplace = Get-Content -LiteralPath (Join-Path $repoRoot '.agents\plugins\marketplace.json') -Raw | ConvertFrom-Json -Depth 16
$marketplaceEntry = @($marketplace.plugins) | Where-Object { $_.name -eq 'parentpick-guard' } | Select-Object -First 1
if ($null -eq $marketplaceEntry) {
    throw "Marketplace entry for parentpick-guard was not found."
}

$examplePath = Join-Path $pluginRoot 'examples\avent-pacifier-case.json'
$reportPath = Join-Path $pluginRoot 'generated\sample-report.html'
$screenshotPath = Join-Path $pluginRoot 'assets\demo-screenshot.png'

& (Join-Path $pluginRoot 'scripts\New-ParentPickReport.ps1') -InputPath $examplePath -OutputPath $reportPath | Out-Null
& (Join-Path $pluginRoot 'scripts\New-ParentPickDemoScreenshot.ps1') -ReportPath $reportPath -OutputPath $screenshotPath -GenerateBrandAssets | Out-Null

if (-not (Test-Path -LiteralPath $reportPath)) {
    throw "Generated sample report missing: $reportPath"
}

if (-not (Test-Path -LiteralPath $screenshotPath)) {
    throw "Generated screenshot missing: $screenshotPath"
}

$reportHtml = Get-Content -LiteralPath $reportPath -Raw
$expectedFragments = @(
    'ParentPick Guard',
    'Public-source case boundary',
    'Source Map',
    'MAS Persona Lens',
    'MECE Risk Map',
    'Decision Criteria',
    'not medical advice'
)

foreach ($fragment in $expectedFragments) {
    if (-not $reportHtml.Contains($fragment)) {
        throw "Generated HTML does not contain expected fragment: $fragment"
    }
}

[PSCustomObject] @{
    Status = 'PASS'
    PluginRoot = $pluginRoot
    ReportPath = $reportPath
    ScreenshotPath = $screenshotPath
    RequiredFileCount = $requiredFiles.Count
}
