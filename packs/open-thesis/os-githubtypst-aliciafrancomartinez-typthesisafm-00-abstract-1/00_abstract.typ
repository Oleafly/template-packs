

#show heading.where(level: 1, numbering: none): it => {
    set align(center) 
    set text(size: 26pt) 
    v(1em)
    it.body
  }
#heading(level: 1, numbering: none)[Abstract]

#set par(justify: true, first-line-indent: 2em)

Aquí tu abstract en inglés

#v(50pt)
#pad(x: 1cm)[
  #set par(first-line-indent: 0pt)
  #text(size: 11pt)[
    _Keywords_: hasta cinco, separadas por comas
  ]
]

#pagebreak()

#heading(level: 1, numbering: none)[Resumen]

#set par(justify: true, first-line-indent: 2em)

Aquí tu resumen en español

#v(50pt)
#pad(x: 1cm)[
  #set par(first-line-indent: 0pt)
  #text(size: 11pt)[
    _Palabras clave_: hasta cinco, separadas por comas
  ]
]