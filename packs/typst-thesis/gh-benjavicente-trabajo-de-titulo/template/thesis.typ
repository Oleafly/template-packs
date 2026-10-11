// Template de Trabajo de Título. Solo incluye estilos y configuraciones generales.
#let template(doc) = {
  // Formato carta
  // Margen inferior y derecha de 2.5cm
  // Numeración cardinal arriba a la derecha
  set page(paper: "us-letter", margin: (bottom: 2.5cm, right: 2.5cm), numbering: "1", number-align: top + right)

  // Sangria de 1.27 cm
  // Justificados
  // Espaciado doble enter 2em
  set par(spacing: 2em, leading: 1em, justify: true,  first-line-indent: ( amount: 1.27cm, all: true ))

  // Times New Roman tamaño 12
  set text(lang: "es", font: "Times New Roman", size: 12pt)

  // Espaciados de los títulos
  show heading: set block(above: 1.4em, below: 1em)

  // Figuras con texto en tamaño 10, pero no en su título
  show figure: set text(size: 10pt)
  show figure.caption: set text(size: 12pt)
  show figure: set par(leading: 0.5em)

  // Numeración cardinal en los títulos
  set heading(numbering: "1.1", supplement: [Contenido])

  // Salto de páginas al mostrar índices
  show outline: outline => {
    outline
    pagebreak()
  }

  // Código
  show figure.where(kind: raw): set figure(supplement: [Código])

  // Links
  show link: set text(fill: blue)

  // No enumerar títulos antes del contenido
  set heading(numbering: none)

  doc
}

// Funciones generales

// Outline de las secciones
#let main_outline(depth: 2) = {
  outline(title: "Indice General", indent: auto, depth: depth, target: heading.where(supplement: [Contenido]))
}

// Outline de las figuras (tablas, código, etc.)
#let figure_outline() = {
  heading([Índice de Figuras], level: 1)
  outline(title: none, indent: auto, target: figure)
}

// Inicio del contenido principal
#let content(doc) = {
  pagebreak(weak: true)
  set heading(numbering: "1.")
  doc
}

// TODO: el path relativo es desde aquí, se debe usar path absoluto del proyecto hasta
// que se solucione la siguiente issue https://github.com/typst/typst/issues/971

#let originalBibliography = bibliography
// Bibliografía con estilo APA
#let bibliography(path) = {
  pagebreak(weak: true)
  originalBibliography(path, style: "apa")
}

// Incluir apéndice como página externa
#let appendix(path) = {
  pagebreak(weak: true)
  // Se establece que la numeración de las secciones del apéndice comience en 1,
  // con el heading de apéndice como padre.
  heading([Anexos], level: 1, numbering: none)
  outline(title: none, indent: auto, target: heading.where(supplement: [Anexo]))
  counter(heading).update(1)
  set heading(offset: 1, supplement: [Anexo], bookmarked: true, numbering: (..numbs) => numbering("1.1.", ..numbs.pos().slice(1)))
  include(path)
}

// Utilidad para marcar partes por hacer
#let todo(body) = {
  v(-1em)
  box(fill: gray.lighten(80%), outset: 0.5em, width: 100%)[
    #text(weight: "bold")[TODO:]
    #{body}
  ]
  v(0.5em)
}
