#import "@preview/cuti:0.2.1": show-cn-fakebold

#let sgcc-conf(title: [], author: (), doc) = {
  set page(paper: "a4", footer: context {
    let n = counter(page).get().first()
    let line = [—]
    let space = h(0.5em)
    let page-footer = text(size: 14pt)[#line#space#n#space#line]
    let one-char = text(size: 14pt)[#h(1em)]
    if calc.odd(n) {
      align(right, page-footer + one-char)
    } else {
      align(left, one-char + page-footer)
    }
  })

  show: show-cn-fakebold

  show figure.where(kind: image): set figure(supplement: [图])
  show figure.where(kind: raw): set figure(supplement: [代码])
  show figure.where(kind: table): set figure(supplement: [表])
  set figure.caption(separator: h(0.5em))

  set text(
    font: ((name: "Times New Roman", covers: "latin-in-cjk"), "FZFangSong-Z02"),
    size: 16pt,
    top-edge: "ascender",
    bottom-edge: "descender",
  )

  set par(
    first-line-indent: (amount: 2em, all: true),
    justify: true,
    leading: 12pt,
    spacing: 12pt,
  )

  show enum: e => {
    for (i, item) in e.children.enumerate() {
      let n = i + 1
      block(spacing: 12pt, [#h(2em)#n.#h(0.5em)#item.body])
    }
  }

  let h1 = counter("h1")
  let h2 = counter("h2")
  let h3 = counter("h3")
  let h4 = counter("h4")

  show heading: set text(weight: "regular")

  show heading.where(level: 1): it => {
    set text(
      font: ((name: "Times New Roman", covers: "latin-in-cjk"), "FZHei-B01"),
      size: 16pt,
    )
    h1.step()
    h2.update(0)
    h3.update(0)
    h4.update(0)
    block(
      spacing: 12pt,
    )[#par(
      first-line-indent: (amount: 2em, all: true),
    )[#context h1.display("一、")#it.body]]
  }

  show heading.where(level: 2): it => {
    set text(
      font: ((name: "Times New Roman", covers: "latin-in-cjk"), "FZKai-Z03"),
      size: 16pt,
    )
    h2.step()
    h3.update(0)
    h4.update(0)
    block(
      spacing: 12pt,
    )[#par(
      first-line-indent: (amount: 2em, all: true),
    )[#context h2.display("（一）")#it.body]]
  }

  show heading.where(level: 3): it => {
    set text(
      font: ((name: "Times New Roman", covers: "latin-in-cjk"), "FZFangSong-Z02"),
      size: 16pt,
    )
    h3.step()
    h4.update(0)
    block(
      spacing: 12pt,
    )[#par(
      first-line-indent: (amount: 2em, all: true),
    )[#context h3.display("1. ")#it.body]]
  }

  show heading.where(level: 4): it => {
    set text(
      font: ((name: "Times New Roman", covers: "latin-in-cjk"), "FZFangSong-Z02"),
      size: 16pt,
    )
    h4.step()
    block(
      spacing: 12pt,
    )[#par(
      first-line-indent: (amount: 2em, all: true),
    )[#context h4.display("（1）")#it.body]]
  }

  align(center)[
    #v(22pt)
    #text(size: 22pt, font: "FZXiaoBiaoSong-B05")[#title]
    #if author.len() > 0 {
      [#parbreak()#text(size: 16pt)[#author.at(0)]]
    } else []
    #v(22pt)
  ]

  doc
}
