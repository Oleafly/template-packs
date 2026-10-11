// chapters/18-pinit-showcase.typ — Pinit Showcase

#import "../styles/theme.typ": fonts, palette, space, type-scale
#import "../components/spreads.typ": chapter-opener, section-break
#import "../components/blocks.typ": callout, card, code-block, key-concept, pull-quote, side-note
#import "../components/inline.typ": badge, icon-text, tag
#import "../components/grids.typ": feature-grid, gallery-grid
#import "../components/layouts.typ": comparison-layout
#import "../components/tables.typ": styled-table

#import "@preview/pinit:0.2.2": *
#import "@preview/in-dexter:0.7.2": index

#chapter-opener(
  title: [Pinit Showcase: Absolute Annotationen],
  lead: [
    Dieses Kapitel demonstriert die volle Leistungsfähigkeit des `@preview/pinit` Pakets. Es zeigt Best Practices für das "Anpinnen" von Positionen im Textfluss und deren anschließende absolute Annotation, ohne das Seitenlayout zu sprengen.
  ],
)

== Phase 1: Foundation and Basics#index[Pinit]

#card(title: [Einfache Highlights und Boxen])[
  #v(2em)

  Ein normaler Textblock mit einem #pin(1)Wort#pin(2) und einem weiteren #pin(3)Begriff#pin(4).

  // 1. ZWINGEND: Eine leere Zeile vor dem Pinit-Aufruf!
  #pinit-highlight(1, 2, fill: rgb(255, 0, 0, 40), radius: 3pt)
  #pinit-rect(3, 4, stroke: 1pt + rgb(0, 0, 255))

  // 2. ZWINGEND: Eine leere Box nach dem Aufruf!
  #box()

  #v(2em)
]

== Phase 2: Complex Vector Pointers#index[Annotation]

#card(title: [Komplexe Vektoren und Arrays])[
  #v(2em)

  Wir betrachten die Unterschiede zwischen #pin(5)body-dx/dy#pin(6) und #pin(7)offset-dx/dy#pin(8) an einem Array von Pins.

  #pinit-highlight(5, 6, fill: rgb(0, 255, 0, 40), radius: 3pt)
  #pinit-highlight(7, 8, fill: rgb(0, 255, 0, 40), radius: 3pt)

  // Recipe B: place label first, then draw arrow with empty body.
  // This keeps the box stable while tuning the connector.
  #pinit-place(dx: 36pt, dy: 50pt, (5, 6, 7, 8))[
    #block(
      inset: (x: 8pt, y: 5pt),
      width: 150pt,
      radius: 3pt,
      stroke: 0.8pt + palette.primary.lighten(35%),
      fill: white,
    )[
      #text(fill: palette.primary, weight: "bold")[Koordinaten-Erklärung] \
      body-dx/dy bestimmt den Pfeilvektor. offset-dx/dy verschiebt den gesamten Annotation-Anker.
    ]
  ]
  #box()

  #pinit-point-from(
    (5, 6, 7, 8),
    pin-dx: 0pt,
    pin-dy: 10pt,
    body-dx: 0pt,
    body-dy: 0pt,
    offset-dx: 36pt,
    offset-dy: 50pt,
    fill: palette.primary,
  )[]
  #box()

  #v(6em)
]

== Phase 3: Advanced Integrations#index[Fletcher]

