# Operation Notes

This project is intentionally optimized for the current Windows 11 Ralphthon machine and for predictable Codex CLI execution.

## Observed Machine Class

Captured without reading secrets or environment variables:

- OS target: Windows 11.
- Shell target: PowerShell 7 only.
- PowerShell version observed: 7.6.2.
- Manufacturer/model observed: ASUS TUF Gaming A14 FA401EA.
- CPU observed: AMD RYZEN AI MAX+ 392 w/ Radeon 8060S.
- CPU class observed: 12 cores / 24 logical processors.
- RAM class observed: about 62.6 GB.

## Execution Choices

- Keep the plugin package static: Markdown, JSON, SVG, and PowerShell.
- Avoid npm, Python, package installation, browser automation, live scraping, hooks, MCP servers, or app connectors.
- Use bounded validation instead of broad experimentation.
- Prefer one main-thread implementation loop with at most one targeted review/debug loop when evidence requires it.
- Keep generated fixture directories under `.omo/ulw-loop/fixtures/` and remove them after negative tests.
- Keep validation temp output under `.codex-temp/` and ensure it is removed by verifier scripts.

## Why This Fits The PC

The machine has enough CPU and RAM for parallel commands, but the project does not benefit from broad parallelism because the package is mostly static files and PowerShell validators. The fastest reliable path is short local validation loops:

```powershell
pwsh -NoProfile -File .\scripts\validate-plugin.ps1
pwsh -NoProfile -File .\plugins\parentpick-guard\scripts\Test-ParentPickGuard.ps1
pwsh -NoProfile -File .\scripts\Show-SubmissionSummary.ps1
```

## Safety Boundaries

- Do not read `.env`, credentials, SSH keys, browser profiles, token stores, or secret-like environment variables.
- Do not modify registry, PATH, execution policy, user profile config, or machine-level settings.
- Do not install dependencies just to satisfy optional LSP diagnostics.
- Do not use destructive git operations.
- Do not claim a real baby product is safe or dangerous without authoritative product-specific evidence.
