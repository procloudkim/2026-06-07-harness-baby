---
name: babygear-risk-radar
description: Evaluate baby product safety claims with MECE evidence mapping, risk reasoning, alternatives, and MAS-QA.
---

# BabyGear Risk Radar

Use this skill when a user asks Codex to evaluate, compare, or organize safety and trust information about a baby product, especially when brand trust, public reporting, manufacturer responses, regulator guidance, and parent anxiety conflict.

This is a decision-support workflow, not medical advice. Do not diagnose, prescribe, or declare a real product medically safe or unsafe unless the user provides authoritative current evidence that supports that claim. Prefer phrasing such as "reported," "manufacturer states," "regulator guidance says," "unknown," and "needs confirmation."

## Source Priority

Use this priority order:

1. Official regulator, recall, standard, or safety-agency source.
2. Official pediatric or clinician society guidance.
3. Manufacturer primary statement, FAQ, certificate, batch label, or test response.
4. Consumer-test organization or lab report.
5. Reputable journalism that summarizes named evidence.
6. Retail, forum, influencer, or anecdotal claims.

When evidence conflicts, keep the conflict visible instead of forcing a verdict.

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

- Check for official recalls and batch/tracking labels.
- Separate chemical claims from physical safety requirements.
- Ask whether any string, cord, chain, clip, toy, lovey, or attachment is involved.
- Treat CPSC physical-hazard guidance as high-priority U.S. regulator context.
- Treat FDA BPA food-contact guidance as BPA context only, not as pacifier-specific proof.
- Treat AAP/HealthyChildren safe-sleep pacifier guidance as parent-facing use context; avoid neck or clothing attachments during sleep.

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

