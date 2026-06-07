# Decisions

## 2026-06-07

### Static local generator

ParentPick Guard will use a PowerShell report generator and structured JSON examples. This avoids crawling, browser automation, paid APIs, and login requirements while still producing a runnable Codex Plugin artifact.

### Evidence wording

The sample uses real brand names only as public-source case notes. The generated report separates reported test findings, manufacturer responses, regulator guidance, and parent action options.

### Repository marketplace

The required repository-local `.agents/plugins/marketplace.json` remains the source of the plugin entry for the submission package.

### Validator fallback

The Codex plugin validator first exposed a missing `PyYAML` dependency in the base Python environment. To avoid mutating the user environment, validation used a temporary in-repo `.tmp-validator-deps` dependency path via `PYTHONPATH`, then removed that temporary path after `quick_validate.py` and `validate_plugin.py` passed. The PowerShell verifier remains the repeatable local check for required files, manifest URLs, skill metadata, marketplace entry, PowerShell syntax, generated HTML, PNG assets, malformed input handling, and documentation consistency.

### Report input hardening

Generated reports now allow only empty, `http`, or `https` source URLs. Unsupported schemes are rejected before HTML output is written so source rows cannot create unsafe links. Required list fields also must contain at least one usable non-null item, which prevents structurally present but empty evidence arrays from producing misleading reports.

Each non-null source row must also provide non-empty string `name`, `type`, `claim`, and `use` fields. `tier`, `date`, and `url` stay optional so the source map can represent incomplete citation metadata without falling back to anonymous or empty evidence rows.

### Evidence replay scope

The evidence replay verifier checks canonical PASS evidence across the initial delivery, evidence-harness hardening, URL/list hardening, and G005 wrapper hardening cycles. RED/diagnostic transcripts remain in `.omo` for audit history, but they are intentionally excluded from the replay PASS list.

### Wrapper-first local tool

The local tool entry point is `tools\Invoke-ParentPickGuard.ps1`. It delegates to `scripts\New-ParentPickReport.ps1`, which remains the generator implementation detail, and the main verifier now checks the wrapper output directly so documentation and executable behavior stay aligned.

### One-command Korean demo discoverability

`scripts\Show-SubmissionSummary.ps1` now reports both `KoreanMockPage` and `KoreanPluginOutput`. This keeps the Korean mock page and actual plugin-run example discoverable from the same PowerShell summary command judges can use for commit count, branch, GitHub URL, validator command, and core plugin paths.

### Prompt packet generator for actual plugin use

`scripts\New-BabyGearDemoPrompt.ps1` generates a Korean prompt packet that can be pasted into Codex CLI with the BabyGear Risk Radar plugin enabled. The tool is intentionally local, deterministic, and output-path bounded to the repository so it does not become an app, crawler, API client, or publisher. The validator executes it against a temporary repo-local path and removes `.codex-temp` when validation finishes.

### Prompt packet parity validation

The root validator now compares normalized output from `scripts\New-BabyGearDemoPrompt.ps1` with the checked-in `examples\korean-demo-prompt.md`. This prevents the static example from drifting away from the actual local PowerShell tool and gives judges one deterministic prompt packet for Korean plugin-use demonstrations.
