// xyznote의 노트형 구성을 참고한 프로젝트 자체 템플릿입니다.
// 본문·코드·도식의 공통 스타일을 관리합니다. 개별 도식은 사용하는 강의 문서에 둡니다.
//
// Helper 사용 설명: README.md의 "강의 노트 helper 참고표"
// 필요한 함수는 이 파일에서 import한 뒤 사용합니다.
//   #boxed[내용]                       테두리 0.8pt, 안쪽 여백 6pt
//   #hcenter[내용] / #hleft[내용] / #hright[내용]  수평 정렬
//   $bvec(v)$ / $bmat(A)$              벡터·행렬 기호를 정립 볼드로 표시
//   #toc(depth: 2, indent: 1em)         목차
//   #medskip() / #bigskip()             세로 여백 8pt / 16pt
//   #callout[제목][본문]                 제목 띠가 있는 강조 박스
//   #sidenote(kind: "note")[제목][본문]  오른쪽 사이드노트
//   #full-width[내용]                   사이드바를 포함한 전체 너비
//   #note-diagram(...)                  Fletcher 도식
//   #uml-diagram(`classDiagram ...`)    UML 클래스 도식
//   #code-panel([제목], "/snippets/example.cpp")  C++ 발췌 파일 + JSON 필요
//   #command-panel[제목][```sh ...```]   명령 패널 (실제로는 여러 줄 코드 블록 사용)


#import "common.typ": bvec, bmat, boxed, hcenter, hleft, hright

// 아래 값은 기본값입니다. 문서별 변경은 lecture-note.with(설정명: 값)으로 지정합니다.
// 기존 font:도 지원하며, 지정하면 body-font:보다 우선합니다.
#let body-font = "Noto Serif KR"  // 본문 글꼴
#let code-font = "D2Coding"  // 코드 글꼴
#let math-font = "New Computer Modern Math"  // 수학 조판을 지원하는 글꼴 또는 글꼴 목록
#let diagram-font = code-font  // 도식 글꼴; with에서 생략하면 code-font를 따름
#let body-font-size = 9.5pt  // 본문 글자 크기

// 첫 페이지의 문서 제목 영역 (본문의 절 제목 heading과 별도입니다).
#let title-font-size = 25pt     // 문서 제목의 글자 크기
#let subtitle-font-size = 10pt  // 제목 아래 부제의 글자 크기
#let title-block-gap = 12pt     // 제목·부제 영역 뒤, 본문 시작 전의 세로 여백

// 자동 배치된 클래스 도식의 전체 너비입니다.
#let uml-width = 145mm  // UML 도식의 기본 출력 너비

// 줄간격과 문단 간격: em은 해당 영역의 글자 크기를 기준으로 합니다.
// leading은 줄 사이의 여백이며, 전체 줄 높이나 '배수 줄간격'이 아닙니다.
#let body-leading = 1.0em  // 본문의 줄 사이 여백
#let paragraph-spacing = 1.5em  // 본문 문단 사이 여백
#let medskip-size = 8pt  // medskip()의 세로 여백
#let bigskip-size = 16pt  // bigskip()의 세로 여백
#let code-leading = 0.35em  // 코드 내부의 줄 사이 여백
#let code-tab-size = 2  // 코드 탭 하나에 해당하는 공백 수
#let code-source-indent-size = 4  // 원본 C++ 코드의 들여쓰기 단위
#let code-indent-size = 2  // 코드 패널에 표시할 들여쓰기 단위
#let diagram-leading = body-leading  // 도식 줄간격; with에서 생략하면 body-leading을 따름

// 목록 항목 간격: auto는 Typst 기본값입니다. 4pt 등으로 바꾸면 직접 지정합니다.
#let list-spacing = auto  // 목록 항목 간격; auto는 Typst 기본값

// 절 제목 번호: 0은 번호 없음, 양의 정수는 번호를 표시할 최대 단계입니다.
#let numbering-depth = 0
#let numbering-by-level = () // 1단계부터 순서대로 번호 형식 지정; 생략 또는 auto는 "1.1"

