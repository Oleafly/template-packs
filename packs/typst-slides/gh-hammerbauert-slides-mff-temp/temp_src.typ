// =============================================
// Conference Presentation Template
// Faculty of Mathematics and Physics, Charles University
// Red and White Theme — Typst 0.13, no external packages
// =============================================

// --- Colors ---
#let red-uk     = rgb("#DC143C")
#let soft-red-uk = rgb("#F08080")
#let white-uk   = rgb("#FFFFFF")
#let dark-blue-uk = rgb("#003366")
#let gray-dark  = rgb("#333333")
#let gray-light = rgb("#F2F2F2")

// --- Section tracking ---
#let _sections   = state("sections", ())
#let _sec-counter = counter("sec-counter")

// -----------------------------------------------
// TITLE SLIDE
// -----------------------------------------------
#let title-slide(
  title:       "Title",
  subtitle:    none,
  author:      none,
  institution: none,
  date:        none,
  logo:        "LOGO_MATFYZ_UK-EN.png",
) = page(margin: 0pt, fill: white-uk)[
  #set align(center + horizon)

  #if logo != none {
    image(logo, width: auto, height: 4.5cm)
    v(0cm)
  }

  #block(width: 78%)[
    #set align(center)
    #text(size: 34pt, fill: dark-blue-uk, weight: "bold")[#title]

    #if subtitle != none {
      v(0.4em)
      text(size: 21pt, fill: dark-blue-uk)[#subtitle]
    }

    #v(0.5em)
    #line(length: 100%, stroke: 1.5pt + dark-blue-uk)
    #v(0.3em)

    #if author != none {
      text(size: 19pt, fill: dark-blue-uk)[#author]
      v(0.25em)
    }
    #if institution != none {
      text(size: 14pt, fill: dark-blue-uk)[#institution]
      v(0.25em)
    }
    #if date != none {
      text(size: 14pt, fill: dark-blue-uk)[#date]
    }
  ]
]

// -----------------------------------------------
// OUTLINE SLIDE
// -----------------------------------------------
#let outline-slide(
  logo: "LOGO_MATFYZ_UK-EN.png",
) = page(margin: 0pt, fill: white-uk)[
  #rect(width: 100%, fill: red-uk, inset: (x: 1.2cm, y: 0.4cm))[
    #text(size: 22pt, fill: white-uk, weight: "bold")[Outline]
  ]

  #pad(x: 2cm, top: 0.9cm)[
    #context {
      let secs = _sections.final()
      for (i, s) in secs.enumerate() [
        #grid(
          columns: (1.4em, 1fr),
          align: (right + top, left + top),
          gutter: 0.6em,
          text(fill: red-uk, weight: "bold")[#(i + 1).],
          text(size: 20pt)[#s],
        )
        #v(0.55em)
      ]
    }
  ]

  #place(bottom + left, dx: 0.8cm, dy: -0.3cm)[
    #image(logo, height: 1.3cm)
  ]
  #place(bottom + right, dx: -0.8cm, dy: -0.4cm)[
    #text(size: 11pt, fill: luma(160))[#context counter(page).display()]
  ]
]

// -----------------------------------------------
// SECTION DIVIDER SLIDE  (registers section + shows highlighted outline)
// -----------------------------------------------
#let section-slide(
  title: "",
  logo:  "LOGO_MATFYZ_UK-EN.png",
) = {
  _sections.update(s => s + (title,))
  _sec-counter.step()

  page(margin: 0pt, fill: dark-blue-uk.lighten(80%))[
    #rect(width: 1.2cm, height: 100%, fill: red-uk, inset: (left: 0pt, top: 0pt, bottom: 0pt))
    #if logo != none {
      place(top + right, dx: -1.2cm, dy: 0.7cm)[
        //#image(logo, width: 2.5cm)
      ]
    }
    #place(center + horizon, dx: 2cm, dy: 0.5cm)[
      #grid(
        columns: (1.1fr, 3fr),
        gutter: 1.7cm,
        align: (left + horizon, left + horizon),
        // Left: vertical outline list
        context {
          let secs    = _sections.final()
          let current = _sec-counter.at(here()).first()
          block(width: 100%, spacing: 2em)[
            #for (i, sec_title) in secs.enumerate() {
              let active = (i + 1 == current)
              block(width: 100%)[
                #if active [
                  #text(size: 20pt, fill: red-uk, weight: "bold")[▶ #sec_title]
                ]else [
                  #text(size: 16pt, fill: dark-blue-uk)[#sec_title]
                ]
              ]
            }
          ]
        },
        // Right: section card with connecting arrow
        block(width: 100%)[
          // Draw connecting arrow from center of active item
          /* #context {
            let secs    = _sections.final()
            let current = _sec-counter.at(here()).first()
            let item_height = 1.7em
            let y = (current - 1) * item_height + item_height/2
            place(left, dx: -1.7cm, dy: y)[
              #line(
                length: 1.7cm,
                angle: 0deg,
                stroke: 2pt + red-uk,
                //end: "arrow",
              )
            ]
          } */
          #block(
            width: 100%,
            fill: white-uk,
            radius: 16pt,
            inset: (x: 2em, y: 1.5em),
            spacing: 0.7em,
          )[
            #v(0.7em)
            #text(size: 40pt, fill: red-uk, weight: "bold")[#title]
            #v(0.7em)
          ]
        ],
      )
    ]
  ]
}

