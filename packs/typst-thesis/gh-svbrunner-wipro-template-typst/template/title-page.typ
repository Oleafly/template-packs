#let document-property(title: "", info: "") = {
  if info != "" {
    [/ #title\:: #info]
  }
  v(.25em)
}

#let checkbox(info: "", checked: false) = box[
  #box(
    width: 1em,
    height: 1em,
    stroke: 0.5pt + black,
    inset: 0.1em,
    baseline: 0.15em,
  )[#if checked [#text(size: 0.8em)[✓]] else [] ]
  #h(0.3em)
  #info
]


#let signature(student: none) = {
  if student != none {
    text(size: 9pt)[#student]
    v(.25em)
  }
  grid(
    columns: (auto, 1fr),
    gutter: 0.75em,
    align: bottom,
    [Ort / Datum, Unterschrift], line(length: 100%, stroke: 1pt + gray),
  )
}

#let title-spread(
  logo: image,
  document-kind: "",
  title: "",
  students: (),
  year: "",
  institution: "",
  study-program: "",
) = {
  let school = if institution == "" { "Hochschule Luzern" } else { institution }

  logo

  align(center)[
    #v(1fr)

    #text(size: 12pt)[
      Departement Informatik
      #linebreak()
      #school (Schweiz)
    ]

    #v(1.2fr)

    #text(size: 15pt, weight: "bold")[#document-kind]
    #v(.8em)
    #text(size: 24pt, weight: "bold")[#title]

    #v(1.4fr)

    #text(size: 11pt)[vorgelegt am Departement Informatik der Hochschule Luzern (Schweiz)]

    #v(1fr)

    #text(size: 11pt)[von]
    #v(.4em)
    #text(size: 15pt)[
      #students.map(student => text(weight: "bold")[#student]).join(" und ")
    ]

    #v(1fr)

    #if study-program != "" [
      #text(size: 11pt)[Studiengang]
      #linebreak()
      #text(size: 13pt)[#study-program]
    ]

    #v(.8fr)

    #if year != "" [
      #text(size: 12pt)[#year]
    ]

    #v(1fr)
  ]
}

#let declaration-page(
  document-kind: "",
  title: "",
  students: (),
  year: "",
  study-program: "",
  supervisor: "",
  expert: "",
  client: "",
  public: false,
  secret: false,
) = {
  text()[= #document-kind an der Hochschule Luzern - Informatik]
  v(1em)

  document-property(title: "Titel", info: title)

  for student in students [
    #document-property(title: "Student", info: student)
  ]

  document-property(title: "Studiengang", info: study-program)
  document-property(title: "Jahr", info: year)
  document-property(title: "Betreuungsperson", info: supervisor)
  document-property(title: "Expertenperson", info: expert)
  document-property(title: "Auftraggeberin / Auftraggeber", info: client)

  v(.5em)

  text()[
    *Codierung / Klassifizierung der Arbeit:*
  ]
  linebreak()
  checkbox(info: "Öffentlich (Normalfall) ", checked: public)
  linebreak()
  checkbox(info: "Vertraulich ", checked: secret)

  v(2em)

  text()[
    *Eidesstattliche Erklärung*

    Ich erkläre hiermit, dass ich/wir die vorliegende Arbeit selbständig und ohne unerlaubte fremde Hilfe angefertigt habe/n. Alle verwendeten Quellen, Literatur und Hilfsmittel (insbesondere künstliche Intelligenz oder sonstige verwendete Instrumente) wurden urheberrechts- und datenschutzkonform verwendet und wörtlich oder inhaltlich entnommene Stellen als solche kenntlich gemacht. Das Vertraulichkeitsinteresse des Auftraggebers wurde gewahrt und die Urheberrechtsbestimmungen der Hochschule Luzern respektiert.
  ]

  v(1em)

  for student in students [
    #signature(student: student)
    #v(1em)
  ]

  v(1fr)

  text(style: "italic")[
    Geistiges Eigentum gemäss der
    #link("https://srl.lu.ch/app/de/texts_of_law/521/versions/3884")[
      #underline()[ Studienordnung]
    ]
    für die Ausbildung an der Hochschule Luzern, FH Zentralschweiz
  ]
}

#let title-page(
  logo: image,
  document-kind: "Wirtschaftsprojekt",
  title: "",
  students: (),
  year: "",
  institution: "",
  study-program: "",
  supervisor: "",
  expert: "",
  client: "",
  public: false,
  secret: false,
  scanned-signature-page: none,
  acknowledgements: none,
) = {
  title-spread(
    logo: logo,
    document-kind: document-kind,
    title: title,
    students: students,
    year: year,
    institution: institution,
    study-program: study-program,
  )
  pagebreak()

  if scanned-signature-page != none {
    scanned-signature-page
  } else {
    declaration-page(
      document-kind: document-kind,
      title: title,
      students: students,
      year: year,
      study-program: study-program,
      supervisor: supervisor,
      expert: expert,
      client: client,
      public: public,
      secret: secret
    )
  }
  
  if acknowledgements != none {
    pagebreak()
    text()[= Danksagung]
    v(1em)
    acknowledgements
  }
  pagebreak()
}
