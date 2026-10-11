// ============================================================
//  DHBW Stuttgart – Titelseite
//  Layout entspricht dem offiziellen Titelblatt-Muster.
//
//  Hinweis: Alles in einem Code-Block { }, damit wir nicht
//  zwischen Code- und Markup-Modus wechseln müssen.
// ============================================================

#import "config.typ": *
#import "template.typ": dhbw-red

#let dhbw-title-page() = {
  // ── Kopfzeile: Logos ────────────────────────────────────
  grid(
    columns: (1fr, auto),
    // Linke Spalte: optionales Partner-Logo oder Platzhalter
    align(
      left + horizon,
      if dual-partner-logo != none {
        dual-partner-logo
      } else {
        text(size: 9pt, fill: luma(150))[
          Ggf. Logo \
          des Dualen Partners
        ]
      }
    ),
    // Rechte Spalte: DHBW-Logo
    align(right + horizon,
      image("dhbw-logo.png", height: 1.6cm)
    ),
  )

  v(3.5cm)

  // ── Titel ───────────────────────────────────────────────
  align(center,
    text(size: 16pt, fill: dhbw-red, work-title)
  )

  v(1.8cm)

  // ── Art der Arbeit ──────────────────────────────────────
  align(center,
    text(size: 13pt, fill: dhbw-red, weight: "bold", upper(work-type))
  )

  v(2.5cm)

  // ── Studiengang & Standort ──────────────────────────────
  align(center)[
    des Studienganges #text(fill: dhbw-red)[#study-program] \
    #v(0.4em)
    an der Dualen Hochschule Baden-Württemberg #text(fill: dhbw-red)[#dhbw-location]
  ]

  v(1.2cm)

  // ── Autor ───────────────────────────────────────────────
  align(center)[
    von \
    #v(0.3em)
    #text(fill: dhbw-red)[#author]
  ]

  v(1.0cm)

  // ── Abgabedatum ─────────────────────────────────────────
  align(center,
    text(fill: dhbw-red, submission-date)
  )

  // ── Metadaten unten ─────────────────────────────────────
  v(1fr)

  line(length: 100%, stroke: 0.5pt + luma(200))
  v(0.5em)

  // Metadaten-Zeilen zusammenstellen
  let meta-rows = (
    ("Bearbeitungszeitraum",  processing-period),
    ("Matrikelnummer, Kurs",  matriculation-number + ", " + course),
    ("Dualer Partner",        dual-partner-name),
  )
  let meta-rows = if show-partner-supervisor {
    meta-rows + (("Betreuer*in des Dualen Partners", dual-partner-supervisor),)
  } else { meta-rows }
  let meta-rows = if show-dhbw-supervisor {
    meta-rows + (("Gutachter*in der Dualen Hochschule", dhbw-supervisor),)
  } else { meta-rows }

  // Zweispaltige Tabelle ohne Rahmen
  grid(
    columns: (7cm, 1fr),
    row-gutter: 4pt,
    ..meta-rows.map(row => (
      text(size: 10pt, row.at(0)),
      text(size: 10pt, fill: dhbw-red, row.at(1)),
    )).flatten()
  )

  if show-partner-supervisor or show-dhbw-supervisor {
    v(0.4em)
    text(
      size:  8pt,
      style: "italic",
      "(Betreuer*in bzw. Gutachter*in ggfs. bei Projekt- und Studienarbeiten streichen)",
    )
  }
}
