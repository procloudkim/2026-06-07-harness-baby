# ParentPick Guard Method Selection

## Candidate Methods

1. Skill-only plugin: fastest, but weak observable demo value.
2. Skill plus local PowerShell JSON-to-HTML generator: reproducible and aligned with Windows/PowerShell constraints.
3. Local web app: richer UI, but unnecessary scope for a 90-minute plugin submission.
4. Automated retrieval/crawler: broader information intake, but conflicts with no-crawling and safety constraints.

## Chosen Method

Method 2: Codex skill plus local PowerShell report generator.

Why:

- Satisfies the Codex Plugin requirement.
- Produces concrete generated output and screenshot asset.
- Keeps execution local, deterministic, and reviewable.
- Avoids crawling, browser automation, paid APIs, and medical/safety overreach.

## Fallback Method

If PNG generation fails, keep the HTML report as the primary demo output and document the failure in `docs/RUN_LOG.md`.

## Rejection Reasons

- Skill-only plugin: insufficient generated artifact for demo.
- Web app: too much surface area for the time limit.
- Retrieval crawler: prohibited by project constraints and likely to overstate safety claims.

## Execution Plan

- Baseline: validate manifest and marketplace, then generate one sample report.
- Controllable variables: input JSON, output paths, template copy, screenshot dimensions.
- Fixed variables: plugin path, public GitHub URL, PowerShell 7, no paid APIs, no browser automation.
- Budget ladder:
  1. Manifest and marketplace.
  2. Skill instructions.
  3. Report generator.
  4. Example input and generated output.
  5. README, demo script, final report, verification.
- Promotion rule: move to the next rung only when the current rung's required files exist.
- Kill rule: stop any feature that needs secrets, browser login, paid services, registry changes, or files outside the repo.
- Stop rule: stop after local verification exits 0 and all Definition of Done files exist.
- Final evaluation rule: PowerShell verification script checks required files, syntax, manifest JSON, sample report sections, and screenshot asset.
- Wall-clock estimate: 60 to 90 minutes.
- RAM estimate: under 512 MB.
- CPU/GPU/NPU role split: CPU only.
- Reboot-required resources: none.