// 제목·도표·패널 내부 간격
#let heading1-above = 24pt  // 1단계 절 제목 위 여백
#let heading1-below = 18pt  // 1단계 절 제목 아래 여백
#let heading2-above = 18pt  // 2단계 절 제목 위 여백
#let heading2-below = 10pt  // 2단계 절 제목 아래 여백
#let figure-caption-gap = 8pt  // 그림과 캡션 사이 간격
#let callout-title-gap = 4pt  // callout 제목 띠의 세로 여백 기준
#let code-title-gap = 4pt  // 코드 출처와 코드 본문 사이 간격

// 페이지 전체에 본문과 사이드 컬럼을 확보합니다.
#let page-width = 210mm  // 페이지 전체 너비
#let page-outer-margin = 21mm  // 페이지 좌우 바깥 여백
#let content-width = page-width - 2 * page-outer-margin  // 본문과 사이드바의 전체 너비; with에서 생략하면 페이지 너비로 계산
#let sidebar-width = 40mm  // 오른쪽 사이드바 너비
#let sidebar-gap = 6mm  // 본문과 사이드바 사이 간격
#let main-width = content-width - sidebar-width - sidebar-gap  // 본문 너비; with에서 생략하면 전체 너비에서 사이드바와 간격을 뺌
#let sidebar-font-size = 8pt  // 사이드노트 글자 크기
#let sidebar-leading = 0.65em  // 사이드노트 내부 줄간격

#import "@preview/fletcher:0.5.8": diagram, edge, node, shapes
#import "@preview/pintorita:0.1.4"
#import "@preview/marge:0.1.0"
#let diamond = shapes.diamond

// 공통 색상
#let ink = rgb("#24334a")  // 본문 기본 색
#let accent = rgb("#236d9b")  // 제목·강조선 색
#let muted = rgb("#61738a")  // 부제·보조 텍스트 색
#let pale = rgb("#eff5fa")  // 사이드노트·도식의 옅은 배경색
#let table-header = rgb("#e8f1f7")  // 표와 명령 패널의 제목 배경색
#let table-line = rgb("#d5e0e9")  // 표·패널 테두리 색

// 별도로 import한 도식·사이드노트·패널이 사용하는 설정만 공유합니다.
// 나머지 본문 설정은 lecture-note의 set/show 규칙에서 직접 적용합니다.
#let note-style = state("lecture-note/style", (
  code-font: code-font,
  diagram-font: diagram-font,
  uml-width: uml-width,
  medskip-size: medskip-size,
  bigskip-size: bigskip-size,
  code-leading: code-leading,
  code-tab-size: code-tab-size,
  code-source-indent-size: code-source-indent-size,
  code-indent-size: code-indent-size,
  diagram-leading: diagram-leading,
  callout-title-gap: callout-title-gap,
  code-title-gap: code-title-gap,
  page-outer-margin: page-outer-margin,
  content-width: content-width,
  sidebar-gap: sidebar-gap,
  sidebar-font-size: sidebar-font-size,
  sidebar-leading: sidebar-leading,
  ink: ink,
  accent: accent,
  muted: muted,
  pale: pale,
  table-header: table-header,
  table-line: table-line,
))

// 제목 번호·페이지 번호·이동 링크는 Typst의 outline을 사용합니다.
// depth: none은 모든 단계, title: none은 목차 제목을 숨깁니다.
// indent: auto는 자동 들여쓰기, 길이를 지정하면 단계마다 해당 크기만큼 들여씁니다.
#let toc(title: [목차], depth: none, indent: auto) = {
  if title != none {
    heading(level: 1, numbering: none, outlined: false, title)
  }
  outline(title: none, depth: depth, indent: indent)
}

// 문서에서 의미 있는 단락 사이를 명시적으로 띄울 때 사용합니다.
#let medskip() = context {
  let style = note-style.get()
  let medskip-size = style.medskip-size
  v(medskip-size)
}

#let bigskip() = context {
  let style = note-style.get()
  let bigskip-size = style.bigskip-size
  v(bigskip-size)
}

