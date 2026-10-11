// TODO: Agregar soporte para equipos (varias personas)
// TODO: Agregar la opción de modificar los campos
// TODO: Determinar que paramétros pueden ser opciones, y agregar la opción de modificarlos mediante una lista de títulos de los campos
// TODO: Remover altura limitada de los escudos

// ╔══════════════════════════════════════════════════════╗
// ║  lib.typ — Plantilla BN 1                            ║
// ║  Uso:                                                ║
// ║    #import "lib.typ": plantilla                      ║
// ║    #show: plantilla.with(universidad: "...", ...)    ║
// ╚══════════════════════════════════════════════════════╝

// ── Escala de grises ──────────────────────────────────────────────────────────
#let _k20 = luma(51)
#let _k30 = luma(77)
#let _k40 = luma(102)
#let _k50 = luma(128)
#let _k60 = luma(153)
#let _k70 = luma(179)
#let _k80 = luma(204)
#let _k85 = luma(217)
#let _k90 = luma(230)

// ── Funciones internas ────────────────────────────────────────────────────────

#let _campo(lbl, val) = {
  line(length: 100%, stroke: 0.75pt + _k90)
  v(6pt)
  text(size: 6pt, weight: "bold", tracking: 1.6pt, fill: _k60, upper(lbl))
  linebreak()
  text(size: 9.5pt, weight: "semibold", fill: _k20, val)
}

#let _notch-lic(licenciatura, card-inset-top) = place(
  top + right,
  dx: -10pt,
  dy: -(card-inset-top + 20pt),
  box(
    fill: white,
    stroke: (left: 1.5pt + _k70, right: 1.5pt + _k70),
    inset: (x: 8pt, y: 5pt),
    stack(
      spacing: 3pt,
      text(size: 6pt, weight: "bold", tracking: 1.5pt,
           fill: _k60, upper("Licenciatura")),
      text(size: 8pt, weight: "semibold", fill: _k40, licenciatura),
    )
  )
)

// ── Bloque de logos dinámico ──────────────────────────────
// Construye el stack horizontal solo con los logos presentes.
// El separador vertical solo aparece cuando hay exactamente dos logos.
#let _logos-row(escudo-universidad, escudo-facultad) = {
  let sep = align(horizon,
    box(width: 1pt, height: 2.5cm)
  )

  if escudo-universidad != none and escudo-facultad != none {
    stack(
      dir: ltr,
      spacing: 1cm,
      escudo-universidad,
      sep,
      escudo-facultad,
    )
  } else if escudo-universidad != none {
    escudo-universidad
  } else if escudo-facultad != none {
    escudo-facultad
  }
  // Si ambos son none no se renderiza nada
}

// ── Data grid dinámico ────────────────────────────────────────────────────────

#let _data-grid(campos) = {
  let celdas = campos
    .filter(c => c.at(1) != none)
    .map(c => _campo(c.at(0), c.at(1)))

  if calc.rem(celdas.len(), 2) != 0 {
    celdas.push([])
  }

  if celdas.len() == 0 { return }

  grid(
    columns: (1fr, 1fr),
    row-gutter: 14pt,
    column-gutter: 36pt,
    align: top,
    ..celdas,
  )
}

// ── Función principal de la plantilla ─────────────────────────────────────────

