# ParentPick Guard

ParentPick Guard is a Codex Plugin package for generating MECE baby-product trust and safety-risk reports.

Repository: https://github.com/procloudkim/2026-06-07-harness-baby

## Run

```powershell
pwsh -NoProfile -File .\plugins\parentpick-guard\tools\Invoke-ParentPickGuard.ps1 `
  -InputPath .\plugins\parentpick-guard\examples\avent-pacifier-case.json `
  -OutputPath .\plugins\parentpick-guard\generated\sample-report.html
pwsh -NoProfile -File .\plugins\parentpick-guard\scripts\Test-ParentPickGuard.ps1
```

`tools\Invoke-ParentPickGuard.ps1` is the local tool entry point. `scripts\New-ParentPickReport.ps1` is the generator implementation behind it.

## Files

- `.codex-plugin/plugin.json`: plugin manifest
- `skills/parentpick-guard/SKILL.md`: Codex skill instructions
- `tools/Invoke-ParentPickGuard.ps1`: local wrapper command
- `scripts/New-ParentPickReport.ps1`: JSON-to-HTML report generator implementation
- `scripts/Test-ParentPickGuard.ps1`: local verifier, including malformed input, unsafe URL, and null-only list checks
- `examples/avent-pacifier-case.json`: public-source case-note demo input
- `generated/sample-report.html`: generated sample report
- `assets/demo-screenshot.png`: demo screenshot asset
