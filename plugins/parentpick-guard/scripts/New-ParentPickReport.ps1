[CmdletBinding()]
param(
    [string] $InputPath = (Join-Path $PSScriptRoot '..\examples\avent-pacifier-case.json'),
    [string] $OutputPath = (Join-Path $PSScriptRoot '..\generated\sample-report.html'),
    [string] $TemplatePath = (Join-Path $PSScriptRoot '..\templates\report-template.html')
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Resolve-LocalPath {
    param(
        [Parameter(Mandatory)]
        [string] $Path
    )

    if ([System.IO.Path]::IsPathRooted($Path)) {
        return [System.IO.Path]::GetFullPath($Path)
    }

    return [System.IO.Path]::GetFullPath((Join-Path (Get-Location) $Path))
}

function Get-Field {
    param(
        [Parameter(Mandatory)]
        [object] $Object,
        [Parameter(Mandatory)]
        [string] $Name,
        [string] $Default = ''
    )

    $property = $Object.PSObject.Properties[$Name]
    if ($null -eq $property -or $null -eq $property.Value) {
        return $Default
    }

    return [string] $property.Value
}

function ConvertTo-HtmlText {
    param([AllowNull()][object] $Value)

    if ($null -eq $Value) {
        return ''
    }

    return [System.Net.WebUtility]::HtmlEncode([string] $Value)
}

function ConvertTo-HtmlList {
    param([AllowNull()][object] $Items)

    $values = @($Items)
    if ($values.Count -eq 0 -or ($values.Count -eq 1 -and $null -eq $values[0])) {
        return '<p class="muted">None recorded.</p>'
    }

    $listItems = foreach ($item in $values) {
        if ($null -ne $item -and [string] $item -ne '') {
            '<li>{0}</li>' -f (ConvertTo-HtmlText $item)
        }
    }

    if (@($listItems).Count -eq 0) {
        return '<p class="muted">None recorded.</p>'
    }

    return '<ul>{0}</ul>' -f ($listItems -join [Environment]::NewLine)
}

function Assert-RequiredTextField {
    param(
        [Parameter(Mandatory)]
        [object] $Object,
        [Parameter(Mandatory)]
        [string] $Name
    )

    $property = $Object.PSObject.Properties[$Name]
    if ($null -eq $property -or $null -eq $property.Value) {
        throw "Input JSON is missing required field: $Name"
    }

    if ([string]::IsNullOrWhiteSpace([string] $property.Value)) {
        throw "Input JSON field must be a non-empty string: $Name"
    }
}

function Assert-RequiredListField {
    param(
        [Parameter(Mandatory)]
        [object] $Object,
        [Parameter(Mandatory)]
        [string] $Name
    )

    $property = $Object.PSObject.Properties[$Name]
    if ($null -eq $property -or $null -eq $property.Value) {
        throw "Input JSON is missing required field: $Name"
    }

    $items = @($property.Value)
    if ($items.Count -eq 0) {
        throw "Input JSON field must contain at least one item: $Name"
    }

    $usableItems = @($items | Where-Object { $null -ne $_ })
    if ($usableItems.Count -eq 0) {
        throw "Input JSON field must contain at least one usable item: $Name"
    }
}

function Assert-SourceUrls {
    param([AllowNull()][object] $Sources)

    foreach ($source in @($Sources)) {
        if ($null -eq $source) {
            continue
        }

        $property = $source.PSObject.Properties['url']
        if ($null -eq $property -or $null -eq $property.Value) {
            continue
        }

        $url = [string] $property.Value
        if ([string]::IsNullOrWhiteSpace($url)) {
            continue
        }

        [System.Uri] $uri = $null
        if (-not [System.Uri]::TryCreate($url, [System.UriKind]::Absolute, [ref] $uri)) {
            throw "Input JSON source URL must be empty or an absolute http/https URL: $url"
        }

        if ($uri.Scheme -notin @('http', 'https')) {
            throw "Input JSON source URL uses unsupported scheme: $($uri.Scheme)"
        }
    }
}

function Assert-SourceTextFields {
    param([AllowNull()][object] $Sources)

    $items = @($Sources)
    for ($index = 0; $index -lt $items.Count; $index++) {
        $source = $items[$index]
        if ($null -eq $source) {
            continue
        }

        foreach ($field in @('name', 'type', 'claim', 'use')) {
            $property = $source.PSObject.Properties[$field]
            if ($null -eq $property -or $null -eq $property.Value -or -not ($property.Value -is [string]) -or [string]::IsNullOrWhiteSpace($property.Value)) {
                throw "Input JSON source field must be a non-empty string: sources[$index].$field"
            }
        }
    }
}

function New-SourceRows {
    param([AllowNull()][object] $Sources)

    $rows = foreach ($source in @($Sources)) {
        if ($null -eq $source) {
            continue
        }

        $tier = ConvertTo-HtmlText (Get-Field $source 'tier' '?')
        $type = ConvertTo-HtmlText (Get-Field $source 'type' 'Source')
        $name = ConvertTo-HtmlText (Get-Field $source 'name' 'Unnamed source')
        $url = ConvertTo-HtmlText (Get-Field $source 'url' '')
        $date = ConvertTo-HtmlText (Get-Field $source 'date' '')
        $claim = ConvertTo-HtmlText (Get-Field $source 'claim' '')
        $use = ConvertTo-HtmlText (Get-Field $source 'use' '')
        $link = if ($url -ne '') { '<br><a href="{0}">{0}</a>' -f $url } else { '' }

        @"
<tr>
  <td>$tier</td>
  <td><strong>$name</strong><br>$type<br><span class="muted">$date</span>$link</td>
  <td>$claim</td>
  <td>$use</td>
</tr>
"@
    }

    if (@($rows).Count -eq 0) {
        return '<tr><td colspan="4" class="muted">No sources recorded.</td></tr>'
    }

    return $rows -join [Environment]::NewLine
}

function New-PersonaCards {
    param([AllowNull()][object] $Personas)

    $cards = foreach ($persona in @($Personas)) {
        if ($null -eq $persona) {
            continue
        }

        $name = ConvertTo-HtmlText (Get-Field $persona 'name' 'Persona')
        $anchor = ConvertTo-HtmlText (Get-Field $persona 'anchor' 'User-provided')
        $focusList = ConvertTo-HtmlList $persona.focus

        @"
<article class="persona">
  <h3>$name</h3>
  <p class="muted">$anchor</p>
  $focusList
</article>
"@
    }

    if (@($cards).Count -eq 0) {
        return '<p class="muted">No persona lenses recorded.</p>'
    }

    return $cards -join [Environment]::NewLine
}

function New-MeceSections {
    param([AllowNull()][object] $Sections)

    $cards = foreach ($section in @($Sections)) {
        if ($null -eq $section) {
            continue
        }

        $name = ConvertTo-HtmlText (Get-Field $section 'name' 'Section')
        $status = ConvertTo-HtmlText (Get-Field $section 'status' 'Review')
        $notes = ConvertTo-HtmlList $section.notes
        $actions = ConvertTo-HtmlList $section.parentActions

        @"
<article class="section-card">
  <h3>$name <span class="badge badge-ok">$status</span></h3>
  <strong>Notes</strong>
  $notes
  <strong>Parent actions</strong>
  $actions
</article>
"@
    }

    if (@($cards).Count -eq 0) {
        return '<p class="muted">No MECE sections recorded.</p>'
    }

    return $cards -join [Environment]::NewLine
}

$inputFullPath = Resolve-LocalPath $InputPath
$outputFullPath = Resolve-LocalPath $OutputPath
$templateFullPath = Resolve-LocalPath $TemplatePath

if (-not (Test-Path -LiteralPath $inputFullPath)) {
    throw "Input file not found: $inputFullPath"
}

if (-not (Test-Path -LiteralPath $templateFullPath)) {
    throw "Template file not found: $templateFullPath"
}

$report = Get-Content -LiteralPath $inputFullPath -Raw | ConvertFrom-Json -Depth 32
$template = Get-Content -LiteralPath $templateFullPath -Raw

foreach ($field in @('reportTitle', 'productName', 'decisionNeed')) {
    Assert-RequiredTextField -Object $report -Name $field
}

foreach ($field in @('sources', 'meceSections')) {
    Assert-RequiredListField -Object $report -Name $field
}

Assert-SourceTextFields -Sources $report.sources
Assert-SourceUrls -Sources $report.sources

$tokens = [ordered] @{
    '{{ReportTitle}}' = ConvertTo-HtmlText (Get-Field $report 'reportTitle')
    '{{GeneratedAt}}' = ConvertTo-HtmlText ((Get-Date).ToString('yyyy-MM-dd HH:mm:ss K'))
    '{{GeneratedFor}}' = ConvertTo-HtmlText (Get-Field $report 'generatedFor' 'ParentPick Guard')
    '{{EvidenceGrade}}' = ConvertTo-HtmlText (Get-Field $report 'evidenceGrade' 'Not graded')
    '{{ProductName}}' = ConvertTo-HtmlText (Get-Field $report 'productName')
    '{{ProductCategory}}' = ConvertTo-HtmlText (Get-Field $report 'productCategory' 'Baby product')
    '{{InfantStage}}' = ConvertTo-HtmlText (Get-Field $report 'infantStage' 'Infant care')
    '{{DecisionNeed}}' = ConvertTo-HtmlText (Get-Field $report 'decisionNeed')
    '{{ClaimBoundary}}' = ConvertTo-HtmlText (Get-Field $report 'claimBoundary' 'Public-source case note only.')
    '{{SummaryList}}' = ConvertTo-HtmlList $report.summary
    '{{SourceRows}}' = New-SourceRows $report.sources
    '{{PersonaCards}}' = New-PersonaCards $report.personas
    '{{MeceSections}}' = New-MeceSections $report.meceSections
    '{{Unknowns}}' = ConvertTo-HtmlList $report.unknowns
    '{{DecisionCriteria}}' = ConvertTo-HtmlList $report.decisionCriteria
    '{{NextActions}}' = ConvertTo-HtmlList $report.nextActions
    '{{FooterNote}}' = ConvertTo-HtmlText (Get-Field $report 'footerNote' 'Not medical advice.')
}

$html = $template
foreach ($token in $tokens.Keys) {
    $html = $html.Replace($token, $tokens[$token])
}

$outputDirectory = Split-Path -Parent $outputFullPath
if (-not (Test-Path -LiteralPath $outputDirectory)) {
    New-Item -ItemType Directory -Path $outputDirectory | Out-Null
}

Set-Content -LiteralPath $outputFullPath -Value $html -Encoding UTF8

[PSCustomObject] @{
    InputPath = $inputFullPath
    OutputPath = $outputFullPath
    SourceCount = @($report.sources).Count
    SectionCount = @($report.meceSections).Count
}
