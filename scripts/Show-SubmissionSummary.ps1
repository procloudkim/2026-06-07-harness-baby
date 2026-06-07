[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$repoRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..'))
$manifestPath = Join-Path $repoRoot '.codex-plugin\plugin.json'
$manifest = Get-Content -LiteralPath $manifestPath -Raw | ConvertFrom-Json -Depth 32

function Invoke-GitText {
    param(
        [Parameter(Mandatory)]
        [string[]] $Arguments
    )

    $output = & git @Arguments 2>$null
    if ($LASTEXITCODE -ne 0) {
        return 'unavailable'
    }

    return ($output | Out-String).Trim()
}

[PSCustomObject]@{
    Status = 'READY'
    Project = 'BabyGear Risk Radar Codex Plugin'
    PluginName = $manifest.name
    GitHubUrl = $manifest.repository
    Branch = Invoke-GitText -Arguments @('branch', '--show-current')
    HeadCommit = Invoke-GitText -Arguments @('rev-parse', '--short', 'HEAD')
    CommitCount = Invoke-GitText -Arguments @('rev-list', '--count', 'HEAD')
    MarketplacePath = './'
    SkillPath = 'skills/babygear-risk-radar/SKILL.md'
    DemoScreenshot = 'assets/demo-screenshot.svg'
    KoreanMockPage = 'mockups/korean-parent-risk-radar.html'
    KoreanPluginOutput = 'examples/korean-plugin-run-output.md'
    KoreanPromptPacket = 'examples/korean-demo-prompt.md'
    PromptGeneratorCommand = 'pwsh -NoProfile -File .\scripts\New-BabyGearDemoPrompt.ps1'
    ValidatorCommand = 'pwsh -NoProfile -File .\scripts\validate-plugin.ps1'
    RegressionCommand = 'pwsh -NoProfile -File .\plugins\parentpick-guard\scripts\Test-ParentPickGuard.ps1'
    SubmissionChecklist = 'docs/SUBMISSION_CHECKLIST.md'
    GhFallback = 'gh unavailable; pushed to user-provided origin'
}
