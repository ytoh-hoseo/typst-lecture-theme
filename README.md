# 강의 테마 사용법

`lecture-theme.typ`는 Metropolyst 0.1.0을 사용하는 공통 테마입니다.
강의 파일에서 가져와 사용하고, 강의별 정보와 본문은 강의 파일에 둡니다.

이 테마를 Typst 로컬 패키지(`@local/lecture-theme:0.1.0`)로 등록하면
강의 파일 위치와 상관없이 아래처럼 바로 import할 수 있습니다.
설치 방법은 이 문서 끝의 [로컬 패키지 설치](#로컬-패키지-설치)를 참고하세요.
노트 작성 중에는 [강의 노트 helper 참고표](#강의-노트-helper-참고표)에서 용도와 예제를 찾을 수 있습니다.

## 공통 helper

`common.typ`에는 슬라이드와 노트에서 함께 쓰는 함수만 정의합니다.
두 템플릿이 이 함수들을 가져와 공개하므로 기존 import 방식은 그대로 사용할 수 있습니다.

| 함수 | 용도 |
| --- | --- |
| `bvec`, `bmat` | 벡터·행렬 기호를 정립 볼드로 표시 |
| `boxed` | 기본 테두리 `0.8pt`, 안쪽 여백 `6pt`인 박스 |
| `hcenter`, `hleft`, `hright` | 콘텐츠를 가운데·왼쪽·오른쪽으로 정렬 |

```typst
// 템플릿 없이 공통 helper만 가져오는 경우
#import "lecture-theme/common.typ": boxed, bvec, bmat, hcenter
#hcenter[#boxed[$bvec(v) = bmat(A) bvec(x)$]]
```

슬라이드에서는 `lecture-theme.typ`, 노트에서는 `lecture-note.typ`에서 같은 이름으로 가져올 수 있습니다.
로컬 패키지에서는 최상위와 `notes` 모듈 양쪽에서 제공됩니다.
공통 helper는 외부 패키지나 템플릿 설정에 의존하지 않습니다.

`medskip`·`bigskip`은 각 템플릿에 유지합니다. 슬라이드는 `.6em`·`1.2em`과
`spacing-defaults`를 사용하고, 노트는 `8pt`·`16pt`와 문서별 `note-style` 설정을 사용하기 때문입니다.
강조 패널·색상·글꼴·도식·사이드바 설정도 각 템플릿의 스타일에 맞춰 별도로 유지합니다.

## 슬라이드에서 사용하기

```typst
#import "@preview/metropolyst:0.1.0": *
#import "@local/lecture-theme:0.1.0": *

#show: lecture-theme.with(
  title: [게임 수학],
  subtitle: [벡터],
  author: [오영택],
  institution: [호서대학교 게임소프트웨어학과],
  font: ("Pretendard", "Noto Sans CJK KR"),
  code-font: "D2Coding",
  footnote-font: "KoPubWorldBatang",
  body-size: 22pt,
  footnote-size: 12pt,
)

#title-slide()
== 첫 슬라이드
내용
```

## 강의 노트에서 사용하기

하나의 패키지 안에 슬라이드 테마와 노트 템플릿을 함께 제공합니다.
`typst.toml`의 진입점은 `lib.typ`이며, 슬라이드 함수들은 직접 공개하고
노트 함수들은 `notes` 모듈로 묶어 공개합니다.

노트 문서에서는 다음 두 줄로 노트 함수들을 가져옵니다.
이후에는 `notes.` 접두어 없이 `lecture-note`, `medskip`, `sidenote` 등을 사용할 수 있습니다.

```typst
#import "@local/lecture-theme:0.1.0": notes
#import notes: *

#show: lecture-note.with(
  title: [수학 노트],
  subtitle: [갈릴레이의 바퀴에서 칸토어의 무한까지],
  author: [오영택],
  date: datetime.today(),
  body-font: "KoPubWorldBatang",
)

= 무한에 관한 질문

본문 내용

#medskip()
#sidenote[참고][본문 옆에 표시할 설명]
```

절 제목 번호는 `lecture-note.with(numbering-depth: 2)`처럼 지정합니다.
기본값 `0`은 모든 단계의 번호를 숨기고, `1`은 `=`만, `2`는 `==`까지,
`4`는 `====`까지 번호를 표시합니다. 기본 번호 형식은 `1`, `1.1`, `1.1.1`이며,
`numbering-depth`에는 0 이상의 정수를 지정합니다.

`numbering-by-level`에는 1단계부터 순서대로 번호 형식을 지정합니다.
기본값은 빈 배열 `()`이며, 생략한 단계나 `auto`인 단계는 `"1.1"` 형식을 사용합니다.

```typst
#show: lecture-note.with(
  numbering-depth: 3,
  numbering-by-level: ("제1절", "1.1"),
)
```

위 설정은 `제1절`, `1.1`, `1.1.1`로 표시됩니다.
1단계만 지정하려면 `("제1절",)`처럼 쉼표를 붙이고,
2단계만 바꾸려면 `(auto, "1.1)")`처럼 지정하세요.
번호 형식은 Typst의 numbering 패턴 또는 함수를 받으며, 함수에는 상위 단계부터의 번호가 전달됩니다.
`numbering-depth`를 넘는 단계에는 번호를 표시하지 않습니다.
개별 제목의 `#heading(level: 1, numbering: "제1절")[제목]` 설정도 그대로 사용할 수 있습니다.

`toc`를 가져오면 `#toc()`로 목차를 삽입할 수 있습니다.
제목은 기본적으로 "목차"이며, 모든 단계의 제목과 페이지 번호, 이동 링크를 표시합니다.
본문에 설정한 단계별 번호 형식도 그대로 반영합니다.

```typst
#import "lecture-theme/lecture-note.typ": lecture-note, toc
// 패키지를 사용할 때는 #import notes: toc
#toc()
// #toc(depth: 2)              // 2단계까지만 표시
// #toc(indent: 1em)           // 단계마다 1em 들여쓰기 (기본값: auto)
// #toc(indent: 0pt)           // 들여쓰기 없음
// #toc(title: [차례])         // 목차 제목 변경
// #toc(title: none)           // 목차 제목 숨김
```

`outlined: false`인 제목은 목차에서 제외되며, 목차 제목 자체는 번호나 목차 항목에 포함되지 않습니다.

간단한 테두리 박스는 `boxed`를 가져와 사용합니다. 기본 테두리는 `0.8pt`, 안쪽 여백은 `6pt`입니다.

```typst
#import "lecture-theme/lecture-note.typ": boxed
#boxed[강조할 문장]
#boxed(stroke: 1pt, inset: (x: 8pt, y: 4pt))[여백과 테두리 변경]
```

슬라이드와 노트에는 `medskip`, `bigskip`처럼 같은 이름의 보조 함수가 있습니다.
노트 문서에서는 패키지 전체를 `*`로 가져오는 대신 위와 같이 `notes`만 선택하세요.
노트의 보조 함수가 필요 없다면 템플릿만 직접 가져와도 됩니다.

```typst
#import "@local/lecture-theme:0.1.0": lecture-note
```

`author`와 `date`는 푸터의 왼쪽과 오른쪽에 표시되며, 그 사이에 페이지 번호가 들어갑니다.
둘 다 생략하면 페이지 번호만 기존처럼 오른쪽에 표시됩니다.
`date`는 문자열·콘텐츠 또는 `datetime`을 받으며, `datetime`은 `YYYY-MM-DD`로 표시합니다.
사이드노트 없이 본문을 전체 너비로 쓰려면 `lecture-note.with`에
`sidebar-width: 0mm, sidebar-gap: 0mm`를 지정하세요.

## 강의 노트 helper 참고표

이 절은 `lecture-note.typ`의 함수 설명입니다. 아래의 슬라이드 컴포넌트와는 별개입니다.
강의 문서에서 필요한 이름을 가져오고 `lecture-note`를 적용한 뒤 사용하세요.
다음 상대 경로 예시는 강의 문서 옆에 `lecture-theme` 폴더가 있는 구성을 기준으로 합니다.

```typst
#import "lecture-theme/lecture-note.typ": lecture-note, boxed, toc, callout, sidenote
#show: lecture-note.with(title: [강의 노트])
```

로컬 패키지를 사용할 때는 `#import "@local/lecture-theme:0.1.0": notes` 다음에
`#import notes: *`로 노트 함수를 모두 가져올 수 있습니다.

| 함수 | 용도 | 기본값 / 주요 옵션 |
| --- | --- | --- |
| `boxed` | 짧은 문장·수식의 테두리 | `stroke: 0.8pt`, `inset: 6pt`; `box` 옵션 사용 가능 |
| `bvec`, `bmat` | 벡터·행렬 기호를 정립 볼드로 표시 | 수식 안에서 `bvec(v)`, `bmat(A)` |
| `hcenter`, `hleft`, `hright` | 수평 정렬 | `#hcenter[내용]`처럼 본문 전달 |
| `toc` | 목차 | `title: [목차]`, `depth: none`, `indent: auto` |
| `medskip`, `bigskip` | 세로 여백 | 각각 `8pt`, `16pt`; 인자 없음 |
| `callout` | 제목 띠가 있는 강조 박스 | 제목·본문 필수, `caution: false` |
| `sidenote` | 오른쪽 여백에 보충 설명 | 제목·본문 필수, `kind: "info"` |
| `full-width` | 본문과 사이드바를 합친 너비 사용 | 본문 필수 |
| `note-diagram` | 공통 스타일의 Fletcher 도식 | Fletcher의 노드·연결선·배치 옵션 전달 |
| `uml-diagram` | UML 클래스 도식 | raw 콘텐츠 필수, `width: auto` → 기본 `145mm` |
| `code-panel` | 출처·줄 번호가 있는 C++ 코드 | 제목·파일 경로 필수, 같은 이름의 JSON 필요 |
| `command-panel` | 각 줄에 `$`가 붙는 명령 패널 | 제목·본문 필수 |

### 테두리와 목차: boxed, toc

```typst
#boxed[강조할 문장]
#align(center)[#boxed[$a^2 + b^2 = c^2$]]
#boxed(stroke: 1pt, inset: (x: 8pt, y: 4pt))[옵션 변경]

#toc()
#toc(depth: 2, indent: 1em, title: [차례])
#toc(title: none, indent: 0pt)
```

`boxed`는 내용 크기의 박스이며 가운데 정렬은 바깥의 `align(center)`로 지정합니다.
`toc`의 `depth: none`은 모든 단계, `title: none`은 목차 제목 숨김입니다.
`indent`에 길이를 주면 단계마다 해당 크기만큼 들여씁니다.

### 벡터와 행렬 기호: bvec, bmat

```typst
#import "lecture-theme/lecture-note.typ": bvec, bmat

$bvec(v) = bmat(A) bvec(x)$
$bvec(v) = vec(1, 2, 3)$
$bmat(A) = mat(1, 0; 0, 1)$
```

두 함수는 기호를 기울이지 않은 굵은 글자(정립 볼드)로 표시하며, 슬라이드와 노트에서 동일하게 사용할 수 있습니다.
`bvec`는 벡터 기호, `bmat`는 행렬 기호를 나타내는 이름이며 내부 서식은 같습니다.
성분을 나열하는 열벡터나 행렬 자체는 Typst의 `vec`, `mat`으로 작성합니다.
로컬 패키지의 노트 모듈에서는 `#import notes: bvec, bmat`으로 가져올 수 있습니다.

### 세로 여백: medskip, bigskip

```typst
앞의 설명

#medskip()

다음 설명

#bigskip()

새로운 내용 묶음
```

간격은 `lecture-note.with(medskip-size: 10pt, bigskip-size: 20pt)`로 변경합니다.
이 함수는 추가 여백을 넣는 용도이며 본문 문단 간격은 `paragraph-spacing`으로 조절합니다.

### 강조 박스와 사이드노트: callout, sidenote

```typst
#callout[핵심 개념][벡터는 크기와 방향을 가진다.]
#callout(caution: true)[주의][영벡터는 정규화할 수 없다.]

#sidenote[참고][추가 설명]
#sidenote(kind: "note")[보충][관련 개념]
#sidenote(kind: "caution")[주의][계산 시 주의할 점]
#sidenote(kind: "example")[예제][$1 + 1 = 2$]
```

`callout`은 본문 너비의 강조 박스이고, `caution: true`이면 주황색 계열로 표시합니다.
`sidenote`는 호출 위치에 맞춰 오른쪽 사이드바에 배치합니다.
`kind`는 `"info"`(기본), `"note"`, `"caution"`, `"example"` 중 하나입니다.
사이드노트를 사용하려면 `sidebar-width`에 공간을 확보하세요(기본 `40mm`).

### 넓은 콘텐츠: full-width

```typst
#full-width[
  #block(width: 100%, fill: luma(245), inset: 8pt)[넓은 설명 영역]
]
```

본문과 사이드바를 합친 `content-width`만큼 공간을 사용합니다.
같은 높이의 사이드노트와는 공간이 겹칠 수 있으므로 배치에 유의하세요.

### 도식: note-diagram, uml-diagram

```typst
#import "@preview/fletcher:0.5.8": node, edge
#note-diagram(
  node((0, 0), [입력]),
  node((1, 0), [출력]),
  edge((0, 0), (1, 0), "->"),
)
```

`note-diagram`은 공통 글꼴·색상을 적용하고 인자를 Fletcher의 `diagram`에 전달합니다.
노드와 연결선은 Fletcher에서 가져오며, 마름모 도형은 노트 모듈의 `diamond`로도 가져올 수 있습니다.

````typst
#uml-diagram(width: 120mm, ```
classDiagram
  class Player {
    +int hp
    +move()
  }
```)
````

`uml-diagram`은 `classDiagram`으로 시작하는 raw 콘텐츠를 받습니다.
너비를 생략하면 `lecture-note.with(uml-width: ...)`의 값을 사용합니다(기본 `145mm`).

### 코드와 명령: code-panel, command-panel

```typst
#code-panel([이동 함수], "/snippets/move.cpp")
```

`code-panel`은 C++ 파일과 같은 경로의 `move.json`을 함께 읽습니다.
경로를 `/`로 시작하면 Typst 프로젝트 루트를 기준으로 읽습니다.
일반 상대 경로는 이 helper가 정의된 `lecture-note.typ`의 위치를 기준으로 해석됩니다.
JSON에는 다음 필드가 필요하며, `ref`만 생략할 수 있습니다.

```json
{
  "source": "src/player.cpp",
  "start_line": 10,
  "end_line": 12,
  "ref": "v1.0"
}
```

원본 줄 번호와 출처를 표시하고 C++ 구문 강조 및 들여쓰기 정리를 적용합니다.
발췌 파일과 JSON은 미리 준비해야 합니다.

````typst
#command-panel[빌드 명령][
  ```sh
  cmake -S . -B build
  cmake --build build
  ```
]
````

명령은 여러 줄 raw 코드 블록으로 넣으세요. 각 줄 앞의 `$`는 자동으로 붙습니다.
명령을 실행하지 않고 문서에 표시합니다.

## 슬라이드 설정 위치

`title-slide`, `pause` 등 슬라이드 기능은 Metropolyst에서 직접 가져옵니다.
이 테마는 해당 이름을 재공개하지 않습니다.

| 변경 대상 | 설정 방법 |
|---|---|
| 한 강의의 본문·코드·각주 글꼴 | `lecture-theme`의 `font`, `code-font`, `footnote-font` |
| 본문 크기·굵기 | `body-size`, `body-weight` |
| 문단·목록 간격 | `leading`, `list-gap`, `list-indent` |
| 슬라이드 장식색·배경·본문색 | `accent`, `background`, `text-color` |
| 배포용 자료와 발표 전용 콘텐츠 | `handout`, `presentation-only` |
| 제목·헤더·푸터 글꼴과 크기 등 | `theme-options`에 Metropolyst 옵션 전달 |
| 특정 패널·표·메모 | 해당 함수의 이름 있는 옵션 |
| 표지·헤더·하단 로고 | `logo`, `header-logo`, `bottom-logo`에 각각 크기를 지정한 이미지 전달 |
| 모든 강의의 기본값 | 테마 파일 상단의 `*-defaults` 사전 |

테마는 행렬과 열벡터를 대괄호로 표시합니다. 행렬·열벡터·분수는 글줄 안에서도
디스플레이 수식 크기로 표시하며, 높아진 수식은 실제 높이에 맞춰 줄 간격을 계산합니다.
벡터와 행렬 기호는 각각 `$bvec(v)$`, `$bmat(A)$`로 정립 볼드로 표시할 수 있습니다.

`logo`는 표지 전용이며 `header-logo`는 헤더 오른쪽에 표시됩니다.
`header-logo`를 생략하거나 `none`으로 지정하면 헤더 로고를 숨깁니다.
`bottom-logo`는 왼쪽 아래에 표시되며 기본값은 `none`입니다. 오른쪽 페이지 번호는 유지됩니다.
이미지의 크기는 각각 지정하세요. 예:

```typst
logo: image("figs/meme-hoseo.jpg", height: 2em),
header-logo: image("figs/meme-hoseo.jpg", height: 1em),
bottom-logo: image("figs/meme-hoseo.jpg", height: 1em),
```

`theme-options`는 테마의 Metropolyst 기본값보다 우선합니다.
따라서 `theme-options: (header-right: [...])`를 지정하면 `header-logo`보다 우선합니다.
`theme-options: (footer: [...])`는 `bottom-logo`보다 우선합니다.
로고가 있으면 페이지 번호를 로고 높이의 가운데에 맞춥니다.
`theme-options.footer-right`를 지정하면 이 자동 정렬을 포함한 번호 영역을 대체합니다.
`footer`만 직접 대체할 경우 정렬 높이의 기준은 여전히 `bottom-logo`입니다.

푸터 기본 크기는 현재 `.45em`이며 `theme-options.footer-size`로 변경합니다.
`em`으로 지정한 하단 로고도 이 크기를 따릅니다. 로고를 고정 크기로 유지하려면
`image(..., height: 12pt)`처럼 `pt`를 사용하세요.

예를 들어 제목과 헤더만 별도 글꼴로 표시할 수 있습니다.

```typst
#show: lecture-theme.with(
  title: [게임 수학],
  theme-options: (
    title-font: "Pretendard",
    header-font: "Pretendard",
    header-size: 1.2em,
    title-weight: "semibold",
  ),
)
```

`accent`는 슬라이드 장식과 목록의 색입니다. `c-concept`, `c-meaning` 등
의미별 컴포넌트 색상은 독립적이며 각 컴포넌트의 `color`로 변경합니다.
폰트 fallback 배열은 순서대로 사용하며, 설치되지 않은 이름에 대한 Typst 경고는 숨기지 않습니다.

`handout: true`이면 각 슬라이드의 마지막 단계만 남기고 `presentation-only` 콘텐츠를 숨깁니다.

```typst
#show: lecture-theme.with(handout: true)

#presentation-only[
  #answer-panel[발표할 때만 보여 줄 정답]
]
```

## 기본값 사전

- `font-defaults`: 본문·코드·각주 글꼴
- `text-defaults`: 본문·각주 크기와 강조 굵기
- `spacing-defaults`: 문단·목록·열·아이콘 간격
- `panel-defaults`: 패널 여백·테두리·모서리·배경 농도
- `table-defaults`: 표 여백·헤더 배경·선 굵기
- `decoration-defaults`: 밑줄·강조 배경·구분선·진행 막대
- `slide-defaults`: 화면비와 Metropolyst 타이포그래피

이 사전은 함수 정의의 기본값입니다. 가져온 뒤 같은 이름의 변수를 새로 정의해도
이미 정의된 함수의 기본값은 바뀌지 않습니다. 강의별 변경은 함수 옵션을 사용하세요.
`em`은 주변 글자 크기에 비례하고, `pt`는 고정 크기입니다.

## 컴포넌트 예시

| 함수 | 기본 표현 |
|---|---|
| `plain-panel` | 회색 전체 테두리, 내용 너비 |
| `concept-panel` | 파란 왼쪽 굵은 선, 본문 가운데 정렬 |
| `observation-panel` | 보라색 전체 테두리 |
| `meaning-panel` | 청록색 전체 테두리 |
| `caution-panel` | 주황색 왼쪽 선 |
| `example-panel` | 초록색 전체 테두리, 넉넉한 여백, 제목에 문서 아이콘 |
| `alert-panel` | 빨간 전체 테두리, 본문 가운데 정렬 |
| `definition-panel` | 개념 패널에 접두어와 추가 제목 |
| `answer-panel` | 빨간 위쪽 굵은 선, 기본 제목 `정답` |
| `note-panel` / `note` | 노란 메모 아이콘·테두리, 작은 회색 본문 |

```typst
#example-panel(size: .85em, radius: 0pt, title-gap: 8pt)[내용]
#concept-panel(fill-lighten: 96%, list-gap: 1em)[내용]

