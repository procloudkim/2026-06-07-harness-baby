[CmdletBinding()]
param(
    [string] $EvidenceRoot = (Join-Path $PSScriptRoot '..\..\..\.omo\ulw-loop\evidence')
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$resolvedEvidenceRoot = [System.IO.Path]::GetFullPath($EvidenceRoot)
$requiredEvidenceFiles = @(
    'C001-happy-path.txt',
    'C002-malformed-input.txt',
    'C003-regression-consistency.txt',
    'G002-C001-evidence-replay.txt',
    'G002-C002-missing-evidence.txt',
    'G002-C003-verifier-regression.txt',
    'G003-C001-safe-links-happy.txt',
    'G003-C002-unsafe-url.txt',
    'G003-C003-verifier-regression.txt',
    'G005-C001-tool-wrapper.txt',
    'G005-C002-wrapper-malformed.txt',
    'G005-C003-tool-wrapper-regression.txt'
)

foreach ($fileName in $requiredEvidenceFiles) {
    $path = Join-Path $resolvedEvidenceRoot $fileName

    if (-not (Test-Path -LiteralPath $path)) {
        throw "Evidence file missing: $fileName"
    }

    $fileInfo = Get-Item -LiteralPath $path
    if ($fileInfo.Length -le 0) {
        throw "Evidence file empty: $fileName"
    }

    $text = Get-Content -LiteralPath $path -Raw
    if (-not $text.Contains('result: PASS')) {
        throw "Evidence file missing PASS marker: $fileName"
    }

    if (-not $text.Contains('cleanup:')) {
        throw "Evidence file missing cleanup receipt: $fileName"
    }
}

[PSCustomObject] @{
    Status = 'PASS'
    EvidenceRoot = $resolvedEvidenceRoot
    CheckedEvidenceCount = $requiredEvidenceFiles.Count
    CheckedEvidenceReplayFile = 'G005-C003-tool-wrapper-regression.txt'
    CheckedEvidenceFileList = ($requiredEvidenceFiles -join ', ')
    CheckedEvidenceFiles = $requiredEvidenceFiles
}
