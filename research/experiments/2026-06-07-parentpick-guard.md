# ParentPick Guard Experiments

## Experiment E1. Local Verification

- Objective: Confirm the plugin package can regenerate the sample report and screenshot locally.
- Evaluator: `plugins/parentpick-guard/scripts/Test-ParentPickGuard.ps1`
- Metric definition:
  - Required files exist.
  - PowerShell scripts parse without syntax errors.
  - Plugin manifest and marketplace JSON parse.
  - Generated HTML contains required MECE sections.
  - Demo screenshot PNG exists and is non-empty.
- Fixed variables: example JSON, HTML template, output paths.
- Controllable variables: none for the baseline.
- Promotion rule: verification exits 0.
- Kill rule: stop if the script requires credentials, admin privileges, browser automation, or files outside the repo.
- Variance note: deterministic; no random seed.

## Result

- PASS: `pwsh -NoProfile -File .\plugins\parentpick-guard\scripts\Test-ParentPickGuard.ps1` returned `Status = PASS`.
- PASS: `python3 C:\Users\K\.codex\skills\.system\skill-creator\scripts\quick_validate.py .\plugins\parentpick-guard\skills\parentpick-guard` returned `Skill is valid!`.
- PASS: `python3 C:\Users\K\.codex\skills\.system\plugin-creator\scripts\validate_plugin.py .\plugins\parentpick-guard` returned `Plugin validation passed`.
- Environment note: the Python validators needed temporary in-repo PyYAML dependencies because the available base Python interpreters did not include `yaml`.
