// Plantilla FIUBA — documentos académicos (Facultad de Ingeniería, UBA).
// Uso:
//   #import "../lib.typ": fiuba-tp
//   #show: fiuba-tp.with(titulo: "...", ...)

#let fiuba-tp(
  titulo: none,
  subtitulo: none,
  materia-codigo: none,
  materia-nombre: none,
  catedra: none,
  docente: none,
  cuatrimestre: none,
  anio: none,
  autores: (),
  fecha: auto,
  logo-uba: "assets/uba.svg",
  logo-fiuba: "assets/fiuba.png",
  titulo-corto: auto,
  doc,
) = {
  assert(titulo != none, message: "fiuba-tp: falta `titulo`")
  assert(materia-nombre != none, message: "fiuba-tp: falta `materia-nombre`")
  assert(autores.len() > 0, message: "fiuba-tp: `autores` no puede estar vacío")

  let fecha-final = if fecha == auto {
    datetime.today().display("[day]/[month]/[year]")
  } else { fecha }

  let encabezado-corto = if titulo-corto == auto { titulo } else { titulo-corto }
  let materia-linea = if materia-codigo == none {
    [#materia-nombre]
  } else {
    [#materia-codigo — #materia-nombre]
  }

  // --- Configuración base: A4, español ---
  set page(paper: "a4", margin: (x: 2.5cm, y: 2.3cm))
  set text(size: 11pt, lang: "es")
  set par(justify: true, leading: 0.65em, spacing: 0.9em)
  set heading(numbering: "1.1")
  show heading.where(level: 1): it => block(
    above: 1.4em, below: 0.8em,
    text(size: 15pt, weight: "bold", it),
  )
  show heading.where(level: 2): it => block(
    above: 1.1em, below: 0.6em,
    text(size: 13pt, weight: "bold", it),
  )
  set list(indent: 1.2em, body-indent: 0.5em)
  set enum(indent: 1.2em, body-indent: 0.5em)
  show link: it => underline(text(fill: rgb("#0b3d91"), it))
  show raw.where(block: true): it => block(
    fill: luma(245), inset: 10pt, radius: 4pt, width: 100%,
    text(size: 9.5pt, it),
  )
  show raw.where(block: false): it => box(
    fill: luma(245), inset: (x: 4pt, y: 1pt), radius: 3pt,
    text(size: 9.5pt, it),
  )
  show figure: set block(spacing: 1em)
  set table(stroke: 0.5pt + luma(180))

  // --- Carátula (página 1, sin header/footer) ---
  {
    set page(header: none, footer: none, numbering: none)
    // Logos UBA (izq) + FIUBA (der)
    grid(
      columns: (1fr, 1fr),
      align: (left, right),
      image(logo-uba, height: 2.6cm),
      image(logo-fiuba, height: 2.0cm),
    )
    v(0.6cm)
    align(center, text(size: 11pt, weight: "bold")[
      Universidad de Buenos Aires \
      #text(weight: "regular")[Facultad de Ingeniería]
    ])
    v(0.3cm)
    line(length: 100%, stroke: 0.8pt)
    v(0.3cm)
    align(center, text(size: 11pt, materia-linea))
    if catedra != none {
      align(center, text(size: 10pt, fill: luma(70))[#catedra])
    }
    if docente != none {
      align(center, text(size: 10pt, fill: luma(70))[Docente: #docente])
    }
    if cuatrimestre != none or anio != none {
      let periodo = (
        (if cuatrimestre != none { cuatrimestre } else { "" })
        + (if cuatrimestre != none and anio != none { " — " } else { "" })
        + (if anio != none { str(anio) } else { "" })
      )
      align(center, text(size: 10pt, fill: luma(70))[#periodo])
    }
    v(1.0cm)
    align(center, text(size: 22pt, weight: "bold", titulo))
    if subtitulo != none {
      v(0.3cm)
      align(center, text(size: 13pt, fill: luma(70), subtitulo))
    }
    v(1.0cm)
    align(center, text(size: 11pt, weight: "bold")[Autores])
    v(0.3cm)
    align(
      center,
      table(
        columns: (auto, auto, auto),
        inset: (x: 10pt, y: 6pt),
        align: (left, center, left),
        table.header(
          [*Nombre*], [*Padrón*], [*Email*],
        ),
        ..autores.map(a => (
          a.nombre, str(a.padron), [#link("mailto:" + a.email)[#a.email]],
        )).flatten(),
      ),
    )
    v(1fr)
    align(center, text(size: 10pt, fill: luma(100))[Buenos Aires, #fecha-final])
    pagebreak(weak: true)
  }

  // --- Header/footer desde página 2 ---
  // (este `set page` va después de la carátula: solo afecta a las páginas
  // siguientes, por eso no necesita guardar por número de página)
  set page(
    numbering: "1",
    header: grid(
      columns: (1fr, auto),
      text(size: 8pt, fill: luma(100))[#materia-linea],
      text(size: 8pt, fill: luma(100))[#encabezado-corto],
    ),
    footer: context align(center, text(size: 8pt, fill: luma(100))[
      Página #counter(page).display() de #counter(page).final().first()
    ]),
  )
  counter(page).update(1)

  doc
}