// 도식의 글꼴·기본 크기·노드 색상을 일괄 적용합니다.
// 개별 도식에서는 cell-size, spacing, 노드와 연결선만 전달합니다.
#let note-diagram(..args) = context {
  let style = note-style.get()
  let diagram-font = style.diagram-font
  let diagram-leading = style.diagram-leading
  let ink = style.ink
  let accent = style.accent
  let pale = style.pale
  set text(size: 8pt, font: diagram-font, fill: ink)
  set par(leading: diagram-leading)
  diagram(node-stroke: 0.8pt + accent, node-fill: pale, ..args)
}

// pintorita 0.1.4는 추정한 글자 폭과 가운데 앵커를 조합하여 멤버를 정렬합니다.
// 실제 글꼴 폭에 의존하지 않도록 클래스 본문만 왼쪽 앵커로 보정합니다.
// 제목·스테레오타입·관계 라벨의 위치는 유지합니다.
#let svg-escape(value) = value.replace("&", "&amp;").replace("\"", "&quot;").replace("<", "&lt;").replace(">", "&gt;")

#let align-uml-members(nodes) = {
  let body-origin = none
  for element in nodes {
    if (
      type(element) == dictionary
        and element.tag == "path"
        and element.attrs.at("class", default: "") == "class__section-bg"
    ) {
      // 본문 배경 경로의 첫 M 좌표가 해당 클래스의 본문 시작점입니다.
      body-origin = element.attrs.d.split(" ").at(1).split(",").map(float)
    }
  }
  nodes
    .map(element => {
      if type(element) == str { return svg-escape(element) }
      let attrs = element.attrs
      // xml()은 namespace 선언을 반환하지 않으므로 SVG 루트에 다시 붙입니다.
      if element.tag == "svg" { attrs.insert("xmlns", "http://www.w3.org/2000/svg") }
      if body-origin != none and element.tag == "text" and float(attrs.y) >= body-origin.at(1) {
        attrs.insert("x", str(body-origin.at(0) + 8))
        attrs.insert("text-anchor", "start")
      }
      let attributes = attrs.pairs().map(pair => pair.at(0) + "=\"" + svg-escape(pair.at(1)) + "\"").join(" ")
      "<" + element.tag + " " + attributes + ">" + align-uml-members(element.children) + "</" + element.tag + ">"
    })
    .join()
}

// UML 문자열은 개별 도식에서 작성하고 글꼴·색상·레이아웃은 여기에서 적용합니다.
#let uml-diagram(source, width: auto) = context {
  let style = note-style.get()
  let diagram-font = style.diagram-font
  let ink = style.ink
  let accent = style.accent
  let muted = style.muted
  let pale = style.pale
  let uml-width = style.uml-width
  let width = if width == auto { uml-width } else { width }
  let defaults = (
    "@param layoutDirection TB",
    "@param edgeType ortho",
    "@param entityBackground " + pale.to-hex(),
    "@param entityBodyBackground #ffffff",
    "@param entityBorderColor " + accent.to-hex(),
    "@param entityTextColor " + ink.to-hex(),
    "@param relationLineColor " + muted.to-hex(),
    "@param relationTextColor " + ink.to-hex(),
    "@param labelBackground #ffffff",
  ).join("\n")
  let code = source.text.replace("classDiagram", "classDiagram\n" + defaults, count: 1)
  let svg = pintorita.render-svg(code, font: diagram-font, style: "default")
  image(bytes(align-uml-members(xml(bytes(svg)))), format: "svg", width: width)
}

// sidenote(옅은 배경 + 왼쪽 강조선)와 구분되도록 색 제목 띠와 전체 테두리를 사용합니다.
#let callout(title, body, caution: false) = context {
  let style = note-style.get()
  let callout-title-gap = style.callout-title-gap
  let accent = style.accent
  let tone = if caution { rgb("#c1842a") } else { accent }
  block(width: 100%, radius: 4pt, stroke: 0.8pt + tone, clip: true)[
    #block(width: 100%, above: 0pt, below: 0pt, fill: tone,
      inset: (x: 11pt, y: callout-title-gap + 2pt))[
      #text(weight: "bold", fill: white)[#title]
    ]
    #block(width: 100%, above: 0pt, below: 0pt, inset: 11pt)[#body]
  ]
}

// 큰 코드와 도식은 본문·사이드 영역을 함께 사용합니다.
#let full-width(body) = context {
  let style = note-style.get()
  let content-width = style.content-width
  align(left, block(width: content-width, body))
}

