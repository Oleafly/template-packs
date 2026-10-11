// ---------------------------------------------------------------
// Corporate report template — typst-report-template
// Usage: #import "template.typ": report
//        #show: report.with(title: "...", subtitle: "...", authors: (...), date: datetime.today(), lang: "fr")
// ---------------------------------------------------------------

#let accent = rgb("#1a5276")
#let accent-light = rgb("#d6eaf8")
#let text-col = rgb("#212f3d")
#let muted = rgb("#5d6d7e")

#let heading-font = "New Computer Modern"
#let body-font = "New Computer Modern"

#let styled-heading(num) = {
  set text(fill: accent)
  block(above: 1.6em, below: 1em)[
    #grid(
      columns: (auto, 1fr),
      column-gutter: 0.7em,
      align: (center + horizon, left + horizon),
      place(center)[#box(width: 1.9em, height: 1.9em, fill: accent, radius: 0.25em)[
        #place(center + horizon)[#text(fill: white, weight: "bold", size: 0.9em)[#num]]
      ]],
      text(size: 1.35em, weight: "bold", fill: accent)[#num.body],
    )
  ]
}

#let report(..args) = {
  // In this Typst version the show-rule content arrives via rest args.
  let doc = args.pos().first()
  let title = args.named().title
  let subtitle = args.named().at("subtitle", default: "")
  let authors = args.named().at("authors", default: ())
  let date = args.named().at("date", default: datetime.today())
  let lang = args.named().at("lang", default: "fr")
  set page(
    paper: "a4",
    margin: (top: 2.6cm, bottom: 2.6cm, x: 2.2cm),
    numbering: "1 / 1",
    number-align: center,
    header: context {
      if counter(page).get().first() > 1 {
        set text(size: 0.75em, fill: muted)
        grid(
          columns: (1fr, auto),
          align: (left, right),
          title,
          context counter(page).display("1"),
        )
        v(-0.5em)
        line(length: 100%, stroke: 0.5pt + accent-light)
      }
    },
  )
  set text(font: body-font, size: 10.5pt, fill: text-col, lang: lang)
  set par(justify: true, leading: 0.62em)
  set heading(numbering: "1.1")
  set list(indent: 1em)
  set enum(indent: 1em)

  // ---- Cover page (no header/footer) ----
  set page(header: none, footer: none, numbering: none)
  set text(lang: lang)
  {
    place(center + horizon)[
      #block(width: 100%)[
        #v(2.5em)
        #place(center)[#rect(width: 100%, height: 2.2em, fill: accent, radius: 0.1em)]
        #v(5em)
        #place(center)[#text(size: 26pt, weight: "bold", fill: accent)[#title]]
        #if subtitle != "" [#v(0.8em) #place(center)[#text(size: 13pt, fill: muted)[#subtitle]]]
        #v(8em)
        #if authors.len() > 0 [
          #place(center)[
            #text(size: 10.5pt)[
              #authors.map(a => a.name + if "role" in a [ — #a.role]).join(linebreak())
            ]
          ]
        ]
        #v(1.2em)
        #place(center)[#text(size: 10.5pt, fill: muted)[#if lang == "fr" { date.display("[day] [month repr:long] [year]") } else { date.display("[month repr:long] [day], [year]") }]]
        #v(6em)
        #place(center)[#line(length: 40%, stroke: 2pt + accent)]
      ]
    ]
  }

  // ---- TOC page ----
  set page(header: none, numbering: "1", footer: context align(center)[
    #text(size: 0.75em, fill: muted)[#counter(page).display("1")]
  ])
  set heading(numbering: none)
  counter(page).update(1)
  text(size: 16pt, weight: "bold", fill: accent)[
    #if lang == "fr" [Sommaire] else [Table of contents]
  ]
  v(1em)
  outline(title: none, indent: 1em)

  // ---- Body ----
  pagebreak()
  counter(page).update(1)
  set heading(numbering: "1.1")
  show heading.where(level: 1): it => { pagebreak(weak: true); styled-heading(it) }
  show heading.where(level: 2): it => {
    set text(fill: text-col)
    block(above: 1.4em, below: 0.8em)[#text(size: 1.15em, weight: "semibold")[#it]]
  }
  show heading.where(level: 3): it => {
    set text(fill: muted)
    block(above: 1.2em, below: 0.6em)[#text(size: 1.05em, weight: "medium")[#it]]
  }
  show figure.caption: it => {
    set text(size: 0.85em, fill: muted)
    it
  }
  show table: set text(size: 0.9em)
  show raw: set text(size: 0.85em)

  doc
}

// Styled table helper: zebra rows, accent header.
// Usage: #fancy-table((headers..), ((row1..), (row2..), ...))
#let fancy-table(headers, rows) = {
  let header-row = table.header(
    repeat: true,
    table.cell(fill: accent)[#text(fill: white, weight: "bold")[#headers.enumerate().map(((i, h)) => table.cell(align: if i == 0 { left } else { center }, [#h]))]],
  )
  let body-rows = rows.enumerate().map(((i, row)) =>
    row.enumerate().map(((j, cell)) =>
      table.cell(
        fill: if calc.odd(i) { accent-light.lighten(50%) } else { white },
        inset: (y: 0.55em, x: 0.8em),
        align: if j == 0 { left } else { center },
        [#cell],
      )
    ).flatten()
  ).flatten()
  table(columns: headers.len(), stroke: none, header-row, ..body-rows)
}
