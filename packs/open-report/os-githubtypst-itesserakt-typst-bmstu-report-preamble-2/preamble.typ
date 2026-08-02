#let conf(doc) = {
  let par_indent = 1.25cm

  set page(
    paper: "a4", 
    margin: (left: 3cm, right: 1.5cm, top: 2cm, bottom: 2cm),
    numbering: "1",
    number-align: center + bottom
  )
  
  set text(
    font: "Times New Roman",
    size: 14pt,
    lang: "ru"
  )

  show raw: set text(font: "Fira Code")
  
  set par(
    justify: true,
    linebreaks: "optimized",
    first-line-indent: (amount: par_indent, all: true),
    spacing: 1em,
    leading: 0.75em,
  )

  set heading(numbering: "1.1", outlined: true, supplement: "Раздел")
  show heading: it => {
    set text(size: if it.depth == 1 { 16pt } else { 14pt })
    set par(justify: false)
    set block(above: 2em, below: 1.5em, breakable: false)
    it
  }

  set list(marker: [--], indent: par_indent)
  set enum(indent: par_indent, numbering: "1)")
  set math.equation(numbering: "(1)")
  show figure.where(kind: raw): set figure(supplement: "Листинг")
  show figure.where(kind: raw): set block(width: 100%)

  set figure(supplement: "Рисунок")
  set figure.caption(separator: [ -- ])
  show figure.where(kind: table): set figure(supplement: "Таблица")
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: raw): set figure.caption(position: top)
  show figure.where(kind: table): set block(width: 100%)
  show figure: set block(breakable: false)
  show figure.caption: it => {
    set par(leading: 0.5em)
    set par(spacing: 0.5em)
    if it.kind == table {
      let n = counter(figure.where(kind: table)).at(here())
      let number = numbering(it.numbering, ..n)
      align(right + top)[
        #it.supplement #number

        #it.body
      ]
    }
    else if it.kind == raw {
      let n = counter(figure.where(kind: raw)).at(here())
      let number = numbering(it.numbering, ..n)
      align(right + top)[
        #it.supplement #number

        #it.body
      ]
    } else {
      it
    }
  }

  set table.header(repeat: false)
  set table(align: left + top)
  show table.cell.where(y: 0): set text(weight: "bold")

  show math.equation.where(block: true): set par(spacing: 2em)
  // Автоматическая нумерация используемых формул
  show math.equation.where(block: true): it => if (
    it.numbering != none and (not it.has("label") or query(ref.where(target: it.label)).len() == 0)
  ) [
    #counter(math.equation).update(v => calc.max(0, v - 1))
    #math.equation(it.body, block: true, numbering: none)
  ] else {
    it
  }

  // Именование рисунков и таблиц не учитывает падеж
  show ref.where(form: "normal"): set ref(supplement: it => {
    if it.func() == figure {
      if it.kind == image {
        return "рис. "
      } else if it.kind == table {
        return "табл."
      }
    }
    it.supplement
  })
  
  [#doc]
}
