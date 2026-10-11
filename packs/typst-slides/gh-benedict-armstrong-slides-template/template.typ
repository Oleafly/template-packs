#import "@preview/polylux:0.4.0": *

#let heading-color = rgb("#2a2a68")
#let title-color = rgb("#08407E")

#let page-footer = context [
  #place(bottom + right)[
    #pad(bottom: 1.5em)[
      #text(size: 0.8em)[
        *#toolbox.slide-number* / #toolbox.last-slide-number
      ]
    ]
  ]
]

#let speaker-notes(notes) = context {
  let page-num = counter(page).display()
  let filename = "notes-slide-" + page-num + ".json"

  let note-data = (
    slide: page-num,
    notes: notes,
  )
  let json-string = json.encode(note-data)

  pdf.attach(
    filename,
    bytes(json-string),
    description: "Speaker notes for slide " + page-num,
    mime-type: "application/json",
  )
}

#let presentation(body) = {
  set page(paper: "presentation-16-9", footer: none, margin: 1.5cm)
  set text(font: "PT Sans", size: 1.6em)
  show heading.where(level: 1): set block(below: 1.2em)
  show heading.where(level: 1): set text(fill: heading-color, size: 1.2em)
  show figure.caption: set text(size: 0.8em)
  show footnote.entry: set text(size: 0.6em)
  body
}

#let title-slide(body) = slide[
  #block(
    height: 1fr,
    width: 100%,
    inset: (x: 0cm),
    align(horizon)[
      #grid(
        columns: (auto, 1fr, auto),
        align: (left, center, right),
        image("figures/mpi_logo.png", height: 1.5cm), [], image("figures/camail.png", height: 1.5cm),
      )
    ],
  )

  #block(
    height: 11fr,
    width: 100%,
    {
      place(top + left)[
        #box(
          image("figures/zurich2.jpg", width: 100%, fit: "cover"),
          radius: 0.2em,
        )
      ]

      place(left + horizon, dy: 1.8cm, dx: -1.6em)[
        #block(
          fill: title-color,
          radius: 0.2em,
          width: 80%,
          inset: (x: 1.4em, y: 1.6em),
          outset: (y: 0cm),
          body,
        )
      ]
    },
  )
]

#let highlight(slide, color, content, next_slide: true) = {
  only(str(slide))[#text(fill: color, weight: "bold", content)]
  if next_slide {
    only("1-" + str(slide - 1) + "," + str(slide + 1) + "-")[#content]
  }
}

#let reveal(content, switch, color, from: "1") = {
  only(str(from) + "-" + str(switch - 1))[#content]
  only(str(switch) + "-")[#text(fill: color, weight: "bold", content)]
}

#let content-slides(body) = {
  set text(size: 1em)
  show heading.where(level: 1): set text(fill: title-color, size: 0.9em)
  show raw: set block(fill: silver.lighten(65%), width: 100%, inset: 1em)
  set page(footer: page-footer)
  body
}

#let avec(a) = math.bold(a)
#let amat(a) = math.upright(math.bold(a))
