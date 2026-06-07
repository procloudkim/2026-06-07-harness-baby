# ParentPick Guard Evidence Brief

## Problem Definition

- Goal: Build a Codex Plugin that helps newborn parents organize baby-product trust and safety-risk information into a structured MECE report.
- Context: Mini-Ralphthon project started on 2026-06-07 14:47 KST. The motivating case is a public-source Philips Avent pacifier BPA discussion.
- Constraints: PowerShell 7 only, work inside the repo, no browser automation, no crawling, no paid APIs, no unsupported product-danger claims, no medical diagnosis.
- Success criteria: Valid plugin manifest, skill, local PowerShell tools, examples, templates, generated sample output, screenshot asset, README, marketplace entry, final report, demo script, and documented verification.
- Done-when: `plugins/parentpick-guard/scripts/Test-ParentPickGuard.ps1` exits 0 and the required files exist.

## Evidence Brief

### Authoritative Source Map

1. Project AGENTS.md: binding implementation and safety requirements.
2. Local Codex `plugin-creator` skill: plugin manifest and marketplace shape.
3. Philips official support page, published 2026-05-28: states Philips Avent pacifier ranges are BPA-free and that DEKRA follow-up tests found no detectable BPA across listed ranges, including the sample discussed. URL: https://www.usa.philips.com/c-f/XC000022169/i-ve-read-news-about-pacifiers-and-bpa-how-do-you-validate-philips-avent-pacifiers-are-bpa-free
4. Philips Canada support page, published 2026-05-28: states Avent pacifiers meet or exceed international safety standards and are BPA-free throughout manufacturing. URL: https://www.philips.ca/c-f/XC000022123/are-philips-avent-pacifiers-safe-for-my-baby
5. Kormedi article, published 2025-10-22: reports dTest findings and manufacturer responses; used as a secondary health-news source. URL: https://kormedi.com/2758325/
6. User-provided YouTube channel URLs: used only as persona anchors for practical parent operations, pediatric caution, and family logistics; not used as scraped factual sources.

### Verified Facts

- Kormedi reports that dTest tested pacifiers in artificial saliva at 37 degrees C for 30 minutes and reported BPA findings for several products.
- Kormedi reports Philips Avent Ultra Air at 2 micrograms per kilogram and reports that Philips disputed the result.
- Philips official support says follow-up DEKRA testing found no detectable BPA across Avent pacifier ranges, including the sample discussed.
- The project requires a repo-local plugin at `plugins/parentpick-guard/` and a repo-local marketplace at `.agents/plugins/marketplace.json`.

### Inferences

- The safest useful plugin behavior is evidence organization, not product verdict generation.
- The MECE report should separate trust signals, risk signals, source conflicts, actions, and replacement criteria.
- A static HTML report is sufficient and reproducible under the time limit.

### Unknowns

- Whether all external article metadata will remain unchanged after 2026-06-07.
- Whether the public GitHub remote has an authenticated runner available for pushing.
- Whether future Codex Plugin validation schema changes will require manifest updates.

### Assumptions

- Public repository URL is `https://github.com/procloudkim/2026-06-07-harness-baby`.
- The latest AGENTS.md timestamp, 2026-06-07 14:47 KST, is the binding project start time.
- Real brand names are acceptable only in clearly labeled public-source case notes with citations.

### Risks

- Safety language may be overread as advice; mitigated by disclaimers and evidence-level labels.
- Secondary sources may paraphrase primary testing details; mitigated by marking source type and authority.
- Git commit/push visibility depends on the outer PowerShell runner per AGENTS.md.
