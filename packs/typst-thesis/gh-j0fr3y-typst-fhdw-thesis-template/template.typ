#let value(meta, key, default: none) = meta.at(key, default: default)

#let joined(value, separator: ", ") = {
  if value == none {
    none
  } else if type(value) == array {
    value.join(separator)
  } else {
    value
  }
}

#let cover-page(meta) = {
  set page(numbering: none)
  align(center + horizon, block(inset: 0pt)[
    #if value(meta, "logo") != none [
      #image(value(meta, "logo"), width: 4.8cm)
      #v(1.6cm)
    ]

    #text(22pt, weight: "bold")[#value(meta, "thesis-type", default: "Bachelorthesis")]
    #v(1.2cm)

    #text(18pt, weight: "semibold")[#value(meta, "title", default: "Titel der Arbeit")]
    #if value(meta, "subtitle", default: "") != "" [
      #v(0.35cm)
      #text(13pt)[#value(meta, "subtitle")]
    ]

    #v(1.8cm)

    #if value(meta, "examiner") != none [
      #text(11pt, weight: "semibold")[Pruefer(in)]
      #v(0.2cm)
      #text(11pt)[#joined(value(meta, "examiner"))]
      #v(1.1cm)
    ]

    #text(11pt, weight: "semibold")[Verfasser(in)]
    #v(0.2cm)
    #text(11pt)[#value(meta, "author", default: "Max Mustermann")]
    #if value(meta, "student-id", default: "") != "" [
      #linebreak()
      #value(meta, "student-id")
    ]
    #if value(meta, "address", default: "") != "" [
      #linebreak()
      #value(meta, "address")
    ]
    #if value(meta, "city", default: "") != "" [
      #linebreak()
      #value(meta, "city")
    ]

    #if value(meta, "program", default: "") != "" or value(meta, "specialization", default: "") != "" [
      #v(1.1cm)
      #if value(meta, "program", default: "") != "" [
        #text(11pt)[#value(meta, "program")]
      ]
      #if value(meta, "specialization", default: "") != "" [
        #linebreak()
        #value(meta, "specialization")
      ]
    ]

    #v(1.5cm)
    #text(11pt, weight: "semibold")[Eingereicht am]
    #v(0.2cm)
    #text(11pt)[#value(meta, "submission-date", default: value(meta, "date", default: ""))]
  ])
  pagebreak()
}

#let frontmatter-title(title) = [
  #align(center)[#text(16pt, weight: "bold")[#title]]
  #v(0.75cm)
]
