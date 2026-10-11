#let tiny-text-size = 8pt
#let small-text-size = 10pt
#let normal-text-size = 14pt
#let large-text-size = 20pt

#show par: set text(spacing: 0pt)

#let abnormals = rgb("FF0000").lighten(30%)

#let style-state = state("style", "0")
#let horizontal-state = state("horizontal", "0")

#let emer-page(black-and-white: false, body) = {
  let size = 0.33in
  let padding = 0pt
  let color = if black-and-white {
    black
  } else {
    abnormals
  }

  set page(
    margin: (x: .5in, y: .4in),
    background: [
      #align(left + top)[
        #block(width: size, height: 100%, fill: none)[
          #for i in range(18) {
            polygon(
              (0pt, 0pt),
              (size, -size),
              (size, 0pt),
              (0pt, size),
              fill: color,
            )
            v(0.1in)
          }]
      ]
      #align(right + bottom)[
        #block(width: size, height: 100%, fill: none)[
          #for i in range(18) {
            polygon(
              (0pt, 0pt),
              (size, size),
              (size, 0pt),
              (0pt, -size),
              fill: color,
            )
            v(0.1in)
          }]
      ]
    ],
  )

  body

}

#let topic(
  title,
  fill-clr: rgb("b0b0b0"),
  stroke: 1pt,
  inset: 4pt,
  body,
) = {
  context {
    box(width: 100%, stroke: stroke, inset: inset, fill: fill-clr)[
    #v(5pt)
    #align(center)[#text(size: large-text-size, strong(title))]
    #v(5pt)
    ]

    if (horizontal-state.get()) {
    columns(3, gutter: 1em)[ #body ]
    } else {
    columns(2, gutter: 1em)[ #body ]
    }
  }
}

#let section(
  title,
  fill-clr: rgb("b0b0b0"),
  stroke: 1pt,
  inset: 4pt,
  body,
) = (
    context {
        block(breakable: false, {
        stack(dir: ttb, {
        if (title != none and title != "") {
            box(width: 100%, stroke: stroke, inset: inset, fill: fill-clr)[
                #v(5pt)
                #align(center)[#strong(title)]
                #v(5pt)
            ]
        }
        },
        {
        if (style-state.get() == 1) {
            box(width: 1fr, stroke: 1pt, inset: inset)[
                #v(5pt)
                #body
                #v(5pt)
            ]
        } else {
            body
            ellipse(width: 30pt, height: 20pt, fill: rgb("000000"))[
                #align(center + horizon)[#text(size: tiny-text-size, fill: rgb("FFFFFF"), strong("END"))]
            ]
        }
        }
        )
        }
        )
    }
)

#let step(a, b, bold: false) = {
  if ((a != none and a != "") or (b != none and b != "")) {
    if bold { strong(a) } else { a }
    " "
    box(width: 1fr, line(length: 100%, stroke: (paint: rgb("d0d0d0"))))
    //box(width: 1fr, repeat([.]))
    " "
    if bold { strong(b) } else { b }
    linebreak()
  }
}

#let small-caution(
  caution,
) = {
  text(size: small-text-size)[
    #text("Attenzione: ", fill: rgb("FF0000"))
  ]
  v(-1.68em)
  align(top + right)[#box(width: 83%)[#align(left)[
        #text(size: small-text-size)[#caution]
      ]]]
}

#let note(note) = {
  text(size: small-text-size)[Nota:]
  v(-1.68em)
  align(top + right)[#box(width: 91.5%)[#align(left)[
        #text(size: small-text-size)[#note]
      ]]]
}

#let page-number() = (
  context {
    counter(page).display("1 of 1", both: true)
  }
)

#let wait-separator() = {
    v(-2pt)
    line(start: (5%, 0pt), end: (95%, 0pt), stroke: (paint: rgb("d0d0d0"), dash: (6pt, 6pt)))
    v(-2pt)
}

#let checklist(
  title: none,
  version: none,
  disclaimer: none,
  font: "archivo narrow",
  disclaimer-fill: rgb("FF0000").lighten(40%),
  style: 0,
  horizontal: true,
  text-size: normal-text-size,
  title-stroke: 1pt,
  disclaimer-stroke: 1pt,
  inset: 4pt,
  body,
) = {
  set page(
    footer: [
      #line(start: (0pt, -15pt), length: 100%)
      #place(
        left,
        dy: -10pt,
        text(size: tiny-text-size, fill: rgb("000000"))[
          #datetime.today().display() | Ver. #version
        ],
      )
      #place(
        center,
        dy: -10pt,
        text(size: tiny-text-size, fill: rgb("000000"))[
          #page-number()
        ],
      )
      #place(
        right,
        dy: -10pt,
        text(size: tiny-text-size, fill: rgb("000000"))[
          #title
        ],
      )
    ],
  )

  set text(size: text-size, font: font)

  style-state.update(style)
  horizontal-state.update(horizontal)

  stack(dir: ttb, {
    stack(dir: ltr, {
    box(width: 20%, height: 36pt, stroke: title-stroke, inset: 1em, fill: rgb("FFFFFF"))[
      #align(center + horizon)[#text(size: normal-text-size, {"Version " + version})]
    ]},{
    box(width: 60%, height: 36pt, stroke: title-stroke, inset: 1em, fill: rgb("FFFFFF"))[
      #align(center + horizon)[#text(size: large-text-size, strong(title))]
    ]},{
    box(width: 20%, height: 36pt, stroke: title-stroke, inset: 1em, fill: rgb("FFFFFF"))[
      #align(center + horizon)[#text(size: normal-text-size, {datetime.today().display()})]
    ]}
)
  },

    {
  if disclaimer != none {
    box(width: 100%, height: 36pt, stroke: 1pt, fill: disclaimer-fill)[
      #align(center + horizon)[#text(size: normal-text-size, upper(strong(disclaimer)))]
    ]
  }
  }
)

  body
}
