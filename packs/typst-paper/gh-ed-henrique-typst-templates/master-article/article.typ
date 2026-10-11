// Imports
#import "@preview/orchid:0.1.0"

// Styling
#set page(
  paper: "a4",
  margin: (
    top: 3cm,
    left: 3cm,
    right: 2cm,
    bottom: 2cm,
  ),
  header: block()[
    #block(below: 0.5em)[
      #text(size: 8pt)[Fundação Getúlio Vargas - Mestrado de Administração Pública]
    ]
    #line(length: 100%)
  ],
  number-align: center,
  numbering: "1",
)
#set heading(numbering: "1.")
#show heading.where(level: 1): set text(size: 12pt)
#show heading.where(level: 1): set block(below: 1.5em, above: 1.5em)
#set text(font: "Arial", size: 12pt)
#set par(spacing: 1.5em, justify: true, leading: 0.5em)

// Functions
#let to-review(body) = {
  set text(fill: blue)
  [#body]
}
#let long-citation(body) = {
  par(
    first-line-indent: 4cm,
    hanging-indent: 4cm,
  )[
    #text(size: 10pt)[
      #body
    ]
  ]
}

// Main content
#align(center)[
  #heading(numbering: none)[
    #text(weight: "bold")[
      Title here
    ]    
  ]
]

#align(right)[
  #par(spacing: 0.5em)[
    *Eduardo Henrique Freire Machado*
    #text(size: 10pt)[
      #orchid.generate-link("0009-0008-7340-976X")
    ]
  ]
  // #par(spacing: 0.5em)[
  //   #text(size: 10pt)[_eduardo.machado.1\@fgv.edu.br_]
  // ]
]

= INTRODUCTION <introduction>

= Content <content>

= Discussion <discussion>

= Conclusion <conclusion>

#bibliography(
  "references.bib",
  style: "associacao-brasileira-de-normas-tecnicas",
  title: "REFERENCES",
)