#definition-panel(label: [정리])[추가 제목][본문]
#definition-panel[][추가 제목 없음]

#note(
  width: 60%, outer-alignment: right, color: c-meaning,
  icon-name: "pencil", icon-gap: .5em,
)[본문]
#answer-panel(label: [풀이], width: 70%, size: .85em)[내용]

#theme-table(
  ([개념], [핵심]),
  columns: (28%, 72%),
  header-fill: none,
  first-column-weight: "regular",
  [벡터], [크기와 방향],
)
```

패널의 `outer-alignment`는 상자 위치, `alignment`는 본문 정렬입니다.
`width: auto`는 내용 너비를 사용합니다. 패널의 `size`는 상대 크기와 절대 크기 모두 받습니다.
메모는 아이콘과 본문을 두 열로 배치하며 자동 너비에서도 불필요하게 늘어나지 않습니다.

`title-gap`은 제목과 본문 사이 여백, `list-gap`은 패널 내부 목록 간격입니다.
`fill-lighten`이 클수록 배경이 밝아집니다. 제목이 `none` 또는 `[]`이면 제목 여백도 생략합니다.
`definition-panel[][본문]`은 예외적으로 기본 접두어 `정의`를 제목으로 표시합니다.
추가 제목은 주변 본문 색·굵기를 따르며, 그 안에 직접 넣은 강조는 유지됩니다.

### 제목 아이콘과 아이콘 패널

`panel`의 `icon`에는 Font Awesome 이름 또는 콘텐츠를 전달합니다.
제목이 있을 때만 제목 왼쪽에 표시하며, 제목이 없거나 빈 블록이면 아이콘도 생략합니다.
`example-panel`은 `panel`의 프리셋으로, 문서 아이콘(`file-lines`)을 기본으로 사용합니다.

```typst
#panel(title: [관찰], icon: "pencil")[본문]
#example-panel(title: [예시], width: auto)[제목에 문서 아이콘]
#example-panel[제목과 아이콘 없이 본문만]
#example-panel(title: [예시], icon: none)[아이콘 숨김]
```

`icon-panel`은 별도 컴포넌트입니다. 제목이 있으면 제목 왼쪽에,
제목이 없으면 본문 왼쪽에 아이콘을 표시합니다.
`note-panel`은 그 프리셋이며 `note`는 위치 지정까지 지원하는 간편 함수입니다.
기존 `icon-name`, `icon-gap`, `text-color` 등의 옵션을 그대로 사용합니다.
이 컴포넌트의 아이콘 변경에는 `icon` 대신 `icon-name`을 사용하세요.

```typst
#note-panel[메모지 아이콘과 작은 회색 본문]
#note[기존 호출도 동일하게 동작]
#icon-panel(icon-name: "pencil", color: c-meaning)[직접 구성한 패널]
```

### 세로 간격

LaTeX와 유사한 이름으로 수동 세로 간격을 넣을 수 있습니다.

| 함수 | 기본 간격 | 사용 예 |
| --- | --- | --- |
| `#smallskip()` | `.3em` | 설명과 수식 사이 |
| `#medskip()` | `.6em` | 풀이 단계 사이 |
| `#bigskip()` | `1.2em` | 내용 묶음 사이 |

