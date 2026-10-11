// Copyright (C) 2026 DaubnerSchule

#let bg-dark  = rgb("#0B1929")
#let accent   = rgb("#3B82F6")
#let muted    = rgb("#94A3B8")
#let subtle   = rgb("#64748B")

#let protokol(
  title:   "Protokoltitel",
  name:    "NAME",
  class:   "class",
  teacher: "teacher",
  subject: "subject",
  body,
) = {
  set document(title: title)
  set text(font: "Arial", size: 14pt)

  // ── Titelseite ─────────────────────────────────────────────────────
  set page(
    paper: "a4",
    margin: 0cm,
    fill: bg-dark,
    background: {
      // Grosser dezenter Kreis unten-rechts als Tiefeneffekt
      place(bottom + right,
        circle(radius: 9cm, fill: rgb("#122640"), stroke: none)
      )
      // Schmaler Akzentstreifen rechts
      place(top + right,
        rect(width: 0.45cm, height: 29.7cm, fill: accent)
      )
    },
  )

  pad(left: 3.5cm, right: 2.5cm, top: 3.5cm, bottom: 3cm)[
    #image("../pic/htl-logo.png", width: 3.5cm)

    #v(3.5cm)

    #text(size: 8pt, fill: accent, tracking: 3pt, weight: "bold")[PROTOKOL]
    #v(0.35cm)

    #text(size: 34pt, weight: "bold", fill: white)[#title]
    #v(0.45cm)

    #line(length: 3cm, stroke: 2pt + accent)
    #v(0.55cm)

    #text(size: 11pt, fill: muted)[#teacher #h(0.8em) · #h(0.8em) #subject]

    #v(7cm)

    #text(size: 13pt, weight: "bold", fill: white)[#name]
    #linebreak()
    #text(size: 10pt, fill: subtle)[#datetime.today().display()]
  ]

  pagebreak()

  // ── Inhaltsseiten ──────────────────────────────────────────────────
  set page(
    paper: "a4",
    margin: auto,
    fill: white,
    background: none,
    header: [
      #align(center)[#datetime.today().display()]
    ],
    footer: [
      #context grid(
        columns: (1fr, 1fr, 1fr),
        align(left)[#class],
        align(center)[#name],
        align(right)[#counter(page).display()],
      )
    ],
  )

  set heading(numbering: "1.")
  outline(indent: 1em)

  body
}
