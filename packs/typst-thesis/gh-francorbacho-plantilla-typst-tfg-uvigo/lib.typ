// FIXME: workaround for the lack of `std` scope
#let std-bibliography = bibliography

#let template(
  // Core thesis metadata
  title: [Título del TFG],
  candidate: "Sin autor",
  tutor: "Tutor/a",
  school: "Escuela Superior de Enxeñaría Informática",
  degree: "Enxeñaría Informática",
  date: "Xullo, 2025",
  lang: "gl",

  // Academic & administrative data
  tfg-num: "00/00-100",
  area: "Enxeñería de Sistemas e Automática",
  departamento: "Enxeñería de Sistemas e Automática",

  // Layout & visual configuration
  paper-size: "a4",
  logo: image("images/universidade_de_vigo_logo.png"),

  // Bibliographic resources
  bibliography: none,

  // Main body content
  body
) = {
  // Set document metadata
  set document(title: title, author: candidate)

  // set text(font: "New Computer Modern", lang: lang, size: 12pt)
  set text(font: "Times New Roman", lang: lang, size: 12pt)

  // Configure the page
  set page(
    paper: paper-size,

    // Margins are taken from the university's guidelines
    margin: (right: 3.25cm, left: 3.25cm, top: 2cm, bottom: 2cm)
  )

  // Configure equation numbering and spacing
  set math.equation(numbering: "(1)")
  show math.equation: set block(spacing: 0.65em)

  // Configure raw text/code blocks
  show raw.where(block: true): set text(size: 0.9em, font: "Fira Code")
  show raw.where(block: true): set par(justify: false)
  show raw.where(block: true): set align(left)
  show raw.where(block: true): block.with(
    fill: gradient.linear(luma(240), luma(245), angle: 270deg),
    inset: 6pt,
    radius: 4pt,
    width: 100%,
  )
  show raw.where(block: false): box.with(
    fill: gradient.linear(luma(240), luma(245), angle: 270deg),
    inset: (x: 3pt, y: 0pt),
    outset: (y: 3pt),
    radius: 2pt,
  )

  show figure: set block(breakable: true)

  // Configure figure's padding
  show figure: pad.with(top: 10pt, bottom: 10pt)

  // Configure lists and enumerations
  set enum(indent: 10pt, body-indent: 9pt)
  set list(indent: 10pt, body-indent: 9pt, marker: ([•], [--]))

  // Configure headings
  set heading(numbering: "1.")
  show heading.where(level: 1): text.with(1.3em, weight: "bold")
  show heading.where(level: 1): it => block(inset: (bottom: 4mm), it)
  show heading.where(level: 2): it => block(width: 100%, height: 8mm)[
    #set align(left)
    #set text(1em, weight: "bold")
    #v(2mm)
    #smallcaps(it)
  ]
  show heading.where(level: 3): it => block(width: 100%)[
    #set align(left)
    #set text(1em, weight: "bold")
    #smallcaps(it)
  ]

  // Title page
  set align(center)

  v(3fr)

  block[
    #box(height: 52pt, logo)

    #text(1.2em, school)
  ]

  v(4fr)

  [Memoria do Traballo de Fin de Grao que presenta]
  v(1fr)
  text(weight: "bold")[D. #candidate]
  v(1fr)
  [para a obtención do Título de Graduado en #degree]
  v(2fr)
  text(1.5em, weight: 700, title)

  v(4fr)


  let document(title: "", number: "", area: "", department: "") = {
      v(2cm) // Vertical space
    align(center)[
      #image("images/emblema.png")
      #text(20pt)[Julio, 20XX]
      #v(1cm)
      #text(16pt)[Trabajo de Fin de Grado Nº: #number]
      #v(0.5cm)
      #text(14pt)[Título: #title]
      #v(0.5cm)
      #text(12pt)[Área de conocimiento: #area]
      #v(0.5cm)
      #text(12pt)[Departamento: #department]
    ]
  }


  grid(
    columns: (1fr, 3fr),
    column-gutter: 0.6cm,
    image("images/emblema.png"),
    align(left)[
      #v(1mm)
      #date \
      Traballo de Fin de Grao Nº #tfg-num\

      Titor: #tutor\
      Área de coñecemento: #area\
      Departamento: #departamento
    ]
  )

  v(2fr)

  set par(justify: true, first-line-indent: 0em, leading: 1em, hanging-indent: 0em)
  set align(center + horizon)

  // Table of contents
  // Outline customization
  // show outline.entry.where(level: 1): it => {
  //   if it.body != [References] {
  //   v(12pt)
  //   link(it.element.location(), strong({
  //     it.body
  //     h(1fr)
  //     it.page
  //   }))}
  //   else {
  //     text(size: 1em, it)
  //   }
  // }

  show outline.entry.where(level: 3): it => {
    text(size: 0.8em, it)
  }

  par(justify: true, hanging-indent: 0em)[#outline(depth: 3, indent: auto)]

  // Main body

  show link: underline
  set page(numbering: "1")
  set align(top + left)
  counter(page).update(1)


  body

  // Bibliography / Bibliografía
  if bibliography != none {
    heading(
      level: 1,
      numbering: none,
      if lang == "en" { "References" } else { "Bibliografía" }
    )
    show std-bibliography: set text(size: 0.9em)
    set std-bibliography(title: none)
    bibliography
  }
}

// Languages
#let en = it => text(lang: "en", style: "italic", it)
#let es = it => text(lang: "es", style: "italic", it)
#let lat = it => text(lang: "lat", style: "italic", it)
#let gal = it => text(lang: "gal", style: "italic", it)

// Helpful highlights
#let notes = it => box(fill: yellow, inset: 5%, it)
#let todo = it => highlight(fill: yellow, extent: 1pt)[*TODO:* #it]
