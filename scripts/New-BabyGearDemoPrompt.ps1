[CmdletBinding()]
param(
    [string] $OutputPath = '.\examples\korean-demo-prompt.md'
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$repoRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..'))

function Test-PathInsideRoot {
    param(
        [Parameter(Mandatory)][string] $FullPath,
        [Parameter(Mandatory)][string] $RootPath
    )

    $rootWithSeparator = $RootPath.TrimEnd([System.IO.Path]::DirectorySeparatorChar, [System.IO.Path]::AltDirectorySeparatorChar) + [System.IO.Path]::DirectorySeparatorChar
    return $FullPath.Equals($RootPath, [System.StringComparison]::OrdinalIgnoreCase) -or
        $FullPath.StartsWith($rootWithSeparator, [System.StringComparison]::OrdinalIgnoreCase)
}

function Resolve-RepoOutputPath {
    param([Parameter(Mandatory)][string] $Path)

    if ([System.IO.Path]::IsPathRooted($Path)) {
        $fullPath = [System.IO.Path]::GetFullPath($Path)
    }
    else {
        $fullPath = [System.IO.Path]::GetFullPath((Join-Path (Get-Location) $Path))
    }

    if (-not (Test-PathInsideRoot -FullPath $fullPath -RootPath $repoRoot)) {
        throw "OutputPath must stay inside repository root: $Path"
    }

    return $fullPath
}

$outputFullPath = Resolve-RepoOutputPath -Path $OutputPath
$outputParent = Split-Path -Parent $outputFullPath
New-Item -ItemType Directory -Force -Path $outputParent | Out-Null

$prompt = @'
# BabyGear Risk Radar Korean Demo Prompt Packet

Use the `babygear-risk-radar` Codex plugin.

아래 영유아 제품 이슈 묶음을 한글로 분석해 주세요. 목표는 특정 제품을 안전/위험하다고 단정하는 것이 아니라, 부모가 확인해야 할 근거, 불확실성, 대안 비교 기준, 공식 확인 경로를 MECE하게 정리하는 것입니다.

## 입력 케이스

### Case 1 - Philips Avent 쪽쪽이 BPA 논란

- 맥락: 부모가 브랜드 신뢰와 BPA-free claim을 보고 구매했지만, 이후 일부 공갈젖꼭지 BPA 검출 보도를 접한 상황.
- 공개 소스 성격: 기사/소비자단체 실험 보도와 제조사 반박이 충돌하는 public-source case note.
- 제조사 확인 경로: https://www.usa.philips.com/c-f/XC000022169/i-ve-read-news-about-pacifiers-and-bpa-how-do-you-validate-philips-avent-pacifiers-are-bpa-free
- 분석 요구: reported finding, manufacturer response, regulator/standard context, parent action을 분리.

### Case 2 - Philips Avent 관련 YouTube 제보 입력

- 입력 URL: https://www.youtube.com/watch?v=EJKZ8XXYku0
- 처리 규칙: transcript를 크롤링하거나 사실로 인용하지 말고, unverified media input으로만 취급.
- 분석 요구: 영상 주장 확인 전까지 citation gap으로 표시하고, 공식 문서/제조사/규제기관 확인 질문으로 전환.

### Case 3 - Philips Avent monitor replacement context

- 맥락: Philips Avent 디지털 비디오 베이비모니터 replacement/recall-style official support page가 있는 경우.
- 공식 확인 경로: https://www.usa.philips.com/c-w/support-home/recall/avent-digital-video-baby-monitors.html
- 분석 요구: 화학물질 논란과 전기/제품 교체 이슈를 섞지 말고 별도 hazard class로 분리.

### Case 4 - Fisher-Price CPSC recall context

- 맥락: Fisher-Price 관련 infant sleep/swing 제품은 CPSC official recall context를 우선 확인해야 하는 제품군.
- 공식 확인 경로:
  - https://www.cpsc.gov/Recalls/2023/Fisher-Price-Reannounces-Recall-of-4-7-Million-Rock-n-Play-Sleepers-At-Least-Eight-Deaths-Occurred-After-Recall
  - https://www.cpsc.gov/Recalls/2025/Fisher-Price-Recalls-More-than-2-Million-Snuga-Infant-Swings-Due-to-Suffocation-Hazard-After-5-Deaths-Reported
- 분석 요구: recall 여부, 제품 모델 식별, 사용 중단/공식 조치 확인, 소아청소년과 상담 필요성을 부모 행동 카드로 정리.

## 출력 요구

공식 출처 우선순위:

- CPSC recall pages and CPSC Infant Sleep Products guidance.
- AAP Safe Sleep and CDC Safe Sleep guidance for infant sleep or soothing product use.
- Philips official support pages for manufacturer statements and replacement context.
- Journalism, consumer tests, YouTube, and parent anecdotes only as lower-tier signals unless primary evidence is supplied.

MAS 운영 규칙:

- 홀수 라운드는 Visionary 관점으로 부모 결정 흐름과 실행 가능성을 개선하세요.
- 짝수 라운드는 Critical 관점으로 과장, 근거 공백, 브랜드 신뢰 편향, 의학/법적 경계 위반을 비판하세요.
- `docs/KOREAN_MAS_ROUNDS.md`의 구조를 따르세요.

1. Product and usage context.
2. Parent concern summary.
3. MECE evidence map.
4. Authority source ladder.
5. Evidence tier table.
6. Safety and regulatory risk matrix.
7. Brand-claim skepticism review.
8. Alternative product criteria.
9. Decision options: continue using, pause and replace, seek official confirmation, consult pediatrician/regulator.
10. MAS debate with odd/even rounds:
    - Round 1 Visionary.
    - Round 2 Critical.
    - Round 3 Visionary.
    - Round 4 Critical.
11. MAS-QA checklist.
12. Final parent action card.
13. Uncertainty and citation gaps.

## 안전 경계

- 의학적 조언이 아닙니다.
- 특정 브랜드나 제품을 안전하다고 또는 위험하다고 단정하지 마세요.
- YouTube 입력은 검증 전 주장으로 취급하세요.
- 최신 recall이나 규제 상태는 공식 CPSC, 제조사, 소아청소년과 의사 또는 규제기관 확인이 필요하다고 명시하세요.
- 제휴 링크, 구매 유도, 실시간 크롤링, 외부 API 호출 없이 작성하세요.
'@

$prompt | Set-Content -LiteralPath $outputFullPath -Encoding UTF8
$item = Get-Item -LiteralPath $outputFullPath

[PSCustomObject]@{
    Status = 'PASS'
    OutputPath = $outputFullPath
    Bytes = $item.Length
    CaseCount = 4
    Language = 'ko'
    ExternalApiRequired = $false
}
