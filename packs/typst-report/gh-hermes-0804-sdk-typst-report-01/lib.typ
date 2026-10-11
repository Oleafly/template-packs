// -----*****-----
// ABOUT THIS TEMPLATE
// -----*****-----
// Report designed by Sundekant
// Adapted from template: structured-uib by AugustinWinther

// -----*****-----*****-----*****-----
// TEMPLATE FUNCTION
// -----*****-----*****-----*****-----
#let report(
  project: (),
  revisions: (),
  body
) = {

  // -----*****-----*****-----*****-----
  // DOCUMENT METADATA
  // -----*****-----*****-----*****-----
  set document(
    title: [#project.code - #project.document],
    author: "YVT",
    date: datetime.today()
  )

  // -----*****-----*****-----*****-----
  // DOCUMENT LANGUAGE
  // -----*****-----*****-----*****-----
  set text(lang: "es")

  // -----*****-----*****-----*****-----
  // DOCUMENT FONTS
  // -----*****-----*****-----*****-----
  set text(font: "New Computer Modern")
  show math.equation: set text(font: "New Computer Modern Math")

  // -----*****-----*****-----*****-----
  // COVER PAGE
  // -----*****-----*****-----*****-----º
  set page(paper: "a4", margin: (left: 27mm, right: 27mm, top: 20mm, bottom:30mm))

  v(10mm)

  // COMPANIES LOGOTIPES
  table(
    columns: (0.2fr, 1fr, 1fr, 0.2fr),
    stroke: none,
    align: horizon+center,
    column-gutter: 5mm,
    [],
    [#image("assets/logo_client.png", fit: "contain")], 
    [#image("assets/logo_consulting.png", fit: "contain")],
    [],
  )

  v(5mm)

  // PROJECT TITLE

  v(5mm)

  line(length: 16cm, stroke: 0.1cm)
  align(center, text(size: 24pt, smallcaps[*#project.title*]))

  line(length: 16cm, stroke: 0.1cm)

  // PROJECT GENERAL INFORMATION

  v(5mm) 

  align(center, text(size: 20pt, smallcaps[*#project.document*]))
  align(center, text(size: 20pt, smallcaps[*#project.code*]))
  align(center, text(size: 20pt, smallcaps[*#project.discipline*]))
  align(center, text(size: 20pt, [*#project.revision*]))
  align(center, text(size: 12pt, [APROBADO POR:]))

  v(5mm)

  // MAIN PROJECT STAKEHOLDERS
  table(  
    columns: (0.75fr, 1fr, 1fr),
    rows:(10mm, 10mm, 10mm),
    stroke: none,
    align: (bottom+left, bottom+left, bottom+left),
    row-gutter: 0mm,
    [Jefe de disciplina:], [#project.specialist], [],
    table.hline(start: 2),
    [Jefe de proyecto:], [#project.manager], [],
    table.hline(start: 2),
    [Cliente:], [#project.client], [],
    table.hline(start: 2),
  )
  v(5mm)

  pagebreak()

  // -----*****-----*****-----*****-----
  // SETUP AFTER COVER
  // -----*****-----*****-----*****-----
  // 
  // PAGE SETUP
  set page(
    paper: "a4",
    margin: (left: 27mm, right: 20mm, top: 45mm, bottom:30mm),
    //numbering: "1/1",
    header-ascent: 15pt,
    header: context [
      #set text(10pt)
      #table(
        align: (horizon+center),
        columns: (1.5in,3fr,1fr,1in),
        fill: white,
          [#project.code\ #project.revision],
          [#project.document\ #project.title\ #project.discipline],
          [#project.date\ Pág. #here().page()],
          [#image("assets/logo_client.png")]
      )
    ]
  )
  counter(page).update(1) // Skip first page in numbering

  // PARAGRAPH SETUP
  set par(
  first-line-indent: 1.8em,
  spacing: 1.25em,
  leading: 0.55em,
  justify: true,
  )

  // HEADING SETUP
  set heading(
  numbering: "1.",
  supplement: [capítulo]
  )
  show heading: set block(above: 1.4em, below: 1em)

  // LIST SETUP
  set enum(indent: 10pt, body-indent: 9pt)
  set list(indent: 10pt, body-indent: 9pt)

  // EQUATION SETUP
  set math.equation(numbering: "(1)")
  show math.equation: set block(spacing: 20pt)

  // FIGURE SETUP
  show figure: it => {
    align(center, 
    if it.kind == image or it.kind == raw {
      text(10pt, [*#it.supplement #it.counter.display(it.numbering)*: _ #it.caption.body _])
      v(-6pt)
      it.body
    } else if it.kind == table {
      text(10pt, [*#it.supplement #it.counter.display(it.numbering)*: _ #it.caption.body _])
      v(-6pt)
      it.body
    })
  v(15pt, weak: true)
  }
  
  // TABLE SETUP
  set table(fill: (_, row) => if row == 0 { luma(220) } else { white })
  show table: it => {
    set par(justify: false,)
    set align(center)
    it
  }

  // LINK SETUP
  show link: it => {
      text(fill: rgb("#00F"), it)
  }

  // REFERENCE SETUP
  show ref: it => {
      text(fill: rgb("#000000"), weight: "bold", it)
  }

  // FOOTNOTE SETUP
  //show footnote: it => {
  //    text(fill: rgb("#000000"), weight: "bold", it)
  //}

  // OUTLINE SETUP
  set outline(indent: auto, depth: 3)


  // BIBLIOGRAPHY SETUP
  set bibliography(title: "Bibliografía")


  // -----*****-----*****-----*****-----
  // REVISION TABLE
  // -----*****-----*****-----*****-----
  table(
  columns: 1fr,
  rows: 10mm,
  table.cell(align: horizon+center)[*TABLA DE REVISIONES*]
  )
  let count = revisions.len()
  let nrows = calc.min(count)
  table(
    columns: (0.5fr, 0.70fr, 1.5fr, 0.70fr, 0.6fr, 0.6fr),
    rows: (auto, 10mm, 10mm, 10mm, 10mm, 10mm,10mm,10mm,10mm,10mm,10mm,10mm,10mm,10mm, 10mm, 10mm),
    align: horizon+center,
    table.header(
      [*Rev.*], [*Hecho Por*], [*Descripción*], [*Fecha*], [*Revisado*], [*Aprobado*],
    ),
    ..revisions.map(revision => [#revision.one]), 
    ..revisions.map(revision => [#revision.two]),
    ..revisions.map(revision => [#revision.three]), 
  )
  table(
    columns: 1fr,
    rows: 30mm,
    fill: white,
    table.cell(align: top+left)[COMENTARIOS DEL CLIENTE:]
  )

  pagebreak()

  // -----*****-----*****-----*****-----
  // REPORT CONTENT
  // -----*****-----*****-----*****-----
  body

  // 

}
