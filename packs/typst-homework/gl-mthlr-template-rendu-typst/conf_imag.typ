#let description(body) = {
  set text(
    style: "italic",
    weight: "extralight"
  )
  set text(black.transparentize(45%))
  body
  v(0.5em)
}

#let imag_color = cmyk(80%, 0%, 100%, 0%)

#let eqn(body: ()) = {
  set text(13pt)
  align(center)[
    #v(0.5em)
    $display(#body)$
    #v(0.5em)
  ]
  v(1em)
}

#let conf(title: none, authors: (), title_page: false, doc) = {
  set page(
    paper: "a4", 
    margin: 1.75cm,
    footer: context [
      *#title*
      #h(1fr)
      #counter(page).display(
        "1/1",
        both: true,
      )
    ]
  )

  set heading(numbering: "1.", bookmarked: true) // Gestion de la numérotation des titres

  set text(12pt, font: "New Computer Modern") // Police principale
  set par(justify: true)

  if title_page {
    // On override la page pour la page de titre
    set page(
      paper: "a4", 
      margin: 1.75cm,
      background: align(center + horizon)[
        #place[
          #rect(fill: imag_color, width: 100%, height: 100%) // Bande colorée en bas
        ]
        #place(center + horizon)[
          #ellipse(fill: white, width: 105%, height: 105%) // Centre coloré
        ]
        #place(top)[
          #rect(fill: white, width: 50%, height: 50%) // Bande colorée en haut
        ]
        #place(bottom + right)[
          #rect(fill: white, width: 50%, height: 50%) // Bande colorée en bas
        ]
      ],
      footer: none
    )

    // Page de titre
    place(
      horizon + center,
      clearance: 1em,
    )[
      #image("logo_ensimag.svg", width: 50%)
      #v(2em)
      #rect(fill: imag_color, width: 50%, height: 0.1cm)
      #text(title, 30pt, weight: "bold")
      #v(1em)
      #text(
        authors.map(((name, mail)) => link("mailto:" + mail)[#smallcaps(name)]).join(", ", last: " et "), 
        16pt, 
        weight: "light",
        fill: imag_color.darken(30%)
      )
      #v(5cm)
    ]

    // Saut de page après la page de titre
    pagebreak()
  } else {
    // En-tête si pas de page de titre
    place(
      top + center,
      float: true,
      scope: "parent",
      clearance: 1em,
    )[
      #line(length: 100%)
      #grid(
        columns: (1fr,2fr), 
        align(left)[
          #image("logo_ensimag.svg", width: 5cm)
        ],
        align(right)[
          #text(title, 20pt, weight: "bold")
          #v(0.2em)
          #text(
            authors.map(((name, mail)) => link("mailto:" + mail)[#smallcaps(name)]).join(", ", last: " et "), 
            14pt, 
            weight: "light",
            fill: imag_color.darken(30%)
          )
        ]
      )
      #line(length: 100%)
      #v(2em)
    ]
  }

  show link: set text(fill: blue)
  show link: underline
  show heading.where(level: 1): set text(1.4em) if title_page
  show heading.where(level: 2): set text(1.2em) if title_page
  show heading.where(level: 3): set text(1.2em) if title_page

  doc
}