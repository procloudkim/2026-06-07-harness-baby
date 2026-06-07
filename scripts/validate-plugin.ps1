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
    'mockups\korean-parent-risk-radar.html',
    'examples\avent-pacifier-risk-brief.md',
    'examples\korean-demo-prompt.md',
    'examples\korean-plugin-run-output.md',
    'examples\sample-output.md',
    'templates\babygear-mece-report-template.md',
    'templates\parent-action-card-template.md',
    'scripts\validate-plugin.ps1',
    'scripts\New-BabyGearDemoPrompt.ps1',
    'scripts\Show-SubmissionSummary.ps1',
    'scripts\Test-ContentSafety.ps1',
    'docs\ASSUMPTIONS.md',
    'docs\MAS_DECISIONS.md',
    'docs\ACCEPTANCE_CRITERIA.md',
    'docs\COMMIT_LOG.md',
    'docs\FINAL_REPORT.md',
    'docs\DEMO_SCRIPT.md',
    'docs\AUTHORITY_SOURCE_MAP.md',
    'docs\MAS_ROUNDS.md',
    'docs\OPERATION_NOTES.md',
    'docs\SUBMISSION_CHECKLIST.md',
    'docs\KOREAN_QUICKSTART.md',
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
Assert-TextContains -Text $skillText -Needle 'Authority Source Ladder' -Label 'Skill authority ladder'
Assert-TextContains -Text $skillText -Needle 'CPSC' -Label 'Skill CPSC source'
Assert-TextContains -Text $skillText -Needle 'AAP/HealthyChildren' -Label 'Skill AAP source'
Assert-TextContains -Text $skillText -Needle 'FDA BPA' -Label 'Skill FDA source'
Assert-TextContains -Text $skillText -Needle 'NIEHS BPA' -Label 'Skill NIEHS source'
Assert-TextContains -Text $skillText -Needle 'templates/babygear-mece-report-template.md' -Label 'Skill template reference'
Assert-TextContains -Text $skillText -Needle 'templates/parent-action-card-template.md' -Label 'Skill action-card template reference'

foreach ($scriptRelativePath in @('scripts\validate-plugin.ps1', 'scripts\New-BabyGearDemoPrompt.ps1', 'scripts\Show-SubmissionSummary.ps1', 'scripts\Test-ContentSafety.ps1')) {
    $parseTokens = $null
    $parseErrors = $null
    [System.Management.Automation.Language.Parser]::ParseFile((Join-Path $root $scriptRelativePath), [ref] $parseTokens, [ref] $parseErrors) | Out-Null
    if ($parseErrors.Count -gt 0) {
        $messages = ($parseErrors | ForEach-Object { $_.Message }) -join '; '
        throw "PowerShell syntax errors found in $scriptRelativePath`: $messages"
    }
}

$summaryScript = Get-Content -LiteralPath (Join-Path $root 'scripts\Show-SubmissionSummary.ps1') -Raw
foreach ($needle in @(
    'KoreanMockPage',
    'mockups/korean-parent-risk-radar.html',
    'KoreanPluginOutput',
    'examples/korean-plugin-run-output.md',
    'KoreanPromptPacket',
    'examples/korean-demo-prompt.md',
    'PromptGeneratorCommand',
    'scripts\New-BabyGearDemoPrompt.ps1'
)) {
    Assert-TextContains -Text $summaryScript -Needle $needle -Label 'Show-SubmissionSummary'
}

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
Assert-TextContains -Text $readme -Needle 'docs/KOREAN_QUICKSTART.md' -Label 'README'

$demoScript = Get-Content -LiteralPath (Join-Path $root 'docs\DEMO_SCRIPT.md') -Raw
Assert-TextContains -Text $demoScript -Needle 'static README screenshot and sample prompt' -Label 'DEMO_SCRIPT'
Assert-TextContains -Text $demoScript -Needle 'No app server, deployment, browser automation, or external API is required.' -Label 'DEMO_SCRIPT'

