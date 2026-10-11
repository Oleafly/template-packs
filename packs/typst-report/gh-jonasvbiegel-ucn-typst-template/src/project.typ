#import "@preview/hydra:0.6.1": hydra
#import "@preview/zebraw:0.5.5": *
#import "@preview/cetz:0.4.2"

#let project(
  title: "Ingen titel",
  subtitle: "Ingen undertitel",
  authors: ("Forfatter 1", "Forfatter 2", "Forfatter 3"),
  supervisors: ("Vejleder 1", "Vejleder 2"),
  theme: "Tema",
  projectperiod: "Periode",
  group-number: "Gruppenummer",
  rev-number: 1,
  resume: lorem(100),
  characters: 0,
  repository: "https://github.com/jonasvbiegel/ucn-typst-template",
  body,
) = {
  set text(lang: "da", size: 12pt, font: "Palatino Linotype")

  set align(center + horizon)

  set page(fill: rgb("#eef3f4"))

  set text(fill: rgb("#ffffff"), size: 14pt)

  box(width: 70%, height: 15%, fill: rgb("#004251"), outset: 40pt)[
    #text(weight: "bold", size: 24pt)[#{ title }]
    #v(-10pt)
    #{ subtitle }

    #text(size: 15pt)[
      #{ authors }.join(", ", last: " & ")\
    ]

    #let today = datetime.today()

    #text(size: 12pt)[#{ today }.display("[day]/[month]-[year]")]

    #{ theme }
  ]

  v(250pt)

  image("UCN-hovedlogo.svg")

  set align(start + top)

  set page(fill: rgb("#ffffff"))

  set text(fill: rgb("#000000"), size: 12pt)

  let info = (
    [*Titel:*\ #{ title }],
    [*Tema*:\ #{ theme }],
    [*Projektperiode:*\ #{ projectperiod }],
    [*Projektgruppe:*\ #{ group-number }],
    if (authors.len() == 1) {
      [*Deltager:*\ #{ authors }.join()]
    } else {
      [*Deltagere:*\ #{ authors }.join(" " + linebreak())]
    },
    if (supervisors.len() == 1) {
      [*Vejleder:*\ #{ supervisors.join() }]
    } else {
      [*Vejledere:*\ #supervisors.join(" " + linebreak())]
    },
    [*Oplagstal:* #{ rev-number }],
    [*Sidetal:* #str(calc.round(characters / 2400, digits: 1)) sider af #str(calc.trunc(characters)) anslag],
    [*Repository:*\ #link({ repository })],
    [*Afleveringsdato:*\ #datetime.today().display("[day]/[month]-[year]")],
  )

  set align(start + top)

  set page(fill: rgb("#ffffff"))

  set text(fill: rgb("#000000"), size: 12pt, hyphenate: false)

  page(
    grid(
      columns: (1fr, 1fr),
      rows: (3fr, 7fr, 30pt),
      column-gutter: 10pt,
      image("UCN-hovedlogo-simple.svg", width: 80%),
      align(right + horizon)[
        #strong[Afdeling]\
        Professionshøjskolen UCN\
        #link("www.ucn.dk")
      ],

      grid(gutter: 16pt, ..info),
      [*Resumé*\ #box(width: 100%, stroke: .5pt, inset: 4pt, resume)],
    ),
  )

  show outline.entry.where(level: 1): set block(above: 1.2em)

  show outline.entry.where(level: 2): set block(above: 0.8em)

  outline(depth: 3)
  counter(page).update(0)

  set page(
    // standard page with header
    paper: "a4",
    margin: (top: 3.6cm, left: 2.2cm, right: 2.2cm, bottom: 3cm),
    header: context {
      grid(
        columns: (1fr, 1fr),
        align: (left, right),
        row-gutter: 0.5em,
        text(size: 11pt, context {
          hydra(1, use-last: false, skip-starting: false)
        }),
        text(size: 11pt, number-type: "lining", {
          counter(page).display("1")
        }),
        grid.cell(colspan: 2, line(length: 100%, stroke: 0.5pt)),
      )
    },
    header-ascent: 1.5em,
  )

  set figure(numbering: it => {
    let count = counter(heading.where(level: 1)).get().first()
    if count > 0 {
      numbering("1.1", count, it)
    }
  })

  show heading.where(level: 1): it => {
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: raw)).update(0)
    counter(math.equation).update(0)
    it
  }

  show figure.caption: it => {
    set text(size: 11pt)
    block(it)
  }

  show figure.where(kind: table): set figure.caption(position: top)

  show figure: f => { [#v(5pt) #f #v(5pt) ] }

  set par(first-line-indent: 0em, spacing: 1em, justify: true)

  set heading(numbering: "1.")
  show heading: set text(weight: "regular")

  let body-size = 12pt

  show heading.where(level: 1): it => {
    (
      v(3.8 * body-size, weak: true)
        + block(it, height: 2 * body-size, sticky: true)
    )
  }
  show heading.where(level: 2): it => {
    v(0.8 * body-size) + block(it, height: 1.2 * body-size, sticky: true)
  }
  show heading.where(level: 3): it => {
    v(0.8 * body-size) + block(it, height: 1 * body-size, sticky: true)
  }

  show raw.where(block: true): set align(center)
  show raw.where(block: true): set text(font: "Fira Code")
  show raw: t => (text(font: "Fira Code", t))

  show raw.where(block: true): block.with(
    fill: luma(240),
    inset: 10pt,
    radius: 4pt,
  )

  show: zebraw.with(..zebraw-themes.zebra-reverse)
  show: t => zebraw(lang: false, block-width: 50pt, indentation: 4, t)

  show math.equation: set text(14pt)

  set math.equation(numbering: it => {
    let count = counter(heading.where(level: 1)).get().first()
    if count > 0 {
      numbering("(1.1)", count, it)
    }
  })

  show heading.where(level: 1, outlined: true): it => {
    pagebreak()
    it
  }

  body

  bibliography("../bibliography.bib")
}
