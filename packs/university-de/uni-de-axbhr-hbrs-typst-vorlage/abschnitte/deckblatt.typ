// ─── Deckblatt ───────────────────────────────────────────────────────────────
// Entspricht abschnitte/Deckblatt.tex
#import "../meta.typ": *

// Kopfzeile: Logo + Hochschulname
#grid(
  columns: (auto, 1fr),
  gutter: 12pt,
  // Logo
  align(bottom,
    image("../bilder/fhlogo.pdf", height: 4em)
  ),
  // Universitätsname
  align(left + bottom)[
    #text(weight: "bold")[Hochschule\ Bonn-Rhein-Sieg] \
    #text(style: "italic")[University of Applied Sciences] \
    \
    #text(weight: "bold")[Fachbereich #thesis-study-course-german] \
    #text(style: "italic")[Department of #thesis-study-course]
  ],
)

#v(0.15 * 29.7cm) // ≈ 0.15 × Seitenhöhe

// Arbeitstyp, Studiengang, Titel, Autor
#align(center)[
  #text(size: 24pt, weight: "bold")[#thesis-subject-type]

  #v(1em)
  #text(size: 14pt)[im #(thesis-type)-Studiengang #thesis-study-course-german]

  #v(0.10 * 29.7cm)

  #text(size: 24pt, weight: "bold")[#thesis-title]

  #v(1em)
  #text(size: 14pt, weight: "bold")[von]

  #v(0.5em)
  #text(size: 14pt, weight: "bold")[#thesis-author]
]

#v(0.10 * 29.7cm)

// Betreuer & Datum
#text(size: 14pt)[
  #table(
    columns: (auto, auto),
    stroke: none,
    inset: (x: 0pt, y: 3pt),
    column-gutter: 1em,
    [Betreuer:],    [#thesis-supervisor-first],
    // [Zweitbetreuer:], [#thesis-supervisor-second],
    // [Externer Betreuer:], [#thesis-supervisor-external],
    [Eingereicht am: ], [#thesis-pub-date],
  )
]
