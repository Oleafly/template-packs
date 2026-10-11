#let template(
  title: [Title],
  subtitle: [Subtitle],
  year: [Year],
  authors: (),
  doc,
  institution: [Work place],
  supervisor: [Work place supervisor],
  university_supervisor: [University supervisor],
) = {
  set text(lang: "lt")
  set page(paper: "a4", margin: (top: 1.8cm, right: 1.8cm, bottom: 2.8cm, left: 2.8cm))

  set text(font: "Liberation Serif", lang: "lt", size: 12pt)
  show raw: set text(font: "Liberation Mono", size: 9pt)
  set block(spacing: 0.9em)

  set heading(numbering: "1.")
  show heading: set text(font: "Liberation Sans")
  show heading: it => pad(left: 0.3cm * (it.level - 1), it)
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    it
  }
  show heading.where(level: 1): h => {
    set block(below: 16pt)
    set text(size: 14pt)
    upper(h)
  }
  show heading.where(level: 2): h => {
    set block(below: 14pt)
    set text(size: 14pt)
    h
  }
  show heading.where(level: 3): h => {
    set block(below: 14pt)
    set text(size: 12pt)
    h
  }

  // citation style
  set cite(style: "institute-of-electrical-and-electronics-engineers")

  show figure: set text(size: 11pt)

  // table formatting
  set table(stroke: 0.5pt)
  show table.cell.where(y: 0): strong
  show figure.where(kind: table): set figure.caption(separator: [ lentelė. ], position: top)
  show figure.where(kind: table): fig => {
    set text(hyphenate: true)
    block(
      breakable: false,
      {
        align(left, pad(x: 0.5cm, fig.caption))
        v(-0.05cm)
        fig.body
      },
    )
  }

  // image numbering
  // when referencing figures always prefix the name with 'fig:'; So <example> becomes @fig:example
  show figure.where(kind: image): set figure.caption(separator: [ pav. ])
  set figure(supplement: [])

  // not translated in lithuanian
  set ref(supplement: [])

  // title page
  // TODO: move definition from here
  text(font: "Liberation Sans")[
    #grid(
      rows: (4fr, 2fr, 0.8fr, 3fr, auto),

      align(center)[
        #image("mif-logo.png", width: 15%)

        #text(size: 11pt)[
          VILNIAUS UNIVERSITETAS \
          MATEMATIKOS IR INFORMATIKOS FAKULTETAS \
          INFORMACINIŲ SISTEMŲ INŽINERIJOS STUDIJŲ PROGRAMA \
        ]
      ],

      align(center)[
        #text(size: 14pt, weight: "bold")[#title]
        #v(12pt)
        #text(size: 11pt)[#subtitle]
      ],

      text(size: 11pt)[
        #grid(
          row-gutter: 30pt,
          columns: (4fr, 4fr),
          [],
          [
            #for (name, email) in authors [
              Atliko: #name \ VU el. p.: #email #parbreak()
            ]
          ],
        )
      ],

      text(size: 11pt)[
        #grid(
          row-gutter: 12pt,
          columns: (2fr, 4fr),
          [], [ Praktikos institucija: #institution ],
          [], [ Praktikos vadovas: #supervisor ],
          [], [ Universiteto praktikos vadovas: #university_supervisor ],
        )
      ],

      text(size: 10pt)[
        #align(center)[
          Vilnius \
          2025
        ]
      ]
    )
  ]

  set par(justify: true, first-line-indent: (amount: 0.8cm, all: true))

  show outline.entry.where(level: 1): it => upper(it)
  show outline.entry: it => {
    set text(font: "Liberation Sans", size: 11pt, top-edge: 1em)
    it
  }

  // table of contents
  // TODO: move definition from here
  outline(title: [Turinys], indent: 1em)

  // page numbering, must go after the table of contents and title page
  set page(
    footer: context [
      #align(center)[
        #set text(font: "Liberation Sans")
        #counter(page).display()
      ]
    ],
  )

  // per section figure numbering
  show heading.where(level: 1): it => {
    counter(math.equation).update(0)
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: raw)).update(0)
    it
  }
  set math.equation(numbering: num => numbering("(1.1)", counter(heading).get().first(), num))
  set figure(numbering: num => numbering("1.1", counter(heading).get().first(), num))

  doc
}