#card(title: [Pinit in Code und Formeln])[
  #v(4em) // Mehr Platz für die Annotationen oberhalb

  Wir können Pinit auch in Formeln anwenden:

  #figure(
    $ #pin(11) x^2 #pin(12) + #pin(13) y^2 #pin(14) = r^2 $,
    numbering: none,
    alt: "Gleichung x-Quadrat plus y-Quadrat gleich r-Quadrat mit vier Pinit-Ankerpunkten an den Termen.",
  )

  // Compact boxed labels are easier to align than bare text labels.
  #let p-label(body, clr) = block(
    inset: (x: 5pt, y: 2pt),
    radius: 2pt,
    stroke: 0.7pt + clr,
    fill: white,
  )[
    #text(fill: clr, weight: "bold", size: 8pt)[#body]
  ]

  #pinit-highlight(11, 12, fill: rgb(255, 0, 0, 40))
  #pinit-highlight(13, 14, fill: rgb(0, 0, 255, 40))

  // x-term label: below-left, short clean connector.
  #pinit-place(dx: -70pt, dy: 26pt, (11, 12))[#p-label([x-Koor.], rgb(255, 0, 0))]
  #box()

  #pinit-point-from(
    (11, 12),
    pin-dx: -8pt,
    pin-dy: 2pt,
    body-dx: 0pt,
    body-dy: 0pt,
    offset-dx: -56pt,
    offset-dy: 24pt,
    fill: rgb(255, 0, 0),
  )[]
  #box()

  // y-term label: above-right, mirrored geometry.
  #pinit-place(dx: 44pt, dy: -36pt, (13, 14))[#p-label([y-Koor.], rgb(0, 0, 255))]
  #box()

  #pinit-point-from(
    (13, 14),
    pin-dx: 6pt,
    pin-dy: -10pt,
    body-dx: 0pt,
    body-dy: 0pt,
    offset-dx: 42pt,
    offset-dy: -28pt,
    fill: rgb(0, 0, 255),
  )[]
  #box()

  #v(4em)

  Pinit in Raw Code Blöcken (via Regex):

  #show raw: it => {
    show regex("pin\d+"): name => pin(int(name.text.slice(3)))
    it
  }

  ```typst
  let x = pin15 10 pin16
  let y = pin17 20 pin18
  ```

  #pinit-highlight(15, 16, fill: rgb(255, 0, 0, 40))

  // Keep this label closer to the code line for readability.
  #pinit-place(dx: 62pt, dy: 0pt, (15, 16))[#p-label([Zuweisung 1], rgb(255, 0, 0))]
  #box()

  #pinit-point-from(
    (15, 16),
    pin-dx: 8pt,
    pin-dy: 0pt,
    body-dx: 0pt,
    body-dy: 0pt,
    offset-dx: 62pt,
    offset-dy: 4pt,
    fill: rgb(255, 0, 0),
  )[]
  #box()

  #v(3em)

  Integration mit Fletcher (Diagramm-Kanten):

  #import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
  #v(1em)

  In einem Diagramm können wir Pins nutzen, um externe Erklärungen anzubinden:
  #v(4em)

  #diagram(
    spacing: 15mm,
    node((0, 0), [#pin(20)Diagnose#pin(21)], stroke: 1pt, fill: palette.primary.lighten(90%)),
    node((1, 0), [Therapie], stroke: 1pt),
    edge((0, 0), (1, 0), "-|>"),
  )

  #pinit-place(dx: 52pt, dy: -44pt, (20, 21))[#p-label([Zentraler Einstiegspunkt], palette.primary)]
  #box()

  #pinit-point-from(
    (20, 21),
    pin-dy: -12pt,
    body-dx: 0pt,
    body-dy: 0pt,
    offset-dx: 52pt,
    offset-dy: -40pt,
    fill: palette.primary,
  )[]
  #box()

  #v(2em)
]

== Phase 4: Radial Geometry Showcase#index[Radiales Layout]

#pagebreak(weak: false)

#card(title: [Radiales Pinit-Layout: 9 unterschiedliche Annotationstypen])[
  #v(0.5em)
  Diese Seite übernimmt die erprobte Geometrie aus `test/pinit-radial.typ` und zeigt bewusst unterschiedliche Arrow/Label-Varianten:

  - *12:00 / 6:00*: Standardrichtung vs. Reverse (`pinit-point-to`)
  - *1:30 / 3:00*: Lange Pfeile
  - *4:30*: Kurzer Pfeil mit Abstand zur Kreislinie
  - *7:30*: Fetter Strich
  - *9:00*: Pfeilspitze zeigt ins Kreiszentrum
  - *10:30*: Elbow/Shelf-Callout (Diagonal + horizontale Linie)
  - *upper-right*: Seitenabsolute Positionierung (Recipe C)
]

