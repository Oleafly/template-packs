// ============================================================
// Plantilla simple de Informe de Laboratorio
// UNSA - EPIS
// ============================================================

// ---------- Colores ----------
#let primary-color = rgb("#C8310E")
#let header-border-color = rgb("#808080")
#let table-border-width = 0.5pt
#let table-border-color = black
#let table-stroke = black + 1pt
#let table-inset = 0.5em
#let code-bg-color = rgb("#F8F9FA")
#let code-border-color = rgb("#D0D5DD")
#let code-line-number-color = rgb("#8C959F")
#let code-inline-color = rgb("#1F2328")
#let code-text-size = 7.5pt
#let code-line-number-size = 6pt

// ---------- Tipografía y geometría ----------
#let font-family = "Lato"
#let font-lang = "es"
#let page-paper = "a4"
#let page-margin = (
  top: 6cm,
  bottom: 2.54cm,
  left: 1.9cm,
  right: 1.9cm,
)
#let page-header-ascent = 5%

// ---------- Encabezado institucional ----------
#let header-institution-text-size = 7.5pt
#let header-meta-text-size = 7pt
#let header-title-text-size = 13pt
#let header-spacing-bottom = 1em

// ---------- Tabla de información básica ----------
#let info-table-text-size = 8.5pt
#let info-header-text-size = 11pt
#let info-header-fill = primary-color
#let info-header-text-color = white

// ---------- Encabezados y listas ----------
#let heading-1-size = 10pt
#let heading-2-size = 9pt
#let list-indent = 1em
#let list-marker = "-"
#let enum-numbering = "1."
#let image-default-width = 90%

// ---------- Idiomas personalizados ----------------------------
// Si un lenguaje no existe en Typst (p. ej. VDM++), se puede añadir
// fácilmente con sus colores:
//   1. Crea el archivo `syntaxes/<tag>.sublime-syntax` (formato Sublime).
//   2. Registra una entrada "<tag>": "syntaxes/<archivo>.sublime-syntax".
// Luego úsalo en cualquier práctica con un bloque de código:
//     ```<tag>
//     ... tu código ...
//     ```
// No genera warnings: si el lenguaje no está registrado, lo indicamos
// aquí y Typst lo resalta con tu definición.
#let extra-languages = (
  "vdmpp": "syntaxes/vdmpp.sublime-syntax",
  // Ej.: "karel": "syntaxes/karel.sublime-syntax",
)

// ---------- Secciones ----------
#let section-align-mode = left + top
#let section-stroke = black + 1pt
#let section-inset = 0.5em
#let section-header-fill = primary-color
#let section-header-text-size = 11pt
#let section-header-text-color = white
#let section-body-text-size = 8.5pt

// ============================================================
// Componentes
// ============================================================

// Sección de laboratorio
#let lab-section(
  title,
  align-mode: section-align-mode,
  stroke: section-stroke,
  inset: section-inset,
  header-fill: section-header-fill,
  ..bodies,
) = {
  let cell-items = bodies.pos().map(b => [
    #set text(size: section-body-text-size)
    #b
  ])

  grid(
    align: align-mode,
    stroke: stroke,
    inset: inset,
    columns: 1fr,
    grid.header(
      repeat: false,
      grid.cell(fill: header-fill, align: center + horizon)[
        #set text(size: section-header-text-size, weight: "bold", fill: section-header-text-color)
        #title
      ],
    ),
    ..cell-items,
  )
}

// Apartado de ejercicio (EJERCICIO 1, 2, 3...)
#let ejercicio-section(number, ..bodies) = {
  lab-section("EJERCICIO " + str(number), ..bodies)
}

// Apartado de pregunta (PREGUNTA 1, 2, 3...)
#let pregunta-section(number, ..bodies) = {
  lab-section("PREGUNTA " + str(number), ..bodies)
}

// Logos por defecto
#let default-logo-epis = image("img/epis.png", width: 95%)
#let default-logo-abet = image("img/abet.png", width: 97%)