$koreanMockPage = Get-Content -LiteralPath (Join-Path $root 'mockups\korean-parent-risk-radar.html') -Raw
foreach ($needle in @(
    '한글 영유아 제품 리스크 레이더',
    'Case 1 - Philips Avent 쪽쪽이 BPA 논란',
    'Case 2 - Philips Avent 관련 YouTube 제보 입력',
    'https://www.youtube.com/watch?v=EJKZ8XXYku0',
    'Case 3 - Philips Avent 디지털 비디오 베이비모니터 replacement',
    'Case 4 - Fisher-Price 공식 CPSC 리콜 맥락',
    'Rock ''n Play',
    'Snuga Swing',
    'MECE 근거 맵',
    '리스크 매트릭스',
    'MAS Round - 정반합',
    '부모 행동 카드',
    '의학적 조언이나 구매 추천이 아닙니다'
)) {
    Assert-TextContains -Text $koreanMockPage -Needle $needle -Label 'KOREAN_MOCK_PAGE'
}

$koreanPluginOutput = Get-Content -LiteralPath (Join-Path $root 'examples\korean-plugin-run-output.md') -Raw
foreach ($needle in @(
    'BabyGear Risk Radar 실제 사용 예시 출력',
    'Product and Usage Context',
    'MECE Evidence Map',
    'Authority Source Ladder',
    'Safety and Regulatory Risk Matrix',
    'MAS Debate',
    'Final Parent Action Card',
    'Uncertainty and Citation Gaps',
    'Philips Avent BPA 논란',
    'YouTube case-2',
    'https://www.youtube.com/watch?v=EJKZ8XXYku0',
    'Philips Avent monitor replacement',
    'Fisher-Price CPSC recall context',
    '의학적 조언'
)) {
    Assert-TextContains -Text $koreanPluginOutput -Needle $needle -Label 'KOREAN_PLUGIN_OUTPUT'
}

$koreanDemoPrompt = Get-Content -LiteralPath (Join-Path $root 'examples\korean-demo-prompt.md') -Raw
foreach ($needle in @(
    'BabyGear Risk Radar Korean Demo Prompt Packet',
    'Use the `babygear-risk-radar` Codex plugin',
    'Case 1 - Philips Avent 쪽쪽이 BPA 논란',
    'Case 2 - Philips Avent 관련 YouTube 제보 입력',
    'https://www.youtube.com/watch?v=EJKZ8XXYku0',
    'Case 3 - Philips Avent monitor replacement context',
    'Case 4 - Fisher-Price CPSC recall context',
    'MAS-QA checklist',
    'Final parent action card',
    '의학적 조언이 아닙니다',
    '특정 브랜드나 제품을 안전하다고 또는 위험하다고 단정하지 마세요',
    '외부 API 호출 없이 작성하세요'
)) {
    Assert-TextContains -Text $koreanDemoPrompt -Needle $needle -Label 'KOREAN_DEMO_PROMPT'
}

$promptGeneratorScript = Get-Content -LiteralPath (Join-Path $root 'scripts\New-BabyGearDemoPrompt.ps1') -Raw
foreach ($needle in @(
    'OutputPath must stay inside repository root',
    'Test-PathInsideRoot',
    'DirectorySeparatorChar',
    'CaseCount = 4',
    'ExternalApiRequired = $false',
    'BabyGear Risk Radar Korean Demo Prompt Packet'
)) {
    Assert-TextContains -Text $promptGeneratorScript -Needle $needle -Label 'New-BabyGearDemoPrompt'
}

