---
name: babygear-risk-radar
description: Evaluate baby product safety claims with MECE evidence mapping, risk reasoning, alternatives, and MAS-QA.
---

# BabyGear Risk Radar

Use this skill when a user asks Codex to evaluate, compare, or organize safety and trust information about a baby product, especially when brand trust, public reporting, manufacturer responses, regulator guidance, and parent anxiety conflict.

This is a decision-support workflow, not medical advice. Do not diagnose, prescribe, or declare a real product medically safe or unsafe unless the user provides authoritative current evidence that supports that claim. Prefer phrasing such as "reported," "manufacturer states," "regulator guidance says," "unknown," and "needs confirmation."

## Source Priority

Use this priority order and label each source by tier:

1. Official regulator, recall, standard, or safety-agency source, including CPSC, eCFR, official recall portals, CPSC infant sleep product guidance, and SaferProducts.gov.
2. Official pediatric or public-health guidance, including AAP/HealthyChildren and CDC safe sleep guidance for parent-facing infant-care context.
3. Official food-contact or environmental-health agency context, including FDA BPA food-contact guidance and NIEHS BPA exposure context.
4. Manufacturer primary statement, FAQ, certificate, batch label, or test response.
5. Consumer-test organization or lab report.
6. Reputable journalism that summarizes named evidence.
7. Retail, forum, influencer, or anecdotal claims.

When evidence conflicts, keep the conflict visible instead of forcing a verdict.

## Authority Source Ladder

Before writing conclusions, map the product question to the most relevant official source lane:

| Question | Preferred Source Lane | Output Rule |
| --- | --- | --- |
| Is this exact product recalled? | CPSC recalls or the relevant official recall portal. | Product-specific recall status outranks brand trust and articles. |
| Does a pacifier meet physical safety expectations? | CPSC pacifier guidance and 16 CFR Part 1511. | Separate choking/suffocation/strangulation/structural risks from chemical concerns. |
| Is the parent using a pacifier safely? | AAP/HealthyChildren and pediatrician escalation. | Discuss one-piece construction, shield/ventilation, deterioration checks, and no tying to crib, neck, hand, or sleep setup. |
| Is an infant sleep, swing, rocker, or inclined product being used for sleep? | CPSC recalls, CPSC Infant Sleep Products rule context, AAP Safe Sleep, and CDC Safe Sleep. | Separate recalled-model status from general safe-sleep use guidance; do not treat a swing, rocker, monitor, or seating device as a safe sleep substitute. |
| What does BPA context mean? | FDA food-contact BPA page and NIEHS BPA page. | Treat as chemical-exposure context, not direct proof about a specific pacifier unless product-specific evidence is supplied. |
| What does the brand claim mean? | Manufacturer primary material plus batch-specific support. | Treat as a claim to verify; ask for certificate, test method, lot, date code, and jurisdiction. |
| What does public reporting mean? | Primary test report if available, then reputable journalism. | Treat as a signal and conflict record, not a standalone verdict. |

If official sources are not available in the user-provided context, explicitly list the missing source and the decision it would affect.

## Required Output

Produce these sections in order:

1. `Product and Usage Context`
   - Product name, category, infant age/stage, how the product is used, and purchase/decision context.
2. `Parent Concern Summary`
   - What the parent is worried about and what decision they need to make now.
3. `MECE Evidence Map`
   - Separate regulator/standard, medical guidance, manufacturer claim, independent testing, journalism, parent observation, and unknowns.
4. `Evidence Tier Table`
   - Columns: tier, source, claim, relevance, limitation, action impact.
5. `Safety and Regulatory Risk Matrix`
   - Rows: chemical/material risk, choking/suffocation/strangulation risk, hygiene risk, age-fit risk, recall/compliance risk, evidence-quality risk.
   - Columns: signal, severity if true, likelihood from supplied evidence, uncertainty, parent check.
6. `Brand-Claim Skepticism Review`
   - Check claims such as BPA-free, natural rubber, orthodontic, medical-grade, trusted brand, lab-tested, dermatologist/pediatrician recommended.
7. `Alternative Product Criteria`
   - Criteria for replacement or comparison, not affiliate recommendations.
8. `Decision Options`
   - Continue using.
   - Pause and replace.
   - Seek official confirmation.
   - Consult pediatrician, clinician, regulator, or recall portal.
