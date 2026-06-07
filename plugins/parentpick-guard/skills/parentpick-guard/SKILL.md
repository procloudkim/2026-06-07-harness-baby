---
name: parentpick-guard
description: Use when newborn parents need to organize baby-product trust, safety-risk, source-conflict, and replacement-criteria information into a structured MECE report without making medical diagnoses or unsupported danger claims.
---

# ParentPick Guard

ParentPick Guard turns baby-product trust and safety-risk notes into a parent-facing MECE report. Use it when the user is comparing public claims, official product statements, regulatory notes, or expert/persona perspectives for newborn or infant products.

## Safety Boundary

- Do not make medical diagnoses.
- Do not state that a real product is dangerous unless the claim is directly supported by cited evidence.
- For real brands, frame the output as a public-source case note.
- Separate verified facts, source-reported claims, inferences, assumptions, unknowns, and parent actions.
- Do not add affiliate links or purchase endorsements.
- Prefer official product pages, regulator pages, standards, and primary test reports over secondary summaries.

## MAS Persona Lens

When the user provides persona channels or experts, use them as analysis lenses rather than as uncited factual authorities unless a specific cited statement is available.

Default lenses:

1. Practical parent operator: What should be checked, photographed, stored, replaced, or asked of support?
2. Pediatric evidence caution: What should not be overclaimed, and when should a clinician or regulator be consulted?
3. Family logistics explainer: How can caregivers share the decision consistently?

## Required Output Shape

Produce these MECE sections:

1. Decision need
2. Evidence grade
3. Source map
4. Source conflicts
5. Product identity and batch checks
6. Risk signals
7. Unknowns
8. Replacement or monitoring criteria
9. Next smallest safe actions

## Local PowerShell Tool

From the repository root:

```powershell
pwsh -NoProfile -File .\plugins\parentpick-guard\scripts\New-ParentPickReport.ps1 `
  -InputPath .\plugins\parentpick-guard\examples\avent-pacifier-case.json `
  -OutputPath .\plugins\parentpick-guard\generated\sample-report.html
```

Verify the plugin demo:

```powershell
pwsh -NoProfile -File .\plugins\parentpick-guard\scripts\Test-ParentPickGuard.ps1
```

## Case Framing Rule

The included Avent pacifier sample is demo data based on public-source notes. It must not be treated as a fresh investigation or as a product-danger verdict. The generated report explicitly records source conflict between secondary reports and the manufacturer response.
