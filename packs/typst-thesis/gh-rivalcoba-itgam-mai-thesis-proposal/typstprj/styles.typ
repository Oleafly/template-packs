// ------------------------------------------------------------
// Paleta de colores
// ------------------------------------------------------------
#let navy = rgb("#1f3b6d")
#let navy-dark = rgb("#172f59")
#let gold = rgb("#c7a15a")
#let burgundy = rgb("#9c1742")
#let ink = rgb("#243553")
#let muted = rgb("#68758b")
#let paper-gray = rgb("#f7f6f4")
#let line-gray = rgb("#dfdfdd")

#let document-style(data, body) = {
  set text(
    font: (
      "Montserrat",
      "Inter",
      "Noto Sans",
    ),
    lang: "es",
    region: "MX",
    hyphenate: true,
    fill: ink,
  )

  set par(
    justify: true,
    leading: 0.72em,
  )

  set math.equation(
    numbering: "(1)",
    number-align: end,
    supplement: [Ecuación],
  )

  set page(
    paper: "us-letter",

    margin: (
      top: 25mm,
      bottom: 23mm,
      left: 26mm,
      right: 23mm,
    ),

    header: context {
      if counter(page).get().first() > 1 {
        grid(
          columns: (1fr, auto),

          text(
            size: 7.5pt,
            weight: "bold",
            fill: navy,
          )[
            #data.program
          ],

          text(
            size: 7.5pt,
            fill: muted,
          )[
            #data.document-type
          ],
        )

        v(2mm)

        line(
          length: 100%,
          stroke: 0.55pt + gold,
        )
      }
    },

    footer: context {
      line(
        length: 100%,
        stroke: 0.4pt + line-gray,
      )

      v(2mm)

      grid(
        columns: (1fr, auto),

        text(
          size: 7.3pt,
          fill: muted,
        )[
          #data.student
        ],

        text(
          size: 7.3pt,
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

  show heading.where(level: 1): set text(
    size: 19pt,
    weight: "bold",
    fill: navy,
  )

  show heading.where(level: 2): set text(
    size: 13pt,
    weight: "bold",
    fill: burgundy,
  )

  show heading.where(level: 3): set text(
    size: 10.8pt,
    weight: "bold",
    fill: navy,
  )

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