```typst
*① 방향 벡터 구하기*
$ d = P - M $

#medskip()

*② 정규화하기*
$ hat(d) = d / norm(d) $
```

기본값은 `spacing-defaults`의 `smallskip`, `medskip`, `bigskip`에서 조절합니다.
`em` 단위이므로 현재 글자 크기에 비례합니다. 내부적으로 `v(...)`를 사용하며,
문단 간격을 대체하는 설정은 아닙니다. 추가 구분이 필요한 곳에 사용하세요.

### 목록·표·두 열

- `spaced-list`: 전달한 블록 안의 목록 간격만 변경합니다.
- `theme-table`: 헤더 배열 다음에 셀을 행 순서대로 나열합니다. `columns: auto`이면
  헤더 개수만큼 동일 너비의 열을 만듭니다. 본문 내부선과 세로선은 표시하지 않습니다.
- `two-cols`: `[왼쪽][오른쪽]` 블록을 받습니다. 열별 세로 정렬이 `auto`이면
  공통 `valign`을 사용합니다. `bar: true`이면 가운데 선 양쪽에 `gutter`가 각각 들어갑니다.

표의 `header-rule-ratio`는 바깥선에 대한 헤더 구분선 굵기의 비율입니다.
`first-column-weight`와 `header-weight`는 첫 열과 헤더의 굵기를 각각 제어합니다.