$promptValidationTempRoot = Join-Path $root '.codex-temp\babygear-demo-prompt-validation'
$promptValidationOutput = Join-Path $promptValidationTempRoot 'prompt.md'
try {
    New-Item -ItemType Directory -Force -Path $promptValidationTempRoot | Out-Null
    $promptGeneratorOutput = & pwsh -NoProfile -File (Join-Path $root 'scripts\New-BabyGearDemoPrompt.ps1') -OutputPath $promptValidationOutput 2>&1 | Out-String
    if ($LASTEXITCODE -ne 0) {
        throw "Prompt generator failed: $promptGeneratorOutput"
    }

    Assert-File -Root $promptValidationTempRoot -RelativePath 'prompt.md'
    $generatedPrompt = Get-Content -LiteralPath $promptValidationOutput -Raw
    Assert-TextContains -Text $generatedPrompt -Needle 'Use the `babygear-risk-radar` Codex plugin' -Label 'Generated prompt'
    Assert-TextContains -Text $generatedPrompt -Needle 'https://www.youtube.com/watch?v=EJKZ8XXYku0' -Label 'Generated prompt'
    Assert-TextContains -Text $generatedPrompt -Needle 'Fisher-Price CPSC recall context' -Label 'Generated prompt'
}
finally {
    if (Test-Path -LiteralPath $promptValidationTempRoot) {
        $resolvedTempRoot = [System.IO.Path]::GetFullPath($promptValidationTempRoot)
        $allowedTempParent = [System.IO.Path]::GetFullPath((Join-Path $root '.codex-temp'))
        $allowedTempPrefix = $allowedTempParent.TrimEnd([System.IO.Path]::DirectorySeparatorChar, [System.IO.Path]::AltDirectorySeparatorChar) + [System.IO.Path]::DirectorySeparatorChar
        if (-not ($resolvedTempRoot.Equals($allowedTempParent, [System.StringComparison]::OrdinalIgnoreCase) -or $resolvedTempRoot.StartsWith($allowedTempPrefix, [System.StringComparison]::OrdinalIgnoreCase))) {
            throw "Unsafe temp cleanup path: $resolvedTempRoot"
        }

        Remove-Item -LiteralPath $promptValidationTempRoot -Recurse -Force
        if ((Test-Path -LiteralPath $allowedTempParent) -and -not (Get-ChildItem -LiteralPath $allowedTempParent -Force)) {
            Remove-Item -LiteralPath $allowedTempParent -Force
        }
    }
}

$screenshot = Get-Content -LiteralPath (Join-Path $root 'assets\demo-screenshot.svg') -Raw
foreach ($needle in @(
    'width="1200"',
    'height="800"',
    'viewBox="0 0 1200 800"',
    '<title id="title">BabyGear Risk Radar demo screenshot</title>',
    '<desc id="desc">',
    'Evidence',
    'Risk',
    'Alternatives',
    'Parent Action',
    'Authority Ladder',
    'MAS-QA PASS',
    'Uncertainty noted',
    'No app server',
    'not medical advice'
)) {
    Assert-TextContains -Text $screenshot -Needle $needle -Label 'demo-screenshot.svg'
}

$finalReport = Get-Content -LiteralPath (Join-Path $root 'reports\FINAL_REPORT.md') -Raw
Assert-TextContains -Text $finalReport -Needle 'https://github.com/procloudkim/2026-06-07-harness-baby' -Label 'FINAL_REPORT'
Assert-TextContains -Text $finalReport -Needle 'Validation: PASS' -Label 'FINAL_REPORT'

$masQa = Get-Content -LiteralPath (Join-Path $root 'reports\MAS_QA_REPORT.md') -Raw
Assert-TextContains -Text $masQa -Needle 'MAS-QA Result: PASS' -Label 'MAS_QA_REPORT'

$authoritySourceMap = Get-Content -LiteralPath (Join-Path $root 'docs\AUTHORITY_SOURCE_MAP.md') -Raw
foreach ($needle in @(
    'https://www.cpsc.gov/Business--Manufacturing/Business-Education/Business-Guidance/Pacifiers',
    'https://www.ecfr.gov/current/title-16/chapter-II/subchapter-C/part-1511',
    'https://www.cpsc.gov/Recalls',
    'https://www.saferproducts.gov/',
    'https://www.healthychildren.org/English/safety-prevention/at-home/Pages/Pacifier-safety.aspx?form=HealthyChildren',
    'https://www.fda.gov/newsevents/publichealthfocus/ucm064437.htm',
    'https://www.niehs.nih.gov/health/topics/agents/sya-bpa'
)) {
    Assert-TextContains -Text $authoritySourceMap -Needle $needle -Label 'AUTHORITY_SOURCE_MAP'
}

