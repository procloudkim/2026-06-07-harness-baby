# AGENTS.md

## Mission Context

This repository is for a mini-Ralphthon project starting at 2026-06-07 14:47 KST.

The submission target is a public GitHub repository containing a Codex Plugin.

Project:
ParentPick Guard Codex Plugin

Purpose:
Help newborn parents organize baby-product trust and safety-risk information into a structured MECE report.

## Environment

- OS: Windows 11.
- Shell: PowerShell 7 only.
- Work only inside the current Git repository.
- Do not use Bash, WSL, Git Bash, Linux shell syntax, `rm -rf`, `chmod`, `sed`, `awk`, `grep`, or `make`.
- Do not assume administrator privileges.

## Codex Plugin Requirements

Create a valid Codex Plugin package under:

- `plugins/parentpick-guard/`

The plugin must include:

- `.codex-plugin/plugin.json`
- `skills/parentpick-guard/SKILL.md`
- local PowerShell tools
- examples
- templates
- generated sample output
- demo screenshot asset

The repo root must include:

- `README.md`
- `.agents/plugins/marketplace.json`
- `docs/FINAL_REPORT.md`
- `docs/DEMO_SCRIPT.md`

## Autonomy

Continue autonomously until the Definition of Done is satisfied or all fallback options are exhausted.

Do not ask the user questions unless:

1. A secret, credential, API key, browser login, billing account, or paid external service is required.
2. A destructive operation is required.
3. A file outside the repository must be modified.
4. A legal, license, or safety issue blocks the task.
5. The requested output is impossible.

## Do Not

Never:

- Read `.env`, credential files, SSH keys, browser profiles, token stores, or environment variables that look like secrets.
- Modify Windows registry, PATH, execution policy, user profile config, or machine-level settings.
- Deploy, publish packages, create accounts, or use paid external APIs.
- Use web crawling, login scraping, browser automation, or Chrome extension.
- Add affiliate links.
- Make medical diagnoses.
- Claim that a real product is dangerous unless supported by cited evidence.
- Use real brand names in generated demo data unless clearly framed as public-source case notes.
- Use `--yolo` or bypass sandboxing.
- Stop with only analysis if an MVP can be implemented.

## Git and Commit Policy

The outer PowerShell runner handles commits.

Codex should:

- Make coherent phase-level changes.
- Update `docs/RUN_LOG.md`.
- Update `docs/DECISIONS.md`.
- Avoid direct git commits unless explicitly asked by the runner.

The implementation process must be visible through multiple commits.

## Required Workflow

1. Scaffold plugin manifest and marketplace.
2. Implement the skill instructions.
3. Implement report generator.
4. Add examples and generated sample reports.
5. Add README, demo script, screenshot asset, and final report.
6. Verify locally with PowerShell.

## Definition of Done

Done means:

- Public GitHub URL is present in README and plugin manifest.
- Root `README.md` summarizes the project.
- Plugin manifest exists.
- Skill `SKILL.md` exists and has metadata.
- PowerShell report generator exists.
- Example inputs exist.
- A sample HTML report exists.
- A demo screenshot asset exists.
- Implementation process is recorded through commits.
- `docs/FINAL_REPORT.md` exists.
- `docs/DEMO_SCRIPT.md` exists.
- Verification command has been run and documented.