### 메모 위치 지정

```typst
#note[본문 흐름에 배치]
#note(position: bottom + right, dy: -1.5em, width: 12em)[오른쪽 아래 메모]
```

`position`을 생략하면 기존 메모와 동일합니다. 지정하면 내부에서 `place`를 사용하며
본문 공간을 차지하지 않습니다. `dx` 양수는 오른쪽, `dy` 양수는 아래쪽입니다.
두 이동값은 `position`을 지정한 경우에만 적용됩니다.

### 기타 유용한 패키지

- [theorion](https://typst.app/universe/package/theorion/): 정리·정의·보조정리·증명 등의 수학적 내용을 일관된 스타일로 표시하는 패키지. 자동 번호, 라벨·참조, 다국어 및 Touying 애니메이션을 지원한다.
- [mannot](https://typst.app/universe/package/mannot/): 수식의 특정 항을 강조하고 설명을 붙이는 패키지. 색상(`mark`), 배경 강조(`markhl`), 테두리(`markrect`), 밑줄(`markul`), 물결 밑줄(`markuw`), 아래 괄호(`markub`)로 표시한 뒤 `annot`으로 주석을 연결한다.
- [pinit](https://typst.app/universe/package/pinit/): 문서 안에 기준점(`pin`)을 지정하고, 그 위치를 기준으로 설명·화살표·도형을 배치하는 패키지. 수식뿐 아니라 일반 텍스트와 코드에도 사용할 수 있으며, 특정 부분을 가리키거나 연결할 때 유용하다.

## 로컬 패키지 설치

Typst는 `@preview/...`처럼 인터넷에서 받는 패키지 말고도, 내 컴퓨터의 정해진
폴더에 직접 놓아둔 패키지를 `@local/...`로 인식하는 기능이 있습니다. 이 저장소는
`typst.toml`이 있는 Typst 패키지이므로, 그 폴더 규칙에 맞춰 이 저장소로의
심볼릭 링크를 걸어두면 어떤 위치의 강의 파일에서도
`#import "@local/lecture-theme:0.1.0": *`로 바로 가져올 수 있습니다.

저장소를 새로 받은 뒤(또는 옮긴 뒤) 아래 스크립트를 한 번 실행하면 됩니다.

```sh
./install.sh
```

`typst`가 현재 사용하는 패키지 경로(`TYPST_PACKAGE_PATH` 환경 변수, 없으면 OS별
기본 위치)를 스크립트가 자동으로 찾아 `local/lecture-theme/0.1.0`에 심볼릭 링크를
겁니다.

`TYPST_PACKAGE_PATH`를 따로 설정해두지 않았다면, conda 등으로 `typst`를 여러
환경에 설치해 두었어도 전부 같은 OS 기본 경로를 보기 때문에 `install.sh`는 한 번만
실행하면 충분합니다. VS Code의 tinymist 확장도 마찬가지입니다 — `tinymist`는
외부 `typst` 바이너리를 호출하지 않고 자체 내장 컴파일러를 쓰므로
(`tinymist.serverPath`로 특정 바이너리를 지정한 게 아니라면) 같은 기본 경로를
그대로 인식하며, conda 환경 여부와는 무관합니다.

반대로 특정 conda 환경 등에서만 `TYPST_PACKAGE_PATH`를 다르게 설정해뒀다면, 그
환경을 활성화한 셸에서 `install.sh`를 한 번 더 실행해야 하고, tinymist가 같은
패키지를 보게 하려면 VS Code 설정에 `tinymist.typstExtraArgs`로
`["--package-path", "<그 경로>"]`를 추가해줘야 합니다.

링크를 걸고 나면 테마를 수정할 때 저장소 파일만 바꾸면 바로 반영됩니다.
버전을 올릴 때는 `typst.toml`의 `version`을 바꾸고 `install.sh`를 다시 실행하세요.

## 다른 저장소에서 서브모듈로 사용하기

강의 자료 저장소 안에 이 테마를 함께 버전 관리하고 싶다면 git submodule로
추가합니다.

```sh
git submodule add https://github.com/ytoh-hoseo/typst-lecture-theme.git lecture-theme
git submodule update --init --recursive
```

이후 강의 파일에서는 지금까지와 동일하게 상대 경로로 import할 수 있습니다.

```typst
#import "lecture-theme/lecture-theme.typ": *
```

`@local/lecture-theme:0.1.0` 형태로 쓰려면 [로컬 패키지 설치](#로컬-패키지-설치)의
`install.sh`를 별도로 한 번 실행하면 됩니다. 두 가지는 서로 다른 문제입니다 —
submodule은 이 저장소를 다른 저장소에 버전 고정해 포함시키는 것이고,
`install.sh`는 컴퓨터 어디서든 `@local/...`로 import할 수 있게 등록하는 것입니다.

테마 쪽 커밋이 갱신되면 강의 저장소에서 아래처럼 반영합니다.

```sh
cd lecture-theme && git pull origin main && cd ..
git add lecture-theme
git commit -m "lecture-theme 업데이트"
```

새로 clone할 때는 `git clone --recurse-submodules <강의 저장소 URL>`을 쓰거나,
일반 clone 후 `git submodule update --init --recursive`를 실행하세요.
