# Demo Script

## Goal

Show that BabyGear Risk Radar is a Codex CLI plugin package, not an app, and that it helps Codex turn an uncertain baby-product safety controversy into a structured parent decision report.

## Local Validation

```powershell
pwsh -NoProfile -File .\scripts\validate-plugin.ps1
```

Expected result:

```text
Status          : PASS
PluginName      : babygear-risk-radar
MarketplacePath : ./
Screenshot      : ./assets/demo-screenshot.svg
SkillPath       : skills/babygear-risk-radar/SKILL.md
```

## Demo Prompt

```text
Use the babygear-risk-radar skill.

Evaluate this public-source case note:
A parent trusted a well-known pacifier brand because the product was marketed as BPA-free. Later reporting described a consumer-test finding that allegedly detected BPA in some pacifiers, while the manufacturer disputed the finding and cited additional testing. Produce a parent-friendly MECE report with evidence tiers, risk matrix, alternatives, MAS debate, MAS-QA, and a final parent action card.
```

## Expected Output Shape

- Product and usage context.
- Parent concern summary.
- MECE evidence map.
- Evidence tier table.
- Safety and regulatory risk matrix.
- Brand-claim skepticism review.
- Alternative selection criteria.
- MAS debate and MAS-QA checklist.
- Final parent action card.
- Uncertainty and citation gaps.

## Screenshot

![Demo screenshot](../assets/demo-screenshot.svg)
