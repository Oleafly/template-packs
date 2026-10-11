// references:
// https://tu-freiberg.de/zuv/dezernat-5-universitaetskommunikation/corporate-design
// https://tu-freiberg.de/zuv/d5/corporate-design/markenlogo
// https://tu-freiberg.de/corporate-design/typografie
// https://tu-freiberg.de/zuv/d5/corporate-design/farbdefinition

#let colors = (
  Uniblau:    rgb("#0069b4"),
  Dunkelblau: rgb("#00497f"),
  Schwarz:    rgb("#000000"),
  Weiß:       rgb("#ffffff"),
  Geo:        rgb("#8b7530"),
  Material:   rgb("#007b99"),
  Energie:    rgb("#b71e3f"),
  Umwelt:     rgb("#15882e"),
)

#let sizes = (
  title: 20pt,
  subtitle: 16pt,
  subsubtitle: 14pt,
  large: 12pt,
  normal: 10pt,
  small: 9pt,
)

#let translation = (
  "en": (
    section: "section",
    image: "Figure",
    table: "Table",
    algorithm: "Algorithm",
    supervisor: "Supervisor",
    examiner: "Examiner",
    theorem: "Theorem",
    corollary: "Corollary",
    definition: "Definition",
    example: "Example",
    proof: "Proof",
    studentID: "Student-ID",
    bibliography: "Bibliography",
    table_of_figures: "Table of Figures",
    table_of_tables: "Table of Tables",
    declaration_of_authenticity: "Declaration of Authenticity",
    note: "Note",
    tip: "Tip",
    warning: "Warning",
    important: "Important",
    danger: "Danger",
    months: (
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    )
  ),
  "de": (
    section: "Abschnitt",
    image: "Abbildung",
    table: "Tabelle",
    algorithm: "Algorithmus",
    supervisor: "Betreuer",
    examiner: "Prüfer",
    theorem: "Satz",
    corollary: "Folgerung",
    definition: "Definition",
    example: "Beispiel",
    proof: "Beweis",
    studentID: "Matrikelnummer",
    bibliography: "Literatur",
    table_of_figures: "Abbildungsverzeichnis",
    table_of_tables: "Tabellenverzeichnis",
    declaration_of_authenticity: "Eigenständigkeitserklärung",
    note: "Hinweis",
    tip: "Tipp",
    warning: "Warnung",
    important: "Wichtig",
    danger: "Gefahr",
    months: (
      "Januar",
      "Februar",
      "März",
      "April",
      "Mai",
      "Juni",
      "July",
      "August",
      "September",
      "Oktober",
      "November",
      "Dezember",
    )
  ),
)

// https://github.com/typst/typst/issues/1295
#let in-outline = state("in-outline", false)
#let flex-caption(short: none, long: none) = context if state("in-outline", false).get() { short} else { long }

// colored boxes for notes, warnings, etc
#let _create-box(title, content, bg-color, text-color, border-color) = {
  block(
    fill: bg-color,
    stroke: (left: 3pt + border-color),
    inset: 1em,
    radius: 0.25em,
  )[
    #text(weight: "bold", fill: text-color)[#title]
    #text(fill: text-color)[#content]
  ]
}

#let note(lang: "en", content) = _create-box(
  [#translation.at(lang).note: ],
  content,
  colors.Uniblau.lighten(80%),
  colors.Dunkelblau,
  colors.Uniblau,
)

#let tip(lang: "en", content) = _create-box(
  [#translation.at(lang).tip: ],
  content,
  rgb("#d4edda").lighten(20%),
  rgb("#155724"),
  rgb("#28a745"),
)

#let warning(lang: "en", content) = _create-box(
  [#translation.at(lang).warning: ],
  content,
  rgb("#fef3cd").lighten(20%),
  rgb("#856404"),
  rgb("#ffc107"),
)

#let important(lang: "en", content) = _create-box(
  [#translation.at(lang).important: ],
  content,
  rgb("#f8d7da").lighten(20%),
  rgb("#721c24"),
  rgb("#dc3545"),
)

#let danger(lang: "en", content) = _create-box(
  [#translation.at(lang).danger: ],
  content,
  rgb("#f8d7da"),
  rgb("#721c24"),
  rgb("#dc3545"),
)

#let longdate(
  lang: "en",
  datetime,
) = [
  #datetime.day(). 
  #translation.at(lang).months.at(datetime.month() - 1) 
  #datetime.year()
]

