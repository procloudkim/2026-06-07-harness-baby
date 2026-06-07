# ParentPick Guard Method Selection

Date: 2026-06-07

## Candidate Methods

1. Static MECE report generator
   - Input: curated JSON evidence notes.
   - Output: static HTML report.
   - Strength: fast, auditable, no external service, good screenshot/demo fit.
   - Weakness: input still requires human or Codex curation.

2. Interactive web application
   - Input: form fields and source links.
   - Output: browser-rendered dashboard.
   - Strength: better UX for repeated manual use.
   - Weakness: higher implementation and verification cost inside 90 minutes.

3. AI-assisted recommendation engine
   - Input: product name and source links.
   - Output: risk score and alternatives.
   - Strength: useful if enough data and validation exist.
   - Weakness: high risk of unsupported safety, medical, or purchase claims.

4. Scraper-driven source collector
   - Input: URLs.
   - Output: automatically extracted evidence.
   - Strength: reduces manual data entry.
   - Weakness: conflicts with the no-crawling and no-browser-automation constraints.

## Chosen Method

Static MECE report generator.

Why:

- It matches the plugin requirement and the 90-minute public-repo submission target.
- It keeps evidence, source quality, uncertainty, and action items visible.
- It avoids scraping, diagnosis, affiliate, and recommendation risks.
- It can be verified locally with PowerShell only.

## Fallback Method

Markdown-only report generator.

Fallback trigger: if HTML generation or PNG screenshot creation fails under PowerShell 7.

## Rejection Reasons

- Interactive web app rejected due to time, surface area, and unnecessary server/runtime complexity.
- AI recommendation engine rejected because it could overstate risk and imply medical or purchase advice.
- Scraper-driven collector rejected because the repo instructions prohibit crawling and browser automation.

## Execution Plan

Baseline:

- Use one curated JSON example based on the user-supplied Avent public-source case.
- Generate one static HTML report and one PNG demo screenshot asset.

Controllable variables:

- Evidence categories.
- Source quality labels.
- Action checklist phrasing.
- Confidence labels.
- Report template sections.

Fixed variables:

- Plugin path: `plugins/parentpick-guard/`.
- Runtime: PowerShell 7.
- Output format: HTML sample report.
- Repository: https://github.com/procloudkim/2026-06-07-harness-baby

Budget ladder:

1. Scaffold and manifest: 10 minutes.
2. Research gate and source map: 15 minutes.
3. Generator, templates, examples: 30 minutes.
4. Sample output, screenshot, docs: 20 minutes.
5. Verification, commits, push: 15 minutes.

Promotion rule:

- Move to docs/demo only after the generator produces an HTML file from the example JSON.

Kill rule:

- Drop optional icon/logo polish if it delays verification.

Stop rule:

- Stop implementation only after local verification passes or all fallback options are exhausted.

Final evaluation rule:

- Run `pwsh -NoProfile -File plugins/parentpick-guard/tools/Test-ParentPickGuard.ps1`.
- Run the plugin manifest validator from the plugin-creator skill.
- Confirm required files exist.

Wall-clock estimate:

- 70 to 90 minutes total.

RAM estimate:

- Less than 512 MB; static text and PNG generation only.

CPU / GPU / NPU role split:

- CPU only for PowerShell, JSON parsing, HTML generation, and bitmap drawing.
- GPU/NPU not used.

Reboot-required resources:

- None.
