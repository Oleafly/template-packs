#let Theme = (
  fonts: (
    main: "STIX Two Text",
    sans: "Noto Sans",
    mono: "Fira Code",
    math: "STIX Two Math",
  ),
  colors: (
    primary: rgb("#00707f"),
    secondary: rgb("#5fa4b0"),
    accent: rgb("#CC0033"),
    warning: rgb("#F6A800"),
    text-light: rgb("#8c8b82"),
  ),
)

#let code-stroke-color = rgb("#d0d7de")
#let code-bg-color = rgb("#f6f8fa")

#let HEPLColors = (
  beige-super-pale:   rgb("#e8e8e3"),
  rouge-prv:          rgb("#CC0033"),
  jaune-prv:          rgb("#F6A800"),
  jaune-fonce-hepl:   rgb("#be7f00"),
  bleu-hepl:          rgb("#0080a0"),
  bleu-clair-hepl:    rgb("#8abcc8"),
  bleu-clair-darker-hepl: rgb("#294e57"),
  bleu-fonce-hepl:    rgb("#002b4f"),
)

#let Uliege = (
  TealDark:  rgb(000, 112, 127),
  TealLight: rgb(095, 164, 176),
  BeigeLight: rgb(232, 226, 222),
  BeigePale:  rgb(230, 230, 225),
  BeigeDark:  rgb(198, 192, 180),
  Yellow:        rgb(255, 208, 000),
  OrangeLight:   rgb(248, 170, 000),
  OrangeDark:    rgb(240, 127, 060),
  Red:           rgb(230, 045, 049),
  GreenPale:     rgb(185, 205, 118),
  GreenLight:    rgb(125, 185, 040),
  Green:         rgb(040, 155, 056),
  GreenDark:     rgb(000, 132, 059),
  BlueLight:     rgb(031, 186, 219),
  BlueDark:      rgb(000, 092, 169),
  LavenderDark:  rgb(091, 087, 162),
  LavenderLight: rgb(141, 166, 214),
  PurpleLight:   rgb(168, 088, 158),
  PurpleDark:    rgb(091, 037, 125),
  GrayDark:      rgb(140, 139, 130),
  GrayLight:     rgb(181, 180, 169),
)

#let academic-year(date) = {
  let y = date.year()
  if date.month() < 9 {
    [Année académique #(y - 1) -- #y]
  } else {
    [Année académique #y -- #(y + 1)]
  }
}

#let heading-level-style(body, level) = {
  let sizes = (
    "1": 1.15em,
    "2": 1.08em,
    "3": 1.03em,
  )
  let weights = (
    "1": "semibold",
    "2": "semibold",
    "3": "regular",
  )
  let l = str(level)
  text(
    font: Theme.fonts.sans,
    fill: Uliege.TealDark,
    weight: weights.at(l, default: "semibold"),
    size: sizes.at(l, default: 0.95em),
  )[#body]
}

#let note(body) = block(
  fill: Uliege.TealDark.lighten(90%),
  inset: 1em,
  radius: 4pt,
)[
  *Note:* #body
]

#let full-title-page(
  main-title,
  sub-title,
  authors,
  date,
) = {
  let authors-content = authors.map(author => [
    #author.first-name #smallcaps(author.last-name)  \
    #author.cursus \
    #if author.at("specialty", default: none) != none [#author.specialty] \
    \
  ])
  page(
    margin: (x: 2.5cm, top: 2cm, bottom: 2cm),
    background: [
      #place(top + left, dx: -1.5cm, dy: -1cm, rotate(15deg, polygon.regular(fill: HEPLColors.bleu-hepl, size: 5cm, vertices: 6)))
      #place(top + left, dx: 3cm, dy: 25cm, rotate(-10deg, circle(radius: 1.5cm, fill: HEPLColors.rouge-prv)))
      #place(top + right, dx: -1cm, dy: 0pt, rotate(20deg, polygon.regular(fill: HEPLColors.jaune-prv, size: 3cm, vertices: 5)))
      #place(bottom + left, dx: 0pt, dy: 1cm, rotate(-15deg, circle(radius: 2cm, fill: HEPLColors.bleu-clair-hepl)))
      #place(bottom + right, dx: -1.5cm, dy: 1cm, rotate(10deg, polygon.regular(fill: HEPLColors.bleu-fonce-hepl, size: 2.8cm, vertices: 4)))
      #place(bottom + right, dx: 2.5cm, dy: 0pt, rotate(-5deg, circle(radius: 1.2cm, fill: HEPLColors.rouge-prv.lighten(30%))))
    ]
  )[
    #align(center + top)[
      #v(1cm)
      #image("figures/g2.svg", height: 3cm)
      #v(0.8em)
      #text(size: 0.9em, fill: HEPLColors.bleu-fonce-hepl)[#academic-year(date)]
      #v(2cm)
      #text(size: 2em, fill: HEPLColors.bleu-fonce-hepl, weight: "bold")[#main-title]
      #v(0.3em)
      #text(size: 1.5em, fill: HEPLColors.bleu-clair-darker-hepl, weight: "medium")[#sub-title]
      #v(10cm)
      #stack(dir: ttb, ..authors-content)
    ]
  ]
  pagebreak()
}

