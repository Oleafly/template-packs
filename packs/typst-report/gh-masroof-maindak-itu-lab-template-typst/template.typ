#let project(
  title: "",
  instructor: "",
  batch: "",
  lab_no: none,
  code: none,
  faculty_rolls: (),
  body,
) = {
  set page(
    paper: "a4",
    margin: (x: 2cm, y: 2.5cm),
    numbering: "1 / 1",
  )

  set text(
    size: 12pt,
    lang: "en",
  )

  set enum(numbering: "1.i)")
  
  show raw.where(block: true): it => block(
    fill: luma(240),
    inset: 10pt,
    radius: 4pt,
    width: 100%,
    it,
  )

  show link: set text(fill: rgb("#0055aa"))

  set par(justify: true, leading: 0.8em)

  let primary-color = rgb("#0055aa")
  let secondary-color = luma(100)

  show heading: it => {
    set text(fill: primary-color)
    v(0.5em)
    it
    v(0.2em)
    if it.level == 1 {
      line(length: 100%, stroke: 0.5pt + primary-color)
    }
    v(0.5em)
  }

  {
    // Auto-infer season
    let current_date = datetime.today()
    let season_name = if current_date.month() <= 6 { "Spring" } else { "Fall" }
    let current_season = season_name + " " + str(current_date.year())

    set page(margin: (top: 3cm, bottom: 2cm, x: 2.5cm))

    // Layout
    align(center)[
      #image("itu-logo.png", width: 100mm)

      #v(1.75cm)

      // Title Block
      #block(
        stroke: (left: 4pt + primary-color),
        inset: (left: 1em),
        above: 2em,
        below: 2em,
      )[
        #align(left)[
          #text(
            title,
            size: 22pt,
            weight: "bold",
            fill: primary-color,
            hyphenate: false,
          )
          #if code != none {
            parbreak()
            text(code, size: 14pt, style: "italic", fill: secondary-color)
          }
        ]
      ]

      #v(1.5cm)

      #if lab_no != none {
        text(
          "Lab " + str(lab_no),
          size: 18pt,
          weight: 500,
          fill: secondary-color,
        )

        v(1cm)
      }

      // Info Grid
      #grid(
        columns: (auto, auto),
        gutter: 1.5em,
        align: (right, left),
        text("Instructor:", weight: "bold", fill: primary-color),
        text(instructor),

        text("Batch:", weight: "bold", fill: primary-color), text(batch),
        text("Season:", weight: "bold", fill: primary-color),
        text(current_season),
      )

      #v(1.75cm)

      // Faculty Section
      #if faculty_rolls.len() > 0 {
        block(
          fill: luma(250),
          stroke: (dash: "dashed", paint: primary-color),
          inset: 1.5em,
          radius: 8pt,
          width: 80%,
        )[
          #text(
            "Faculty Contact",
            weight: "bold",
            size: 10pt,
            fill: secondary-color,
          )
          #v(0.5em)
          #grid(
            columns: (1fr, 1fr),
            row-gutter: 0.8em,
            ..faculty_rolls.map(r => {
              let email = r + "@itu.edu.pk"
              link("mailto:" + email)[#text(email, size: 10pt)]
            })
          )
        ]
      }
    ]
    pagebreak()
  }

  body
}

// --- UTILITY FUNCTIONS ---

#let note(body) = block(
  fill: rgb("#f0f7ff"),
  stroke: (left: 4pt + rgb("#0055aa")),
  inset: 14pt,
  radius: 4pt,
  width: 100%,
  [
    #place(top + left, dx: -4pt, dy: -4pt)[
      #circle(radius: 0pt) // Placeholder for icon positioning if needed
    ]
    *Note:* #body
  ],
)

#let warning(body) = block(
  fill: rgb("#fff4e5"),
  stroke: (left: 4pt + rgb("#ff9800")),
  inset: 14pt,
  radius: 4pt,
  width: 100%,
  [*Warning:* #body],
)