#let plantilla(
  // Institución
  universidad:        "Nombre de la universidad",
  facultad:           "Nombre de la facultad",
  // Escudos: pasar image(...) o none para omitir
  escudo-universidad: none,
  escudo-facultad:    none,
  // Trabajo
  etiqueta:       "Trabajo Académico",
  titulo:             "Título del Trabajo",
  licenciatura:       "Nombre de la Licenciatura",
  // Asignatura
  asignatura:         "Nombre de la Asignatura",
  // Alumno
  alumno:             "Nombre del Alumno",
  num-cuenta:         "Número de Cuenta",
  // Campos opcionales — pasar none para omitirlos
  profesor:           none,
  grupo:              none,
  semestre:           "Semestre",
  // Cuerpo del documento
  body,
) = {

  // ── Configuración global ─────────────────────────────────
  set document(
    title:  titulo,
    author: alumno,
  )

  set page(
    paper: "us-letter",
    margin: 1in,
    numbering: "1",
    number-align: center,
  )

  set text(
    font: "Manrope",
    size: 12pt,
    lang: "es",
    region: "mx",
  )

  set par(
    leading: 0.75em,
    justify: true,
  )

  set heading(numbering: "1.1.")

  show heading.where(level: 1): it => [
    #set text(size: 16pt, weight: "bold", fill: _k20)
    #block(above: 1.5em, below: 0.8em, it)
  ]

  show heading.where(level: 2): it => [
    #set text(size: 13pt, weight: "semibold", fill: _k30)
    #block(above: 1.2em, below: 0.6em, it)
  ]

  // ── Portada ─────────────────────────────────────────────
  page(
    margin: 0.75in,
    numbering: none,
    header: none,
    footer: none,
    background: {
      let bcol   = _k30
      let bsize  = 21pt
      let bthick = 2pt
      let off    = 21pt

      place(top + left,  dx:  off, dy:  off,
        box(width: bsize, height: bsize,
          stroke: (top: bthick + bcol, left: bthick + bcol)))
      place(top + right, dx: -off, dy:  off,
        box(width: bsize, height: bsize,
          stroke: (top: bthick + bcol, right: bthick + bcol)))
      place(bottom + left,  dx:  off, dy: -off,
        box(width: bsize, height: bsize,
          stroke: (bottom: bthick + bcol, left: bthick + bcol)))
      place(bottom + right, dx: -off, dy: -off,
        box(width: bsize, height: bsize,
          stroke: (bottom: bthick + bcol, right: bthick + bcol)))
    }
  )[
    #set align(center)

    // Logos — solo se renderizan los que no son none
    #_logos-row(escudo-universidad, escudo-facultad)

    // Institución
    #text(size: 17pt, weight: "bold", tracking: 1.2pt,
          fill: _k20, upper(universidad))
    #linebreak()
    #v(3pt)
    #text(size: 13pt, weight: "regular", fill: _k50, facultad)

    #v(0.5cm)

    // Separador con punto central
    #grid(
      columns: (1fr, auto, 1fr),
      align: center + horizon,
      column-gutter: 10pt,
      line(length: 100%, stroke: 0.75pt + _k85),
      circle(radius: 2.5pt, fill: _k70, stroke: none),
      line(length: 100%, stroke: 0.75pt + _k85),
    )

    #v(0.7fr)
    #set align(left)

    // Tipo de trabajo
    #text(size: 8pt, weight: "bold", tracking: 1.6pt,
          fill: _k60, upper(etiqueta))

    // Title card
    #let inset-top = 27pt
    #box(
      width: 100%,
      stroke: 1.5pt + _k70,
      radius: 9pt,
      inset: (x: 33pt, top: inset-top, bottom: 27pt),
    )[
      #_notch-lic(licenciatura, inset-top / 6 * 4)

      #text(size: 28.5pt, weight: "black", fill: _k20, titulo)

      #v(12pt)
      #stack(
        dir: ltr,
        spacing: 4pt,
        box(width: 27pt, height: 2.5pt, radius: 2pt, fill: _k40),
        box(width: 14pt, height: 2.5pt, radius: 2pt, fill: _k80),
        box(width: 8pt,  height: 2.5pt, radius: 2pt, fill: _k85),
      )
    ]

    #v(0.55fr)

    // Asignatura con reglas flanqueantes
    #grid(
      columns: (1fr, auto, 1fr),
      align: center + horizon,
      column-gutter: 14pt,
      line(length: 100%, stroke: 0.75pt + _k90),
      [
        #set align(center)
        #text(size: 6pt, weight: "bold", tracking: 2pt,
              fill: _k60, upper("Asignatura"))
        #linebreak()
        #text(size: 11pt, weight: "bold", fill: _k20, asignatura)
      ],
      line(length: 100%, stroke: 0.75pt + _k90),
    )

    #v(0.55fr)

    // Data grid dinámico
    #_data-grid((
      ("Alumno",           alumno),
      ("Número de Cuenta", num-cuenta),
      ("Profesor",         profesor),
      ("Grupo",            grupo),
    ))

    #v(0.4cm)

    // Footer
    #align(center,
      text(size: 7.5pt, weight: "medium", fill: _k60,
           tracking: 0.8pt, "SEMESTRE " + semestre)
    )
  ]

  counter(page).update(1)

  // ── Cuerpo del documento ─────────────────────────────────
  body
}