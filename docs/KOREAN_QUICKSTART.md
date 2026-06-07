# BabyGear Risk Radar 한국어 퀵스타트

## 프로젝트 요약

BabyGear Risk Radar는 Codex CLI용 플러그인 패키지입니다. 영유아 제품 안전성 논란을 앱이나 크롤러로 처리하지 않고, Codex가 MECE 근거 구조, 공식 소스 우선순위, 안전 리스크, 대안 기준, MAS-QA, 부모 행동 카드로 정리하도록 돕습니다.

## 제출 URL

```text
https://github.com/procloudkim/2026-06-07-harness-baby
```

선호 저장소 이름은 `babygear-risk-radar-codex-plugin`이었지만, 이 PC에는 GitHub CLI(`gh`)가 없어 새 저장소 자동 생성이 불가능했습니다. 따라서 사용자가 제공한 public origin으로 push했습니다.

## 핵심 파일

| 목적 | 경로 |
| --- | --- |
| 플러그인 manifest | `.codex-plugin/plugin.json` |
| Codex skill | `skills/babygear-risk-radar/SKILL.md` |
| 로컬 marketplace | `.agents/plugins/marketplace.json` |
| 데모 스크린샷 | `assets/demo-screenshot.svg` |
| 예시 입력 | `examples/avent-pacifier-risk-brief.md` |
| 한글 demo prompt packet | `examples/korean-demo-prompt.md` |
| 한글 plugin 사용 예시 출력 | `examples/korean-plugin-run-output.md` |
| 예시 출력 | `examples/sample-output.md` |
| 공식 소스 맵 | `docs/AUTHORITY_SOURCE_MAP.md` |
| MAS 라운드 | `docs/MAS_ROUNDS.md` |
| 한글 MAS 라운드/공식 출처 가드레일 | `docs/KOREAN_MAS_ROUNDS.md` |
| 공식 출처 freshness log | `docs/SOURCE_FRESHNESS_LOG.md` |
| 한글 mock page | `mockups/korean-parent-risk-radar.html` |
| 재사용 템플릿 | `templates/` |

## 검증 명령

PowerShell 7에서 repository root 기준으로 실행합니다.

```powershell
pwsh -NoProfile -File .\scripts\validate-plugin.ps1
pwsh -NoProfile -File .\scripts\Test-ContentSafety.ps1
pwsh -NoProfile -File .\scripts\Show-SubmissionSummary.ps1
pwsh -NoProfile -File .\scripts\New-BabyGearDemoPrompt.ps1
```

`Show-SubmissionSummary.ps1` 출력에는 `KoreanMockPage`, `KoreanPluginOutput`, `KoreanPromptPacket`, `PromptGeneratorCommand` 경로가 포함됩니다.

기대 상태:

```text
Status: PASS
PluginName: babygear-risk-radar
MarketplacePath: ./
Screenshot: ./assets/demo-screenshot.svg
```

## 설치/사용 방향

Codex가 repo marketplace를 지원하는 환경에서는 `.agents/plugins/marketplace.json`의 local plugin entry를 사용합니다.

예시 프롬프트:

```text
Use BabyGear Risk Radar to evaluate this pacifier safety concern.
Create a MECE evidence map, authority source ladder, risk matrix, alternatives, MAS debate, MAS-QA checklist, and final parent action card.
```

## 데모 스크린샷

```text
assets/demo-screenshot.svg
```

README에서도 같은 이미지를 참조합니다.

## 한글 Mock Page

```text
mockups/korean-parent-risk-radar.html
```

이 mock page는 BabyGear Risk Radar skill 흐름을 실제로 적용한 정적 한글 페이지입니다. Philips Avent BPA 논란, 사용자 제공 YouTube case-2, Philips Avent monitor replacement 맥락, Fisher-Price CPSC recall 맥락을 MECE evidence map, risk matrix, MAS round, parent action card로 정리합니다.

같은 케이스 묶음의 텍스트형 plugin-run 예시는 아래 파일입니다.

```text
examples/korean-plugin-run-output.md
```

## 한글 Prompt Packet

```text
examples/korean-demo-prompt.md
```

이 파일은 `scripts\New-BabyGearDemoPrompt.ps1`로 재생성할 수 있습니다. Codex CLI에서 BabyGear Risk Radar plugin을 실제로 사용할 때 그대로 입력할 한글 prompt packet입니다.

## 한글 MAS 라운드

```text
docs/KOREAN_MAS_ROUNDS.md
```

한글 출력에서는 홀수 라운드를 Visionary 관점, 짝수 라운드를 Critical 관점으로 둡니다. Philips Avent BPA 논란, 사용자 제공 YouTube case-2, Philips Avent monitor replacement, Fisher-Price CPSC recall context는 각각 별도 hazard class로 분리하고, CPSC, AAP Safe Sleep, CDC Safe Sleep, Philips official support page 같은 공식 출처를 먼저 확인하는 구조를 사용합니다.

## 공식 출처 Freshness Log

```text
docs/SOURCE_FRESHNESS_LOG.md
```

이 문서는 2026-06-07 KST 현재 세션에서 확인한 Philips official support pages, CPSC recall/infant sleep product pages, AAP Safe Sleep, CDC Safe Sleep 출처와 적용 경계를 기록합니다. 실제 부모 의사결정에서는 같은 공식 출처를 다시 확인해야 합니다.

## 알려진 한계

- 실시간 recall, regulator, manufacturer 조회를 자동으로 수행하지 않습니다.
- YouTube, 의료 웹사이트, 쇼핑몰, 뉴스 사이트를 크롤링하지 않습니다.
- 제휴 추천이나 구매 유도 문구를 제공하지 않습니다.
- 특정 제품을 안전하다고 또는 위험하다고 단정하지 않습니다.
- 최신 근거는 사용자가 제공하거나 Codex 세션에서 공식 출처로 확인해야 합니다.

## 안전 고지

이 플러그인은 의학적 조언이 아니라 의사결정 보조 워크플로우입니다. 증상, 긴급 우려, 제품 파손, recall, 신생아/영아의 개별 위험이 있으면 소아청소년과 의사, 임상의, 제조사, 규제기관 또는 공식 recall 채널에 확인해야 합니다.
