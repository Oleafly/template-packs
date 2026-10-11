#import "variables.typ": *

#let apa_template(doc) = {
  // --- CONFIGURACIÓN DEL DOCUMENTO ---
  set document(
    title: titulo,
    author: autores,
    date: datetime.today(),
  )

  // --- PÁGINA ---
  set page(
    paper: "us-letter",
    margin: 2.54cm,
    header: context {
      set text(font: tipografia, size: fuente_parrafo, fill: gray)
      if tipo_portada == "apa_student" {
        // APA Estudiante: solo número de página
        h(1fr)
        counter(page).display("1")
      } else if tipo_portada == "apa_professional" {
        // APA Profesional: running head + número de página
        titulo_corto
        h(1fr)
        counter(page).display("1")
      } else {
        // Custom: título corto + número de página
        titulo_corto
        h(1fr)
        counter(page).display("1")
      }
    },
    footer: none,
  )

  // --- TEXTO BASE ---
  set text(
    font: tipografia,
    size: fuente_parrafo,
    lang: "es",
  )

  // --- PÁRRAFO (APA 7) ---
  set par(
    justify: false,
    leading: 1em,
    first-line-indent: (
      amount: 1.27cm,
      all: true,
    ),
  )

  // --- TÍTULOS Y JERARQUÍA ---
  set heading(numbering: none)

  // Nivel 1: siempre en nueva página
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    set text(size: fuente_parrafo, weight: "bold")
    align(center, block(above: 1.5em, below: 1em, it.body))
  }

  // Niveles 2-5: sin salto de página
  show heading.where(level: (2, 3, 4, 5)): it => {
    set text(size: fuente_parrafo, weight: "bold")

    if it.level == 2 {
      block(above: 1.5em, below: 1em, it.body)
    } else if it.level == 3 {
      block(above: 1.5em, below: 1em, text(style: "italic", it.body))
    } else if it.level == 4 {
      parbreak()
      h(1.27cm) + it.body + [. ]
    } else if it.level == 5 {
      parbreak()
      h(1.27cm) + text(style: "italic", it.body) + [. ]
    }
  }

  // --- CITAS EN BLOQUE ---
  show quote.where(block: true): it => pad(
    left: 1.27cm,
    text(size: fuente_parrafo, style: "normal", it.body),
  )

  // --- CÓDIGO EN LÍNEA Y BLOQUES ---
  show raw.where(block: false): set text(font: "DejaVu Sans Mono", size: 10pt)
  show raw.where(block: true): set block(
    fill: rgb("#f8f9fa"),
    inset: 10pt,
    radius: 3pt,
  )

  // --- ENLACES ---
  show link: set text(fill: rgb("#0066cc"))

  // Retornar el documento con los estilos aplicados
  doc
}
