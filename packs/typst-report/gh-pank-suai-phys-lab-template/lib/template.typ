#let gost(body) = {
  set text(
    font: "Times New Roman",
    size: 14pt,
    lang: "ru",
    region: "ru",
    hyphenate: true,
  )
  set par(justify: true, first-line-indent: (amount: 1.25cm, all: true))
  set heading(numbering: "1.")
  show heading: it => pad(left: 1.25cm, it)
  show heading: set par(leading: 1.2em)

  show heading: set text(size: 14pt)

  counter(page).update(3)
  set page(margin: (top: 20mm, bottom: 20mm, left: 20mm, right: 20mm), number-align: center + top, numbering: "1")
  

  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: table): it => {

    align(right)[
      #emph([#it.caption.supplement #it.caption.counter.display()])
    ]
    align(center)[
      #strong(it.caption.body)
    ]
    set text(size: 12pt)
    it.body
  }
  show figure.caption: it => emph(it)

  set list(indent: 1.25cm, marker: [--])

  //set math.equation(numbering: "(1)")
  //show figure: set block(breakable: true)

  show ref: it => {
    let eq = math.equation
    let el = it.element
    if el != none and el.func() == eq {
      // Override equation references.
      link(
        el.location(),
        numbering(el.numbering, ..counter(eq).at(el.location())),
      )
    } else {
      // Other references as usual.
      it
    }
  }

  body
}
