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
| 예시 출력 | `examples/sample-output.md` |
| 공식 소스 맵 | `docs/AUTHORITY_SOURCE_MAP.md` |
| MAS 라운드 | `docs/MAS_ROUNDS.md` |
| 한글 mock page | `mockups/korean-parent-risk-radar.html` |
| 재사용 템플릿 | `templates/` |

## 검증 명령

PowerShell 7에서 repository root 기준으로 실행합니다.

```powershell
pwsh -NoProfile -File .\scripts\validate-plugin.ps1
pwsh -NoProfile -File .\scripts\Test-ContentSafety.ps1
pwsh -NoProfile -File .\scripts\Show-SubmissionSummary.ps1
```

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

## 알려진 한계

- 실시간 recall, regulator, manufacturer 조회를 자동으로 수행하지 않습니다.
- YouTube, 의료 웹사이트, 쇼핑몰, 뉴스 사이트를 크롤링하지 않습니다.
- 제휴 추천이나 구매 유도 문구를 제공하지 않습니다.
- 특정 제품을 안전하다고 또는 위험하다고 단정하지 않습니다.
- 최신 근거는 사용자가 제공하거나 Codex 세션에서 공식 출처로 확인해야 합니다.

## 안전 고지

이 플러그인은 의학적 조언이 아니라 의사결정 보조 워크플로우입니다. 증상, 긴급 우려, 제품 파손, recall, 신생아/영아의 개별 위험이 있으면 소아청소년과 의사, 임상의, 제조사, 규제기관 또는 공식 recall 채널에 확인해야 합니다.
