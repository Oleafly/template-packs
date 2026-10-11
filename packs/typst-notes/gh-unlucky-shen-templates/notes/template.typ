#let project(
  title: "",
  subtitle: "",
  author: "",
  body
) = {
  set page(
    paper: "a4",
    margin: (top: 1.0in, bottom: 1.0in, left: 1.0in, right: 1.0in,),
  )

  set text(font: "Crimson Pro", size: 11pt,)
  
  set par(leading: 1.05em, justify: true, linebreaks: "optimized",)

  show heading.where(level: 1): it => [
    #set text(weight: "bold")
    #it.body
    #v(0.5em)
  ]

  show heading.where(level: 2): it => [
    #set text(weight: "bold", style: "italic")
    #it.body
    #v(0.2em)
  ]

  show heading.where(level: 3): it => [
    #set text(weight: "bold")
    #it.body
    #v(0.2em)
  ]

  align(center)[ // Document Metadata
    #block(text(weight: "bold", size: 1.5em, title))
    #v(0.2em)
    #block(text(subtitle))
    #block(text(author))
    #v(1em)
  ]

  body
}

#let definition(term, body) = { // Definitions
  block(
    fill: rgb("#e8f4f8"),
    stroke: (left: 4pt + rgb("#2980b9")),
    inset: 12pt,
    radius: 2pt,
    width: 100%,
    [
      #text(weight: "bold", fill: rgb("#2980b9"))[Definition: #term] \
      #body
    ]
  )
}

#let note(body) = { // Notes
  block(
    fill: rgb("#fff9db"),
    stroke: (left: 4pt + rgb("#f59f00")),
    inset: 12pt,
    radius: 2pt,
    width: 100%,
    [
      #text(weight: "bold", fill: rgb("#d97706"))[Note:] \
      #body
    ]
  )
}
