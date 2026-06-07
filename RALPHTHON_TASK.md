# RALPHTHON_TASK.md

## Event Context

- Event: 90-minute mini-Ralphthon.
- Start: 2026-06-07 14:40 KST.
- End: 2026-06-07 16:10 KST.
- Submission: public GitHub repository URL.
- Artifact type: Codex CLI plugin package, not an app.

## Target

Repository/package name:

```text
babygear-risk-radar-codex-plugin
```

Plugin name:

```text
babygear-risk-radar
```

One-line description:

```text
A Codex plugin that helps parents and builders evaluate baby product safety claims with MECE evidence mapping, risk reasoning, alternatives, and MAS-style QA.
```

## MVP Scope

Build a root-level Codex plugin package with:

- `.codex-plugin/plugin.json`
- `skills/babygear-risk-radar/SKILL.md`
- `.agents/plugins/marketplace.json`
- `assets/demo-screenshot.svg`
- `examples/avent-pacifier-risk-brief.md`
- `examples/sample-output.md`
- `scripts/validate-plugin.ps1`
- `docs/ASSUMPTIONS.md`
- `docs/MAS_DECISIONS.md`
- `docs/ACCEPTANCE_CRITERIA.md`
- `docs/COMMIT_LOG.md`
- `reports/MAS_QA_REPORT.md`
- `reports/FINAL_REPORT.md`
- `README.md`
- `LICENSE`
- `.gitignore`

Do not add hooks, MCP servers, apps, external dependencies, scraping, affiliate links, telemetry, backend services, or medical-diagnosis behavior.

## Safety Boundary

The plugin is a decision-support workflow. It must help Codex separate evidence, uncertainty, safety risk, alternatives, and parent actions. It must not claim that a real baby product is medically safe or unsafe unless the user supplies authoritative current evidence in that Codex session.

## Source Grounding

The motivating case is the Philips Avent pacifier/BPA controversy. The skill should frame it as a public-source case note with disputed evidence, not as a definitive product danger finding. Use official regulator and pediatric guidance where possible.

## Required Commits

Preserve implementation through meaningful commits:

1. `docs: add babygear ralphthon spec`
2. `feat: scaffold babygear plugin manifest`
3. `feat: add babygear risk radar skill`
4. `docs: add babygear examples and screenshot`
5. `test: add babygear plugin validator`
6. `docs: add babygear readme and qa reports`
7. `chore: record babygear submission metadata`

## Verification

Primary command:

```powershell
pwsh -NoProfile -File .\scripts\validate-plugin.ps1
```

Regression command:

```powershell
pwsh -NoProfile -File .\plugins\parentpick-guard\scripts\Test-ParentPickGuard.ps1
```

