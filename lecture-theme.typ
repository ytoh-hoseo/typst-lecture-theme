// 공통 강의 테마 — 사용 예제와 전체 옵션 안내: README.md
// 이 파일: 기본값과 재사용 컴포넌트. 강의 파일: 강의 정보와 슬라이드 본문.
// 강의에서 title-slide/pause 등은 Metropolyst를 직접 import해서 사용한다.
// Metropolyst 0.1.0이 사용하는 Touying 버전을 그대로 따른다.
//
// 구성: 1. 팔레트 / 2. 기본값 / 3. 인라인 표현 / 4. 목록·표
//       5. 밑줄·배경 강조 / 6. 패널 / 7. 아이콘 패널 / 8. 두 열 / 9. 문서 테마
#import "@preview/metropolyst:0.1.0" as metropolis
#import "@preview/fontawesome:0.6.2": *

// -----------------------------------------------------------------------------
// 1. 색상 팔레트
// -----------------------------------------------------------------------------
// concept: 정의·핵심 개념 / observation: 관찰 / meaning: 의미·직관
// critical: 경고 / positive: 긍정·예시 / caution: 주의 / highlight: 배경 강조
// 패널·아이콘은 color 옵션으로 색을 변경한다. 인라인 의미 함수는 아래 팔레트를 따른다.
#let c-theme = rgb("#b71c1c")
#let c-plain-fg = rgb("#000000")
#let c-plain-bg = luma(55%)
#let c-concept = rgb("#1D4ED8")
#let c-observation = rgb("#7C3A95")
#let c-meaning = rgb("#0F766E")
#let c-critical = rgb("#B91C1C")
#let c-positive = rgb("#15803D")
#let c-caution = rgb("#C2410C")
#let c-highlight = rgb("#f9a825")
#let c-muted = luma(30%)
// 기존 자료에서 참조할 수 있는 보조 팔레트. 기본 panel의 배경은 color에서 계산한다.
#let c-block-head = rgb("#f5a142")
#let c-block-body = rgb("#fff3e4")
#let c-alert-head = rgb("#b71c1c")
#let c-alert-body = rgb("#f7dddd")
// -----------------------------------------------------------------------------
// 2. 디자인 기본값
// -----------------------------------------------------------------------------
// 디자인 기본값: 같은 역할의 수치와 글꼴은 이곳에서 함께 관리한다.
// em은 현재 글자 크기 기준, pt는 고정 크기이다.
// 공통 변경은 이 사전을 편집하고, 강의·컴포넌트별 변경은 함수 옵션을 사용한다.
// 강의에서 같은 이름의 사전을 새로 선언해도 이 파일의 기본값은 바뀌지 않는다.
// 본문·코드·각주 글꼴 목록. 먼저 나오는 글꼴부터 fallback한다.
#let font-defaults = (
  body: ("NanumSquareRound", "Noto Sans CJK KR", "Noto Sans KR"),
  code: ("D2Coding", "Noto Sans Mono CJK KR", "DejaVu Sans Mono"),
  footnote: ("KoPubWorldBatang", "Noto Sans CJK KR", "Noto Sans KR"),
)
// 문서 본문과 각주의 크기·굵기. 표와 메모의 기본 크기는 별도이다.
#let text-defaults = (
  body-size: 22pt,
  body-weight: "medium",
  emphasis-weight: "bold",
  footnote-size: 12pt,
  strong-delta: 200,
)
// 문단 leading, 목록 간격, 열·아이콘 사이 간격.
#let spacing-defaults = (
  leading: .72em,
  list-gap: .8em,
  list-indent: .55em,
  spaced-list-gap: 2em,
  label-indent: 1em,
  label-gap: .1em,
  column-gap: 1.2em,
  icon-gap: .35em,
)
// 패널의 폭·내부 여백·선·모서리와 제목 간격.
#let panel-defaults = (
  width: 95%,
  inset: (x: 12pt, y: 9pt),
  example-inset: (x: 24pt, y: 18pt),
  border-width: 1pt,
  concept-border-width: 3pt,
  answer-border-width: 2pt,
  radius: 5pt,
  title-gap: 4pt,
  fill-lighten: 92%,
  note-size: .65em,
)
// 표: 위·아래 외곽선과 가는 헤더 구분선만 표시한다.
#let table-defaults = (
  size: 18pt,
  inset: (x: 14pt, y: 8pt),
  rule-color: luma(30%),
  header-fill: luma(96%),
  rule-width: 1.2pt,
  header-rule-ratio: .5,
  header-rule-lighten: 35%,
)
// 밑줄·하이라이트·열 구분선·진행 막대의 기본값.
#let decoration-defaults = (
  underline-width: 1.2pt,
  underline-offset: 5pt,
  colored-underline-offset: 7pt,
  highlight-lighten: 80%,
  highlight-inset: (x: 8pt, y: 4pt),
  highlight-radius: 2pt,
  column-rule-color: luma(75%),
  column-rule-width: 1pt,
  progress-lighten: 82%,
)
// Metropolyst 고유 옵션은 lecture-theme의 theme-options에서 개별 변경한다.
#let slide-defaults = (
  aspect-ratio: "16-9",
  align: horizon,
  footer-progress: true,
  header-size: 1.12em,
  header-weight: "bold",
  title-size: 1.45em,
  title-weight: "bold",
  subtitle-weight: "regular",
  author-weight: "semibold",
  institution-weight: "medium",
  section-size: 1.45em,
  section-weight: "bold",
  footer-size: .45em, // 푸터 글자와 em 단위 하단 로고의 크기에 함께 영향
)
#let c-soft = c-concept.lighten(panel-defaults.fill-lighten)
#let c-alert-soft = c-critical.lighten(90%) // 기존 사용처를 위한 보조색

