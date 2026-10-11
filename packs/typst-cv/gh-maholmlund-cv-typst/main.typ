#let dark1 = "#000000"
#let dark2 = "#121212"
#let dark3 = "#3B3B3B"
#let light1 = "#FFFFFF"
#let light2 = "#E1E1E1"
#let orange1 = "#FF7417"
#let orange2 = "#FFA366"
#let orange3 = "#FFDCB5"
#let name = "John Doe"

#set page(
  paper: "a4",
  margin: (x: 0em, y: 0em),
)
#set text(
  font: "Comfortaa",
  size: 12pt,
  fill: rgb(dark2),
)
#set document(
  title: [#name],
  author: name,
  description: "CV of " + name,
)

#let cvsection(title, body) = [
  #show heading: it => text(
    fill: rgb(orange1),
    it,
  )
  #block(inset: 0.4em)[
    == #title
    #block(inset: (left: 1em))[#body]
  ]
]

#let cvitem(title, body) = [
  #block(below: 1.8em)[
    *#title*
    #block(inset: (left: 1em))[#body]
  ]
]

#let language(name, level) = [
  #let level_n = if level == "C2" {
    6
  } else if level == "C1" {
    5
  } else if level == "B2" {
    4
  } else if level == "B1" {
    3
  } else if level == "A2" {
    2
  } else if level == "A1" {
    1
  } else {
    0
  }
  #block(width: 100%)[
    #table(
      columns: (2fr, 1fr, 3fr),
      stroke: none
    )[
      #name
    ][
      #level
    ][
      #let i = 1
      #while i <= 6 {
        let fill_color = if i <= level_n { rgb(orange2) } else { none }
        box(
          inset: 0.06cm,
          (circle(radius: 0.14cm, fill: fill_color, stroke: black)),
        )
        i += 1
      }
    ]
  ]
]

#block(
  fill: rgb(dark3),
  inset: (top: 2em, bottom: 2em),
  width: 100%,
  below: 0em,
)[
  #show text: it => text(fill: rgb(light1), it)

  #grid(
    columns: (1fr, 2fr),
    align(
      center,
      box(
        radius: 50%,
        clip: true,
        height: 8em,
        image("photo.jpg"),
      ),
    ),

    align(center + horizon)[
      #text(size: 16pt)[#title()]

      Computer science student
    ],
  )
]

#grid(
  columns: (1fr, 2fr),
  block(
    fill: rgb(orange3),
    width: 100%,
    inset: 1em,
  )[
    #lorem(30)

    #lorem(28)

    #v(1fr)

    #text(fill: rgb(orange1))[== Language Skills]

    #list(spacing: 0cm, marker: none)[
      #language("Finnish", "C2")
    ][
      #language("English", "C1")
    ][
      #language("German", "B2")
    ][
      #language("Swedish", "B2")
    ]

    #text(fill: rgb(orange1))[== Contact Information]

    #set text(size: 10pt)
    #show text: it => align(left + horizon, it)
    #set image(height: 1.4em)

    #align(center + bottom)[
      #table(
        columns: 2,
        stroke: none,
        image("phone.svg"), [+1234567890],
        image("mail.svg"), link("mailto:john.doe@example.com"),
        image("world-www.svg"), link("https://example.com")[example.com],
        image("github.svg"), link("https://github.com/johndoe")[github.com/johndoe],
        image("linkedin.svg"), link("https://linkedin.com/johndoe")[linkedin.com/johndoe],
        image("location.svg"), [Helsinki],
      )
    ]
  ],
  block(
    inset: 1em,
  )[
    #cvsection("Work")[
      #cvitem("Software Developer (02/2025-present)")[
        Johnny's code studio \
        Writing frontend code \
        Supporting customers
      ]
      #cvitem("First job (05/2024-09/2024)")[
        Gardener at my city \
        Enjoying planting flowers
      ]
      #cvitem("Course Assistant (01/2024-05/2024)")[
        Programming course 1 \
        Programming course 2
      ]
    ]

    #cvsection("Education")[
      #cvitem("University of Helsinki (09/2024-present)")[
        Bachelor's degree program in CS \
        GPA 1.234 \
        Completed 123 ECTS credits
      ]
      #cvitem("My great high school")[
        Finnish high school \
        Final grades best of my school
      ]
    ]

    #cvsection("Skills")[
      Eating, Sleaping, Coding, Repeating
    ]
  ],
)
