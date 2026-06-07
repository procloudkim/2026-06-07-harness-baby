# Ultrawork Notepad

## Skills Used

- `omo:ulw-loop`: durable criteria, evidence ledger, and continued work without final completion.
- `plugin-creator`: Codex plugin package structure and marketplace expectations.
- `skill-creator`: focused `SKILL.md` design and validation expectations.
- `openai-docs`: official Codex plugin structure verification.

## Scope Sizing

- Surfaces: root plugin package, skill workflow, marketplace, README, examples, SVG screenshot, validator, reports, GitHub metadata, prior ParentPick regression surface.
- Files: 15+ new or modified files.
- Steps: scaffold, skill, examples, validation, README/reports, evidence capture, commits, optional GitHub publication.

## Operating Decision

PC has 12 physical cores, 24 logical processors, and about 64 GB RAM. The slow path is not compute capacity; it is long agent waits and oversized status output. Use at most one planning/review worker at a time and prefer short local PowerShell verification loops.

## Evidence Plan

- G008-C001: root BabyGear validator PASS.
- G008-C002: validator rejects missing skill file.
- G008-C003: ParentPick regression still PASS plus BabyGear validator PASS and commit count proof.

