#import "languages.typ": t

#let document-property(title: "", info: "") = {
  [/ #title\:: #info]
  v(.25em)
}

#let checkbox(info: "", checked: false) = box[
  #box(
    width: 1em,
    height: 1em,
    stroke: 0.5pt + black,
    inset: 0.1em,
    baseline: 0.15em,
  )[
    #if checked [#text(size: 0.8em)[✓]] else []
  ]
  #h(0.3em)
  #info
]

#let signature(language: "de") = {
  grid(
    columns: (auto, 1fr),
    gutter: 0.75em,
    align: bottom,
    t(language: language, key: "place-date-signature"), line(length: 100%, stroke: 1pt + gray),
  )
}

#let title-page(
  logo: image,
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
  thesis-type: "",
  scanned-signature-page: none,
  language: "de",
  gratitude: "",
) = {
  logo

  align(center)[

    #v(1fr)

    #text(size: 14pt)[
      #t(language: language, key: "department")
      #linebreak()
      #t(language: language, key: "institution")
    ]

    #v(1.5fr)

    #text(size: 24pt, weight: "bold")[#title]

    #v(2fr)

    #text(size: 16pt)[#upper(thesis-type)]

    #text(
      size: 11pt,
    )[#t(language: language, key: "submitted")]

    #v(2fr)

    #text(size: 11pt)[#t(language: language, key: "by")]

    #text(size: 15pt)[
      #(
        students
          .map(student => text(weight: "bold")[#student])
          .join(" " + t(language: language, key: "name-combine") + " ")
      )
    ]

    #v(1fr)

    #text(size: 11pt)[#t(language: language, key: "from")]

    #text(size: 15pt)[#t(language: language, key: "place")]

    #v(2fr)
  ]

  pagebreak()

  if scanned-signature-page != none {
    scanned-signature-page
  } else {
    text()[= #thesis-type #t(language: language, key: "submitted")]
    v(1em)

    document-property(title: t(language: language, key: "title"), info: title)

    for student in students [
      #document-property(title: t(language: language, key: "student"), info: student)
    ]

    document-property(title: t(language: language, key: "program"), info: study-program)

    document-property(title: t(language: language, key: "year"), info: year)
    document-property(title: t(language: language, key: "supervisor"), info: supervisor)
    document-property(title: t(language: language, key: "expert"), info: expert)
    document-property(title: t(language: language, key: "client"), info: client)

    v(.5em)

    text()[

      *#t(language: language, key: "classification")*
    ]
    linebreak()
    checkbox(info: t(language: language, key: "public"), checked: public)
    linebreak()
    checkbox(info: t(language: language, key: "confidential"), checked: secret)

    v(2em)

    text()[

      *#t(language: language, key: "declaration")*

      #t(language: language, key: "declaration-text")
    ]

    for _ in students [
      #signature(language: language)
    ]

    if gratitude != "" {
      pagebreak()

      gratitude

      align(bottom)[
        _#t(language: language, key: "intellectual-property")_
      ]
    } else {
      align(bottom)[
        _#t(language: language, key: "intellectual-property")_
      ]
    }
  }
}