// -----------------------------------------------------------------------------
// 3. 인라인 강조와 아이콘
// -----------------------------------------------------------------------------
// 인라인 강조. weight를 지정하면 문구별로 굵기를 바꿀 수 있다.
#let concept(body, weight: text-defaults.emphasis-weight) = text(fill: c-concept, weight: weight, body)
#let observation(body, weight: text-defaults.emphasis-weight) = text(fill: c-observation, weight: weight, body)
#let meaning(body, weight: text-defaults.emphasis-weight) = text(fill: c-meaning, weight: weight, body)
#let critical(body, weight: text-defaults.emphasis-weight) = text(fill: c-critical, weight: weight, body)
#let positive(body, weight: text-defaults.emphasis-weight) = text(fill: c-positive, weight: weight, body)
#let caution(body, weight: text-defaults.emphasis-weight) = text(fill: c-caution, weight: weight, body)
#let muted(body) = text(fill: c-muted, body)

// 공통 아이콘. 예: #icon-pencil(color: c-meaning, size: 1.2em)
// top-edge: bounds로 아이콘 글리프의 실제 윗부분을 정렬 기준으로 삼는다.
// solid: false는 해당 아이콘에 regular 스타일이 있을 때 사용한다.
#let icon(name, color: c-plain-fg, size: 1em, solid: true) = text(
  fill: color,
  size: size,
  top-edge: "bounds",
  fa-icon(name, solid: solid),
)
#let icon-pencil = icon.with("pencil")
#let icon-important = icon.with("circle-exclamation", color: c-critical)
#let icon-youtube = icon.with("youtube", color: c-critical)

// -----------------------------------------------------------------------------
// 4. 목록과 표
// -----------------------------------------------------------------------------
// 전달한 본문 안의 목록에만 간격을 적용한다. 바깥 목록에는 영향이 없다.
// - 글머리 목록(list)과 + 번호 목록(enum)에 모두 적용한다.
// 예: #spaced-list(gap: 1em)[- 항목 ...] (실제 항목은 줄을 나누어 작성)
#let spaced-list(gap: spacing-defaults.spaced-list-gap, body) = {
  set list(spacing: gap)
  set enum(spacing: gap)
  body
}

// headers는 헤더 콘텐츠 배열, 나머지 위치 인자는 행 순서대로 나열한 셀이다.
// columns: auto이면 헤더 수만큼 같은 너비의 열을 만든다.
// first-column-weight/header-weight는 각각 첫 열/헤더의 굵기이다.
// header-rule-ratio는 헤더 구분선 굵기 ÷ 바깥선 굵기이다.
// 예: #theme-table(([개념], [핵심]), [벡터], [크기와 방향])
#let theme-table(
  headers,
  columns: auto,
  color: table-defaults.rule-color,
  size: table-defaults.size,
  inset: table-defaults.inset,
  header-fill: table-defaults.header-fill,
  rule-width: table-defaults.rule-width,
  header-rule-ratio: table-defaults.header-rule-ratio,
  header-rule-lighten: table-defaults.header-rule-lighten,
  first-column-weight: text-defaults.emphasis-weight,
  header-weight: text-defaults.emphasis-weight,
  alignment: left + horizon,
  ..cells,
) = {
  set text(size: size)
  show table.cell.where(x: 0): set text(weight: first-column-weight)
  show table.cell.where(y: 0): set text(weight: header-weight)
  table(
    columns: if columns == auto { headers.len() } else { columns },
    stroke: none,
    fill: (x, y) => if y == 0 { header-fill } else { none },
    align: alignment,
    inset: inset,
    table.header(
      table.hline(stroke: rule-width + color),
      ..headers,
      table.hline(stroke: (rule-width * header-rule-ratio) + color.lighten(header-rule-lighten)),
    ),
    ..cells.pos(),
    table.hline(stroke: rule-width + color),
  )
}