// --- Radial canvas (copied/adapted from test/pinit-radial.typ) ----------------
// We keep everything page-absolute on this page so each example stays deterministic.

#let rs-cx = 297.5pt
#let rs-cy = 500pt
#let rs-r = 100pt
#let rs-d = 185pt
#let rs-s45 = calc.sin(45deg)
#let rs-o = rs-d - rs-r
#let rs-od = rs-o * rs-s45

#let rs-blue = rgb("#1565c0")
#let rs-red = rgb("#b71c1c")

#let rs-ann-box(body, clr: rs-blue, txt-size: 8pt, pad-x: 7pt, pad-y: 4pt) = block(
  inset: (x: pad-x, y: pad-y),
  stroke: 0.8pt + clr,
  radius: 3pt,
  fill: white,
)[#text(fill: clr, weight: "bold", size: txt-size)[#body]]

#let rs-lbw = 34pt
#let rs-lbh = 18pt
#let rs-lg = 5pt

#let rs-o-long = rs-o + 30pt
#let rs-od-long = rs-o-long * rs-s45
#let rs-o-short = rs-o - 20pt
#let rs-od-short = rs-o-short * rs-s45

// Circle and quick legend.
#absolute-place(dx: rs-cx - rs-r, dy: rs-cy - rs-r)[
  #box(width: 2 * rs-r, height: 2 * rs-r, stroke: 2pt + rgb("#333"), radius: rs-r)
]
#absolute-place(dx: rs-cx - 16pt, dy: rs-cy - 6pt)[
  #text(size: 7pt, fill: rgb("#666"), style: "italic")[circle]
]
#absolute-place(dx: rs-cx - 126pt, dy: 122pt)[
  #text(size: 7pt, fill: rgb("#555"))[
    Pins 101-104, 106-108: #text(fill: rs-blue, weight: "bold")[pinit-point-from] ·
    Pin 105: #text(fill: rs-red, weight: "bold")[pinit-point-to] ·
    Pin 109: absolute page target
  ]
]

// Pins on circle perimeter (plus one at page corner).
// Using 101-109 avoids collisions with earlier examples in this chapter.
#absolute-place(dx: rs-cx, dy: rs-cy - rs-r)[#pin(101)]
#absolute-place(dx: rs-cx + rs-r * rs-s45, dy: rs-cy - rs-r * rs-s45)[#pin(102)]
#absolute-place(dx: rs-cx + rs-r, dy: rs-cy)[#pin(103)]
#absolute-place(dx: rs-cx + rs-r * rs-s45, dy: rs-cy + rs-r * rs-s45)[#pin(104)]
#absolute-place(dx: rs-cx, dy: rs-cy + rs-r)[#pin(105)]
#absolute-place(dx: rs-cx - rs-r * rs-s45, dy: rs-cy + rs-r * rs-s45)[#pin(106)]
#absolute-place(dx: rs-cx - rs-r, dy: rs-cy)[#pin(107)]
#absolute-place(dx: rs-cx - rs-r * rs-s45, dy: rs-cy - rs-r * rs-s45)[#pin(108)]
#absolute-place(dx: 595pt - 10pt, dy: 10pt)[#pin(109)]

// 101 -> 12:00
#pinit-place(dx: -rs-lbw / 2, dy: -rs-o - rs-lbh - rs-lg, 101)[#rs-ann-box[12:00]]
#box()
#pinit-point-from(
  101,
  pin-dx: 0pt,
  pin-dy: 0pt,
  body-dx: 0pt,
  body-dy: 0pt,
  offset-dx: 0pt,
  offset-dy: -rs-o - rs-lg,
  fill: rs-blue,
)[]
#box()