// 종류별 색상: info는 문서의 accent/pale 설정을 따릅니다.
// note는 보충 설명, caution은 주의, example은 예제에 사용합니다.
#let sidenote-palette(kind, style) = {
  let palettes = (
    info: (accent: style.accent, fill: style.pale),
    note: (accent: rgb("#75619b"), fill: rgb("#f3eff9")),
    caution: (accent: rgb("#c1842a"), fill: rgb("#fff6e8")),
    example: (accent: rgb("#34826a"), fill: rgb("#edf7f2")),
  )
  assert(kind in palettes, message: "sidenote kind는 info, note, caution, example 중 하나여야 합니다.")
  palettes.at(kind)
}

#let sidenote-card(title, body, kind: "info") = context {
  let style = note-style.get()
  let palette = sidenote-palette(kind, style)
  block(
    width: 100%,
    inset: 8pt,
    fill: palette.fill,
    stroke: (left: 2pt + palette.accent),
  )[
    #set text(size: style.sidebar-font-size)
    #set par(leading: style.sidebar-leading, spacing: 0.6em)
    #text(weight: "bold")[#title]
    #v(5pt)
    #body
  ]
}

// 호출 위치를 기준으로 오른쪽에 배치하고, 겹침과 페이지 하단 처리는 marge에 맡깁니다.
// 사용 예: #sidenote(kind: "example")[계산 예제][예제 내용]
// kind를 생략하면 info를 사용합니다. 주의 사항은 kind: "caution"으로 지정합니다.
#let sidenote(title, body, kind: "info") = context {
  let style = note-style.get()
  let page-outer-margin = style.page-outer-margin
  let sidebar-gap = style.sidebar-gap
  let anchor = [
    #set par(leading: 0pt, spacing: 0pt)
    #marge.sidenote(
      sidenote-card(title, body, kind: kind),
      side: right,
      padding: (left: sidebar-gap, right: page-outer-margin),
      gap: 4mm,
      format: it => it.body,
    )
  ]

  // 이 호출의 끝을 표시하여 카드 내부 문단을 제외한 다음 본문 요소를 찾습니다.
  let marker-value = ("lecture-note/sidenote-end", title, body, kind)
  let markers = query(metadata.where(value: marker-value).after(here()))
  let next = if markers.len() > 0 {
    query(selector(heading).or(par).or(math.equation).or(raw).or(table)
      .after(markers.first().location()))
  } else { () }
  if next.len() > 0 and next.first().func() == heading {
    // 제목 앞에서 블록을 끼우면 앞 제목의 below와 다음 제목의 above가
    // 따로 누적됩니다. 공간을 차지하지 않는 배치로 원래 여백 병합을 보존합니다.
    place(left, anchor)
  } else {
    // 일반 본문 앞에서는 앵커 높이만 상쇄하고 다음 본문과 페이지를 함께 이동합니다.
    // height: 0pt는 카드의 배경·강조선을 지울 수 있으므로 자연 높이를 유지합니다.
    block(
      above: par.spacing,
      below: 0pt,
      inset: (bottom: -measure(sym.zwj).height),
      sticky: true,
      anchor,
    )
  }
  metadata(marker-value)
}

#let code-spaces(count) = range(count).map(_ => " ").join()

#let compact-code-indent(
  line,
  code-source-indent-size: code-source-indent-size,
  code-indent-size: code-indent-size,
  code-tab-size: code-tab-size,
) = {
  let leading = line.match(regex("^[ \t]*")).text
  let compact = leading
    .replace(code-spaces(code-source-indent-size), code-spaces(code-indent-size))
    .replace("\t", code-spaces(code-tab-size))
  compact + line.slice(leading.len())
}

