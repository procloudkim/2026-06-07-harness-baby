[CmdletBinding()]
param(
    [string] $ReportPath = (Join-Path $PSScriptRoot '..\generated\sample-report.html'),
    [string] $OutputPath = (Join-Path $PSScriptRoot '..\assets\demo-screenshot.png'),
    [switch] $GenerateBrandAssets
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

function New-SolidBrush {
    param([Parameter(Mandatory)][string] $Color)
    return [System.Drawing.SolidBrush]::new([System.Drawing.ColorTranslator]::FromHtml($Color))
}

function Save-CardImage {
    param(
        [Parameter(Mandatory)][string] $Path,
        [int] $Width = 1200,
        [int] $Height = 760
    )

    Add-Type -AssemblyName System.Drawing

    $directory = Split-Path -Parent $Path
    if (-not (Test-Path -LiteralPath $directory)) {
        New-Item -ItemType Directory -Path $directory | Out-Null
    }

    $bitmap = [System.Drawing.Bitmap]::new($Width, $Height)
    $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
    $graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
    $graphics.Clear([System.Drawing.Color]::White)

    $ink = New-SolidBrush '#172033'
    $muted = New-SolidBrush '#667085'
    $brand = New-SolidBrush '#2563eb'
    $soft = New-SolidBrush '#f6f8fb'
    $warn = New-SolidBrush '#b45309'
    $linePen = [System.Drawing.Pen]::new([System.Drawing.ColorTranslator]::FromHtml('#d6dae3'), 2)
    $brandPen = [System.Drawing.Pen]::new([System.Drawing.ColorTranslator]::FromHtml('#2563eb'), 5)

    $titleFont = [System.Drawing.Font]::new('Segoe UI', 32, [System.Drawing.FontStyle]::Bold)
    $h2Font = [System.Drawing.Font]::new('Segoe UI', 17, [System.Drawing.FontStyle]::Bold)
    $bodyFont = [System.Drawing.Font]::new('Segoe UI', 13, [System.Drawing.FontStyle]::Regular)
    $monoFont = [System.Drawing.Font]::new('Consolas', 12, [System.Drawing.FontStyle]::Regular)

    try {
        $graphics.FillRectangle($soft, 0, 0, $Width, $Height)
        $graphics.FillRectangle([System.Drawing.Brushes]::White, 44, 42, $Width - 88, $Height - 84)
        $graphics.DrawRectangle($linePen, 44, 42, $Width - 88, $Height - 84)
        $graphics.DrawLine($brandPen, 44, 42, $Width - 44, 42)

        $graphics.DrawString('ParentPick Guard', $titleFont, $ink, 78, 82)
        $graphics.DrawString('MECE baby-product trust and safety-risk report', $h2Font, $brand, 82, 134)
        $graphics.DrawString('Demo generated from local PowerShell tools. No crawling, no diagnosis, no purchase endorsement.', $bodyFont, $muted, 82, 168)

        $left = 82
        $top = 226
        $cardWidth = 320
        $cardHeight = 128
        $gap = 26
        $cards = @(
            @{ Title = 'Evidence Grade'; Text = 'Mixed public-source evidence'; Color = '#2563eb' },
            @{ Title = 'Case Boundary'; Text = 'Public-source note, not danger verdict'; Color = '#b45309' },
            @{ Title = 'Output'; Text = 'Static HTML report + screenshot'; Color = '#047857' }
        )

        for ($i = 0; $i -lt $cards.Count; $i++) {
            $x = $left + ($i * ($cardWidth + $gap))
            $graphics.DrawRectangle($linePen, $x, $top, $cardWidth, $cardHeight)
            $graphics.FillRectangle((New-SolidBrush $cards[$i].Color), $x, $top, 8, $cardHeight)
            $graphics.DrawString($cards[$i].Title, $h2Font, $ink, $x + 22, $top + 22)
            $graphics.DrawString($cards[$i].Text, $bodyFont, $muted, $x + 22, $top + 58)
        }

        $graphics.DrawString('Generated report sections', $h2Font, $ink, 82, 414)
        $sections = @(
            '[x] Decision need and claim boundary',
            '[x] Source map with official and secondary summaries',
            '[x] MAS persona lens for parent operations, pediatric caution, family logistics',
            '[x] MECE risk map, unknowns, decision criteria, next safe actions'
        )

        $y = 454
        foreach ($section in $sections) {
            $graphics.DrawString($section, $monoFont, $ink, 98, $y)
            $y += 34
        }

        $graphics.DrawString('Verification command:', $h2Font, $ink, 82, 620)
        $graphics.DrawString('pwsh -NoProfile -File .\plugins\parentpick-guard\scripts\Test-ParentPickGuard.ps1', $monoFont, $warn, 98, 658)

        $bitmap.Save($Path, [System.Drawing.Imaging.ImageFormat]::Png)
    }
    finally {
        $graphics.Dispose()
        $bitmap.Dispose()
        $ink.Dispose()
        $muted.Dispose()
        $brand.Dispose()
        $soft.Dispose()
        $warn.Dispose()
        $linePen.Dispose()
        $brandPen.Dispose()
        $titleFont.Dispose()
        $h2Font.Dispose()
        $bodyFont.Dispose()
        $monoFont.Dispose()
    }
}

function Save-BrandAsset {
    param(
        [Parameter(Mandatory)][string] $Path,
        [int] $Width,
        [int] $Height,
        [string] $Text
    )

    Add-Type -AssemblyName System.Drawing

    $directory = Split-Path -Parent $Path
    if (-not (Test-Path -LiteralPath $directory)) {
        New-Item -ItemType Directory -Path $directory | Out-Null
    }

    $bitmap = [System.Drawing.Bitmap]::new($Width, $Height)
    $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
    $graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
    $fontSize = if ($Width -le 128) { 28 } else { 34 }
    $font = [System.Drawing.Font]::new('Segoe UI', $fontSize, [System.Drawing.FontStyle]::Bold)
    $background = New-SolidBrush '#2563eb'
    $white = [System.Drawing.Brushes]::White

    try {
        $graphics.Clear([System.Drawing.Color]::White)
        $graphics.FillRectangle($background, 0, 0, $Width, $Height)
        $format = [System.Drawing.StringFormat]::new()
        $format.Alignment = [System.Drawing.StringAlignment]::Center
        $format.LineAlignment = [System.Drawing.StringAlignment]::Center
        $graphics.DrawString($Text, $font, $white, [System.Drawing.RectangleF]::new(0, 0, $Width, $Height), $format)
        $bitmap.Save($Path, [System.Drawing.Imaging.ImageFormat]::Png)
    }
    finally {
        $graphics.Dispose()
        $bitmap.Dispose()
        $font.Dispose()
        $background.Dispose()
    }
}

$reportFullPath = Resolve-LocalPath $ReportPath
$outputFullPath = Resolve-LocalPath $OutputPath

if (-not (Test-Path -LiteralPath $reportFullPath)) {
    throw "Report file not found: $reportFullPath"
}

Save-CardImage -Path $outputFullPath

$generated = @($outputFullPath)
if ($GenerateBrandAssets) {
    $assetDirectory = Split-Path -Parent $outputFullPath
    $iconPath = Join-Path $assetDirectory 'icon.png'
    $logoPath = Join-Path $assetDirectory 'logo.png'
    Save-BrandAsset -Path $iconPath -Width 128 -Height 128 -Text 'PG'
    Save-BrandAsset -Path $logoPath -Width 512 -Height 256 -Text 'ParentPick Guard'
    $generated += $iconPath
    $generated += $logoPath
}

[PSCustomObject] @{
    ReportPath = $reportFullPath
    GeneratedAssets = $generated
}
