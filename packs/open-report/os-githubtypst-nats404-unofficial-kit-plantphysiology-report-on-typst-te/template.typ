#let in-outline = state("in-outline", false)
#let flex-caption(short, long) = context if in-outline.get() [ #short ] else [ #short #linebreak() #text(weight: "regular", long) ]


#let pflanzenphys-protokoll(
  title: [thesis title],
  author: "author name",
  ID: " ",
  email: " ",
  year: " ",
  group: " ",
  acronyms:(:),
  bibliography: none,
  body
)={
  set document(title: title, author: author)
  set heading(numbering: "1.1.")
  set text(size: 11pt, font: "arial", hyphenate: true, lang: "de")
  set par(justify: true)

  //line spacing
  let leading = 1.5em
  let leading = leading - 0.75em
  set block(spacing: leading)
  set par(spacing: leading)
  set par(leading: leading)
  set text(top-edge: 1em)

  // heading specs
  show heading: it => {
    let sizes = (25pt, 18pt, 15pt, 12pt, 12pt, 12pt)
    let spacings = (2em, 1.6em, 1.3em, 1.1em, 1em, 1em)
    let level = it.level - 1
    let size = if level < sizes.len() { sizes.at(level) } else { 11pt }
    let spacing = if level < spacings.len() { spacings.at(level) } else { 1em }

    // Apply size, weight and spacing for all headings and add pagebreak
    if it.level == 1 and it.numbering != none and it.body != [Einleitung]{
        pagebreak()
    }

    text(size: size, weight: "bold")[#it]
    v(spacing, weak: true)
  }



  // caption position of figures
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.caption.where(kind: table): it => {
    text(size: 10pt, weight: "bold")[#it]
  }

  show figure.caption.where(kind: image): it=>{
    text(size: 10pt, weight: "bold")[#it]
  }

  // COVER PAGE

  align(center)[Pflanzenphysiologisches Praktikum #year]

  v(14em)

  align(horizon)[
      #par(leading: 3.5em, text(size: 35pt, weight: "bold")[#title])
    ]

  v(25%)

  align(right)[
    #text(size: 13pt)[#group]

    #text(size: 23pt, weight: "bold")[#author]

    #v(1em)

    #text(size:13pt)[Matrikelnummer: #ID]

    #text[E-Mail: #email]
  ]

  pagebreak()

  // Roman numerals as page numbering
  set page(numbering: "I")
  counter(page).update(1)

  show outline.entry: it => {
    v(12pt, weak: true)
    strong(it)
  }

  outline(title: text(size: 25pt, weight: "bold")[Inhaltsverzeichnis])
  pagebreak()

  //Abkürzungsverzeichnis
  if acronyms != none {
  heading(level: 1, numbering: none)[Abkürzungsverzeichnis]
    table(
       columns: (25%, 75%),
       row-gutter: (4pt),
       stroke: 0pt,
       align: (center, left),
       table.header(
         [*Abkürzung*], [*Definition*]
       ),
      ..acronyms.pairs().map(((key, value)) => (key, value)).flatten()
    )
    pagebreak()
  }

  // Show no caption in Abbildungsverzeichnis/Tabellenverzeichnis
  show outline: it => {
    in-outline.update(true)
    it
    in-outline.update(false)
  }

  // Abbildunsgverzeichnis
  heading(level: 1, numbering: none)[Abbildungsverzeichnis]
  outline(title: none, target: figure.where(kind: image))
  pagebreak()

  // Tabellenverzeichnis
  heading(level: 1, numbering: none)[Tabellenverzeichnis]
  outline(title: none, target: figure.where(kind: table))
  pagebreak()

  // Main content with arabic numerals
  [
    #metadata(none) <main>
  ]
  set page(numbering: "1")
  counter(page).update(1)


  // bibliography
  show std.bibliography: set par(spacing: 1em, leading: 0.5em)
  set std.bibliography(title: [Literaturverzeichnis], style: "apa")

  body

  pagebreak()

  //Eidestattliche Erklärung
  heading(level: 1, numbering: none)[Eidesstattliche Erklärung]
  text[Ich versichere wahrheitsgemäß, die Arbeit selbstständig angefertigt, alle benutzten Hilfsmittel vollständig und genau angegeben und alles kenntlich gemacht zu haben, was aus Arbeiten anderer unverändert oder mit Abänderungen entnommen wurde \ (§ 6 Absatz 7 der Studien- und Prüfungsordnung (SPO) des KIT in der Fassung vom 27.6.2017)]
  v(25pt)
  grid(
    rows: 3cm,
    columns: 3,
    gutter: 1fr,
    [Datum:],
    [Unterschrift:]
  )

  // turning back page numbering
  pagebreak()
  set page(numbering: "I")
  context {
    counter(page).update(counter(page).at(<main>))
  }

/*  heading(level: 1, numbering: none)[Eidesstattliche Erklärung]
  text[Ich versichere wahrheitsgemäß, die Arbeit selbstständig angefertigt, alle benutzten Hilfsmittel vollständig und genau angegeben und alles kenntlich gemacht zu haben, was aus Arbeiten anderer unverändert oder mit Abänderungen entnommen wurde \ (§ 6 Absatz 7 der Studien- und Prüfungsordnung (SPO) des KIT in der Fassung vom 27.6.2017)]
  v(25pt)
  grid(
    rows: 3cm,
    columns: 3,
    gutter: 1fr,
    [Datum:],
    [Unterschrift:]
  )

  pagebreak()*/

  bibliography
}