#let normalize-code-snippet(
  source,
  code-source-indent-size: code-source-indent-size,
  code-indent-size: code-indent-size,
  code-tab-size: code-tab-size,
) = {
  let lines = source.replace(regex("\r\n?"), "\n").replace(regex("\n$"), "").split("\n")
  // 전처리기 지시문은 원래 1열에 표시하므로 공통 들여쓰기 계산에서 제외한다.
  let code-lines = lines.filter(line => {
    let trimmed = line.trim()
    trimmed != "" and not trimmed.starts-with("#")
  })
  let common-indent = if code-lines.len() == 0 { 0 } else {
    calc.min(..code-lines.map(line => line.match(regex("^[ \t]*")).text.len()))
  }

  let conditional-depth = 0
  let normalized = ()
  for line in lines {
    let trimmed = line.trim()
    if trimmed == "" {
      normalized.push("")
    } else if trimmed.starts-with("#") {
      if trimmed.match(regex("^#[ \t]*endif($|[ \t])")) != none {
        conditional-depth = calc.max(0, conditional-depth - 1)
      }
      normalized.push(trimmed)
      if trimmed.match(regex("^#[ \t]*(if|ifdef|ifndef)($|[ \t])")) != none {
        conditional-depth += 1
      }
    } else {
      let dedented = line.slice(calc.min(common-indent, line.len()))
      let compact = compact-code-indent(
        dedented,
        code-source-indent-size: code-source-indent-size,
        code-indent-size: code-indent-size,
        code-tab-size: code-tab-size,
      )
      normalized.push(code-spaces(conditional-depth * code-indent-size) + compact)
    }
  }
  normalized.join("\n")
}

#let code-panel(title, path) = context {
  let style = note-style.get()
  let code-font = style.code-font
  let code-leading = style.code-leading
  let code-tab-size = style.code-tab-size
  let code-source-indent-size = style.code-source-indent-size
  let code-indent-size = style.code-indent-size
  let code-title-gap = style.code-title-gap
  let accent = style.accent
  let muted = style.muted
  block(width: 100%)[
    #show raw.where(block: true): it => it
    #let source = json(path.replace(regex("\\.cpp$"), ".json"))
    #text(size: 9pt, weight: "bold", fill: accent)[#title]
    #v(3pt)
    #text(size: 8pt, font: code-font, fill: muted)[
      // 완료된 장의 발췌는 마일스톤 태그 시점의 코드이므로 태그 이름을 함께 표시한다.
      #source.source : #source.start_line–#source.end_line#if "ref" in source [ \@ #source.ref]
    ]
    #v(code-title-gap)
    #block(width: 100%, fill: rgb("#f5f7fa"), inset: 10pt, radius: 4pt)[
      #set par(spacing: 0pt, leading: code-leading)
      // 번호는 원본 C++의 줄 번호입니다. 구문 강조된 본문은 그대로 표시합니다.
      #show raw.line: it => {
        let number = text(fill: muted, str(source.start_line + it.number - 1))
        box(width: 100%, grid(
          columns: (2.8em, 1fr),
          column-gutter: 0.8em,
          align: top,
          align(right, number), it.body,
        ))
      }
      // 파일 끝의 개행 하나만 제거하여 원본에 없는 마지막 빈 줄 번호를 방지합니다.
      #let snippet = normalize-code-snippet(
        read(path),
        code-source-indent-size: code-source-indent-size,
        code-indent-size: code-indent-size,
        code-tab-size: code-tab-size,
      )
      #raw(snippet, lang: "cpp", block: true, tab-size: code-tab-size)
    ]
  ]
}

#let command-panel(title, body) = context {
  let style = note-style.get()
  let code-font = style.code-font
  let code-leading = style.code-leading
  let code-tab-size = style.code-tab-size
  let ink = style.ink
  let accent = style.accent
  let table-header = style.table-header
  let table-line = style.table-line
  block(
    width: 100%,
    stroke: 0.5pt + table-line,
    radius: 4pt,
    clip: true,
  )[
    #block(width: 100%, above: 0pt, below: 0pt, fill: table-header, inset: (x: 10pt, y: 6pt))[
      #grid(
        columns: (auto, 1fr),
        column-gutter: 7pt,
        align: horizon,
        text(font: code-font, size: 8pt, weight: "bold", fill: accent, ">_"),
        text(size: 8.5pt, weight: "semibold", fill: ink, title),
      )
    ]
    #block(width: 100%, above: 0pt, below: 0pt, fill: rgb("#f5f7fa"), inset: (x: 10pt, y: 8pt))[
      #show raw.where(block: true): it => it
      #set par(spacing: 0pt, leading: code-leading)
      #set raw(tab-size: code-tab-size)
      #show raw.line: it => box(width: 100%, grid(
        columns: (1em, 1fr),
        column-gutter: 0.5em,
        align: top,
        text(font: code-font, weight: "bold", fill: accent, "$"),
        it.body,
      ))
      #body
    ]
  ]
}

