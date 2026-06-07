# Assumptions

## Project Assumptions

- The final Ralphthon target is `babygear-risk-radar-codex-plugin`.
- The plugin itself lives at the repository root, so the repo-scoped marketplace entry points to `./`.
- Existing `plugins/parentpick-guard` work remains in Git history and as an adjacent regression surface, but the submission README and root plugin metadata should prioritize BabyGear Risk Radar.
- The preferred public GitHub URL was `https://github.com/procloudkim/babygear-risk-radar-codex-plugin`.
- Because GitHub CLI is not installed locally and the preferred repository does not exist, the actual pushed submission URL is `https://github.com/procloudkim/2026-06-07-harness-baby`.
- If GitHub publication is unavailable, the failure reason must be documented in `reports/FINAL_REPORT.md`.

## Safety Assumptions

- Public articles and manufacturer statements are treated as evidence inputs, not as medical conclusions.
- User-provided YouTube channels are represented only as abstract MAS personas. The plugin does not scrape, quote, or summarize channel transcripts.
- Parents should be directed to official recalls, regulators, product certificates, batch labels, pediatricians, or clinicians for action decisions when risk is unclear.

## Source Assumptions

- CPSC pacifier guidance is used for physical and regulatory safety context.
- FDA BPA food-contact guidance is used only as BPA regulatory context and not as pacifier-specific proof.
- AAP/HealthyChildren safe-sleep guidance is used for parent-facing pacifier-use boundaries, including avoiding neck or clothing attachments during sleep.
