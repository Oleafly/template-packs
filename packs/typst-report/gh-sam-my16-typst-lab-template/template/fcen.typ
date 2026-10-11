#let informe-labo(body) = {
  set page(
    paper: "a4",
    margin: (rest:2.54cm),
    numbering: "1",
  )

  set math.equation(numbering: "(1)")
  
  set text(lang: "es", size: 12pt, font: "New Computer Modern")

  set heading(numbering: "1.")

  set par(justify: true, leading: 0.75em, spacing: 1.2em)

  show figure.caption: it => [
    #set text(size: 10pt)
    #block(width: 90%, align(center)[
       #strong([#it.supplement #it.counter.display(it.numbering):]) #it.body
    ])
  ]

  show link: set text(fill: blue)

  counter(page).update(1)
  body
}
