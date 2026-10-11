#import "../utils/font.typ": 字号, 字体
#import "@preview/i-figured:0.2.4"

#let basic-layout(doc) = {
  set bibliography(title: "参考文献", style: "gb-7714-2015-numeric")
  show bibliography: set heading(numbering: none)

  set enum(numbering: "(1)(a)")

  set figure.caption(separator: h(1em))
  show figure: i-figured.show-figure.with(
    numbering: "1-1",
    extra-prefixes: ("code": [代码]),
  )
  show figure.caption: set text(font: 字体.宋体, size: 字号.五号)
  show figure.where(kind: image): set figure(supplement: [图])
  show figure.where(kind: table): set figure(supplement: [表])
  show figure.where(kind: "code"): set figure(supplement: [代码])
  show figure.where(kind: table): set figure.caption(position: top)

  set heading(numbering: "1.1", outlined: true, supplement: [章节])

  show heading: set text(font: 字体.黑体, weight: "light")
  show heading: set par(first-line-indent: 0em)
  show heading.where(level: 1): set align(center)
  show heading.where(level: 1): set text(size: 字号.三号)
  show heading.where(level: 2): set text(size: 字号.四号)
  show heading.where(level: 3): set text(size: 字号.小四)

  show heading: it => [#counter(heading).display()#h(1em)#it.body]
  show heading.where(level: 1): it => [
    #set text(bottom-edge: "bounds")
    #pagebreak(weak: true)

    #v(2em)
    #if it.numbering == none [
      #it.body
    ] else [
      #counter(heading).display()#h(1em)#it.body
    ]
    #v(1em)
  ]

  set math.equation(supplement: [式])
  show math.equation: i-figured.show-equation.with()

  set page(paper: "a4", margin: (top: 3cm, bottom: 2cm, left: 4cm, right: 2cm))

  set pagebreak(weak: true)

  set par(first-line-indent: (amount: 2em, all: true), justify: true)
  set par(leading: 2em - 字号.小四, spacing: 2em - 字号.小四)

  set raw(theme: none)
  show raw: set text(font: "FiraCode Nerd Font")

  set text(font: 字体.宋体, size: 字号.小四)

  doc
}