// Encabezado de página institucional
#let page-header(logo-epis: default-logo-epis, logo-abet: default-logo-abet) = block(
  width: 100%,
  inset: (bottom: header-spacing-bottom),
)[
  #table(
    align: center + horizon,
    stroke: table-border-width + header-border-color,
    columns: (1fr, 2fr, 1fr),
    align(horizon)[#if logo-epis != none { logo-epis }],
    table.cell(align: center + horizon)[
      #set text(size: header-institution-text-size, weight: "bold")
      UNIVERSIDAD NACIONAL DE SAN AGUSTÍN \
      FACULTAD DE INGENIERÍA DE PRODUCCIÓN Y SERVICIOS \
      ESCUELA PROFESIONAL DE INGENIERÍA DE SISTEMAS
    ],
    align(horizon)[#if logo-abet != none { logo-abet }],
    table.cell(colspan: 3)[
      #set text(size: header-meta-text-size)
      #text(weight: "bold")[Formato: ]
      Guía de Práctica de Laboratorio / Talleres / Centros de Simulación
    ],
    table.cell[
      #set text(size: header-meta-text-size, weight: "bold")
      Aprobación: 2022/03/01
    ],
    table.cell[
      #set text(size: header-meta-text-size, weight: "bold")
      Código: GUIA-PRLE-001
    ],
    context table.cell(align: right + horizon)[
      #set text(size: header-meta-text-size, weight: "bold")
      Página: #counter(page).display("1")
    ],
  )
]

// Tabla de información básica
#let basic-info-table(
  course-name,
  lab-title,
  lab-number,
  year,
  sem-code,
  presentation-date,
  presentation-hour,
  member-list,
  instructor-name,
) = [
  #show table.cell: set text(size: info-table-text-size)
  #table(
    align: left + horizon,
    stroke: table-stroke,
    inset: table-inset,
    columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
    table.cell(colspan: 6, fill: info-header-fill, align: center + horizon)[
      #set text(size: info-header-text-size, weight: "bold", fill: info-header-text-color)
      INFORMACIÓN BÁSICA
    ],
    [#text(weight: "bold")[ASIGNATURA:]],
    table.cell(colspan: 5)[#course-name],
    [#text(weight: "bold")[TÍTULO DE LA PRÁCTICA:]],
    table.cell(colspan: 5)[#lab-title],
    [#text(weight: "bold")[NÚMERO DE LA PRÁCTICA:]],
    [#lab-number],
    [#text(weight: "bold")[AÑO LECTIVO:]],
    [#year],
    [#text(weight: "bold")[NRO. SEMESTRE:]],
    [#sem-code],
    [#text(weight: "bold")[FECHA DE PRESENTACIÓN:]],
    [#presentation-date],
    [#text(weight: "bold")[HORA DE PRESENTACIÓN:]],
    table.cell(colspan: 3)[#presentation-hour],
    table.cell(colspan: 4)[
      #text(weight: "bold")[INTEGRANTE(s):] \
      #for member in member-list {
        [
          - #member
        ]
      }
    ],
    [#text(weight: "bold")[NOTA (0 - 20):]],
    [Nota colocada por el docente],
    table.cell(colspan: 6)[
      #text(weight: "bold")[DOCENTE: ] \
      #instructor-name
    ],
  )
]

// Plantilla principal del informe
#let unsa-report(
  course_name: none,
  lab_title: none,
  lab_number: none,
  instructor_name: none,
  members: (),
  year: none,
  presentation_date: none,
  sem_code: none,
  presentation_hour: "11:59:00",
  logo-epis: default-logo-epis,
  logo-abet: default-logo-abet,
  body,
) = {
  let gen-time = datetime.today()
  let resolved-year = if year != none { year } else { gen-time.year() }
  let resolved-presentation-date = if presentation_date != none {
    presentation_date
  } else {
    gen-time.display("[day]/[month]/[year]")
  }
  let resolved-sem-code = if sem_code != none {
    sem_code
  } else {
    if gen-time.month() < 8 { "A" } else { "B" }
  }

  set text(font: font-family, lang: font-lang)
  show heading.where(level: 1): set text(size: heading-1-size)
  show heading.where(level: 2): set text(size: heading-2-size)
  set list(indent: list-indent, marker: list-marker)
  set enum(numbering: enum-numbering)
  set image(width: image-default-width)
  show image: set align(center)
  show raw.where(block: false): set text(fill: code-inline-color)
  for (lang, path) in extra-languages {
    show raw.where(lang: lang): set raw(syntaxes: path)
  }
  show raw.where(block: true): it => {
    block(
      width: 100%,
      fill: code-bg-color,
      stroke: 0.5pt + code-border-color,
      radius: 2pt,
      inset: (x: 7pt, y: 5pt),
      breakable: true,
    )[
      #show raw.line: line => {
        box(
          width: 1.8em,
          align(right)[
            #text(fill: code-line-number-color, size: code-line-number-size)[#line.number]
            #h(0.6em)
          ]
        )
        line.body
      }
      #set text(size: code-text-size)
      #set par(justify: false)
      #it
    ]
  }

  set page(
    paper: page-paper,
    margin: page-margin,
    header: page-header(logo-epis: logo-epis, logo-abet: logo-abet),
    header-ascent: page-header-ascent,
  )

  align(center)[#text(size: header-title-text-size, weight: "bold")[INFORME DE LABORATORIO]]

  basic-info-table(
    course_name,
    lab_title,
    lab_number,
    resolved-year,
    resolved-sem-code,
    resolved-presentation-date,
    presentation_hour,
    members,
    instructor_name,
  )

  body
}

// Bloque de código estilo LaTeX listings
#let code-block(
  source,
  lang: "text",
  fill: code-bg-color,
  stroke: 0.5pt + code-border-color,
  radius: 2pt,
  text-size: code-text-size,
  spacing: 0.65em,
) = {
  let raw-text = if type(source) == str {
    source
  } else if type(source) == content and source.has("text") {
    source.text
  } else {
    repr(source)
  }
  let resolved-lang = if lang != "text" {
    lang
  } else if type(source) == content and source.has("lang") and source.lang != none {
    source.lang
  } else {
    "text"
  }

  set text(size: text-size)
  set par(justify: false)
  raw(raw-text, lang: resolved-lang, block: true)
}