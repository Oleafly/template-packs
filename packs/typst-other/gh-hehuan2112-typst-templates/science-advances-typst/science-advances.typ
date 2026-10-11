#let sa-serif = "Times New Roman"

#let manuscript(
  title: none,
  short-title: none,
  authors: (),
  affiliations: (),
  corresponding: none,
  keywords: (),
  manuscript-label: "Manuscript Template",
  bibliography-file: none,
  body,
) = {
  set page(
    paper: "us-letter",
    margin: (
      top: 0.69in,
      right: 1.38in,
      bottom: 0.56in,
      left: 0.56in,
    ),
    background: context if counter(page).get().first() == 1 [
      #place(
        top + left,
        dx: 1in,
        dy: 0.5in,
        image("sciadv.jpg", width: 4in),
      )
      #place(
        top + left,
        dx: 1in,
        dy: 0.5in,
        rect(
          width: 4in,
          height: 0.86in,
          fill: white.transparentize(50%),
          stroke: none,
        ),
      )
    ],
    footer: context [
      #set text(font: sa-serif, size: 9pt)
      #line(length: 100%)
      #v(-5pt)
      #grid(
        columns: (1fr, auto, 1fr),
        column-gutter: 0pt,
        row-gutter: 0pt,
        align: (left + top, center + top, right + top),
        emph[Science Advances],
        [#manuscript-label],
        [Page #counter(page).get().first() of #counter(page).final().first()],
      )
    ],
  )

  set text(font: sa-serif, size: 12pt)
  set par(justify: true, first-line-indent: 0.2in, leading: 3pt)
  set par.line(
    numbering: "1",
    number-margin: left,
    number-align: right,
    number-clearance: 10pt,
    numbering-scope: "document",
  )
  set heading(numbering: "1.")

  show heading.where(level: 1): it => block(above: 12pt, below: 6pt)[
    #set text(font: sa-serif, size: 12pt, weight: "bold")
    #set par(first-line-indent: 0pt)
    #it.body
  ]

  show heading.where(level: 2): it => block(above: 8pt, below: 4pt)[
    #set text(font: sa-serif, size: 12pt, weight: "bold")
    #set par(first-line-indent: 0pt)
    #counter(heading).display(it.numbering)
    #h(0.4em)
    #it.body
  ]

  let body-block(body) = block(inset: (left: 0.5in))[
    #body
  ]

  show list: it => block(inset: (left: 0.5in))[
    #it
  ]

  show enum: it => block(inset: (left: 0.5in))[
    #it
  ]

  show figure.caption: set text(font: sa-serif, size: 12pt)
  show figure.caption.where(kind: image): it => [
    #strong[Fig. #context it.counter.display(it.numbering).]
    #h(0.4em)
    #it.body
  ]
  show figure.caption.where(kind: table): it => [
    #strong[Table #context it.counter.display(it.numbering).]
    #h(0.4em)
    #it.body
  ]
  show math.equation: set text(font: sa-serif, size: 12pt)

  [
    #v(0.95in)

    #align(center)[
      #set text(font: sa-serif, size: 12pt, weight: "bold")
      #authors.join([; ])
    ]

    #v(6pt)

    #set par(first-line-indent: 0pt, justify: false)
    #set text(font: sa-serif, size: 12pt, weight: "regular")
    #for affiliation in affiliations [
      #affiliation \
    ]

    #if corresponding != none {
      v(4pt)
      text(font: sa-serif, size: 12pt)[*Correspondence to:* #corresponding]
    }

    #if keywords.len() > 0 {
      v(4pt)
      text(font: sa-serif, size: 12pt)[*Keywords:* #keywords.join([, ])]
    }

    #v(10pt)

    #show par: body-block

    #body

    #if bibliography-file != none {
      v(12pt)
      bibliography(bibliography-file, title: [References])
    }
  ]
}
