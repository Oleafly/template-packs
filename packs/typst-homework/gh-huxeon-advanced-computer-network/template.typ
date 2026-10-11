#import "@preview/pointless-size:0.1.2": zh
#import "@preview/numbly:0.1.0": numbly

#let font-sun = ((name: "Times New Roman", covers: "latin-in-cjk"), "SimSun")
#let font-hei = ((name: "Times New Roman", covers: "latin-in-cjk"), "SimHei")
#let font-math = ("Cambria Math", "SimSun")

#let S = h(0.25em, weak: true)
#let D = h(-2em, weak: true)

#let mark1(n) = numbering("（1）", n)
#let mark2(n) = numbering("1）", n)
#let mark3(n) = numbering("\u{2460} ", n)
#let mark4(n) = numbering("[1] ", n)

#let doc(
  bibliography: content,
  appendix: none,
  body,
) = {
  set par(
    first-line-indent: (amount: 2em, all: true),
    leading: 1.5em,
    spacing: 1.5em,
    justify: true,
  )
  set std.bibliography(style: "gb-7714-2015-numeric")
  set text(lang: "zh", region: "cn", font: font-sun, size: zh(5))

  align(center, {
    set page(numbering: "I")
    show heading.where(level: 1): set text(font: font-hei, size: zh(3))

    outline(indent: 2em, depth: 3)
    pagebreak(weak: true)

    outline(title: [插图清单], target: figure.where(kind: image))
    pagebreak(weak: true)

    outline(title: [附表清单], target: figure.where(kind: table))
    pagebreak(weak: true)
  })

  set heading(numbering: "1.1")
  show heading: set text(font: font-hei, size: zh(5))
  show heading: set block(above: 1.5em + 6pt, below: 1.5em + 6pt)
  show heading.where(body: [引言]): set heading(numbering: none)

  show figure.caption: set text(font: font-hei, size: zh(5))
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: table): set text(font: font-sun, size: zh(5.5))
  show table: set par(leading: 0.65em)
  set table(align: center + horizon, stroke: 0.5pt)

  set math.equation(numbering: "公式（1）")
  show math.equation: set text(font: font-math, size: zh(5))

  set page(numbering: "1")
  counter(page).update(1)

  body

  pagebreak(weak: true)
  bibliography
  pagebreak(weak: true)

  if appendix != none {
    show heading.where(level: 1): it => {
      pagebreak(weak: true)
      it
    }
    set heading(numbering: "附录A")

    counter(heading).update(0)

    appendix
  }
}
