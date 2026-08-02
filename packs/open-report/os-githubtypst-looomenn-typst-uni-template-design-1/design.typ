#let BodyFont = "IBM Plex Sans"
#let MonoFont = "IBM Plex Mono"
#let AccentColor = rgb("#111827")


#let code_box(title: "Source Code", info: "", body) = {
  block(
    width: 100%,
    stroke: 0.5pt + luma(210),
    fill: rgb("#ffffff"),

  )[
    // шапка з назвою
    #block(
      width: 100%,
      fill: luma(240),
      inset: (x: 8pt, y: 6pt),
      stroke: (bottom: 0.5pt + luma(220)),
    )[
      #set text(font: BodyFont, size: 9pt)
      #stack(
        dir: ltr,
        spacing: 1fr,
        align(left)[
          #text(weight: "bold", fill: rgb("#333"))[#title]
        ],
        align(right)[
          #text(font: MonoFont, fill: rgb("#888"))[#info]
        ],
      )
    ]

    // тіло з кодом
    #block(
      width: 100%,
      inset: 8pt,
    )[
      #show raw.where(block: true): it => block(
        // fill: none,
        stroke: none,
        inset: 0pt,
        radius: 0pt,
        {
          set text(font: MonoFont, size: 0.9em)
          it
        },
      )
      #body
    ]
  ]
}


#let apply_style(body) = {
  set page(
    paper: "a4",
    margin: (top: 2cm, bottom: 2cm, left: 2.5cm, right: 1.5cm),
    numbering: "1",
    number-align: right
  )

  set text(
    font: BodyFont,
    size: 11pt,
    lang: "uk",
    weight: "regular",
  )

  set par(
    justify: true, 
    leading: 1.1em,
    spacing: 0.8em,
  )

  set heading(
    numbering: "1.1.",
  )


  show heading.where(level: 1): it => block({
    set text(size: 16pt, weight: "semibold")
    v(0.8em)
    it
    v(-0.7em)
    line(length: 100%, stroke: 1pt + black)
    v(0.8em)
  })

  show heading.where(level: 2): it => block({
    set text(size: 13pt, weight: "semibold")
    v(1em)
    it
    v(0.4em)
  })

  show raw: set text(font: MonoFont, size: 1.1em)

  show raw.where(block: false): it => box(
    fill: rgb("#dfe3e7"),
    inset: (x: 3pt, y: 1pt),
    outset: (y: 3pt),
    radius: 2pt,
    it
  )

  show raw.where(lang: "diff"): it => {
    block({
      let lines = it.text.split("\n")

      for line in lines {
        if line.starts-with("+") {
          block(fill: rgb("#c4ffd2"), width: 100%, inset: (x: 4pt, y: 2pt), below: 0pt)[#line]
        } else if line.starts-with("-") {
          block(fill: rgb("#fcceca"), width: 100%, inset: (x: 4pt, y: 2pt), below: 0pt)[#line]
        } else if line.starts-with("@@") {
          block(text(fill: purple, line), inset: (x: 4pt, y: 2pt), below: 0pt)
        } else {
          block(inset: (x: 4pt, y: 2pt), below: 0pt)[#line]
        }
      }
    })
  }

  body
}

