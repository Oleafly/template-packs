#import "config/meta.typ": colors, page_margins

#let cover(
  title: "Titel der Arbeit",
  subtitle: none,
  authors: (
    (name: "Max Mustermann", matricle: "123456"),
    (name: "Erika Musterfrau", matricle: "654321"),
  ),
  submission_date: datetime.today(),
  study_year: "2024/2025",
  institution: "Hochschule/Universität",
  course: "Studiengang",
  supervisor: "Prof. Dr. Beispiel",
  location: "Stadt",
) = {
  set page(
    paper: "a4",
    margin: page_margins,
    numbering: none,
  )
  set text(font: "Georgia", size: 11pt, fill: colors.text)
  set par(justify: false)

  place(
    top + left,
    dx: -10mm,
    dy: -5mm,
    rect(width: 3mm, height: 30mm, fill: colors.accent),
  )

  v(5cm)

  block(
    breakable: false,
    [
      #text(size: 32pt, weight: "bold", fill: colors.text, tracking: -0.5pt)[
        #title
      ]

      #if subtitle != none [
        #v(1cm)
        #text(size: 14pt, fill: colors.subtle, style: "italic", tracking: 0.5pt)[
          #subtitle
        ]
      ]
    ],
  )

  v(1fr)

  block(
    breakable: false,
    [
      #text(size: 8pt, fill: colors.subtle, weight: "regular", tracking: 2pt)[
        #if authors.len() == 1 [AUTOR] else [AUTOREN]
      ]

      #v(0.5cm)

      #let author_list = (
        authors
          .map(author => (
            text(size: 11pt, fill: colors.text)[#author.name]
              + text(size: 8pt, fill: colors.subtle)[ · #author.matricle]
          ))
          .join(text(size: 8pt, fill: colors.subtle)[ · ])
      )

      #author_list
    ],
  )

  v(2cm)

  block(
    breakable: false,
    [
      #text(size: 9pt, fill: colors.subtle)[
        #institution
      ]

      #if course != none [
        #v(0.2cm)
        #text(size: 8pt, fill: colors.subtle, style: "italic")[
          #course
        ]
      ]
    ],
  )

  v(1fr)
  block(
    breakable: false,
    [
      #grid(
        columns: (auto, auto, auto),
        column-gutter: 2cm,
        row-gutter: 0.8cm,
        text(size: 7pt, fill: colors.subtle, tracking: 1pt)[ABGABE],
        [],
        text(size: 7pt, fill: colors.subtle, tracking: 1pt)[JAHRGANG],

        text(size: 9pt, fill: colors.text)[#submission_date.display("[day].[month].[year]")],
        [],
        text(size: 9pt, fill: colors.text)[#study_year],

        if supervisor != none [
          #text(size: 7pt, fill: colors.subtle, tracking: 1pt)[BETREUER]
        ] else [],
        [],
        if location != none [
          #text(size: 7pt, fill: colors.subtle, tracking: 1pt)[ORT]
        ] else [],

        if supervisor != none [
          #text(size: 9pt, fill: colors.text)[#supervisor]
        ] else [],
        [],
        if location != none [
          #text(size: 9pt, fill: colors.text)[#location]
        ] else [],
      )
    ],
  )
  v(1cm)
}
