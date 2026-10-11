#import "constants.typ": *
#import "acronyms.typ": *

#let insertCoverText = {
  align(center)[
    #text(size: 18pt, weight: "bold")[
      #title
    ]
    #v(24mm)
    #text(size: 14pt, weight: "bold")[
      #document_type_phrase
    ]
  ]

  if document_type == "T3_3300" [
    #align(center)[
      #v(12mm)
      für die Prüfung zum
      #v(3mm)
      #degree
    ]
  ]

  align(center)[
    #v(12mm)
    #study_program
    #v(3mm)
    #university
    #v(12mm)
    von
    #v(3mm)
    #text(size: 14pt, weight: "bold")[
      #author
    ]
    #v(12mm)
    #date
  ]
}

#let insertCompanyImage = [
  #grid(
    columns: (1fr, 1fr, 1fr),
    align: (left, center, right),
    if show_company {
      image("../resources/logo-company.png", height: 1.5cm)
    } else {
      []
    },
    [],
    image("../resources/logo-dhbw.png", width: 4cm)
  )
]

#let create_header() = {
  insertCompanyImage
  line(length: 100%)
}

// Define a function to create footers
#let create_footer() = context {
  line(length: 100%)
  grid(
    columns: (1fr, 1fr, 1fr),
    align: (left, center, right),
    document_type_phrase,
    author,
    [Seite #counter(page).display("1")]
  )
}

// Styling settings
// #set page(
//   margin: (top: 4cm, bottom: 4cm, left: 2.5cm, right: 2.5cm), 
//   header: create_header(),
//   footer: context create_footer,
//   numbering: "1"
// )
// #set text(font: "Arial", size: 12pt)
// #set par(justify: true, leading: 1.5em)

#let importChapter(file) = {
  include file
  pagebreak()
}

#let insertBibliography = {
  // Bibliography
  bibliography("../resources/quellen.bib", title: "Literaturverzeichnis", style: "ieee")
  v(1fr)
}

#let insertListOfFigures = {
  // List of figures
  pagebreak()
  outline(title: "Abbildungsverzeichnis", target: figure.where(kind: image))
  v(1fr)
}

#let insertListOfTables = {
  // List of tables
  pagebreak()
  outline(title: "Tabellenverzeichnis", target: figure.where(kind: table))
  v(1fr)
}

#let insertListOfScripts = {
  // List of code listings
  pagebreak()
  outline(title: "Skriptverzeichnis", target: figure.where(kind: raw))
  v(1fr)
}

#let codeListing(
  file,
  lang: "python",
  start: 1,
  end: none,
  numberStart: 1,
  showBox: false,
  fill: rgb("F2F2F2"),
  stroke: rgb("B8B8B8"),
  inset: 0.8em,
  radius: 0.2em,
) = context {
  let lines = read(file).split("\n")
  let stop = if end == none { lines.len() } else { calc.min(end, lines.len()) }
  let snippet = lines.slice(calc.max(0, start - 1), stop).join("\n")

  let listing = {
    show raw.line: line => [#(numberStart - 1 + line.number) #h(0.75em) #line.body]
    raw(snippet, block: true, lang: lang)
  }

  if showBox [
    #box(
      fill: fill,
      stroke: stroke,
      inset: inset,
      radius: radius,
    )[
      #listing
    ]
  ] else [
    #listing
  ]
}

#let insertAppendix = {
// Appendix
  pagebreak()
  heading(numbering: "A")[Anhang]
  include "../content/999_appendix.typ"
  v(1fr)
}

#let insertAcronyms = {
  // Abbreviations
  pagebreak()
  heading(outlined: true)[Abkürzungsverzeichnis]
  v(1em)
  printAcronyms
  v(1fr)
}

