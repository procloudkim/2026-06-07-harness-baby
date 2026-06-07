# ParentPick Guard Codex Plugin

Public GitHub URL: https://github.com/procloudkim/2026-06-07-harness-baby

ParentPick Guard is a Codex Plugin for newborn parents who need to organize baby-product trust and safety-risk information into a structured MECE report. It is built as a local, reproducible PowerShell workflow so the demo does not require crawling, login, paid APIs, browser automation, or medical/safety overclaims.

## What It Produces

- Codex Plugin package: `plugins/parentpick-guard/`
- Plugin manifest: `plugins/parentpick-guard/.codex-plugin/plugin.json`
- Skill instructions: `plugins/parentpick-guard/skills/parentpick-guard/SKILL.md`
- Local tool wrapper: `plugins/parentpick-guard/tools/Invoke-ParentPickGuard.ps1`
- PowerShell report generator: `plugins/parentpick-guard/scripts/New-ParentPickReport.ps1`
- Local verifier: `plugins/parentpick-guard/scripts/Test-ParentPickGuard.ps1`
- Example input: `plugins/parentpick-guard/examples/avent-pacifier-case.json`
- Generated sample HTML report: `plugins/parentpick-guard/generated/sample-report.html`
- Demo screenshot asset: `plugins/parentpick-guard/assets/demo-screenshot.png`
- Demo script: `docs/DEMO_SCRIPT.md`
- Final report: `docs/FINAL_REPORT.md`

## Run Locally

From the repository root with PowerShell 7:

```powershell
pwsh -NoProfile -File .\plugins\parentpick-guard\tools\Invoke-ParentPickGuard.ps1 `
  -InputPath .\plugins\parentpick-guard\examples\avent-pacifier-case.json `
  -OutputPath .\plugins\parentpick-guard\generated\sample-report.html
pwsh -NoProfile -File .\plugins\parentpick-guard\scripts\Test-ParentPickGuard.ps1
```

The wrapper is the local tool entry point; `scripts/New-ParentPickReport.ps1` remains the JSON-to-HTML implementation detail. The verifier regenerates the sample HTML report and PNG demo screenshot, then checks the required plugin deliverables, PowerShell syntax, wrapper output, malformed input handling, unsafe source URL rejection, and null-only required-list rejection.

## Safety Boundary

The included Avent pacifier case is a public-source case note. ParentPick Guard does not independently claim that a real product is dangerous, does not diagnose medical risk, and does not recommend purchases. It separates official manufacturer statements, regulator guidance, secondary reports, source conflicts, unknowns, and next safe parent actions.

## Evidence Anchors

- Philips Avent public response on pacifier BPA news.
- CPSC pacifier business guidance for U.S. pacifier safety requirements.
- FDA BPA food-contact application guidance for baby bottles, sippy cups, and infant formula packaging context.
- User-provided Kormedi article as the motivating secondary case note.
- User-provided YouTube channel URLs as persona anchors only, not as uncited factual authorities.

## Privacy

This plugin runs locally on JSON input files and writes local HTML/PNG artifacts. It does not collect credentials, read secret files, call paid APIs, or send user data to a remote service.

## Terms

ParentPick Guard is an evidence-organization aid for caregivers. It is not medical advice, legal advice, a product endorsement, or a recall authority.
