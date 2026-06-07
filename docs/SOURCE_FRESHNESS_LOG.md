# Source Freshness Log

## Scope

This log records official-source checks performed during the 2026-06-07 KST Codex session for the Korean BabyGear Risk Radar demo assets. It is not a live recall lookup, crawler, medical opinion, or product-safety certification.

Use it to understand which official URLs the static plugin package was aligned to before submission. For a real parent decision, Codex should re-check the relevant official source in the active session.

## Verification Summary

| Source | Checked in session | Evidence tier | Demo use | Boundary |
| --- | --- | --- | --- | --- |
| Philips Avent pacifier BPA FAQ | 2026-06-07 KST | Manufacturer primary statement | Philips Avent BPA case-1 conflict map | Treat as manufacturer response, not independent proof. |
| Philips Avent BPA/BPS FAQ | 2026-06-07 KST | Manufacturer primary statement | Brand-claim skepticism for BPA/BPS-free wording | Ask for product, model, lot, jurisdiction, and test method when deciding. |
| Philips Avent monitor replacement page | 2026-06-07 KST | Manufacturer recall/support page | Philips Avent monitor case-3 hazard-class separation | Do not mix monitor replacement issues with pacifier chemical concerns. |
| CPSC Rock 'n Play recall page | 2026-06-07 KST | U.S. official recall | Fisher-Price case-4 official recall context | Product-specific recall context, not a universal brand verdict. |
| CPSC Snuga Swing recall page | 2026-06-07 KST | U.S. official recall | Fisher-Price case-4 sleep/swing risk context | Product-specific recall context, not a generic claim about all swings. |
| CPSC Infant Sleep Products FAQ | 2026-06-07 KST | U.S. regulator FAQ | Infant sleep product source ladder | Use for sleep-product classification and regulatory context. |
| AAP Safe Sleep page | 2026-06-07 KST | Pediatric society guidance | Parent-facing sleep safety anchors | Guidance context only; individual care questions go to a clinician. |
| CDC Safe Sleep page | 2026-06-07 KST | U.S. public-health guidance | Parent-facing safe sleep explanation | Supports safe-sleep education, not product certification. |

## Source Notes

### Philips Avent BPA FAQ

- URL: https://www.usa.philips.com/c-f/XC000022169/i-ve-read-news-about-pacifiers-and-bpa-how-do-you-validate-philips-avent-pacifiers-are-bpa-free
- Observed page date: Published on 28 May 2026.
- Demo interpretation: manufacturer states its Philips Avent pacifier ranges are BPA-free and says additional DEKRA testing found no detectable BPA across the cited ranges.
- Plugin action: keep this separate from consumer-test reporting and require uncertainty/citation gaps.

### Philips Avent BPA/BPS FAQ

- URL: https://www.usa.philips.com/c-f/XC000001798/is-my-philips-avent-product-bpa-and-bps-free
- Observed page date: Published on 28 May 2026.
- Demo interpretation: manufacturer states Philips Avent food-contact product parts are BPA- and BPS-free and describes quality controls.
- Plugin action: classify as brand/manufacturer claim that needs product-specific confirmation when a parent asks about a concrete item.

### Philips Avent Monitor Replacement

- URL: https://www.usa.philips.com/c-w/support-home/recall/avent-digital-video-baby-monitors.html
- Observed page context: voluntary replacement action for specific Philips Avent digital video baby monitor models produced between January 2016 and January 2020.
- Demo interpretation: monitor replacement is a product support/recall-style hazard class.
- Plugin action: separate from pacifier BPA, choking, hygiene, or infant sleep-surface analysis.

### Fisher-Price Rock 'n Play CPSC Recall

- URL: https://www.cpsc.gov/Recalls/2023/Fisher-Price-Reannounces-Recall-of-4-7-Million-Rock-n-Play-Sleepers-At-Least-Eight-Deaths-Occurred-After-Recall
- Observed recall date: January 09, 2023.
- Observed product scope: all Rock 'n Play Sleeper models, about 4.7 million units.
- Demo interpretation: official recall context outranks brand trust, articles, and anecdotal claims.
- Plugin action: require model matching, remedy check, and official action path.

### Fisher-Price Snuga Swing CPSC Recall

- URL: https://www.cpsc.gov/Recalls/2025/Fisher-Price-Recalls-More-than-2-Million-Snuga-Infant-Swings-Due-to-Suffocation-Hazard-After-5-Deaths-Reported
- Observed recall date: October 10, 2024.
- Observed product scope: all Fisher-Price Snuga Swings listed by CPSC.
- Demo interpretation: official recall context for swing use and sleep-use warnings.
- Plugin action: separate awake-time product use, sleep-use risk, model identification, and remedy.

### CPSC Infant Sleep Products FAQ

- URL: https://www.cpsc.gov/FAQ/Infant-Sleep-Products
- Observed scope: regulation context for products marketed or intended as sleeping accommodation for infants up to 5 months old.
- Demo interpretation: classify sleep product claims and marketing language before comparing alternatives.
- Plugin action: do not treat a swing, rocker, monitor, carrier, or seating product as a safe sleep substitute.

### AAP Safe Sleep

- URL: https://www.aap.org/en/patient-care/safe-sleep/
- Observed page date: Last Updated 07/07/2025.
- Demo interpretation: parent-care context for back sleeping, own sleep space, firm flat mattress, fitted sheet, and removal of soft items.
- Plugin action: convert into parent action checks and escalation wording, not diagnosis.

### CDC Safe Sleep

- URL: https://www.cdc.gov/sudden-infant-death/sleep-safely/
- Observed page date: September 17, 2024.
- Demo interpretation: U.S. public-health support for AAP safe sleep recommendations.
- Plugin action: use as plain-language parent education context and cite uncertainty if the user's product or jurisdiction differs.

## Korean Demo Asset Linkage

This log supports:

- `docs/KOREAN_MAS_ROUNDS.md`
- `examples/korean-demo-prompt.md`
- `examples/korean-plugin-run-output.md`
- `mockups/korean-parent-risk-radar.html`

The plugin must still say:

- The output is decision support, not medical advice.
- YouTube input is unverified media input until corroborated.
- Official recall and manufacturer pages should be re-checked for a real product decision.
- No affiliate links or purchase recommendations are provided.