$masRounds = Get-Content -LiteralPath (Join-Path $root 'docs\MAS_ROUNDS.md') -Raw
foreach ($needle in @(
    'Round 1 - Visionary',
    'Round 2 - Critical',
    'Round 3 - Visionary',
    'Round 4 - Critical',
    'Round 5 - Visionary',
    'Round 6 - Critical',
    'must not mix chemical context'
)) {
    Assert-TextContains -Text $masRounds -Needle $needle -Label 'MAS_ROUNDS'
}

$operationNotes = Get-Content -LiteralPath (Join-Path $root 'docs\OPERATION_NOTES.md') -Raw
foreach ($needle in @(
    'PowerShell 7',
    'ASUS TUF Gaming A14 FA401EA',
    'AMD RYZEN AI MAX+ 392',
    '12 cores / 24 logical processors',
    'about 62.6 GB',
    'Avoid npm, Python, package installation'
)) {
    Assert-TextContains -Text $operationNotes -Needle $needle -Label 'OPERATION_NOTES'
}

$submissionChecklist = Get-Content -LiteralPath (Join-Path $root 'docs\SUBMISSION_CHECKLIST.md') -Raw
foreach ($needle in @(
    'Public URL',
    'HEAD commit',
    'Commit count',
    'KoreanMockPage',
    'KoreanPluginOutput',
    'KoreanPromptPacket',
    'PromptGeneratorCommand',
    'assets/demo-screenshot.svg',
    'scripts\Show-SubmissionSummary.ps1',
    'scripts\New-BabyGearDemoPrompt.ps1',
    'scripts\Test-ContentSafety.ps1',
    'docs/KOREAN_QUICKSTART.md',
    'mockups/korean-parent-risk-radar.html',
    'examples/korean-demo-prompt.md',
    'examples/korean-plugin-run-output.md',
    'GitHub CLI (`gh`) is not installed',
    'PASS'
)) {
    Assert-TextContains -Text $submissionChecklist -Needle $needle -Label 'SUBMISSION_CHECKLIST'
}

$koreanQuickstart = Get-Content -LiteralPath (Join-Path $root 'docs\KOREAN_QUICKSTART.md') -Raw
foreach ($needle in @(
    'BabyGear Risk Radar는 Codex CLI용 플러그인 패키지입니다',
    'https://github.com/procloudkim/2026-06-07-harness-baby',
    'pwsh -NoProfile -File .\scripts\validate-plugin.ps1',
    'pwsh -NoProfile -File .\scripts\Test-ContentSafety.ps1',
    'assets/demo-screenshot.svg',
    'mockups/korean-parent-risk-radar.html',
    'examples/korean-plugin-run-output.md',
    'examples/korean-demo-prompt.md',
    'pwsh -NoProfile -File .\scripts\New-BabyGearDemoPrompt.ps1',
    'Use BabyGear Risk Radar',
    '알려진 한계',
    '안전 고지',
    '의학적 조언이 아니라 의사결정 보조 워크플로우'
)) {
    Assert-TextContains -Text $koreanQuickstart -Needle $needle -Label 'KOREAN_QUICKSTART'
}

$meceTemplate = Get-Content -LiteralPath (Join-Path $root 'templates\babygear-mece-report-template.md') -Raw
foreach ($needle in @(
    'Product and Usage Context',
    'Authority Source Ladder',
    'MECE Evidence Map',
    'Evidence Tier Table',
    'Safety and Regulatory Risk Matrix',
    'Alternative Product Criteria',
    'MAS-QA Checklist',
    'Final Parent Action Card',
    'This report is decision support, not medical advice'
)) {
    Assert-TextContains -Text $meceTemplate -Needle $needle -Label 'babygear-mece-report-template'
}

$actionCardTemplate = Get-Content -LiteralPath (Join-Path $root 'templates\parent-action-card-template.md') -Raw
foreach ($needle in @(
    'Do Now',
    'Check Next',
    'Compare Alternatives By',
    'Escalate If',
    'does not diagnose, prescribe, or declare a real product safe or dangerous'
)) {
    Assert-TextContains -Text $actionCardTemplate -Needle $needle -Label 'parent-action-card-template'
}

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
