#let primary-color = rgb("#D73F09")
#let panel-fill = luma(240)
#let header-height = 7.3245in

#set page(
  paper: "arch-e",
  flipped: true,
  margin: (rest: .5in),
)

#set text(
  font: "Kievit",
  size: 24pt,
  weight: "regular"
)

#set par(
  justify: true,
  leading: 1.2em,
)

#show heading.where(level: 1): set text(
  font: "StratumNo2",
  size: 36pt,
  weight: "bold",
)

#show heading.where(level: 2): set text(
  font: "StratumNo2",
  size: 24pt,
)

#let panel(title: "", body) = block(
  inset: 1em,
  radius: 4pt,
)[
  #if title != "" {
    grid(
      columns: (auto, 1fr),
      column-gutter: 0.5em,
      align: left + horizon,
      box(fill: primary-color, width: 0.4em, height: 1.2em),
      text(font: "StratumNo2", size: 24pt, weight: "bold")[#title],
    )
  }
  #v(0.5em)
  #text(font: "Arial", size: 24pt, weight: "regular")[#body]
]

#let header(title, authors) = place(
  top + center,
  block(
    width: 100% - 2in,
    height: header-height,
    fill: primary-color,
    inset: (x: 2em, y: 2em),
    outset: (x: 1in),
    radius: 50pt,
  )[
    #set text(fill: white)
    #set align(center + horizon)

    #text(font: "StratumNo2", size: 85pt, weight: "bold")[#title]
    #v(0.5em)
    #text(font: "Kievit", size: 56pt)[#authors]

    #place(
      top + right,
      dx: 0in,
      dy: 1in,
      image("logo.png", width: 4.5in),
    )
  ],
)

#header(
  [MediaHub Poster Template: 
  
  ELECTRIC BEAV Enter A Title And Add Images To Your Poster
],
  [Your authorship here, include university or department names if needed],
)

#v(header-height)

#pad(rest: 1in, grid(
  columns: (1fr, 2fr, 1fr),
  gutter: 1in,

  [
    #panel(title: "Introduction")[
      Start with a short motivation statement, followed by your objective and key context.
    ]
    #v(1em)
    #panel(title: "Methods")[
      Explain your approach in plain language first, then add technical details.
    ]
  ],

  [
    #panel(title: "Results")[
      Highlight your main findings here. Use concise prose and move details into figures or tables.
    ]
    #v(1em)
    #panel()[
      Add figures, tables, or other visualizations to support your results. Make sure they are clear and well-labeled.
    ]
  ],

  [
    #panel(title: "Discussion")[
      Interpret what the results mean and why they matter.
    ]
    #v(1em)
    #panel(title: "Conclusion")[
      End with the key takeaway and next steps.
    ]
  ],
))
