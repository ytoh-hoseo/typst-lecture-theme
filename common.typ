// 슬라이드와 강의 노트가 함께 사용하는 helper입니다.
// 테마·외부 패키지에 의존하지 않으며 직접 import해서도 사용할 수 있습니다.

// 벡터·행렬 기호: 정립 볼드.
#let bvec(it) = math.bold(math.upright(it))
#let bmat(it) = math.bold(math.upright(it))

// 간단한 테두리 박스. 호출 시 box의 옵션을 덮어쓸 수 있습니다.
#let boxed = box.with(stroke: 0.8pt, inset: 6pt)

// 수평 정렬 축약. center/left/right 내장 값과 구분하도록 h를 붙입니다.
#let hcenter(body) = align(center, body)
#let hleft(body) = align(left, body)
#let hright(body) = align(right, body)
