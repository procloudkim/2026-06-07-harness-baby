# Submission Checklist

## Public URL

Actual pushed submission URL:

```text
https://github.com/procloudkim/2026-06-07-harness-baby
```

Preferred repository name was `babygear-risk-radar-codex-plugin`; creating that new repository was blocked because GitHub CLI (`gh`) is not installed and the target repository did not already exist.

## Dynamic Git Evidence

Use the local summary command for current values:

```powershell
pwsh -NoProfile -File .\scripts\Show-SubmissionSummary.ps1
```

Fields reported by the command:

- HEAD commit.
- Commit count.
- Branch.
- GitHub URL.
- Plugin name.
- Screenshot path.
- Skill path.
- Validator command.

## Acceptance Status

| Requirement | Status | Evidence |
| --- | --- | --- |
| Public GitHub URL present | PASS | README, manifest, final report, pushed `origin/main`. |
| Root README summary | PASS | `README.md`. |
| Demo screenshot | PASS | `assets/demo-screenshot.svg`. |
| Plugin manifest | PASS | `.codex-plugin/plugin.json`. |
| Skill with metadata | PASS | `skills/babygear-risk-radar/SKILL.md`. |
| Marketplace entry | PASS | `.agents/plugins/marketplace.json`. |
| Example inputs and sample output | PASS | `examples/avent-pacifier-risk-brief.md`, `examples/sample-output.md`. |
| Validation script | PASS | `scripts/validate-plugin.ps1`. |
| MAS-QA report | PASS | `reports/MAS_QA_REPORT.md`. |
| Final report | PASS | `reports/FINAL_REPORT.md` and `docs/FINAL_REPORT.md`. |
| Demo script | PASS | `docs/DEMO_SCRIPT.md`. |
| Authority source map | PASS | `docs/AUTHORITY_SOURCE_MAP.md`. |
| MAS rounds | PASS | `docs/MAS_ROUNDS.md`. |
| Implementation process commits | PASS | `docs/COMMIT_LOG.md` and `git log --oneline`. |
| No secret-like files tracked | PASS | Enforced by `scripts/validate-plugin.ps1`. |

## Validator Commands

```powershell
pwsh -NoProfile -File .\scripts\validate-plugin.ps1
pwsh -NoProfile -File .\plugins\parentpick-guard\scripts\Test-ParentPickGuard.ps1
```

Expected status for both commands: `PASS`.

## Demo Screenshot Path

```text
assets/demo-screenshot.svg
```

## Known Limitations

- The plugin package does not automate live recall or regulator lookups.
- It does not provide medical advice or diagnosis.
- It does not scrape YouTube, medical websites, retailers, or news sites.
- It does not provide affiliate recommendations.
- The actual pushed repository URL differs from the preferred target name because `gh` is unavailable on this machine.