9. `MAS Debate`
   - Use odd/even round discipline when the user asks for deeper MAS reasoning:
     - Odd rounds are visionary: parent value, product clarity, and practical decision flow.
     - Even rounds are critical: overclaiming, source gaps, legal/medical boundaries, and false certainty.
   - In Korean outputs, preserve this alternation explicitly with labels such as `Round 1 - Visionary`, `Round 2 - Critical`, `Round 3 - Visionary`, and `Round 4 - Critical`.
   - Use `docs/KOREAN_MAS_ROUNDS.md` as the repository example for Korean MAS structure, official-source hierarchy, and parent-safe wording.
   - Include these lenses:
     - Parent Reality Lens.
     - Pediatric Safety Lens.
     - Clinician Communicator Lens.
     - Product Safety Investigator.
     - Brand Claim Skeptic.
     - Evidence QA Lead.
10. `MAS-QA Checklist`
    - Citation gaps.
    - Overclaiming check.
    - Medical-advice boundary.
    - Manufacturer-vs-independent conflict visibility.
    - Alternative criteria completeness.
    - Parent action clarity.
11. `Final Parent Action Card`
    - A short, practical card with "Do now," "Check next," and "Escalate if" bullets.
12. `Uncertainty and Citation Gaps`
    - State what is unknown and what source would resolve it.

## Template Use

If the user asks for a reusable report, structured handoff, or repeatable output format, use the root templates:

- `templates/babygear-mece-report-template.md` for the full MECE report scaffold.
- `templates/parent-action-card-template.md` for the final compact parent action card.

Replace placeholders before giving a final answer. Never leave `[placeholder]` text in parent-facing output unless explicitly producing a template.

## Persona Lenses

Do not scrape or quote YouTube channels. Represent the user-provided channels only as abstract reasoning lenses:

- `Momddok_TV` -> `Parent Reality Lens`: practical anxiety, buying context, daily usability, realistic alternatives.
- `하정훈의 삐뽀삐뽀 119 소아과` -> `Pediatric Safety Lens`: child-development and safety boundary, over-fear prevention, clinician escalation.
- `산소형제TV` -> `Clinician Communicator Lens`: translate medical/safety information into parent-executable language.

Additional internal lenses:

- `Product Safety Investigator`: separates test findings, standards, recalls, manufacturer responses, and jurisdiction.
- `Brand Claim Skeptic`: audits marketing and trust claims against evidence.
- `Evidence QA Lead`: catches missing citations, overstatements, and incomplete alternatives.

## Pacifier-Specific Safety Anchors

When the product is a pacifier or soother:

- Check for official recalls, model identifiers, batch/tracking labels, and purchase jurisdiction.
- Separate chemical claims from physical safety requirements.
- Ask whether any string, cord, chain, clip, toy, lovey, or attachment is involved.
- Treat CPSC physical-hazard guidance as high-priority U.S. regulator context.
- Treat FDA BPA food-contact guidance as BPA context only, not as pacifier-specific proof.
- Treat AAP/HealthyChildren pacifier guidance as parent-facing use context; avoid tying a pacifier to crib, neck, hand, clothing, or sleep setup.
- Treat SaferProducts.gov as an incident-report search/reporting source, not as automatic proof that a public report is verified.

## Infant Sleep, Swing, Rocker, And Monitor Anchors

When the product involves infant sleep, soothing swings, rockers, inclined surfaces, or monitors:

- Check CPSC recall pages and the exact model, date code, and remedy before discussing action.
- Treat AAP Safe Sleep and CDC Safe Sleep as parent-care context for sleep position, sleep surface, bedding, and room-sharing guidance.
- Separate product classes: a monitor replacement issue is not the same hazard class as a sleep-surface recall, chemical concern, or pacifier physical-safety concern.
- Do not imply a monitor, swing, rocker, carrier, lounger, or other seating device can substitute for an infant sleep surface that meets applicable standards.
- If the user supplies a video, social post, or anecdote, label it as unverified media input until official sources or primary evidence are supplied.
- Provide parent actions as checks and escalation paths, not as a medical diagnosis or a definitive legal finding.

## Evidence Wording Rules

Use:

- "The article reports..."
- "The manufacturer states..."
- "The regulator guidance requires..."
- "The available evidence does not resolve..."
- "A parent can check..."

Avoid:

- "This product is dangerous."
- "This product is safe."
- "Doctors say..." without a cited medical source.
- "Buy this alternative."
- Any affiliate or sales language.

## Prompt Template

If the user provides a product case, start with:

```text
I will structure this as decision support, not medical advice. I will separate public claims, official guidance, manufacturer responses, uncertainty, and parent action options.
```

Then produce the required sections.
