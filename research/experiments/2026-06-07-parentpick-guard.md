# ParentPick Guard Experiment Log

Date: 2026-06-07

## Experiment 1: Static Report MVP

Hypothesis: A curated JSON input can be transformed into a useful parent-facing MECE safety/trust report without external services.

Evaluator:

- `plugins/parentpick-guard/tools/Test-ParentPickGuard.ps1`

Metric definition:

- Pass if all required files exist, plugin JSON and marketplace JSON parse, the skill metadata exists, the generator creates HTML from example JSON, and the generated HTML contains key report sections.

Fixed variables:

- Example input: `plugins/parentpick-guard/examples/avent-public-case.json`
- Template: `plugins/parentpick-guard/templates/report.html.template`
- Output: `plugins/parentpick-guard/generated/sample-report.html`

Controllable variables:

- Section headings.
- Confidence labels.
- Evidence item formatting.
- Screenshot text density.

Variance note:

- No stochastic model or random search is used. Repeated runs should produce identical files except for generated timestamp fields.

Result:

- Pending until PowerShell verification runs.

Next smallest safe move:

- Implement generator and verification script, then run the evaluator.
