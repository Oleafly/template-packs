#let cover(
  title: none,
  subtitle: none,
  author: none,
  year: none,
  main-font: "New Computer Modern",
  accent-font: "Arial",
  body
) = [
  #page(margin: 2cm)[
    #set text(font: accent-font)

    #image("assets/aalto_logo_EN_square.png", width: 3cm, alt: "Aalto Logo")
    
    #v(2cm)

    // Title row.
    #text(weight: 600, 1.75em, title)

    #text(weight: 500, 1.15em, subtitle)

    #line(length: 100%, stroke: 0.5pt)

    // Author information.
    #strong(author)

    #v(1fr)
    
    #align(right)[
      #rect(stroke: (left: 2pt))[
        #set text(size: 13pt)
        #set align(left)
        Master's thesis

        #year
      ]
    ]
    #pagebreak()
  ]
  
  #body
]