// -----------------------------------------------------------------------------
// 5. 밑줄·배경 강조·들여쓰기
// -----------------------------------------------------------------------------
// 밑줄은 글자색을 유지하고 선만 꾸민다.
// color: auto는 주변 글자색을 사용한다. offset은 글자에서 밑줄까지의 거리이다.
#let ul(
  body,
  color: auto,
  thickness: decoration-defaults.underline-width,
  offset: decoration-defaults.underline-offset,
) = underline(
  stroke: if color == auto { thickness } else { thickness + color },
  offset: offset,
  body,
)
#let redul = ul.with(color: c-critical, offset: decoration-defaults.colored-underline-offset)
#let blueul = ul.with(color: c-concept, offset: decoration-defaults.colored-underline-offset)
#let greenul = ul.with(color: c-positive, offset: decoration-defaults.colored-underline-offset)

// 배경 강조. lighten이 클수록 배경색이 연해진다.
#let hl(
  body,
  color: c-highlight,
  lighten: decoration-defaults.highlight-lighten,
) = highlight(
  body,
  fill: color.lighten(lighten),
)
#let redhl = hl.with(color: c-critical)
#let bluehl = hl.with(color: c-concept)
#let greenhl = hl.with(color: c-positive)
#let orangehl = hl.with(color: c-caution)

// 텍스트와 수식을 감싸는 인라인 상자 강조. 여러 줄로 나뉘지 않는다.
#let boxhl(
  body,
  color: c-highlight,
  lighten: decoration-defaults.highlight-lighten,
  inset: decoration-defaults.highlight-inset,
  radius: decoration-defaults.highlight-radius,
) = box(
  body,
  fill: color.lighten(lighten),
  inset: inset,
  radius: radius,
)

// 제목 아래에 들여쓴 본문을 배치한다. gap은 제목과 본문 사이 여백이다.
// 예: #labeled[제목][본문]
#let labeled(
  title,
  indent: spacing-defaults.label-indent,
  gap: spacing-defaults.label-gap,
  body,
) = [
  *#title*
  #v(gap)
  #pad(left: indent)[
    #body
  ]
]

// -----------------------------------------------------------------------------
// 6. 기본 패널과 의미별 프리셋
// -----------------------------------------------------------------------------
// 기본 패널. outer-alignment는 상자 위치, alignment는 본문 정렬이다.
// width: auto는 내용에 맞춘 너비. size: 1em은 주변 글자 크기를 유지한다.
// border: "left"/"bottom"/"top"/"all". 그 외 값(예: "none")이면 테두리 없음.
// title: none 또는 []이면 제목과 제목 아래 여백을 모두 생략한다.
// title-gap/title-weight는 제목 간격·굵기, list-gap은 패널 안의 목록 간격이다.
// fill-lighten은 배경을 흰색 쪽으로 밝히는 비율이다.
// icon은 Font Awesome 이름 또는 콘텐츠. 제목이 있을 때만 표시한다.
// 문자열 아이콘은 solid로 표시하고 제목 색상을 따른다.
// 예: #panel(title: [제목], icon: "pencil", width: auto)[본문]
#let panel(
  title: none,
  icon: none,
  icon-gap: spacing-defaults.icon-gap,
  color: c-plain-bg,
  alignment: none,
  outer-alignment: center,
  width: panel-defaults.width,
  inset: panel-defaults.inset,
  border: "left",
  border-width: panel-defaults.border-width,
  radius: panel-defaults.radius,
  title-gap: panel-defaults.title-gap,
  title-weight: text-defaults.emphasis-weight,
  list-gap: spacing-defaults.list-gap,
  fill-lighten: panel-defaults.fill-lighten,
  size: 1em,
  body,
) = {
  set text(size: size)
  let fill-color = color.lighten(fill-lighten)

  let border-stroke = if border == "left" {
    (left: border-width + color)
  } else if border == "bottom" {
    (bottom: border-width + color)
  } else if border == "top" {
    (top: border-width + color)
  } else if border == "all" {
    border-width + color
  } else {
    none
  }

  align(
    outer-alignment,
    box(
      width: width,
      fill: fill-color,
      stroke: border-stroke,
      radius: radius,
      inset: inset,
    )[
      // 바깥 패널 정렬의 상속을 여기서 끊음
      #set align(left)

      #if title != none and title != [] {
        (
          text(
            weight: title-weight,
            fill: color,
            if icon == none { title } else {
              // 아이콘과 제목을 같은 문단의 베이스라인에 나란히 놓는다.
              let title-icon = if type(icon) == str { fa-icon(icon, solid: true) } else { icon }
              title-icon + h(icon-gap) + title
            },
          )
            + v(title-gap)
        )
      }

      #spaced-list(gap: list-gap)[
        #if alignment != none {
          align(alignment, body)
        } else {
          body
        }
      ]
    ],
  )
}

