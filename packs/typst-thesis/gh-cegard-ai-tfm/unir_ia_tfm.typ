#import "@preview/unify:0.7.1": num, qty, numrange, qtyrange
#import "@preview/physica:0.9.5": *

#let abstract_length = 150
#let unir_blue = rgb(0,59%,80%)
#let text_size = 11pt
#let text_font = "New Computer Modern"

#let show_cover(
  title,
  authors,
  director,
  logo,
  city,
  date,
) = {
  set page(
    paper: "a4",
    numbering: none
  )

  align(center)[
    #logo
  ]

  box(inset: (left: 4.5em), width: 15cm)[
    #box(stroke: (left: 2pt + unir_blue), inset: (left: 0.8em))[
      #set text(font: text_font)
      #set par(leading: 0.3em, linebreaks: "simple")

      #text(size: 15pt, weight: "regular")[Universidad Internacional de La Rioja (UNIR)]

      #v(0.1cm)
      #box()[#text(size: 20pt, weight: "bold")[Escuela Superior de Ingeniería y Tecnología]]

      #text(size: 15pt, weight: "regular")[Máster en Inteligencia Artificial]

      #v(0.1cm)
      #text(size: 24.88pt, fill: unir_blue, weight: "bold")[#title]
      
    ]
  ]

  v(6cm)
  box()[
    *Trabajo Fin de Estudios*

    *Presentado por:* #authors

    *Dirigido por:* #director
  ]

  v(3cm)
  box()[
    #text(fill: unir_blue)[Ciudad:] #city

    #text(fill: unir_blue)[Fecha:] #date
  ]
}

#let tfmia(
  title: "Título de mi TFG",
  authors: [],
  director: [],
  resumen: lorem(abstract_length),
  abstract: lorem(abstract_length),
  pclave: (),
  kwords: (),
  logo: "logo_unir.pdf",
  city: [],
  date: [],
  doc,
) = {
  let second_font = "IBM Plex Mono"
  let heading_one_text_size = 22pt
  
  set page(
    paper: "a4",
  )
  set text(font: text_font, size: text_size, lang: "es")
  set par(linebreaks: "simple", justify: true, spacing: 1.8em, leading: 1.2em)

  show link: it => {
    if not (it.body.text.contains(it.dest)) {
      text(fill: unir_blue, underline(it))
    } else { text(fill: unir_blue, font: second_font, size: 10.2pt, underline(it)) }
  }
  
  set heading(numbering: "1.")
  show heading.where(level: 1): item => {
    pagebreak()

    if item.numbering != none {
      text(unir_blue, weight: "semibold", size: heading_one_text_size)[#context counter(heading).display()]
      " "
    }

    text(unir_blue, weight: "semibold", heading_one_text_size)[#item.body]
    v(0.1em)
  }
  
  show heading.where(level: 2): item => {
    text(unir_blue, weight: "light", size: 15pt)[#context counter(heading).display()]
    " "
    text(unir_blue, weight: "light", 15pt)[#item.body]
    v(0.1em)
  }

  show_cover(title, authors, director, logo, city, date)

  set page(
    numbering: none,
    footer: none,
  )

  pagebreak()
  set page(
    numbering: "I",
    footer: context [
      #set align(right)
      #text(size: 8pt)[#counter(page).display()]
    ],
  )

  counter(page).update(1)
  outline(title: "Índice de Contenidos")

  outline(title: "Índice de Ilustraciones", target: figure.where(kind: image))

  outline(title: "Índice de Tablas", target: figure.where(kind: table))

  text()[
    #heading(level: 1, numbering: none)[Resumen]

    #resumen

    #text(weight: "bold")[Palabras clave:]
    #pclave
  ]

  text()[
    #heading(level: 1, numbering: none)[Abstract]

    #abstract

    #text(weight: "bold")[Keywords]:
    #kwords
  ]

  pagebreak()

  align(right)[
    #text(size: 10pt, weight: "light")[
      #authors
      #v(-1em)
      Máster en Inteligencia Artificial
    ]
  ]

  set page(
    numbering: "1",
    footer: context [
      #set align(center)
      #set text(8pt)
      #text()[#counter(page).display()]
    ],
  )
  counter(page).update(1)

  doc
}
