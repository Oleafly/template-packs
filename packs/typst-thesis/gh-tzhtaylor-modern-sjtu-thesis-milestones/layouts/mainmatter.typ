#import "../style.typ": zihao
#import "../figurex.typ": preset
#import "@preview/i-figured:0.2.4"

#let mainmatter(
  doctype: "midterm",
  ziti: (:),
  it,
) = {
  set page(footer: context [
    #set align(center)
    #set text(zihao.xiaowu, weight: "bold")
    #counter(page).display(
      "1 / 1",
      both: true,
    )
  ])
  counter(page).update(1)
  set par(justify: false)

  show: preset

  show heading: i-figured.reset-counters.with(extra-kinds: (
    "image",
    "image-en",
    "table",
    "table-en",
    "algorithm",
    "algorithm-en",
  ))
  show figure: i-figured.show-figure.with(
    extra-prefixes: (image: "img:", algorithm: "algo:"),
    numbering: "1.1",
    level: if doctype == "proposal" { 1 } else { 0 },
  )
  set figure.caption(separator: [#h(1em)])
  show figure.caption: it => {
    set text(size: zihao.wuhao, weight: "bold")
    it
  }
  show figure: set text(size: zihao.wuhao)
  show figure.where(kind: "table"): set figure.caption(position: top)
  show figure.where(kind: "table-en"): set figure.caption(position: top)
  show figure.where(kind: "algorithm"): set figure.caption(position: top)
  show figure: set block(breakable: true)
  show figure.where(kind: "image"): set block(sticky: true)
  show figure.where(kind: "image-en"): set block(sticky: true)
  let xubiao = state("xubiao")

  show table: set text(size: zihao.wuhao, weight: "regular")
  show table: set par(leading: 14pt)
  set table(stroke: (x, y) => {
    if y == 0 {
      none
    } else {
      none
    }
  })
  show table: it => xubiao.update(false) + it

  set math.equation(supplement: [公式])
  show math.equation: i-figured.show-equation.with(numbering: "(1.1)", level: if doctype == "proposal" { 1 } else { 0 })

  show figure.where(kind: "subimage"): it => {
    if it.kind == "subimage" {
      let q = query(figure.where(outlined: true).before(it.location())).last()
      [
        #figure(
          it.body,
          caption: it.counter.display("(a)") + " " + it.caption.body,
          kind: it.kind + "_",
          supplement: it.supplement,
          outlined: it.outlined,
          numbering: "(a)",
          gap: 1em,
        )#label(str(q.label) + ":" + str(it.label))
      ]
    }
  }

  show figure.where(kind: "subimage-en"): it => {
    if it.kind == "subimage-en" {
      let q = query(figure.where(outlined: true).before(it.location())).last()
      [
        #figure(
          it.body,
          caption: if it.caption != none { it.counter.display("(a)") + " " + it.caption.body } else { none },
          kind: it.kind + "_",
          supplement: it.supplement,
          outlined: it.outlined,
          numbering: "(a)",
          gap: 1em,
        )
      ]
      v(0.5em)
    }
  }

  show cite: set text(font: "Times New Roman")
  show smartquote: set text(font: "Times New Roman")
  set text(font: ziti.kaiti, size: zihao.xiaosi)
  show heading: set par(leading: 1em)
  set par(
    leading: 1.25em,
    first-line-indent: (amount: 2em, all: true),
    spacing: 1.25em,
    justify: true,
  )
  set list(indent: 1em, body-indent: 0.65em)
  set enum(indent: 0.83em, body-indent: 0.45em)

  it
}