// 의미별 프리셋. panel의 모든 옵션을 호출 시 다시 지정할 수 있다.
// 일반 수식·짧은 내용: 회색, 내용 너비, 전체 테두리.
#let plain-panel = panel.with(
  color: c-plain-bg,
  width: auto,
  border: "all",
  border-width: panel-defaults.border-width,
)

// 핵심 개념: 파랑, 굵은 왼쪽 선, 본문 가운데 정렬.
#let concept-panel = panel.with(
  color: c-concept,
  border: "left",
  border-width: panel-defaults.concept-border-width,
  alignment: center,
)

// 관찰: 보라색, 전체 테두리.
#let observation-panel = panel.with(
  icon: "eye",
  color: c-observation,
  border: "all",
)

// 의미·직관: 청록색, 전체 테두리.
#let meaning-panel = panel.with(
  icon: "lightbulb",
  color: c-meaning,
  border: "all",
)

// 주의: 주황색, 왼쪽 선.
#let caution-panel = panel.with(
  icon: "circle-exclamation",
  color: c-caution,
  border: "left",
)

// 예시: 제목이 있을 때만 문서 아이콘을 표시하는 기본 패널 프리셋.
#let example-panel = panel.with(
  icon: "file-lines",
  color: c-positive,
  border: "all",
  border-width: panel-defaults.border-width,
  width: panel-defaults.width,
  inset: panel-defaults.example-inset,
)

// 경고: 빨강, 전체 테두리, 본문 가운데 정렬.
#let alert-panel = panel.with(
  color: c-critical,
  icon: "triangle-exclamation",
  border: "all",
  alignment: center,
)

// 두 블록은 [추가 제목][본문]. 빈 제목 []는 label만 표시한다.
// 추가 제목은 호출 위치의 글자색과 굵기를 따른다. 직접 넣은 강조는 유지한다.
// label은 자동 접두어이며 추가 제목이 있으면 뒤에 마침표를 붙인다.
// 예: #definition-panel(label: [정리])[추가 제목][본문]
// ..options는 concept-panel로 전달한다.
#let definition-panel(
  title,
  body,
  label: [정의],
  alignment: center,
  ..options,
) = context {
  let body-color = text.fill
  let body-weight = text.weight
  concept-panel(
    title: if title == [] { label } else {
      [#label. #text(fill: body-color, weight: body-weight, title)]
    },
    alignment: alignment,
    ..options,
    body,
  )
}

// 정답 패널도 size/width/label 등 호출별 옵션을 받는다.
#let answer-panel(body, label: [정답], ..options) = alert-panel.with(
  title: label,
  icon: "pencil",
  border: "top",
  border-width: panel-defaults.answer-border-width,
  alignment: left,
  width: 100%,
)(..options, body)

// lecture-theme의 handout 설정을 presentation-only와 공유한다.
#let lecture-handout-mode = state("lecture-theme-handout-mode", false)

// 발표 자료에만 표시할 콘텐츠. handout이 켜지면 본문에서 제외한다.
#let presentation-only(body) = context if lecture-handout-mode.get() { none } else { body }

