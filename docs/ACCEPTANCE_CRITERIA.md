# Acceptance Criteria

## Package Structure

- [ ] `.codex-plugin/plugin.json` exists and parses as JSON.
- [ ] `skills/babygear-risk-radar/SKILL.md` exists and has required YAML front matter.
- [ ] `.agents/plugins/marketplace.json` exists and points `babygear-risk-radar` to `./`.
- [ ] `assets/demo-screenshot.svg` exists and is referenced from README.
- [ ] `examples/avent-pacifier-risk-brief.md` and `examples/sample-output.md` exist.
- [ ] `scripts/validate-plugin.ps1` exists and passes.
- [ ] `reports/MAS_QA_REPORT.md` and `reports/FINAL_REPORT.md` exist.
- [ ] README starts with `# BabyGear Risk Radar Codex Plugin`.

## Plugin Behavior

- [ ] Skill workflow produces product context, parent concern summary, MECE evidence map, evidence tiers, safety matrix, brand-claim skepticism, alternatives, options, MAS debate, MAS-QA, action card, and uncertainty gaps.
- [ ] Skill explicitly avoids medical diagnosis and unsupported product-danger claims.
- [ ] Skill uses personas as reasoning lenses, not as quoted authorities.
- [ ] Skill includes source priority and citation gap handling.

## Validation

- [ ] Validator fails on missing required files.
- [ ] Validator checks manifest path rules.
- [ ] Validator checks no obvious secret-like files are tracked.
- [ ] Validator checks README screenshot and GitHub URL.
- [ ] ParentPick Guard adjacent regression verifier still passes.
- [ ] Git log shows multiple implementation commits.

