# ParentPick Guard Research Decisions

Date: 2026-06-07

## D1. Evidence Conflict Handling

Decision: Reports must include both consumer-test claims and manufacturer responses when both are available.

Why: The Avent case contains conflicting public evidence. A parent-facing trust report should preserve the conflict instead of collapsing it into a binary "safe" or "unsafe" conclusion.

## D2. MECE Categories

Decision: Use these categories for the sample report:

- Product identity
- Safety signal
- Manufacturer response
- Regulatory or standards context
- Parent-use context
- Action checklist
- Evidence gaps

Why: These categories avoid overlap while covering what parents need to inspect before making their own purchase or use decision.

## D3. No Automated Alternatives

Decision: Do not generate product alternatives or rankings.

Why: The prompt asks for baby-item information discovery and organization, but the evidence base in this sprint does not support endorsement or substitution recommendations.

## D4. Demo Data Labeling

Decision: Real brand names are allowed only in a `public_source_case_note` example with source URLs and conflict notes.

Why: This satisfies the user-provided Avent case while honoring the guardrail against unsupported danger claims.

## D5. Verification Surface

Decision: Verify through the local PowerShell tool surface, not browser automation.

Why: The repository instructions explicitly prohibit browser automation. The report is static HTML, so local generation and file-content checks are enough for MVP verification.