// -----------------------------------------------------------------------------
// 7. 본문에도 아이콘을 표시하는 패널
// -----------------------------------------------------------------------------
// panel(icon: ...)과 달리 제목이 없어도 아이콘을 표시한다.
// 제목 있음: 아이콘 + 제목, 다음 줄에 본문. 제목 없음: 아이콘 + 본문.
// icon-name은 Font Awesome 이름, color는 테두리·아이콘·제목 색상이다.
// text-color는 본문 색상이며, icon-gap은 아이콘과 텍스트 사이 간격이다.
// ..options는 panel로 전달한다. 이 컴포넌트의 아이콘은 icon-name으로 지정한다.
// 자동 너비에서는 본문 열도 auto로 두어 내용에 맞게 줄어들도록 한다.
#let icon-panel(
  body,
  title: none,
  icon-name: "note-sticky",
  alignment: left,
  width: auto,
  size: 1em,
  color: c-plain-bg,
  text-color: c-plain-fg,
  icon-gap: spacing-defaults.icon-gap,
  ..options,
) = {
  let has-title = title != none and title != []
  // 제목은 왼쪽 정렬, 제목 없는 본문은 호출자가 지정한 정렬을 따른다.
  let with-icon(content, content-alignment: left) = grid(
    columns: (auto, if width == auto { auto } else { 1fr }),
    column-gutter: icon-gap,
    align: (left + top, content-alignment + top),
    icon(icon-name, color: color),
    content,
  )
  panel.with(
    color: color,
    border: "all",
    border-width: panel-defaults.border-width,
    width: width,
    size: size,
    alignment: alignment,
  )(
    ..options,
    title: if has-title { with-icon(title) } else { none },
    text(
      fill: text-color,
      if has-title { body } else { with-icon(body, content-alignment: alignment) },
    ),
  )
}

// 메모: 노란 메모지 아이콘·테두리, 작은 회색 본문, 내용에 맞춘 너비.
#let note-panel = icon-panel.with(
  icon-name: "note-sticky",
  color: c-highlight,
  size: panel-defaults.note-size,
  text-color: c-muted,
)

// 메모의 간편 호출. position: none이면 본문 흐름에, 지정하면 place로 배치한다.
// dx/dy는 position 지정 시에만 적용한다. 양수는 오른쪽/아래쪽 이동이다.
// 예: #note(position: bottom + right, dy: -1.5em, width: 12em)[본문]
#let note(
  body,
  position: bottom + right,
  width: 10em,
  size: panel-defaults.note-size,
  dx: 0pt,
  dy: 0pt,
  ..options,
) = {
  let content = note-panel(width: width, size: size, ..options, body)
  if position == none {
    content
  } else {
    place(position, dx: dx, dy: dy, content)
  }
}

// 단독 경고 문구. 패널 없이 정렬과 색상만 적용한다.
#let warning(body, alignment: center, color: c-critical) = align(
  alignment, text(fill: color, weight: text-defaults.emphasis-weight, body),
)

// -----------------------------------------------------------------------------
// 8. 두 열 레이아웃
// -----------------------------------------------------------------------------
// 두 블록 [왼쪽][오른쪽]을 나란히 배치한다. 예: #two-cols[설명][그림]
// left-width/right-width는 열 너비, gutter는 인접한 grid 열 사이 간격이다.
// left-valign/right-valign이 auto이면 공통 valign을 사용한다.
// bar: true이면 가운데 선이 별도 열이 되어 선 양쪽에 gutter가 각각 생긴다.
#let two-cols(
  left-body,
  right-body,
  left-width: 1fr,
  right-width: 1fr,
  gutter: spacing-defaults.column-gap,

  valign: top,
  left-valign: auto,
  right-valign: auto,

  bar: false,
  bar-color: decoration-defaults.column-rule-color,
  bar-width: decoration-defaults.column-rule-width,
) = {
  let lv = if left-valign == auto { valign } else { left-valign }
  let rv = if right-valign == auto { valign } else { right-valign }

  if bar {
    grid(
      columns: (left-width, bar-width, right-width),
      gutter: gutter,

      align: (x, y) => {
        if x == 0 {
          alignment.left + lv
        } else if x == 2 {
          alignment.left + rv
        } else {
          alignment.center + alignment.horizon
        }
      },

      left-body,

      grid.cell(
        fill: bar-color,
        inset: 0pt,
      )[],

      right-body,
    )
  } else {
    grid(
      columns: (left-width, right-width),
      gutter: gutter,

      align: (x, y) => {
        if x == 0 {
          alignment.left + lv
        } else {
          alignment.left + rv
        }
      },

      left-body,
      right-body,
    )
  }
}

