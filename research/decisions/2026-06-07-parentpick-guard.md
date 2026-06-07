# ParentPick Guard Decision Log

## D1. Evidence Organizer Instead Of Product Verdict

- Decision: The plugin produces MECE reports and next-action checklists, not safe/unsafe product verdicts.
- Reason: The available public case has source conflict between a secondary report of dTest findings and Philips official follow-up statements.
- Rejected: A hazard classifier or purchase recommender, because it could imply unsupported safety advice.

## D2. PowerShell Tools

- Decision: Implement local tools in PowerShell 7.
- Reason: AGENTS.md requires PowerShell 7 only on Windows 11.
- Rejected: Node, Python, Bash, WSL, and browser automation.

## D3. Static HTML Output

- Decision: Generate static HTML from JSON input and a local template.
- Reason: HTML is easy to inspect, archive, and screenshot without a server.
- Rejected: Full local app, because it adds unnecessary moving parts.

## D4. Public-Source Case Note

- Decision: Use real brand names only inside the example labeled `Public-source case note`.
- Reason: The prompt includes the Avent case, but AGENTS.md forbids unsupported claims that a real product is dangerous.
- Rejected: Synthetic-only example, because it would not demonstrate the user's motivating case.
