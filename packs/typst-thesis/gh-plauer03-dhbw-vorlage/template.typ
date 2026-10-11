#let style(doc) = {

  // =========================
  // Seitenlayout
  // =========================
  set page(
    paper: "a4",
    margin: (
      top: 3cm,
      bottom: 2.5cm,
      left: 2.5cm,
      right: 2.5cm
    ),
    header: none,
    footer: align(right)[#context counter(page).display()]
  )

  // =========================
  // Grundschrift
  // =========================
  set text(
    font: "Libertinus Serif",
    size: 12pt,
    lang: "de"
  )

  // 1.5 Zeilenabstand
  set par(
    justify: true,
    leading: 1em
  )
  
  // =========================
  // Zitierstil IEEE
  // =========================
  set bibliography(style: "ieee")
  
  // =========================
  // Überschriften Nummerierung
  // =========================
  set heading(numbering: "1.1")

  // =========================
  // Kapitel (Level 1 = "=")
  // =========================
  show heading.where(level: 1): it => {

    pagebreak(weak: true)

    // Block für Styling der Überschrift
    block(
      below: 1cm  // Abstand unter der Überschrift
    )[
      // Abstand NACH Seitenanfang simulieren
      #pad(top: 2cm)[

        // Schriftstil für Kapitel
        #set text(size: 18pt, weight: "bold")

        // eigentliche Überschrift einsetzen
        #it
      ]
    ]
  }

  // =========================
  // Unterkapitel (Level 2 = "==")
  // =========================
  show heading.where(level: 2): it => {
    block(
      above: 1.2cm,  // Abstand davor
      below: 0.6cm   // Abstand danach
    )[
      #set text(size: 16pt, weight: "bold")
      #it
    ]
  }

  // =========================
  // Unter-Unterkapitel (Level 3 = "===")
  // =========================
  show heading.where(level: 3): it => {
    block(
      above: 1.2cm,
      below: 0.6cm
    )[
      #set text(size: 14pt, weight: "bold")
      #it
    ]
  }

  // =========================
  // Abstände für Figuren & Tabellen
  // =========================
  show figure: set block(above: 10pt, below: 10pt)
  
  show figure: it => {
    let content = it.body
    let is-table = content.func() == table

    //let top-gap = if is-table { 25pt } else { 5pt }
    //let bottom-gap = if is-table { 0pt } else { 5pt }

    //block(above: top-gap, below: bottom-gap)

    if is-table [
      #v(10pt)
      #strong[
        Tabelle #it.caption.numbering#it.caption.separator
      ]
      #it.caption.body
      #it.body
      #v(10pt)
    ] else [
      #v(10pt)
      #it.body
      #strong[
        Abbildung #it.caption.numbering#it.caption.separator
      ]
      #it.caption.body
      #v(10pt)
    ]
  }

  // =========================
  // Tabellenstil LaTeX like, alle rechten Zeilen zentriert ANPASSBAR mit: table.cell(align: left)[inhalt]
  // =========================
  show table.cell.where(y: 0): strong
  set table(
    stroke: (x, y) => if y == 0 {
      (bottom: 0.7pt + black)
    },
    align: (x, y) => (
      if x > 0 { center }
      else { left }
    )
  )
  
  // =========================
  // Dokument zurückgeben
  // =========================
  doc
}