// -----------------------------------------------
// REGULAR CONTENT SLIDE
// -----------------------------------------------
#let slide(
  title: "",
  logo:  "LOGO_MATFYZ_UK-EN.png",
  body,
) = page(margin: 0pt, fill: white-uk)[
  // Header bar
  #rect(width: 100%, fill: red-uk, inset: (x: 1.2cm, y: 0.4cm))[
    #grid(
      columns: (1fr, auto),
      align: (left + horizon, right + horizon),
      gutter: 1em,
      text(size: 22pt, fill: white-uk, weight: "bold")[#title],
      //if logo != none { image(logo, height: 0.85cm) },
    )
  ]

  // Content area
  #pad(x: 1.5cm, top: 0.7cm, bottom: 0.8cm)[
    #body
  ]

  // Slide number (bottom-right)
  #place(bottom + right, dx: -0.8cm, dy: -0.4cm)[
    #text(size: 11pt, fill: luma(160))[
      #context counter(page).display()
    ]
  ]

  // Slide number (bottom-right)
  #place(bottom + left, dx: 0.8cm, dy: -0.4cm)[
    #image(logo, height: 1.5cm)
    ]
]

// -----------------------------------------------
// TWO-COLUMN SLIDE
// -----------------------------------------------
#let two-col-slide(
  title: "",
  logo:  "LOGO_MATFYZ_UK-EN.png",
  left,
  right,
) = slide(title: title, logo: logo)[
  #grid(
    columns: (1fr, 1fr),
    gutter: 1.5cm,
    left,
    right,
  )
]

// -----------------------------------------------
// HIGHLIGHT BOX
// -----------------------------------------------
#let info-box(body) = block(
  width: 100%,
  fill: gray-light,
  inset: 0.9em,
  radius: 6pt,
)[
  #text(fill: red-uk, weight: "bold")[Note: ]#body
]

// -----------------------------------------------
// MATH ENVIRONMENTS
// -----------------------------------------------

// Counters
#let thm-counter  = counter("theorem")
#let def-counter  = counter("definition")
#let ex-counter   = counter("example")

// Internal builder
#let _math-block(
  color,
  label,
  counter: none,
  name: none,
  body,
) = {
  if counter != none { counter.step() }
  block(
    width: 100%,
    fill: color.lighten(88%),
    inset: (x: 0.9em, y: 0.7em),
    radius: 4pt,
    stroke: (left: 4pt + color),
  )[
    #text(weight: "bold", fill: color)[
      #label#if counter != none [ #context counter.display()]#if name != none [ (#name)]#[.]
    ]
    #h(0.4em)
    #body
  ]
}

// --- Public environments ---

#let theorem(name: none, body) = _math-block(
  red-uk, "Theorem", counter: thm-counter, name: name, body
)

#let lemma(name: none, body) = _math-block(
  rgb("#B22222"), "Lemma", counter: thm-counter, name: name, body
)

#let corollary(name: none, body) = _math-block(
  rgb("#C0392B"), "Corollary", counter: thm-counter, name: name, body
)

#let proposition(name: none, body) = _math-block(
  rgb("#A93226"), "Proposition", counter: thm-counter, name: name, body
)

#let definition(name: none, body) = _math-block(
  rgb("#1A5276"), "Definition", counter: def-counter, name: name, body
)

#let example(name: none, body) = _math-block(
  rgb("#1E8449"), "Example", counter: ex-counter, name: name, body
)

#let remark(body) = _math-block(
  rgb("#707070"), "Remark", body
)

#let proof(body) = block(width: 100%, inset: (x: 0.9em, y: 0.5em))[
  #text(style: "italic")[_Proof._ #body #h(1fr) $square$]
]