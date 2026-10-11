// 본문에서 사용하는 수학·도식 패키지.
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge
#import "@preview/physica:0.9.8": *
#import "@preview/quill:0.7.3": *

// 공통 프리앰블과 강조 함수를 가져옵니다.
#import "preamble.typ": setup, markrect, markul, markhl

#let doc-title = [문서 제목]
#let doc-author = "작성자"

// PDF 메타데이터.
#set document(
  title: doc-title,
  author: doc-author,
  keywords: ("Typst", "수학", "문서"),
)

// preamble.typ의 set/show 규칙을 문서 전체에 적용합니다.
#show: setup

// 표지.
#align(center)[
  #text(size: 20pt, weight: "bold")[#doc-title]

  #v(0.8em)

  #doc-author
]

#pagebreak()
#outline(title: [목차])
#pagebreak()

= 서론

문서의 목적과 범위를 작성합니다.

== 배경

필요한 배경과 문제 설정을 작성합니다.

= 본문

== 수식

레이블이 없는 블록 수식에는 번호가 붙지 않습니다.

$
  E = m c^2
$

레이블이 있는 블록 수식에는 번호가 붙습니다.

$
  a^2 + b^2 = c^2
$ <eq:pythagoras>

@eq:pythagoras 를 참조할 수 있습니다.

인라인 수식 강조 예시: $markrect(x + y)$

== 도식과 추가 내용

필요에 따라 `fletcher`, `physica`, `quill`의 기능을 사용합니다.

= 결론

핵심 결과와 향후 작업을 정리합니다.
