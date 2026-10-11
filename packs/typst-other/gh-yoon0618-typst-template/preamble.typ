#import "@preview/equate:0.3.3": equate
#import "@preview/mannot:0.3.1" as mannot

// 수식 강조 함수: 테두리와 수식 사이의 기본 여백을 넓힘.
// 본문에서는 `#import "preamble.typ": markrect`로 가져와 사용합니다.
#let markrect = mannot.markrect.with(
  outset: (x: .15em, y: .2em),
)

// 같은 import 문에서 함께 가져올 수 있도록 내보냅니다.
#let markul = mannot.markul
#let markhl = mannot.markhl

// 문서 전체에 적용할 공통 스타일 템플릿.
#let setup(doc) = [
  // 긴 수식의 줄바꿈을 허용합니다.
  #show: equate.with(breakable: true)

  // 수식 번호 형식.
  #set math.equation(numbering: "(1)")

  // 레이블이 없는 블록 수식에는 번호를 표시하지 않습니다.
  #show math.equation: it => {
    if it.block and not it.has("label") and it.numbering != none [
      #counter(math.equation).update(value => value - 1)
      #math.equation(it.body, block: true, numbering: none)
    ] else {
      it
    }
  }

  // 수식 참조를 `eq. (1)` 형식으로 표시합니다.
  #show ref: it => {
    if it.element != none and it.element.func() == math.equation {
      link(it.target)[eq.~#it.element.numbering]
    } else {
      it
    }
  }

  // 장·절·소절 번호 형식.
  #set heading(numbering: (..numbers) => {
    let values = numbers.pos()
    let level = values.len()

    if level == 1 {
      numbering("I.", values.at(0))
    } else if level == 2 {
      numbering("1.", values.at(1))
    } else if level == 3 {
      numbering("1.1.", values.at(1), values.at(2))
    }
  })

  // 하위 제목 들여쓰기.
  #show heading.where(level: 2): it => {
    pad(left: 1.5em)[#it]
  }

  #show heading.where(level: 3): it => {
    pad(left: 3em)[#it]
  }

  // 반드시 마지막에 본문을 배치합니다.
  #doc
]
