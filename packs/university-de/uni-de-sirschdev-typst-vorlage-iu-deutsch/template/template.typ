
// Dokumentweites Styling: Seitenlayout, Schrift, Überschriften, Verzeichnisse, etc.

#let leading = 1em

#let conf(doc) = {
  // ── Allgemeine Stile ────────────────────────────────────────────────────
  set page(
    paper: "a4",
    margin: (top: 2cm, bottom: 2cm, left: 2cm, right: 2cm),
    numbering: "I",
    number-align: center + bottom,
  )
  
  set text(
    font: "Arial",
    size: 11pt,
    fill: black,
    hyphenate: true,
    lang: "de",
  )
  
  set par(
    justify: true,
    leading: leading,
    spacing: leading + 6pt,
    linebreaks: "optimized",
  )
  
  set list(marker: ([•], [•], [•]))
  
  // Alte Überschriften bis April 2026
  set heading(numbering: "1.1.1")
  show heading: it => {
    set align(left)
    set text(size: 12pt, weight: "bold")
    set block(above: 1em + 12pt, below: 1em + 12pt)
    it
  }
  
  // Neue Überschriftenformatierung ab April 2026
  // ───────────────────────────────────────────────────────
  // show heading: it => {
  //   set align(left)
  //   set text(weight: "bold")
  //   set block(above: 1em + 12pt)
  //   it
  // }
  // show heading.where(level: 1): it => {
  //   set text(size: 16pt)
  //   set block(below: 1em + 12pt)
  //   it
  // }
  // 
  // show heading.where(level: 2): it => {
  //   set text(size: 14pt)
  //   set block(below: 1em + 6pt)
  //   it
  // }
  // 
  // show heading.where(level: 3): it => {
  //   set text(size: 11pt)
  //   set block(below: 1em + 6pt)
  //   it
  // }
  // 
  // => Auch Anhang von 12 > 16pt erhöhen in Zeile 109 
  
  // ── Fußnoten ───────────────────────────────────────────────
  show footnote.entry: set text(font: "Arial", size: 10pt)
  show footnote.entry: set par(justify: true)
  
  // ── Inhaltsverzeichnis ──────────────────────────────────────
  show outline.entry.where(level: 1): set text(weight: "bold")
  show outline.entry.where(level: 1): set block(above: 1em + 6pt)
  
  // ── Abbildungs- und Tabellenbeschriftungen
  show figure: it => {
    set figure.caption(position: top)
    set align(left)
    it
  }
  
  show figure.caption: set text(size: 11pt)
  show figure.where(kind: image): set figure(supplement: "Abb.")
  show figure.where(kind: table): set figure(supplement: "Tab.")
  show figure.where(kind: "anhang"): set figure(
    supplement: "Anhang",
    numbering: "A",
  )
  
  show figure.caption.where(kind: "anhang"): it => heading(level: 1, numbering: none, outlined: false)[#it]
  
  // ── Abbildungs- und Tabellenverzeichnis  
  show outline.where(target: figure.where(kind: image)): it => {
    show outline.entry: set text(weight: "regular")
    show outline.entry: set block(above: 1em)
    it
  }
  show outline.where(target: figure.where(kind: table)): it => {
    show outline.entry: set text(weight: "regular")
    show outline.entry: set block(above: 1em)
    it
  }
  // ── Literaturverzeichnis ────────────────────────────────────
  show bibliography: set par(
    hanging-indent: 1.27cm,
    justify: false,
  )
  
  // ── Anhang ──────────────────────────────────────────────────
  show outline.where(target: figure.where(kind: "anhang")): it => {
    show outline.entry: set text(weight: "regular")
    show outline.entry: set block(above: 1.5em)
    show outline.entry: it => link(
      it.element.location(),
      it.indented(it.prefix() + [:], it.body()),
    )
    it
  }
  doc
}
