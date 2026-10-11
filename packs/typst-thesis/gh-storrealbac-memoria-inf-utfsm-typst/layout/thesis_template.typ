#import "/layout/cover.typ": *
#import "/layout/dedication.typ": *
#import "/layout/acknowledgement.typ": acknowledgement as acknowledgement_layout
#import "/layout/abstract.typ": *
#import "/layout/glossary.typ": glossary as glossary_layout
#import "/layout/fonts.typ": *

// Estado para diferenciar captions en outline vs. cuerpo
#let in-outline = state("in-outline", false)

// Contadores de capítulos y secciones
#let chapter-counter = counter("chapter")
#let subsection-counter = counter("subsection")
#let subsubsection-counter = counter("subsubsection")

// Extraer texto plano de un contenido
#let plain-text(body) = {
  if body.has("text") { body.text }
  else if body.has("children") { body.children.filter(c => c.has("text")).map(c => c.text).join("") }
  else { "" }
}

// Obtener el número de página formateado en una ubicación
#let page-display(loc) = {
  let page-num = counter(page).at(loc).first()
  let fmt = loc.page-numbering()
  if fmt != none { numbering(fmt, page-num) } else { str(page-num) }
}

// Entrada del índice de contenidos
#let toc-entry(loc, label-text, displayed-page, bold: false, indent: 0em) = {
  if indent > 0em { h(indent) }
  let weight = if bold { "bold" } else { "regular" }
  link(loc)[
    #text(weight: weight)[#label-text]
    #box(width: 1fr, repeat[.])
    #text(weight: weight)[#displayed-page]
  ]
  linebreak()
}

