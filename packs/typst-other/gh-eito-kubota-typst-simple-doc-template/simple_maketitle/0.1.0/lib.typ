

#let article(
  title: none,
  author: none,
  date: none,
  body,
) = {
  set page(
    paper: "a4",
    margin: (x: 25mm, y: 30mm),
    numbering: "1",
  )

  set text(
    font: (
      "New Computer Modern",
      "Harano Aji Mincho",
    ),
    size: 12pt,
    lang: "en",
  )

  set par(
    justify: true,
    first-line-indent: 1em,
  )

  set heading(numbering: "1.1.")

  //　Title part
  align(center)[
    #if title != none [
      #text(
        size: 1.6em,
        weight: "bold",
      )[
        #title
      ]

      #v(0.8em)
    ]

    #if author != none [
      #author

      #v(0.4em)
    ]

    #if date != none [
      #date.display("[year].[month].[day]")
    ]
  ]

  v(2em)

  body
}