// -----------------------------------------------------------------------------
// 9. 문서 전체 테마와 로고·푸터
// -----------------------------------------------------------------------------
// 문서 전체에 적용하는 테마. 폰트는 이름 또는 fallback 배열로 지정한다.
// theme-options: Metropolyst 옵션 사전. 아래 기본값보다 우선한다.
// 예: theme-options: (header-size: 1.2em, title-font: "Pretendard")
// accent는 슬라이드 장식과 목록 색상이며 의미별 c-concept 등은 독립적이다.
// font/code-font/footnote-font는 본문·코드·각주 글꼴을 각각 설정한다.
// header/title/footer 전용 글꼴은 theme-options에서 지정한다.
// 우선순위: slide-defaults < 이 함수에서 만든 Metropolyst 옵션 < theme-options.
// theme-options.header-right/footer/footer-right로 로고나 번호 영역을 직접 대체할 수 있다.
#let lecture-theme(
  title: none,
  subtitle: none,
  author: none,
  institution: none,
  logo: none,
  // 표지와 헤더 로고는 크기와 내용을 독립적으로 지정한다.
  // 생략하면 헤더에는 로고를 표시하지 않는다.
  header-logo: none,
  // 왼쪽 아래 로고. 크기는 이미지에서 지정한다 (em은 footer-size 기준).
  // none이면 기본 페이지 번호, 로고가 있으면 그 높이에 번호를 가운데 정렬한다.
  bottom-logo: none,
  font: font-defaults.body,
  code-font: font-defaults.code,
  footnote-font: font-defaults.footnote,
  body-size: text-defaults.body-size,
  body-weight: text-defaults.body-weight,
  footnote-size: text-defaults.footnote-size,
  leading: spacing-defaults.leading,
  list-gap: spacing-defaults.list-gap,
  list-indent: spacing-defaults.list-indent,
  strong-delta: text-defaults.strong-delta,
  accent: c-theme,
  text-color: c-plain-fg,
  background: white,
  // true이면 Touying의 handout 모드를 켜고 presentation-only 콘텐츠를 숨긴다.
  handout: false,
  theme-options: (:),
  // config-common(...) 등 추가 Touying 설정을 Metropolyst로 전달한다.
  ..configs,
  body,
) = {
  lecture-handout-mode.update(handout)

  // 사전 병합은 오른쪽 값이 우선한다. 사용자 옵션을 마지막에 적용한다.
  let options = slide-defaults + (
    accent-color: accent,
    line-separator-color: accent,
    progress-bar-color: accent,
    progress-bar-background: accent.lighten(decoration-defaults.progress-lighten),
    header-background-color: accent,
    header-text-color: white,
    header-right: header-logo,
    main-background-color: background,
    main-text-color: text-color,
    footer-text-color: c-muted,
    footer: bottom-logo,
    // 로고가 있으면 같은 높이의 상자 안에서 페이지 번호를 가운데 맞춘다.
    // 높이는 bottom-logo를 기준으로 계산한다. theme-options.footer만 대체하면
    // 이 기준도 자동으로 바뀌지는 않으므로 필요시 footer-right도 직접 지정한다.
    footer-right: self => context {
      let number = metropolis.utils.slide-counter.display() + " / " + metropolis.utils.last-slide-number
      let logo-content = metropolis.utils.call-or-display(self, bottom-logo)
      if logo-content == none {
        number
      } else {
        box(
          width: measure(number).width,
          height: calc.max(measure(logo-content).height, measure(number).height),
          align(horizon, number),
        )
      }
    },
    font: font,
  ) + theme-options

  show: metropolis.metropolyst-theme.with(
    ..options,
    metropolis.config-info(
      title: title,
      subtitle: subtitle,
      author: author,
      institution: institution,
      logo: logo,
    ),
    ..configs,
    metropolis.config-common(handout: handout),
  )
  set text(size: body-size, weight: body-weight)
  set par(justify: false, leading: leading)
  set list(
    marker: box(
      move(dy: -.25em, circle(radius: .14em, fill: accent)),
    ),
    body-indent: list-indent,
    spacing: list-gap,
  )
  set strong(delta: strong-delta)
  show raw: set text(font: code-font)
  show footnote.entry: set text(font: footnote-font, size: footnote-size)
  body
}
