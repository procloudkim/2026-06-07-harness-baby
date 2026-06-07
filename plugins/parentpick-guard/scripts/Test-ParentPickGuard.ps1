[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$pluginRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..'))
$repoRoot = [System.IO.Path]::GetFullPath((Join-Path $pluginRoot '..\..'))

$requiredFiles = @(
    (Join-Path $repoRoot 'README.md'),
    (Join-Path $repoRoot 'PLANS.md'),
    (Join-Path $repoRoot '.agents\plugins\marketplace.json'),
    (Join-Path $repoRoot 'docs\DECISIONS.md'),
    (Join-Path $repoRoot 'docs\RUN_LOG.md'),
    (Join-Path $repoRoot 'docs\FINAL_REPORT.md'),
    (Join-Path $repoRoot 'docs\DEMO_SCRIPT.md'),
    (Join-Path $pluginRoot '.codex-plugin\plugin.json'),
    (Join-Path $pluginRoot 'skills\parentpick-guard\SKILL.md'),
    (Join-Path $pluginRoot 'examples\avent-pacifier-case.json'),
    (Join-Path $pluginRoot 'templates\report-template.html'),
    (Join-Path $pluginRoot 'tools\Invoke-ParentPickGuard.ps1'),
    (Join-Path $pluginRoot 'scripts\New-ParentPickReport.ps1'),
    (Join-Path $pluginRoot 'scripts\New-ParentPickDemoScreenshot.ps1'),
    (Join-Path $pluginRoot 'scripts\Test-ParentPickGuardEvidence.ps1'),
    (Join-Path $pluginRoot 'scripts\Test-ParentPickGuard.ps1')
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

if ($manifest.homepage -ne 'https://github.com/procloudkim/2026-06-07-harness-baby') {
    throw "Plugin manifest homepage URL is missing or incorrect."
}

$readme = Get-Content -LiteralPath (Join-Path $repoRoot 'README.md') -Raw
if (-not $readme.Contains('https://github.com/procloudkim/2026-06-07-harness-baby')) {
    throw "Root README does not contain the public GitHub URL."
}

$runLog = Get-Content -LiteralPath (Join-Path $repoRoot 'docs\RUN_LOG.md') -Raw
$decisions = Get-Content -LiteralPath (Join-Path $repoRoot 'docs\DECISIONS.md') -Raw
if ($runLog.Contains('Plugin validation passed') -and $decisions.Contains('The Codex plugin validator was attempted, but the local Python environment lacks `PyYAML`.')) {
    throw "Decision log contradicts run log about plugin validator status."
}

if ($runLog.Contains('Plugin validation passed') -and -not $decisions.Contains('temporary in-repo `.tmp-validator-deps`')) {
    throw "Decision log does not record the temporary validator dependency path used for official validation."
}

$skillText = Get-Content -LiteralPath (Join-Path $pluginRoot 'skills\parentpick-guard\SKILL.md') -Raw
if (-not [regex]::IsMatch($skillText, '\A---\r?\nname:\s*parentpick-guard\r?\n')) {
    throw "Skill metadata front matter is missing or malformed."
}

$requiredInterfaceFields = @(
    'displayName',
    'shortDescription',
    'longDescription',
    'developerName',
    'category',
    'capabilities',
    'defaultPrompt',
    'brandColor',
    'composerIcon',
    'logo',
    'screenshots'
)

foreach ($field in $requiredInterfaceFields) {
    if ($null -eq $manifest.interface.PSObject.Properties[$field] -or $null -eq $manifest.interface.PSObject.Properties[$field].Value) {
        throw "Plugin manifest interface field missing: $field"
    }
}

foreach ($unsupportedField in @('hooks', 'apps', 'mcpServers')) {
    if ($null -ne $manifest.PSObject.Properties[$unsupportedField]) {
        throw "Plugin manifest includes unsupported or unbacked field: $unsupportedField"
    }
}

foreach ($scriptPath in @(
    (Join-Path $pluginRoot 'tools\Invoke-ParentPickGuard.ps1'),
    (Join-Path $pluginRoot 'scripts\New-ParentPickReport.ps1'),
    (Join-Path $pluginRoot 'scripts\New-ParentPickDemoScreenshot.ps1'),
    (Join-Path $pluginRoot 'scripts\Test-ParentPickGuardEvidence.ps1'),
    (Join-Path $pluginRoot 'scripts\Test-ParentPickGuard.ps1')
)) {
    $parseTokens = $null
    $parseErrors = $null
    [System.Management.Automation.Language.Parser]::ParseFile($scriptPath, [ref] $parseTokens, [ref] $parseErrors) | Out-Null
    if ($parseErrors.Count -gt 0) {
        $messages = ($parseErrors | ForEach-Object { $_.Message }) -join '; '
        throw "PowerShell syntax errors found in $scriptPath`: $messages"
    }
}

$marketplace = Get-Content -LiteralPath (Join-Path $repoRoot '.agents\plugins\marketplace.json') -Raw | ConvertFrom-Json -Depth 16
$marketplaceEntry = @($marketplace.plugins) | Where-Object { $_.name -eq 'parentpick-guard' } | Select-Object -First 1
if ($null -eq $marketplaceEntry) {
    throw "Marketplace entry for parentpick-guard was not found."
}

if ($marketplaceEntry.source.source -ne 'local' -or $marketplaceEntry.source.path -ne './plugins/parentpick-guard') {
    throw "Marketplace source for parentpick-guard is incorrect."
}

if ($marketplaceEntry.policy.installation -ne 'AVAILABLE' -or $marketplaceEntry.policy.authentication -ne 'ON_INSTALL') {
    throw "Marketplace policy for parentpick-guard is incorrect."
}

$examplePath = Join-Path $pluginRoot 'examples\avent-pacifier-case.json'
$reportPath = Join-Path $pluginRoot 'generated\sample-report.html'
$screenshotPath = Join-Path $pluginRoot 'assets\demo-screenshot.png'
$tempValidationParent = Join-Path $repoRoot '.codex-temp'
$tempValidationRoot = Join-Path $tempValidationParent 'parentpick-guard-validation'

if (Test-Path -LiteralPath $tempValidationRoot) {
    Remove-Item -LiteralPath $tempValidationRoot -Recurse -Force
}
New-Item -ItemType Directory -Path $tempValidationRoot | Out-Null

$generatorResult = & (Join-Path $pluginRoot 'scripts\New-ParentPickReport.ps1') -InputPath $examplePath -OutputPath $reportPath
& (Join-Path $pluginRoot 'scripts\New-ParentPickDemoScreenshot.ps1') -ReportPath $reportPath -OutputPath $screenshotPath -GenerateBrandAssets | Out-Null

if (-not (Test-Path -LiteralPath $reportPath)) {
    throw "Generated sample report missing: $reportPath"
}

if ($generatorResult.SourceCount -ne 9) {
    throw "Generated sample report source count changed. Expected 9 but got $($generatorResult.SourceCount)."
}

if (-not (Test-Path -LiteralPath $screenshotPath)) {
    throw "Generated screenshot missing: $screenshotPath"
}

$iconPath = Join-Path $pluginRoot 'assets\icon.png'
$logoPath = Join-Path $pluginRoot 'assets\logo.png'
foreach ($assetPath in @($iconPath, $logoPath)) {
    if (-not (Test-Path -LiteralPath $assetPath)) {
        throw "Generated brand asset missing: $assetPath"
    }
}

foreach ($assetPath in @($screenshotPath, $iconPath, $logoPath)) {
    $assetInfo = Get-Item -LiteralPath $assetPath
    if ($assetInfo.Length -le 0) {
        throw "Generated asset is empty: $assetPath"
    }
}

$manifestScreenshotPath = Join-Path $pluginRoot ($manifest.interface.screenshots[0] -replace '/', '\')
if (-not (Test-Path -LiteralPath $manifestScreenshotPath)) {
    throw "Manifest screenshot path does not exist: $manifestScreenshotPath"
}

$reportHtml = Get-Content -LiteralPath $reportPath -Raw
if ($reportHtml.Contains('Unnamed source')) {
    throw "Generated sample report contains fallback source name."
}

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

$toolWrapperPath = Join-Path $pluginRoot 'tools\Invoke-ParentPickGuard.ps1'
$toolWrapperReportPath = Join-Path $tempValidationRoot 'tool-wrapper-report.html'
& $toolWrapperPath -InputPath $examplePath -OutputPath $toolWrapperReportPath | Out-Null

if (-not (Test-Path -LiteralPath $toolWrapperReportPath)) {
    throw "Tool wrapper report missing: $toolWrapperReportPath"
}

$toolWrapperReportHtml = Get-Content -LiteralPath $toolWrapperReportPath -Raw
$expectedToolFragments = @(
    'ParentPick Guard',
    'Source Map',
    'Decision Criteria'
)

foreach ($fragment in $expectedToolFragments) {
    if (-not $toolWrapperReportHtml.Contains($fragment)) {
        throw "Tool wrapper HTML does not contain expected fragment: $fragment"
    }
}

if ([regex]::IsMatch($toolWrapperReportHtml, 'href\s*=\s*["''](?:javascript|data):', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)) {
    throw "Tool wrapper HTML contains an unsafe href scheme."
}

$checkedFailureCases = [System.Collections.Generic.List[string]]::new()

function Invoke-ExpectedGeneratorFailure {
    param(
        [Parameter(Mandatory)]
        [string] $CaseName,
        [hashtable] $Patch = @{},
        [scriptblock] $Mutate,
        [Parameter(Mandatory)]
        [string] $ExpectedMessage
    )

    $caseInput = Join-Path $tempValidationRoot "$CaseName.json"
    $caseOutput = Join-Path $tempValidationRoot "$CaseName.html"
    $caseData = Get-Content -LiteralPath $examplePath -Raw | ConvertFrom-Json -Depth 32

    if (Test-Path -LiteralPath $caseOutput) {
        Remove-Item -LiteralPath $caseOutput -Force
    }

    foreach ($key in $Patch.Keys) {
        $caseData.$key = $Patch[$key]
    }

    if ($null -ne $Mutate) {
        & $Mutate $caseData
    }

    $caseData | ConvertTo-Json -Depth 32 | Set-Content -LiteralPath $caseInput -Encoding UTF8

    try {
        & (Join-Path $pluginRoot 'scripts\New-ParentPickReport.ps1') -InputPath $caseInput -OutputPath $caseOutput | Out-Null
        throw "Expected generator failure for $CaseName, but generation succeeded."
    } catch {
        if (-not $_.Exception.Message.Contains($ExpectedMessage)) {
            throw "Unexpected generator failure for $CaseName. Expected message fragment '$ExpectedMessage' but got '$($_.Exception.Message)'."
        }

        if (Test-Path -LiteralPath $caseOutput) {
            throw "Generator wrote output for failed case: $CaseName"
        }

        $checkedFailureCases.Add($CaseName) | Out-Null
    }
}

Invoke-ExpectedGeneratorFailure `
    -CaseName 'blank-report-title' `
    -Patch @{ reportTitle = '   ' } `
    -ExpectedMessage 'Input JSON field must be a non-empty string: reportTitle'

Invoke-ExpectedGeneratorFailure `
    -CaseName 'empty-sources' `
    -Patch @{ sources = @() } `
    -ExpectedMessage 'Input JSON field must contain at least one item: sources'

Invoke-ExpectedGeneratorFailure `
    -CaseName 'unsafe-url' `
    -Patch @{ sources = @([PSCustomObject] @{ name = 'Unsafe URL fixture'; type = 'Fixture'; claim = 'URL scheme is unsafe.'; use = 'Verify URL rejection.'; url = 'javascript:alert(1)' }) } `
    -ExpectedMessage 'Input JSON source URL uses unsupported scheme: javascript'

Invoke-ExpectedGeneratorFailure `
    -CaseName 'blank-source-name' `
    -Mutate { param($Data) $Data.sources[0].name = '   ' } `
    -ExpectedMessage 'Input JSON source field must be a non-empty string: sources[0].name'

Invoke-ExpectedGeneratorFailure `
    -CaseName 'null-sources' `
    -Patch @{ sources = @($null) } `
    -ExpectedMessage 'Input JSON field must contain at least one usable item: sources'

$reportedValidationTempPath = $tempValidationRoot
if (Test-Path -LiteralPath $tempValidationRoot) {
    Remove-Item -LiteralPath $tempValidationRoot -Recurse -Force
}

if ((Test-Path -LiteralPath $tempValidationParent) -and @((Get-ChildItem -LiteralPath $tempValidationParent -Force)).Count -eq 0) {
    Remove-Item -LiteralPath $tempValidationParent -Force
}

[PSCustomObject] @{
    Status = 'PASS'
    PluginRoot = $pluginRoot
    ReportPath = $reportPath
    ScreenshotPath = $screenshotPath
    ValidationTempPath = $reportedValidationTempPath
    RequiredFileCount = $requiredFiles.Count
    CheckedScriptCount = 5
    CheckedToolCount = 1
    CheckedFailureCases = @($checkedFailureCases)
}
