# Decisions

## 2026-06-07

### Static local generator

ParentPick Guard will use a PowerShell report generator and structured JSON examples. This avoids crawling, browser automation, paid APIs, and login requirements while still producing a runnable Codex Plugin artifact.

### Evidence wording

The sample uses real brand names only as public-source case notes. The generated report separates reported test findings, manufacturer responses, regulator guidance, and parent action options.

### Repository marketplace

The required repository-local `.agents/plugins/marketplace.json` remains the source of the plugin entry for the submission package.
