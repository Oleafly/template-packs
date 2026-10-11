#import "../style.typ": zihao
#import "@preview/cuti:0.4.0": show-cn-fakebold
#import "@preview/itemize:0.2.0" as el
#import "@preview/numbly:0.1.0": numbly

#let doc(
  info: (:),
  doctype: "midterm",
  ziti: (:),
  it,
) = {
  show figure: set align(center)
  show table: set align(center)
  show figure.caption: set par(leading: 10pt, justify: false)

  set heading(numbering: numbly(
    "{1}、",
    "{1}.{2} ",
    "{1}.{2}.{3} ",
    "{1}.{2}.{3}.{4} ",
  ))
  set heading(hanging-indent: 1.5em)
  show heading: it => {
    show h.where(amount: 0.3em): none
    it
  }
  show heading.where(level: 1): set block(above: 2.5em, below: 1.5em)
  show heading.where(level: 2): set block(above: 2em, below: 1.5em)
  show heading.where(level: 3): set block(above: 1.75em, below: 1.5em)
  show heading.where(level: 4): set block(above: 1.5em, below: 1.5em)
  show heading.where(level: 1): set text(
    font: ziti.fangsong,
    weight: if doctype == "proposal" { "bold" } else { "regular" },
    size: zihao.xiaosi,
    top-edge: 3pt,
  )
  show heading.where(level: 2): set text(font: ziti.kaiti, size: zihao.xiaosi)
  set page(margin: (x: if doctype == "proposal" { 2.8cm } else { 2.6cm }, y: 2.5cm))
  set text(hyphenate: false, font: ziti.songti, lang: "zh")
  set par(leading: 1em)
  show: el.default-enum-list
  set enum(body-indent: 1em)
  show: show-cn-fakebold
  show bibliography: set par(hanging-indent: 0em)
  show math.equation: set text(font: ziti.math)
  show raw: set text(font: ziti.dengkuan)

  set document(
    title: info.title,
    author: info.name,
  )

  it
}
