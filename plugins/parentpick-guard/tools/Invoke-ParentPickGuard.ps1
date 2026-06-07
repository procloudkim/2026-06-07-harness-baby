[CmdletBinding()]
param(
    [string] $InputPath = (Join-Path $PSScriptRoot '..\examples\avent-pacifier-case.json'),
    [string] $OutputPath = (Join-Path $PSScriptRoot '..\generated\sample-report.html')
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$generator = Join-Path $PSScriptRoot '..\scripts\New-ParentPickReport.ps1'
& $generator -InputPath $InputPath -OutputPath $OutputPath