// 102 -> 1:30 (long arrow)
#pinit-place(dx: rs-od-long + rs-lg, dy: -rs-od-long - rs-lbh - rs-lg, 102)[#rs-ann-box(txt-size: 7.5pt)[1:30]]
#box()
#pinit-point-from(
  102,
  pin-dx: 0pt,
  pin-dy: 0pt,
  body-dx: 0pt,
  body-dy: 0pt,
  offset-dx: rs-od-long + rs-lg,
  offset-dy: -rs-od-long - rs-lg,
  fill: rs-blue,
)[]
#box()

// 103 -> 3:00 (long horizontal)
#pinit-place(dx: rs-o-long / 2, dy: -rs-lbh / 2, 103)[#rs-ann-box(txt-size: 9pt, pad-x: 8pt)[3:00]]
#box()
#pinit-point-from(
  103,
  pin-dx: 0pt,
  pin-dy: 0pt,
  body-dx: 0pt,
  body-dy: 0pt,
  offset-dx: rs-o-long + rs-lg,
  offset-dy: 0pt,
  fill: rs-blue,
)[]
#box()

// 104 -> 4:30 (short with tip-gap)
#pinit-place(dx: rs-od-short + rs-lg, dy: rs-od-short + rs-lg, 104)[#rs-ann-box(txt-size: 8.5pt)[4:30]]
#box()
#pinit-point-from(
  104,
  pin-dx: 7pt,
  pin-dy: 7pt,
  body-dx: 0pt,
  body-dy: 0pt,
  offset-dx: rs-od-short + rs-lg,
  offset-dy: rs-od-short + rs-lg,
  fill: rs-blue,
)[]
#box()

// 105 -> 6:00 (reverse arrow direction)
#pinit-place(dx: -rs-lbw / 2, dy: rs-o + rs-lg, 105)[#rs-ann-box(clr: rs-red)[6:00]]
#box()
#pinit-point-to(
  105,
  pin-dx: 0pt,
  pin-dy: 0pt,
  body-dx: 0pt,
  body-dy: 0pt,
  offset-dx: 0pt,
  offset-dy: rs-o + rs-lg,
  fill: rs-red,
)[]
#box()

// 106 -> 7:30 (bold stroke)
#pinit-place(dx: -rs-od - rs-lbw - rs-lg, dy: rs-od + rs-lg, 106)[#rs-ann-box(
  txt-size: 7.5pt,
  pad-x: 9pt,
  pad-y: 5pt,
)[7:30]]
#box()
#pinit-point-from(
  106,
  pin-dx: 0pt,
  pin-dy: 0pt,
  body-dx: 0pt,
  body-dy: 0pt,
  offset-dx: -rs-od - rs-lg,
  offset-dy: rs-od + rs-lg,
  fill: rs-blue,
  stroke: 2.4pt + rs-blue,
)[]
#box()

// 107 -> 9:00 (tip points to circle center via pin-dx: rs-r)
#pinit-place(dx: -rs-o - rs-lbw - rs-lg, dy: -rs-lbh / 2, 107)[#rs-ann-box(txt-size: 8pt)[9:00]]
#box()
#pinit-point-from(
  107,
  pin-dx: rs-r,
  pin-dy: 0pt,
  body-dx: 0pt,
  body-dy: 0pt,
  offset-dx: -rs-o - rs-lg,
  offset-dy: 0pt,
  fill: rs-blue,
)[]
#box()

// 108 -> 10:30 elbow/shelf callout.
// Important: the pinit tail and line() start share the same corner to avoid gaps.
#let rs-teal = rgb("#00796b")
#let rs-c8-dx = -rs-od - 18pt
#let rs-c8-dy = -rs-od - 55pt
#let rs-c8-x = rs-cx - rs-r * rs-s45 + rs-c8-dx
#let rs-c8-y = rs-cy - rs-r * rs-s45 + rs-c8-dy
#let rs-bar-w = 75pt