#let thesis(
  titulo: "",
  ciudad: "",
  nombreAlumno: "",
  nombreProfesor: "",
  nombreCorreferente: "",
  mesExamen: "",
  anioExamen: "",
  dedicatoria: "",
  agradecimientos: "",
  resumen: "",
  resumenIngles: "",
  palabrasClave: "",
  palabrasClaveIngles: "",
  glosario: "",
  body,
) = {
  // =====================================================
  // PORTADA (page i, number hidden)
  // =====================================================
  cover(
    titulo: titulo,
    ciudad: ciudad,
    nombreAlumno: nombreAlumno,
    nombreProfesor: nombreProfesor,
    nombreCorreferente: nombreCorreferente,
    mesExamen: mesExamen,
    anioExamen: anioExamen,
  )

  // =====================================================
  // PÁGINAS PRELIMINARES (numeración romana)
  // =====================================================
  set page(
    paper: "us-letter",
    margin: (top: 2.5cm, bottom: 3cm, left: 3cm, right: 3cm),
    numbering: "i",
    number-align: center,
    header: none,
    footer: context {
      let pg = counter(page).get().first()
      if pg > 1 {
        align(center, text(size: 10pt, counter(page).display("i")))
      }
    },
  )
  set text(font: fonts.body, size: 12pt, lang: "es", hyphenate: false)
  set par(justify: true, spacing: 0.4cm, first-line-indent: 0cm)

  counter(page).update(1)

  // =====================================================
  // DEDICATORIA (page ii)
  // =====================================================
  pagebreak()
  dedication(dedicatoria)

  // =====================================================
  // AGRADECIMIENTOS (page iii)
  // =====================================================
  pagebreak()
  acknowledgement_layout(agradecimientos)

  // =====================================================
  // RESUMEN + ABSTRACT (misma página)
  // =====================================================
  pagebreak()
  [#metadata("RESUMEN") <toc-resumen>]
  abstract-page(
    resumen: resumen,
    palabrasClave: palabrasClave,
    resumenIngles: resumenIngles,
    palabrasClaveIngles: palabrasClaveIngles,
  )

  // =====================================================
  // GLOSARIO (page v)
  // =====================================================
  pagebreak()
  [#metadata("GLOSARIO") <toc-glosario>]
  glossary_layout(glosario)

  // =====================================================
  // ESTILOS DE ENCABEZADOS (para índice y cuerpo)
  // =====================================================

  show math.equation: set text(weight: 400)

  // Encabezados nivel 1
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    if it.numbering == none {
      block(above: 1cm, below: 1cm, text(size: 16pt, weight: "bold", upper(it.body)))
    } else {
      chapter-counter.step()
      subsection-counter.update(0)
      context {
        let num = chapter-counter.get().first()
        block(above: 1cm, below: 1cm)[
          #text(size: 16pt, weight: "bold")[CAPÍTULO #num]
          \
          #text(size: 16pt, weight: "bold")[#upper(it.body)]
        ]
      }
    }
  }

  // Subsecciones: "X.Y. TÍTULO"
  show heading.where(level: 2): it => {
    subsection-counter.step()
    subsubsection-counter.update(0)
    context {
      let chap = chapter-counter.get().first()
      let sub = subsection-counter.get().first()
      block(above: 1cm, below: 1cm)[
        #text(size: 12pt, weight: "bold")[#str(chap).#str(sub). #upper(it.body)]
      ]
    }
  }

  // Sub-subsecciones: "X.Y.Z. TÍTULO"
  show heading.where(level: 3): it => {
    subsubsection-counter.step()
    context {
      let chap = chapter-counter.get().first()
      let sub = subsection-counter.get().first()
      let subsub = subsubsection-counter.get().first()
      block(above: 1cm, below: 1cm)[
        #text(size: 12pt, weight: "bold")[#str(chap).#str(sub).#str(subsub). #upper(it.body)]
      ]
    }
  }

  // =====================================================
  // ÍNDICE DE CONTENIDOS
  // =====================================================
  pagebreak()

  text(size: 16pt, weight: "bold")[ÍNDICE DE CONTENIDOS]
  v(0.5cm)

  context {
    // Entradas de páginas preliminares
    let resumen-loc = query(<toc-resumen>).first().location()
    let resumen-page = page-display(resumen-loc)
    toc-entry(resumen-loc, "RESUMEN", resumen-page, bold: true)
    v(3pt)
    toc-entry(resumen-loc, "ABSTRACT", resumen-page, bold: true)
    v(3pt)

    let glosario-loc = query(<toc-glosario>).first().location()
    toc-entry(glosario-loc, "GLOSARIO", page-display(glosario-loc), bold: true)
    v(3pt)

    // Entradas de ÍNDICE DE FIGURAS e ÍNDICE DE TABLAS
    let figuras-loc = query(<toc-figuras>).first().location()
    let figuras-page = page-display(figuras-loc)
    toc-entry(figuras-loc, "ÍNDICE DE FIGURAS", figuras-page, bold: true)
    v(3pt)
    toc-entry(figuras-loc, "ÍNDICE DE TABLAS", figuras-page, bold: true)
    v(3pt)

    // Encabezados del cuerpo - numerar capítulos manualmente
    let chap-num = 0
    let sub-num = 0
    let subsub-num = 0

    for el in query(heading.where(outlined: true)) {
      let loc = el.location()
      let body-text = plain-text(el.body)

      // La bibliografía genera un encabezado con texto vacío; se omite
      // porque REFERENCIAS BIBLIOGRÁFICAS se agrega manualmente abajo.
      if body-text.trim() == "" { continue }

      let displayed-page = page-display(loc)

      if el.level == 1 {
        v(3pt)
        if el.numbering != none {
          chap-num += 1
          sub-num = 0
          subsub-num = 0
          toc-entry(loc, "CAPÍTULO " + str(chap-num) + ": " + upper(body-text), displayed-page, bold: true)
        } else {
          toc-entry(loc, upper(body-text), displayed-page, bold: true)
        }
      } else if el.level == 2 {
        sub-num += 1
        subsub-num = 0
        toc-entry(loc, str(chap-num) + "." + str(sub-num) + "   " + upper(body-text), displayed-page, indent: 1em)
      } else if el.level == 3 {
        subsub-num += 1
        toc-entry(loc, str(chap-num) + "." + str(sub-num) + "." + str(subsub-num) + "   " + upper(body-text), displayed-page, indent: 2em)
      }
    }

    // REFERENCIAS BIBLIOGRÁFICAS al final del índice
    v(3pt)
    let biblio-loc = query(<toc-biblio>).first().location()
    toc-entry(biblio-loc, "REFERENCIAS BIBLIOGRÁFICAS", page-display(biblio-loc), bold: true)
  }

  // =====================================================
  // ÍNDICE DE FIGURAS + ÍNDICE DE TABLAS (misma página)
  // =====================================================
  pagebreak()
  [#metadata("FIGURAS") <toc-figuras>]

  text(size: 16pt, weight: "bold")[ÍNDICE DE FIGURAS]
  v(0.3cm)
  {
    show outline: it => {
      in-outline.update(true)
      it
      in-outline.update(false)
    }
    outline(
      title: none,
      target: figure.where(kind: image),
    )
  }

  v(1cm)

  text(size: 16pt, weight: "bold")[ÍNDICE DE TABLAS]
  v(0.3cm)
  outline(
    title: none,
    target: figure.where(kind: table),
  )

  // =====================================================
  // CUERPO (numeración arábiga)
  // =====================================================
  pagebreak()

  set page(
    numbering: "1",
    margin: (top: 2.5cm, bottom: 3cm, left: 3cm, right: 3cm),
    header-ascent: 1cm,
    header: block(below: 0pt, above: 0pt, inset: 0pt)[
      #align(center, text(size: 10pt, upper(titulo)))
      #v(-6pt)
      #line(length: 100%, stroke: 1pt)
    ],
    footer: context {
      let current = counter(page).get().first()
      let last = counter(page).final().first()
      align(center, text(size: 10pt)[Página *#current* de *#last*])
    },
  )
  counter(page).update(1)

  body

  // =====================================================
  // BIBLIOGRAFÍA
  // =====================================================
  pagebreak()
  [#metadata("BIBLIO") <toc-biblio>]
  bibliography("/thesis.bib", style: "apa", title: text(size: 16pt, weight: "bold")[REFERENCIAS BIBLIOGRÁFICAS])
}
