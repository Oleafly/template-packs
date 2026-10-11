#let header-content = {
  grid(
    columns: (auto, 1fr, auto),
    grid.cell(align: left)[
      #context {
        if counter(page).get().first() != 1 {
          document.title
        }
      }
    ],
    grid.cell(align: center)[],
    grid.cell(align: right)[
      #context [
        #if document.date != none {
          document.date.display("[day].[month].[year]")
        }
      ]
    ],
  )
}

#let footer-content = {
  grid(
    columns: (auto, 1fr, auto),
    grid.cell(align: left)[],
    grid.cell(align: center)[
      #context counter(page).display("1 / 1", both: true)
    ],
    grid.cell(align: right)[],
  )
}

#let leading = 0.65em

#let template(body) = {
  // document
  set page(
    paper: "a4",
    header: header-content,
    footer: footer-content,
    margin: (x: 2cm, y: 2.5cm),
  )

  // page breaking
  show par: it => block(breakable: false, it)
  show list: it => block(above: leading, below: leading, breakable: false, it)
  show heading: it => block(sticky: true, it)

  // line breaking
  show regex(" …"): [~…] // don't linebreak before "…"

  // text
  set text(font: "Catamaran")
  set par(
    justify: true,
    leading: leading,
    spacing: 1.2em,
    linebreaks: "optimized",
  )

  // other
  set list(marker: "•")
  set line(length: 100%)

  body
}
