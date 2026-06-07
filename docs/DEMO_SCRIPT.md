# ParentPick Guard Demo Script

## Setup

Repository: https://github.com/procloudkim/2026-06-07-harness-baby

Run from the repository root with PowerShell 7:

```powershell
pwsh -NoProfile -File .\plugins\parentpick-guard\tools\Invoke-ParentPickGuard.ps1 `
  -InputPath .\plugins\parentpick-guard\examples\avent-pacifier-case.json `
  -OutputPath .\plugins\parentpick-guard\generated\sample-report.html
pwsh -NoProfile -File .\plugins\parentpick-guard\scripts\Test-ParentPickGuard.ps1
pwsh -NoProfile -File .\plugins\parentpick-guard\scripts\Test-ParentPickGuardEvidence.ps1
```

## Demo Flow

1. Open `plugins/parentpick-guard/examples/avent-pacifier-case.json`.
2. Point out that the example is a public-source case note, not a medical diagnosis or product-danger verdict.
3. Run `tools\Invoke-ParentPickGuard.ps1` to generate the report, then run the verification commands above.
4. Open `plugins/parentpick-guard/generated/sample-report.html`.
5. Show the report sections:
   - Source map.
   - MAS persona lens.
   - MECE risk map.
   - Unknowns.
   - Decision criteria.
   - Next smallest safe actions.
6. Open `plugins/parentpick-guard/assets/demo-screenshot.png` as the demo screenshot asset.

## Expected Result

The script reports success, regenerates the sample HTML report, regenerates the PNG screenshot asset, and confirms the local plugin deliverables required by AGENTS.md.

## Presenter Notes

- Do not say the example product is dangerous.
- Say: "This plugin organizes cited public-source information and source conflicts so parents can make a better follow-up checklist."
- Use the Philips and Kormedi entries as a source-conflict example.
- The next smallest safe move after the demo is to add more official product sources to a new JSON input and regenerate the report.