#pinit-point-from(
  108,
  pin-dx: 0pt,
  pin-dy: 0pt,
  body-dx: 0pt,
  body-dy: 0pt,
  offset-dx: rs-c8-dx,
  offset-dy: rs-c8-dy,
  fill: rs-teal,
  stroke: 1.2pt + rs-teal,
)[]
#box()

#absolute-place(dx: 0pt, dy: 0pt)[
  #line(start: (rs-c8-x, rs-c8-y), end: (rs-c8-x + rs-bar-w, rs-c8-y), stroke: 1.8pt + rs-teal)
]
#absolute-place(dx: rs-c8-x + rs-bar-w - 33pt, dy: rs-c8-y - 15pt)[
  #text(fill: rs-teal, weight: "bold", size: 9.5pt)[10:30]
]

// 109 -> page-corner target (Recipe C geometry + pinit arrow primitive).
#let rs-orange = rgb("#e65100")
#let rs-page-w = 595pt
#let rs-lb9-w = 72pt
#let rs-lb9-h = 19pt
#let rs-lb9-right = rs-page-w - 90pt
#let rs-lb9-top = 80pt
#let rs-p9-x = 595pt - 10pt
#let rs-p9-y = 10pt
#let rs-off9-dx = (rs-lb9-right - rs-lb9-w / 2) - rs-p9-x
#let rs-off9-dy = (rs-lb9-top + rs-lb9-h / 2) - rs-p9-y

#pinit-point-from(
  109,
  pin-dx: -3pt,
  pin-dy: 3pt,
  body-dx: 0pt,
  body-dy: 0pt,
  offset-dx: rs-off9-dx,
  offset-dy: rs-off9-dy,
  fill: rs-orange,
  stroke: 1pt + rs-orange,
)[]
#box()

#absolute-place(dx: rs-lb9-right - rs-lb9-w, dy: rs-lb9-top)[
  #block(
    width: rs-lb9-w,
    height: rs-lb9-h,
    inset: (x: 0pt, y: 0pt),
    outset: 0pt,
    stroke: 0.8pt + rs-orange,
    radius: 3pt,
    fill: white,
  )[#align(center + horizon)[#text(fill: rs-orange, weight: "bold", size: 8pt)[upper-right]]]
]

// Reserve enough flow space so the next block starts below the absolute artwork.
#v(27em)

#side-note(title: [Warum diese Phase wichtig ist])[
  Diese Seite zeigt das komplette Spektrum: einfache radial platzierte Labels,
  eine umgekehrte Pfeilrichtung (`point-to`), einen hybriden Elbow-Callout und
  eine seitenabsolute Ecke als Zielpunkt. Damit wird sichtbar, wann Recipe B
  reicht und wann Recipe C-Geometrie notwendig ist.
]

#callout(tone: "warning", title: [Troubleshooting & Best Practices])[
  Pinit Elemente werden absolut positioniert und entfliehen dem Standardfluss. Wenn ein Pfeil an einer verwirrten Stelle auftaucht oder Elemente überlappen, prüfen Sie folgende Punkte:
  - *Boilerplate*: Fehlt die Leerzeile vor dem `#pinit-` Aufruf oder das `#box()` danach?
  - *Text-Überlappung*: Nutzen Sie `#block(inset: ...)` um den Text, damit der Pfeil nicht in die Buchstaben schneidet.
  - *Pfeilwinkel falsch*: Setzen Sie `body-dx/dy` auf kleine Werte für den Vektor und nutzen Sie `offset-dx/dy` zum Verschieben des Textblocks.
  - *Platzbedarf*: Pinit verbraucht keinen Platz im normalen Layout. Nutzen Sie `#v(em)` um ausreichend Abstand für nachfolgenden Text zu schaffen.

  Weitere Details im Dokument `Guides/Pinit-Best-Practices.md`.
]
