// lib/components.typ
// ═══════════════════════════════════════════════════════════════════════════
// Wiederverwendbare Bausteine für den Textteil und die Verzeichnisse.
// Import in jeder Kapitel-Datei:  #import "../lib/components.typ": *
// ═══════════════════════════════════════════════════════════════════════════

// ───────────────────────────────────────────────────────────────────────────
// Quellenangabe unter einer Abbildung / Tabelle
// Hinweise 2.5: "Bei Abbildungen, die nicht selbst erstellt wurden, wird die
// Quelle unterhalb der Abbildungsbezeichnung angegeben. […] Die Quellenangabe
// erscheint nicht im Abbildungs- und Tabellenverzeichnis."
//
// Deshalb steht die Quelle NICHT in der Caption, sondern direkt darunter:
//
//   #block(breakable: false)[
//     #figure(image("/img/beispiel.png"), caption: [Titel der Abbildung]) <fig-beispiel>
//     #quelle[Eigene Darstellung in Anlehnung an @Freund2014[S. 42]]
//   ]
// ───────────────────────────────────────────────────────────────────────────
#let quelle(body) = block(above: 0.5em, below: 0em, width: 100%)[
  #align(center)[#text(size: 10pt)[Quelle: #body]]
]

// Variante für Tabellen (Beschriftung steht oben, Quelle linksbündig darunter)
#let quelle-links(body) = block(above: 0.5em, below: 0em, width: 100%)[
  #text(size: 10pt)[Quelle: #body]
]

// ───────────────────────────────────────────────────────────────────────────
// Tabelle für das Hilfsmittelverzeichnis (Hinweise 3.13)
// Spaltenüberschriften nach dem Muster der Fakultät.
// ───────────────────────────────────────────────────────────────────────────
#let ai_table(..rows) = {
  set text(size: 9.5pt)
  set par(justify: false, leading: 0.5em)
  table(
    columns: (1.5fr, 2.4fr, 2.4fr, 2.3fr),
    inset: (x: 6pt, y: 5pt),
    stroke: 0.4pt + luma(160),
    fill: (x, y) => if y == 0 { luma(230) },
    align: left + top,
    table.header(
      ..(
        [Verwendete KI-Tools],
        [Beschreibung der Nutzung],
        [Prompt(s) / Eingabe(n)],
        [Anmerkung und Reflexion],
      ).map(h => strong(text(hyphenate: false, h)))
    ),
    ..rows
  )
}

// Ein zusammenhängender Block je Einsatzzweck (bricht nicht über Seiten)
#let hilfsmittel-block(title, ..rows) = block(breakable: false, width: 100%, above: 1.2em)[
  #heading(level: 2, numbering: none, outlined: false)[#title]
  #ai_table(..rows)
]

// ───────────────────────────────────────────────────────────────────────────
// Motto / Leitzitat (optional, z. B. vor der Einleitung)
// ───────────────────────────────────────────────────────────────────────────
#let epigraph(quote, author) = align(center)[
  #block(width: 80%)[
    #emph(quote)
    #v(0.4em)
    #align(right)[--- #author]
  ]
]