#let project(
  main-title: "This is the main title",
  sub-title: "Sub-Title of the document",
  fullTitlePage: false,
  abstract: none,
  authors: (),
  thanks: (),
  date: datetime.today(),
  paper-size: "a4",
  bibliography-file: none,
  annex: none,
  binding: true,
  body,
) = {
  import "@preview/codly:1.3.0": *
  import "@preview/codly-languages:0.1.1": *
  show: codly-init.with()
  codly(
    languages: codly-languages,
    stroke: 1pt + code-stroke-color,
    radius: 4pt,
    fill: code-bg-color,
    display-icon: false,
  )

  set document(
    author: authors.map(a => a.first-name + " " + a.last-name),
    title: sub-title,
    keywords: (
      "HEPL",
      "Research",
      "Report",
    ),
  )

  let left-margin = if binding { 3.5cm } else { 2.5cm }
  let page-header = context {
    let headings = query(selector(heading).before(here()))
    if headings.len() == 0 { return none }
    let levels-shown = (1, 2)
    let max-level = calc.max(..levels-shown)
    set text(font: Theme.fonts.sans, fill: Uliege.GrayDark, size: 0.9em)
    grid(
      columns: (1fr, auto),
      column-gutter: 1em,
      align(left, [
        #counter(selector(heading).before(here())).display(
          (..nums) => nums
            .pos()
            .slice(0, calc.min(max-level, nums.pos().len()))
            .map(str)
            .join(".")
        )
        #h(0.25em)
        #levels-shown.map((i) => {
          let at-level = headings.filter(h => h.level == i)
          if at-level.len() == 0 { return none }
          at-level.last().body
        })
        .filter(it => it != none)
        .join([ --- ])
      ]),
      align(right, if page.numbering != none { counter(page).display(page.numbering) }),
    )
  }
  set page(
    paper: paper-size,
    margin: (left: left-margin, right: 2.5cm, top: 1.5cm, bottom: 1.5cm),
    header-ascent: 35%,
    header: page-header,
  )

  let font-size = 11pt
  let code-size = 9pt
  set text(
    font: Theme.fonts.main,
    size: font-size,
    lang: "fr",
    number-type: "lining",
    number-width: "tabular",
  )
  show raw: set text(font: Theme.fonts.mono, size: code-size)
  show raw.where(block: true): set text(size: 0.92em)
  set raw(tab-size: 4)
  set text(hyphenate: true)

  show math.equation: set text(font: Theme.fonts.math)
  set math.equation(numbering: "(1.1)")

  set par(
    leading: 0.75em,
    spacing: 1.2em,
    justify: true,
    justification-limits: (
      tracking: (min: -0.012em, max: 0.012em),
      spacing: (min: 75%, max: 120%),
    ),
  )

  set heading(numbering: "1.1")
  show heading: it => {
    heading-level-style(it, it.level)
    v(0.2em)
  }

  set figure(numbering: "1.1")

  show footnote: set text(size: 0.85em, fill: Uliege.GrayDark)

  show link: it => {
    set text(fill: Uliege.BlueDark)
    it
  }

  show bibliography: set text(0.9em)
  show bibliography: set par(hanging-indent: 1.5em, spacing: 0.9em)

  if fullTitlePage {
    full-title-page(main-title, sub-title, authors, date)
  } else {
    let size = 2.2em
    let extra-authors = if authors.len() > 3 { authors.len() - 3 } else { 0 }
    let header-height = 6.5cm + extra-authors * size

    place(top + center, dy: -2.36cm,
      rect(fill: HEPLColors.beige-super-pale, width: 140%, height: header-height)
    )
    place(top + right, dx: 6cm, dy: -5.35cm,
      rotate(30deg, polygon.regular(fill: HEPLColors.rouge-prv, size: 7.75cm, vertices: 5))
    )
    table(
      columns: (0.75fr, 1fr),
      column-gutter: auto,
      align: (left, right),
      stroke: none,
      [#image("figures/g2.svg", height: 1.25cm)],
      [],
      [
        #academic-year(date)
        \
        #text(size: 1.4em, fill: HEPLColors.bleu-fonce-hepl, weight: "semibold")[#main-title :]
        \
        #text(size: 1.8em, fill: HEPLColors.bleu-clair-darker-hepl, weight: "semibold")[#sub-title]
      ],
      [
        #grid(..authors.map(a => [
          #a.first-name #smallcaps(a.last-name)  \
          #a.cursus \
          #if a.at("specialty", default: none) != none [#a.specialty] \
          \
        ]))
      ],
    )
  }

  set table(
    inset: 0.8em,
    stroke: none,
    fill: (x, y) =>
      if y == 0 {
        Uliege.TealDark.lighten(85%)
      } else if calc.odd(y) {
        white
      } else {
        luma(248)
      },
    align: (x, y) => if x == 0 { horizon + left } else { horizon + center },
  )

  if abstract != none {
    block(
      width: 100%,
      fill: Uliege.TealDark.lighten(90%),
      inset: 2em,
      below: 2em,
      par(first-line-indent: 0em)[
        #text(font: Theme.fonts.sans, fill: Uliege.TealDark, weight: "semibold")[Abstract]
        #linebreak()
        #abstract
      ]
    )
  }

  v(1cm)
  outline(indent: auto, title: "Table des matières", depth: 3)
  pagebreak()

  counter(page).update(1)
  set page(numbering: "1", footer: none)

  body

  if bibliography-file != none {
    pagebreak()
    show bibliography: set text(0.9em)
    bibliography(bibliography-file, full: false, style: "ieee", title: "Bibliographie")
  }

  if annex != none {
    pagebreak()
    counter(heading).update(0)
    set heading(numbering: "A.1", supplement: [Annexe])
    annex
  }
}
