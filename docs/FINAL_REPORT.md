# ParentPick Guard Final Report

## Problem Definition

- Goal: Build a public GitHub-ready Codex Plugin named `ParentPick Guard` that helps newborn parents organize baby-product trust and safety-risk information into a structured MECE report.
- Context: The mini-Ralphthon task centers on finding baby-product information. The motivating case is a public-source discussion about BPA detection claims involving pacifiers, including Philips Avent public response.
- Constraints:
  - Work inside the current Git repository.
  - Use PowerShell 7 local tools.
  - Put the plugin package under `plugins/parentpick-guard/`.
  - Do not use paid APIs, browser automation, login scraping, affiliate links, medical diagnoses, or unsupported danger claims.
  - Direct git commits are left to the outer PowerShell runner per AGENTS.md.
- Success criteria:
  - Valid plugin manifest, skill, marketplace entry, PowerShell generator, example input, generated HTML report, screenshot asset, README, demo script, final report, and documented verification.
- Done when:
  - A local verification command regenerates the sample HTML report and demo screenshot and checks required files.

## Evidence Brief

### Authoritative Source Map

1. Project AGENTS.md: binding repository requirements for path, runtime, deliverables, and safety boundaries.
2. Codex plugin scaffold reference: local `plugin-creator` skill and manifest validator.
3. Philips official support page: public response on Avent pacifier BPA news, published 2026-05-28, stating further DEKRA testing found no detectable BPA across listed pacifier ranges.
4. Kormedi article: Korean health-news summary published 2025-10-22 about dTest-reported BPA findings in several pacifier products.
5. DongA Science article: English-translated secondary summary dated 2025-10-19, used only as corroborating context.
6. User-provided YouTube channel URLs:
   - Momddok_TV: https://www.youtube.com/channel/UC-FZjF-oF0Cvq699UNcG5Tg
   - Ha Jung-hoon's BbiBboBbiBbo 119 Pediatrics: https://www.youtube.com/channel/UC6t0ees15Lp0gyrLrAyLeJQ
   - O2 Brothers TV: https://www.youtube.com/@o2brothersTV

### Prior-Art Summary

- The useful pattern is not a single "safe/unsafe" answer. Parent decisions require a source map, conflict handling, product/batch specificity, and replacement criteria.
- The user-provided personas imply a multi-agent summary style:
  - practical parent operations,
  - pediatric/evidence caution,
  - family logistics and explanation.
- The Avent pacifier case shows why a report must distinguish test claims, official manufacturer response, regulatory thresholds, and consumer action options.

### Verified Facts

- Philips has an official support page, published 2026-05-28, addressing pacifier BPA news and saying DEKRA follow-up tests found no detectable BPA across its pacifier ranges, including the sample discussed.
- Kormedi published a 2025-10-22 article reporting that dTest found BPA in four pacifier products; the article reports Philips Avent Ultra Air at 2 micrograms per kilogram and notes Philips disputed the result.
- The project-specific instructions require `plugins/parentpick-guard/`, `.agents/plugins/marketplace.json`, root README, final report, demo script, generated sample output, and screenshot asset.

### Inferences

- The plugin should act as an evidence organizer and report generator, not a medical or legal safety authority.
- Parent-facing output should use clear action buckets: verify product identity, compare source strength, inspect uncertainty, and define replacement criteria.
- Static HTML is sufficient for the MVP and stronger than a live web app under time constraints.

### Unknowns

- Whether every referenced YouTube channel's current description and subscriber data changed after browsing; the plugin treats URLs as persona anchors, not factual authority.
- Whether the public GitHub remote has runner-side commit/push automation available.
- Whether a future Codex CLI version will change plugin manifest ingestion rules.

### Assumptions

- The public repository URL is `https://github.com/procloudkim/2026-06-07-harness-baby`.
- The AGENTS.md timestamp `2026-06-07 14:47 KST` supersedes earlier 14:40 and 14:45 timestamps.
- The generated demo may use real brand names only inside a clearly labeled public-source case note with citations.

### Risks

- Product safety language can overstate evidence; mitigated by explicit source conflict and "not medical advice" language.
- A generated report can look like endorsement; mitigated by showing decision criteria rather than purchase recommendations.
- Codex plugin validation may reject optional interface metadata; mitigated by running the local plugin validator.

## Method Selection

### Candidate Methods

1. Static Codex skill only.
2. Codex skill plus local PowerShell report generator.
3. Full local web app with UI and report export.
4. Retrieval-heavy crawler that searches products automatically.

### Chosen Method

Method 2: Codex skill plus local PowerShell report generator.

Why:
- Satisfies the Codex Plugin requirement.
- Keeps execution local and reproducible.
- Avoids browser automation and crawling.
- Produces a concrete HTML report and screenshot quickly.

### Fallback Method

If screenshot generation fails, keep the generated HTML report as the primary demo artifact and include a text transcript in `docs/DEMO_SCRIPT.md`.

### Rejection Reasons

- Static skill only: not enough observable behavior for the demo.
- Full web app: unnecessary complexity for a 90-minute plugin deliverable.
- Retrieval-heavy crawler: conflicts with the no-crawling rule and increases safety risk.

## Execution Plan

- Baseline: scaffold plugin, create skill, create JSON-to-HTML generator, run on the Avent public-source example.
- Controllable variables: input JSON fields, output path, report template, screenshot size.
- Fixed variables: plugin path, repository URL, PowerShell 7, no paid APIs, no browser automation.
- Budget ladder:
  1. Valid manifest and marketplace.
  2. Skill instructions.
  3. Generator and example.
  4. Generated HTML and screenshot.
  5. README, demo script, validation.
- Promotion rule: move to the next step only after required files for the current step exist.
- Kill rule: stop any feature that requires credentials, browser login, paid services, or modifying files outside the repo.
- Stop rule: stop when local PowerShell verification passes and all Definition of Done files exist.
- Final evaluation rule: run `plugins/parentpick-guard/scripts/Test-ParentPickGuard.ps1` and local plugin manifest validation.
- Wall-clock estimate: 60 to 90 minutes for MVP completion.
- RAM estimate: under 512 MB.
- CPU/GPU/NPU role split: CPU only; no GPU or NPU required.
- Reboot-required resources: none.

## Final Recommendation Contract

- Chosen method and why: local Codex skill plus PowerShell generator for safe, reproducible MECE reports.
- Rejected alternatives and why: static-only, web app, and crawler rejected for weak demo value, excessive scope, or rule conflict.
- Evidence level: mixed; official manufacturer response plus secondary health/science summaries; public-source case note only.
- Residual risks: source conflict, changing external product statements, and overinterpretation by users.
- Metric definition: required-file existence, generated HTML existence, expected report sections present, screenshot asset exists, plugin validator exits 0.
- Evaluator used: local PowerShell verification script plus plugin manifest validator.
- Variance note: no stochastic component.
- Next smallest safe move: run local verification, then let the outer runner commit/push phase-level changes.