// 문서에서 필요한 항목만 lecture-note.with(...)에 지정합니다.
// 생략한 항목은 파일 상단의 기본값을 사용합니다.
// auto인 파생 설정은 이 문서에 전달된 글꼴·줄간격·너비에서 다시 계산합니다.
// 사용 예:
// #show: lecture-note.with(
//   author: "작성자 이름",    // 선택 사항: 푸터 왼쪽
//   date: datetime(year: 2026, month: 10, day: 27), // 선택 사항: 푸터 오른쪽
//   math-font: "New Computer Modern Math", // 수식 글꼴
//   body-font-size: 10pt,      // 본문 글자 크기
//   paragraph-spacing: 1.5em, // 문단 사이 여백 (본문 글자 크기 기준)
//   sidebar-width: 42mm,      // 사이드바 너비; 본문 너비는 자동으로 조정
// )
#let lecture-note(
  // 문서 정보
  title: "",     // 문서 제목: 첫 페이지·머리말·PDF 메타데이터
  chapter: "",   // 머리말의 단계 이름 (예: M01)
  subtitle: "",  // 첫 페이지와 머리말의 부제
  author: none,  // 푸터 왼쪽 작성자: 문자열·콘텐츠; none 또는 빈 값이면 숨김
  date: none,    // 푸터 오른쪽 날짜: 문자열·콘텐츠 또는 datetime (YYYY-MM-DD)
  font: auto, // 호환용 별칭: 지정하면 body-font보다 우선

  // 글꼴과 본문 크기
  body-font: body-font, // 본문 글꼴
  code-font: code-font, // 코드 글꼴
  math-font: math-font, // 수학 글꼴; 없는 글자는 본문 글꼴에서 찾음
  diagram-font: auto, // auto: code-font를 따름
  body-font-size: body-font-size, // 본문 글자 크기

  // 첫 페이지 제목 영역
  title-font-size: title-font-size, // 문서 제목의 글자 크기
  subtitle-font-size: subtitle-font-size, // 제목 아래 부제의 글자 크기
  title-block-gap: title-block-gap, // 제목·부제 영역 뒤, 본문 시작 전의 세로 여백

  // 도식
  uml-width: uml-width, // UML 도식의 기본 출력 너비

  // 본문의 줄·문단·목록 간격
  body-leading: body-leading, // 본문의 줄 사이 여백
  paragraph-spacing: paragraph-spacing, // 본문 문단 사이 여백
  medskip-size: medskip-size, // medskip()의 세로 여백
  bigskip-size: bigskip-size, // bigskip()의 세로 여백

  // 코드 내부 줄간격과 들여쓰기
  code-leading: code-leading, // 코드 내부의 줄 사이 여백
  code-tab-size: code-tab-size, // 코드 탭 하나에 해당하는 공백 수
  code-source-indent-size: code-source-indent-size, // 원본 C++ 코드의 들여쓰기 단위
  code-indent-size: code-indent-size, // 코드 패널에 표시할 들여쓰기 단위
  diagram-leading: auto, // auto: body-leading을 따름
  list-spacing: list-spacing, // 목록 항목 간격; auto는 Typst 기본값

  // 절 제목 번호와 절 제목·캡션·패널 간격
  numbering-depth: numbering-depth, // 0: 번호 없음, 1: 1단계만, 4: 4단계까지
  numbering-by-level: numbering-by-level, // 예: ("제1절", "1.1"); 생략한 단계 또는 auto는 "1.1"
  heading1-above: heading1-above, // 1단계 절 제목 위 여백
  heading1-below: heading1-below, // 1단계 절 제목 아래 여백
  heading2-above: heading2-above, // 2단계 절 제목 위 여백
  heading2-below: heading2-below, // 2단계 절 제목 아래 여백
  figure-caption-gap: figure-caption-gap, // 그림과 캡션 사이 간격
  callout-title-gap: callout-title-gap, // callout 제목 띠의 세로 여백 기준
  code-title-gap: code-title-gap, // 코드 출처와 코드 본문 사이 간격

  // 페이지와 본문·사이드바 너비
  page-width: page-width, // 페이지 전체 너비
  page-outer-margin: page-outer-margin, // 페이지 좌우 바깥 여백
  content-width: auto, // auto: page-width - 2 * page-outer-margin
  sidebar-width: sidebar-width, // 오른쪽 사이드바 너비
  sidebar-gap: sidebar-gap, // 본문과 사이드바 사이 간격
  main-width: auto, // auto: content-width - sidebar-width - sidebar-gap

  // 사이드노트 내부 글자와 줄간격
  sidebar-font-size: sidebar-font-size, // 사이드노트 글자 크기
  sidebar-leading: sidebar-leading, // 사이드노트 내부 줄간격

  // 공통 색상
  ink: ink, // 본문 기본 색
  accent: accent, // 제목·강조선 색
  muted: muted, // 부제·보조 텍스트 색
  pale: pale, // 사이드노트·도식의 옅은 배경색
  table-header: table-header, // 표와 명령 패널의 제목 배경색
  table-line: table-line, // 표·패널 테두리 색
  body,
) = {
  assert(type(numbering-depth) == int and numbering-depth >= 0,
    message: "numbering-depth는 0 이상의 정수여야 합니다.")
  assert(type(numbering-by-level) == array,
    message: "numbering-by-level은 단계별 번호 형식의 배열이어야 합니다.")
  for pattern in numbering-by-level {
    assert(pattern == auto or type(pattern) == str or type(pattern) == function,
      message: "단계별 번호 형식은 문자열, 함수 또는 auto여야 합니다.")
  }
  let font = if font == auto { body-font } else { font }
  let diagram-font = if diagram-font == auto { code-font } else { diagram-font }
  let diagram-leading = if diagram-leading == auto { body-leading } else { diagram-leading }
  let content-width = if content-width == auto { page-width - 2 * page-outer-margin } else { content-width }
  let main-width = if main-width == auto { content-width - sidebar-width - sidebar-gap } else { main-width }
  // 보조 함수에서도 같은 문서 설정을 사용하도록 전달할 값입니다.
  let style = (
    code-font: code-font,
    diagram-font: diagram-font,
    uml-width: uml-width,
    medskip-size: medskip-size,
    bigskip-size: bigskip-size,
    code-leading: code-leading,
    code-tab-size: code-tab-size,
    code-source-indent-size: code-source-indent-size,
    code-indent-size: code-indent-size,
    diagram-leading: diagram-leading,
    callout-title-gap: callout-title-gap,
    code-title-gap: code-title-gap,
    page-outer-margin: page-outer-margin,
    content-width: content-width,
    sidebar-gap: sidebar-gap,
    sidebar-font-size: sidebar-font-size,
    sidebar-leading: sidebar-leading,
    ink: ink,
    accent: accent,
    muted: muted,
    pale: pale,
    table-header: table-header,
    table-line: table-line,
  )

  // 문서 전체의 기본 서식과 페이지 구성
  set document(title: title)
  set text(font: font, size: body-font-size, lang: "ko", fill: ink)
  set par(justify: false, leading: body-leading, spacing: paragraph-spacing)
  set list(spacing: list-spacing)
  set enum(spacing: list-spacing)
  set page(
    paper: "a4",
    width: page-width,
    margin: (top: 22mm, bottom: 20mm, left: page-outer-margin, right: page-width - page-outer-margin - main-width),
    header: context align(left, block(width: content-width, {
      set text(size: 8pt, fill: muted)
      [#title #h(1fr) #chapter · #subtitle]
      v(4pt)
      line(length: 100%, stroke: 0.5pt + rgb("#d9e3ed"))
    })),
    footer: context align(left, block(width: content-width, {
      set text(size: 8pt, fill: muted)
      let has-author = author != none and author != "" and author != []
      let has-date = date != none and date != "" and date != []
      if has-author or has-date {
        let footer-date = if type(date) == datetime {
          date.display("[year]-[month]-[day]")
        } else { date }
        // 양쪽 열의 너비를 같게 하여 글자 길이에 관계없이 페이지 번호를 중앙에 둡니다.
        grid(
          columns: (1fr, auto, 1fr),
          column-gutter: 8pt,
          align: (left, center, right),
          if has-author { author } else { [] },
          counter(page).display("1"),
          if has-date { footer-date } else { [] },
        )
      } else {
        // 작성자와 날짜를 생략한 기존 문서는 원래 푸터 배치를 유지합니다.
        [#h(1fr) #counter(page).display("1")]
      }
    })),
  )
  // 본문 요소별 표시 규칙
  set heading(numbering: none)
  let numbered-headings = range(1, numbering-depth + 1).fold(
    selector(heading.where(level: 0)),
    (selected, level) => selected.or(heading.where(level: level)),
  )
  show numbered-headings: set heading(numbering: (..numbers) => {
    let levels = numbers.pos()
    let pattern = numbering-by-level.at(levels.len() - 1, default: auto)
    numbering(if pattern == auto { "1.1" } else { pattern }, ..levels)
  })
  let heading-body(it) = context {
    if it.numbering != none {
      counter(heading).display(it.numbering)
      h(0.3em)
    }
    it.body
  }
  show heading.where(level: 1): it => block(above: heading1-above, below: heading1-below, sticky: true)[
    #text(size: 18pt, weight: "bold", fill: accent)[#heading-body(it)]
  ]
  show heading.where(level: 2): it => block(above: heading2-above, below: heading2-below, sticky: true)[
    #text(size: 11pt, weight: "bold", fill: ink)[#heading-body(it)]
  ]
  // 수학 기호는 지정한 수학 글꼴을, 그 글꼴에 없는 한글 설명은 본문 글꼴을 사용합니다.
  // font: 별칭 또는 body-font:로 지정한 글꼴 목록도 그대로 반영합니다.
  show math.equation: set text(
    font: (if type(math-font) == array { math-font } else { (math-font,) })
      + (if type(font) == array { font } else { (font,) }),
  )
  // 링크의 이동 기능을 유지하면서 강조색으로 구분합니다.
  show link: set text(fill: accent)
  show raw: set text(font: code-font)
  // 인라인 코드는 기본 80% 축소를 상쇄하여 주변 본문 크기로 표시합니다.
  show raw.where(block: false): set text(size: 1em / 0.8)
  // 바깥 간격은 본문 크기에서 계산하고, 코드의 글자 크기·줄간격은 안쪽에만 적용합니다.
  show raw.where(block: true): it => context block(
    width: 100%,
    above: par.spacing.to-absolute(),
    below: par.spacing.to-absolute(),
    fill: rgb("#f5f7fa"),
    inset: 10pt,
    radius: 4pt,
  )[
    #set text(size: 7.5pt)
    #set par(leading: code-leading)
    #set block(above: 0pt, below: 0pt)
    #it
  ]
  // 모든 셀은 같은 위쪽 정렬을 사용합니다. 헤더와 첫 열은 셀을 교체하지 않고 글자만 강조합니다.
  set table(
    inset: (x: 8pt, y: 6pt),
    align: left + top,
    fill: (x, y) => if y == 0 { table-header } else { white },
    stroke: (x, y) => (
      top: if y == 0 { 0.8pt + accent } else { none },
      bottom: if y == 0 { 0.8pt + accent } else { 0.4pt + table-line },
    ),
  )
  show table.cell.where(y: 0): it => {
    set text(size: 8.8pt, weight: "semibold", fill: accent.darken(20%))
    it
  }
  show table.cell.where(x: 0): it => {
    set text(weight: "semibold", fill: if it.y == 0 { accent.darken(20%) } else { ink })
    it
  }
  set figure(gap: figure-caption-gap)
  show figure: it => full-width(it)
  show figure.caption: set text(size: 8.5pt, fill: muted)
  // 보조 함수를 배치하기 전에 현재 문서의 공유 설정을 적용합니다.
  note-style.update(style)
  full-width({
    text(size: title-font-size, weight: "bold", fill: ink)[#title]
    linebreak()
    text(size: subtitle-font-size, fill: muted)[#subtitle]
  })
  v(title-block-gap)
  body
}
