# Authority Source Map

This file records the official-source hierarchy used by the BabyGear Risk Radar skill. It is a static source map for the plugin package, not a live recall lookup.

## Source Priority

| Tier | Source Type | Use In The Plugin | Example Sources |
| --- | --- | --- | --- |
| 1 | U.S. product-safety regulator or legal requirement | Physical hazard, recall, certification, tracking label, and reporting checks. | CPSC pacifier guidance, eCFR 16 CFR Part 1511, CPSC recalls, SaferProducts.gov. |
| 2 | Pediatric or clinician society guidance | Parent-facing use context, safe-use cautions, and clinician escalation boundaries. | American Academy of Pediatrics / HealthyChildren pacifier safety. |
| 3 | U.S. food-contact or environmental health agency | BPA and chemical-exposure context, separated from pacifier-specific proof. | FDA BPA food-contact page, NIEHS BPA page. |
| 4 | Manufacturer primary material | Brand claims, certificates, batch explanations, product support statements. | Manufacturer FAQ, test response, batch-specific documentation. |
| 5 | Independent consumer test or lab report | Signal for further investigation, only as strong as methods and batch traceability. | dTest-style consumer testing, if the primary report is available. |
| 6 | Journalism, retail, forum, influencer, anecdote | Context and parent concern intake; never enough alone for a safety conclusion. | News articles and parent observations. |

## Official Sources Checked In This Session

| Source | URL | How BabyGear Risk Radar Should Use It |
| --- | --- | --- |
| CPSC pacifier business guidance | https://www.cpsc.gov/Business--Manufacturing/Business-Education/Business-Guidance/Pacifiers | Treat as high-priority U.S. regulator context for pacifier physical safety, certification, strings/cords/attachments, lead/phthalate/nitrosamine/heavy-element requirements, and tracking labels. |
| eCFR 16 CFR Part 1511 | https://www.ecfr.gov/current/title-16/chapter-II/subchapter-C/part-1511 | Treat as the current online CFR text for pacifier guard/shield, structural integrity, attachment, and labeling requirements. |
| CPSC recalls | https://www.cpsc.gov/Recalls | Use as an official U.S. recall and product-safety warning check when a product name, model, or batch is known. |
| SaferProducts.gov | https://www.saferproducts.gov/ | Use as a public CPSC incident-report search/reporting channel, with caution that public reports may need verification. |
| AAP / HealthyChildren pacifier safety | https://www.healthychildren.org/English/safety-prevention/at-home/Pages/Pacifier-safety.aspx?form=HealthyChildren | Use for parent-facing pacifier safety cautions: one-piece construction, shield size/ventilation, no tying to crib/neck/hand, inspection for deterioration, and pediatrician escalation. |
| FDA BPA food-contact application page | https://www.fda.gov/newsevents/publichealthfocus/ucm064437.htm | Use for U.S. FDA BPA context in food-contact materials; do not treat it as direct proof that a pacifier is safe or unsafe. |
| NIEHS BPA page | https://www.niehs.nih.gov/health/topics/agents/sya-bpa | Use for environmental-health context: exposure routes, why parents may be concerned, and uncertainty around infant/child vulnerability. |

## Decision Rules

- If an official recall applies to the exact product/model/batch, surface it before brand claims or news coverage.
- If a manufacturer disputes an independent test, show both claims in separate evidence rows and ask what source would resolve the conflict.
- If a chemical concern is not product-specific, label it as context, not proof.
- If a parent asks for medical interpretation, route to pediatrician/clinician escalation instead of diagnosing.
- If a source is public reporting rather than primary evidence, mark it as a signal to investigate, not a verdict.
- If a product has an attachment, cord, chain, clip, lovey, or toy element, separate pacifier rules from accessory or toy requirements.

## Non-Claims

BabyGear Risk Radar must not claim that Philips, Avent, or any other real product is dangerous or safe without current authoritative product-specific evidence. The plugin supports structured reasoning under uncertainty.
