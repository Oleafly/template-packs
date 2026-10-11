#import "@preview/polylux:0.4.0": *
#import "uds-theme.typ": *

#show: uds-theme.with(
  short-author: "N.N.",
  short-title: "Kurztitel",
  short-date: "19.\u{2009}03.\u{2009}2026",
)

#title-slide(
  title: "Titel",
  author: "Nomen nominandum",
  date: "19.\u{2009}03.\u{2009}2026",
)

#uds-slide(title: "Inhalt")[]

#uds-slide(title: "Titel der Folie")[
  - Erster Punkt
  - Zweiter Punkt
  - Dritter Punkt

  #v(1em)
  Blindtext
]

// Roter Abschnitt
#section-slide(color: uds-rot)[
  #text(size: 32pt)[Roter Abschnitt]
  #v(4mm)
  #text(size: 14pt)[(der Präsentation)]
]

// Gelber Abschnitt
#section-slide(color: uds-gelb)[
  #text(size: 32pt)[Gelber Abschnitt]
  #v(4mm)
  #text(size: 14pt)[(der Präsentation)]
]

// Dunkelblauer Abschnitt
#section-slide(color: uds-dunkelblau)[
  #text(size: 32pt)[Dunkelblauer Abschnitt]
  #v(4mm)
  #text(size: 14pt)[(der Präsentation)]
]

// Trennfolie (Eule)
#eule-slide()[
  #v(1em)
  #text(size: 32pt)[Trennfolie]
  #v(4mm)
  #text(size: 14pt)[(ein neuer Teil der Präsentation)]
]

// Block-Strukturen
#uds-slide(
  title: [Die #raw("block")-Strukturen der #raw("beamer")-Klasse],
)[
  #uds-block(title: [Die #raw("block")-Umgebung])[
    (Der Inhalt der Umgebung)
  ]
  #uds-alertblock(title: [Die #raw("alertblock")-Umgebung])[
    (Der Inhalt der Umgebung)
  ]
  #uds-exampleblock(title: [Die #raw("exampleblock")-Umgebung])[
    (Der Inhalt der Umgebung)
  ]
]

// Schlussfolie
#final-slide(message: "Alláa dann!")
