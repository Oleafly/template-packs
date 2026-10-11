// Template principal del documento

#let template(
  titulo: "",
  autor: "",
  fecha: "",
  body,
) = {
  // Configuración del documento
  set document(title: titulo, author: autor)

  // Configuración de página
  set page(
    paper: "a4",
    margin: (top: 2.5cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
    numbering: "1",
    number-align: center,
  )

  // Configuración de texto
  set text(
    font: "New Computer Modern",
    size: 11pt,
    lang: "es",
  )

  // Configuración de párrafos
  set par(
    justify: true,
    leading: 0.65em,
    first-line-indent: 1.25em,
  )

  // Configuración de encabezados
  set heading(numbering: "1.1")

  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    block(above: 2em, below: 1em)[
      #set text(size: 16pt, weight: "bold")
      #it
    ]
  }

  show heading.where(level: 2): it => {
    block(above: 1.5em, below: 0.8em)[
      #set text(size: 13pt, weight: "bold")
      #it
    ]
  }

  // Configuración de figuras
  show figure: it => {
    set align(center)
    block(above: 1.5em, below: 1.5em)[
      #it
    ]
  }

  show figure.caption: it => {
    set text(size: 10pt)
    it
  }

  // Portada
  align(center)[
    #v(3cm)
    #text(size: 20pt, weight: "bold")[#titulo]
    #v(2cm)
    #text(size: 14pt)[#autor]
    #v(1cm)
    #text(size: 12pt)[#fecha]
    #v(3cm)
  ]

  pagebreak()

  // Contenido
  body
}