#let declaration_of_authenticity(
  authors,
  datetime,
  location,
  lang: "en",
) = {
  set page(header: none, footer: none)
  v(1fr)
  text(size: sizes.large, weight: "bold")[#translation.at(lang).declaration_of_authenticity]
  v(1em)
  if lang == "en" {
    [#if authors.len() == 1 [I] else [We] hereby declare that #if authors.len() == 1 [I] else [we] have written this term paper independently and without outside assistance, that #if authors.len() == 1 [I] else [we] did not use any other sources apart from the ones stated in the bibliography and that #if authors.len() == 1 [I] else [we] have clearly cited all passages in #if authors.len() == 1 [my] else [our] work that were taken from other sources. This term paper has never been previously submitted in its current or similar form in any other course and/or degree programme.]
  }
  if lang == "de" {
    [Hiermit #if authors.len() == 1 [versichere ich] else [versichern wir], dass #if authors.len() == 1 [ich] else [wir] die vorliegende Arbeit ohne unzulässige Hilfe Dritter und ohne Benutzung anderer als der angegebenen Hilfsmittel angefertigt #if authors.len() == 1 [habe] else [haben]. Die aus fremden Quellen direkt oder indirekt übernommenen Gedanken sind als solche kenntlich gemacht.]
  }
  v(2cm)
  line(length: 6cm, stroke: 0.5pt)
  for author in authors {
    author.name
    linebreak()
    [#location, #longdate(datetime, lang: lang)]
  }
  v(1fr)
}

#let report(
  type: "",
  title: "",
  subtitle: "",
  authors: (
    (
      title: "", 
      name: "", 
      birth-date: "", 
      email: "",
      studentID: "",
    )
  ),
  supervisors: (
    (
      title: "",
      name: "",
    )
  ),
  examiners: (
    (
      title: "",
      name: "",
    )
  ),
  location: "Freiberg",
  lang: "en",
  decl_authenticity: true,
  extra_outlines: (),
  references: "",
  body,
) = {
  // general (1)
  set page(paper: "a4", margin: (left: 4cm, top: 25mm, bottom: 20mm))
  set text(font: "Arial", lang: lang, bottom-edge: "descender", top-edge: "cap-height")
  set par(justify: true, leading: .5em)   // 1.5 line spacing


  // cover page
  counter(page).update(1)
  {
    set par(justify: false)
    image("TUBAF_Logo_blau.svg", width: 42mm)
    v(5mm)
    text(fill: colors.Dunkelblau, size: sizes.small)[*Fakultät für Mathematik und Informatik*\ Institut für Informatik]
    v(1fr)
    text(size: sizes.subtitle)[#type]
    v(0pt)
    text(size: sizes.title)[*#title*]
    if subtitle != "" {
      v(0.5cm)
      text(size: sizes.large, weight: "semibold")[#subtitle]
    }
    v(1cm)
    for author in authors {
      text(size: sizes.large)[#author.name]
      linebreak()
      text(size: sizes.small)[#translation.at(lang).studentID: #author.studentID]
    }
    v(1fr)
    text(size: sizes.large)[#translation.at(lang).supervisor #linebreak()]
    for supervisor in supervisors {
      text(size: sizes.large, weight: "semibold")[#supervisor.title #supervisor.name #linebreak()]
    }
    v(1cm)
    text(size: sizes.large)[#translation.at(lang).examiner #linebreak()]
    for examiner in examiners {
      text(size: sizes.large, weight: "semibold")[#examiner.title #examiner.name #linebreak()]
    }
    v(1cm)
  }


  // declaration of authenticity
  if decl_authenticity {
    declaration_of_authenticity(authors, datetime.today(), location, lang: lang)
  }
  

  // general (2)
  show heading: set block(below: 1em, above: 2.5em)
  set heading(numbering: "1.1.1")
  set heading(supplement: translation.at(lang).section)
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    set text(size: sizes.title)
    v(3em)
    it
    v(1em, weak: true)
    line(length: 100%, stroke: 0.5pt)
    v(1em)
  }
  show heading.where(level: 2): set text(size: sizes.subtitle)
  show heading.where(level: 3): set text(size: sizes.subsubtitle)

  set page(footer: context {              // left-right page counter
    if calc.even(here().page()) [
      #counter(page).display()
    ] else [
      #h(1fr)
      #counter(page).display()
    ]
  })

  set math.equation(numbering: "(1)")
  set math.mat(delim: "(")
  show math.equation.where(block: true): set par(justify: true, leading: 1em)
  
  set list(spacing: 1em)
  set enum(spacing: 1em, numbering: "1)")

  // figures
  show figure: set block(above: 2em, below: 2em)
  show figure: set figure(gap: 0.8em)
  show figure.caption: c => block(width: 94%)[
    #text(size: sizes.small)[*#c.supplement #c.counter.display(c.numbering)#c.separator* #c.body]
  ]

  // list of contents
  set page(numbering: "I")
  outline(indent: 0.5cm)
  pagebreak()

  show outline: it => {
    in-outline.update(true)
    it
    in-outline.update(false)
  }

  // list of images
  let image-outline() = {
    show outline: set heading(outlined: true)
    outline(title: translation.at(lang).table_of_figures, target: figure.where(kind: image))
  }
  image-outline()


  // list of tables
  let table-outline() = {
    show outline: set heading(outlined: true)
    outline(title: translation.at(lang).table_of_tables, target: figure.where(kind: table))
  }
  table-outline()


  // additional outlines
  for outline in extra_outlines [#outline()]

  // body
  pagebreak(weak: true)
  counter(page).update(1)
  set page(numbering: "1")
  set text(size: sizes.normal)
  body


  // bibliography
  if references != "" {
    bibliography(references, title: translation.at(lang).bibliography)
  }
}
