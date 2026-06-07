# Korean MAS Rounds

## 목적

이 문서는 BabyGear Risk Radar Codex plugin을 한글로 사용할 때 MAS 토론을 일관되게 실행하기 위한 기준입니다. 목표는 부모가 불안을 줄이고 다음 확인 행동을 정하도록 돕는 것이며, 특정 제품을 의학적으로 안전하다고 또는 위험하다고 단정하지 않습니다.

## 공식 출처 우선순위

2026-06-07 세션에서 확인한 공식 출처를 다음 순서로 우선합니다.

| 우선순위 | 출처 | 적용 범위 | 사용 규칙 |
| --- | --- | --- | --- |
| 1 | CPSC recall pages | Fisher-Price Rock 'n Play, Snuga Swing 같은 공식 recall 맥락 | 모델명, 날짜 코드, remedy, 사용 중단 안내를 먼저 확인합니다. |
| 2 | CPSC Infant Sleep Products guidance | 영아 수면 제품, 스윙, 락커, 경사진 표면 | sleep use와 awake soothing use를 분리합니다. |
| 3 | AAP Safe Sleep | 신생아/영아 수면 환경과 보호자 설명 | 등을 대고 재우기, 단단하고 평평한 수면 표면, 부드러운 침구 제거 같은 부모 행동 기준으로 씁니다. |
| 4 | CDC Safe Sleep | 부모용 공중보건 설명 | AAP 권고를 부모가 실행할 수 있는 언어로 보강합니다. |
| 5 | Philips official support pages | Philips Avent BPA FAQ, monitor replacement | 제조사 주장, 시험 반박, 제품 교체 정보를 primary brand statement로 분리합니다. |
| 6 | 기사, 소비자단체, 영상, SNS | Philips Avent BPA 보도, 사용자가 준 YouTube case-2 | 공식 확인 전에는 signal 또는 unverified media input으로만 둡니다. |

Reference links:

- https://www.usa.philips.com/c-f/XC000022169/i-ve-read-news-about-pacifiers-and-bpa-how-do-you-validate-philips-avent-pacifiers-are-bpa-free
- https://www.usa.philips.com/c-w/support-home/recall/avent-digital-video-baby-monitors.html
- https://www.cpsc.gov/Recalls/2023/Fisher-Price-Reannounces-Recall-of-4-7-Million-Rock-n-Play-Sleepers-At-Least-Eight-Deaths-Occurred-After-Recall
- https://www.cpsc.gov/Recalls/2025/Fisher-Price-Recalls-More-than-2-Million-Snuga-Infant-Swings-Due-to-Suffocation-Hazard-After-5-Deaths-Reported
- https://www.cpsc.gov/FAQ/Infant-Sleep-Products
- https://www.aap.org/en/patient-care/safe-sleep/
- https://www.cdc.gov/sudden-infant-death/sleep-safely/

## MAS 라운드 규칙

홀수 라운드는 CEO/visionary 관점입니다. 부모가 바로 실행할 수 있는 구조, 제품군별 구분, 신뢰 회복 방향, 심사자가 이해할 제출 가치를 제시합니다.

짝수 라운드는 critical/debate 관점입니다. 과장, 출처 누락, 법적/의학적 경계, YouTube 또는 기사 입력의 검증 공백, 브랜드 신뢰 편향을 공격적으로 점검합니다.

| Round | 관점 | 핵심 질문 | 출력 |
| --- | --- | --- | --- |
| Round 1 - Visionary | Parent Reality Lens + CEO view | 부모가 오늘 어떤 결정을 내려야 하는가? | 제품군, 사용 맥락, 즉시 확인 행동을 정리합니다. |
| Round 2 - Critical | Evidence QA Lead | 근거 없이 단정한 문장이 있는가? | unsupported claim, citation gap, source tier mismatch를 표시합니다. |
| Round 3 - Visionary | Clinician Communicator Lens | 복잡한 근거를 부모가 실행 가능한 말로 바꿀 수 있는가? | Do now, check next, escalate if 구조로 변환합니다. |
| Round 4 - Critical | Brand Claim Skeptic | BPA-free, trusted brand, safe sleep 같은 문구가 검증됐는가? | claim, needed proof, unresolved uncertainty를 분리합니다. |
| Round 5 - Visionary | Product Safety Investigator | 대체재 탐색 기준을 공정하게 만들 수 있는가? | affiliate 없는 비교 기준과 공식 확인 경로를 제시합니다. |
| Round 6 - Critical | Pediatric Safety Lens | 부모 행동 카드가 의학적 조언처럼 보이지 않는가? | pediatrician/regulator escalation boundary를 강화합니다. |

## Case별 적용

### Case 1 - Philips Avent 쪽쪽이 BPA 논란

- 제조사 FAQ는 primary brand statement입니다.
- 기사나 소비자단체 보도는 independent/public signal입니다.
- plugin은 두 주장을 결론으로 합치지 말고, test method, sample lot, jurisdiction, date, independent replication 필요성을 citation gap으로 둡니다.

### Case 2 - Philips Avent 관련 YouTube 입력

- `https://www.youtube.com/watch?v=EJKZ8XXYku0`는 transcript를 크롤링하지 않습니다.
- 영상 주장은 unverified media input으로 표시합니다.
- 부모 행동은 영상 요약 요구가 아니라 공식 문서, 제조사, recall portal, 소아청소년과 상담 질문으로 바꿉니다.

### Case 3 - Philips Avent monitor replacement

- monitor replacement는 전기, 배터리, 화면, 교체 프로그램 같은 제품 지원 이슈로 분리합니다.
- BPA나 쪽쪽이 물성 논란과 섞지 않습니다.
- 사용 중 제품 이상이 있으면 제조사 공식 지원 페이지와 모델/시리얼 확인을 우선합니다.

### Case 4 - Fisher-Price CPSC recall context

- CPSC recall page가 있으면 최상위 근거입니다.
- Rock 'n Play, Snuga Swing 같은 제품명은 public-source case note로만 사용합니다.
- 부모 행동 카드는 모델 식별, 사용 중단 여부 확인, 공식 remedy 확인, 수면 환경 점검, 임상의 상담 필요성으로 제한합니다.

## 금지 문장

- `이 제품은 안전합니다.`
- `이 제품은 위험합니다.`
- `의사가 모두 이렇게 말합니다.`
- `이 대체 제품을 사세요.`
- `YouTube에서 봤으니 사실입니다.`

## 권장 문장

- `공식 recall 여부는 CPSC 또는 제조사 페이지에서 모델명과 날짜 코드를 확인해야 합니다.`
- `제조사는 이렇게 설명하지만, 독립 검증과 sample 조건은 별도 확인이 필요합니다.`
- `영상 입력은 아직 검증된 근거가 아니므로 citation gap으로 둡니다.`
- `수면 관련 제품은 AAP/CDC safe sleep guidance와 CPSC 제품 기준을 분리해서 보겠습니다.`
