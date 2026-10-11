// Paleta obtenida de la identidad visual proporcionada.
#let navy = rgb("#173568")
#let navy-dark = rgb("#10274f")
#let blue = rgb("#073b70")
#let burgundy = rgb("#98163d")
#let gold = rgb("#c49a54")
#let ink = rgb("#22324d")
#let muted = rgb("#68758a")
#let paper = rgb("#f7f8fa")
#let pale-blue = rgb("#eef3f9")
#let line-gray = rgb("#d9dee7")

#let document-style(data, body) = {
  set text(
    font: (
      "Montserrat",
      "Inter",
      "Noto Sans",
    ),
    size: 10.5pt,
    lang: "es",
    region: "MX",
    hyphenate: true,
    fill: ink,
  )

  set par(
    justify: true,
    leading: 0.72em,
    spacing: 0.78em,
  )

  set page(
    paper: "a4",
    margin: (
      top: 27mm,
      bottom: 24mm,
      left: 27mm,
      right: 24mm,
    ),
    header: context {
      if counter(page).get().first() > 0 {
        grid(
          columns: (1fr, auto),
          column-gutter: 8mm,
          text(
            size: 7.4pt,
            weight: "semibold",
            fill: navy,
          )[
            #data.program
          ],
          text(
            size: 7.4pt,
            fill: muted,
          )[
            #data.course
          ],
        )

        v(1.8mm)
        line(
          length: 100%,
          stroke: 0.65pt + gold,
        )
      }
    },
    footer: context {
      line(
        length: 100%,
        stroke: 0.45pt + line-gray,
      )

      v(2mm)
      grid(
        columns: (1fr, auto),
        text(
          size: 7.2pt,
          fill: muted,
        )[
          #data.student · #data.activity
        ],
        text(
          size: 7.4pt,
          weight: "bold",
          fill: navy,
        )[
          #counter(page).display("1")
        ],
      )
    },
  )

  set heading(
    numbering: "1.1",
    outlined: true,
  )

  show heading.where(level: 1): it => {
    v(3mm)
    block(
      width: 100%,
      inset: (bottom: 2.2mm),
      stroke: (bottom: 1.1pt + gold),
    )[
      #text(
        size: 18pt,
        weight: "bold",
        fill: navy,
      )[#it]
    ]
    v(2mm)
  }

  show heading.where(level: 2): it => block(
    above: 1.2em,
    below: 0.55em,
  )[
    #text(
      size: 12.8pt,
      weight: "bold",
      fill: burgundy,
    )[#it]
  ]

  show heading.where(level: 3): it => text(
    size: 10.8pt,
    weight: "bold",
    fill: navy,
  )[#it]

  show link: set text(fill: burgundy)
  show figure.caption: set text(
    size: 8.5pt,
    fill: muted,
  )

  set list(
    indent: 1.2em,
    body-indent: 0.65em,
  )

  set enum(
    indent: 1.2em,
    body-indent: 0.65em,
  )

  set table(
    stroke: 0.45pt + line-gray,
    inset: 2.5mm,
  )

  body
}