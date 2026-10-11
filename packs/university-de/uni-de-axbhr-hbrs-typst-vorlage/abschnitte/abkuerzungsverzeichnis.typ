// ─── Abkürzungsverzeichnis ───────────────────────────────────────────────────
// Entspricht abschnitte/Abkürzungsverzeichnis.tex
// Da Typst kein acronym-Paket besitzt, werden die Abkürzungen als einfache
// Tabelle dargestellt. Die Hilfsfunktionen acf/acs/acl/acp können in anderen
// Abschnitten per `#import "../abschnitte/abkuerzungsverzeichnis.typ": *`
// importiert werden.

// ─── Abkürzungs-Wörterbuch ───────────────────────────────────────────────────
// Einträge: array (Kurzform als Content, Langform als String)
#let acronyms = (
  BUT:  ([BUT],           "Block Under Test"),
  CDMA: ([CDMA],          "Code Division Multiple Access"),
  GSM:  ([GSM],           "Global System for Mobile Communication"),
  IC:   ([IC],            "Integrated Circuit"),
  lh2:  ([$"LH"_2$],      "Liquid Hydrogen"),
  lox:  ([$"LOX"$],       "Liquid Oxygen"),
  NA:   ([$N_A$],         "Number of Avogadro"),
  NADp: ([NAD#super[+]], "Nicotinamide Adenine Dinucleotide"),
  NUA:  ([NUA],           "Not Used Acronym"),
  TDMA: ([TDMA],          "Time Division Multiple Access"),
  UA:   ([UA],            "Used Acronym"),
)

// ─── Hilfsfunktionen ─────────────────────────────────────────────────────────

/// Vollform: "Langform (Kurzform)"
#let acf(key) = {
  let entry = acronyms.at(key)
  [#entry.last() (#entry.first())]
}

/// Kurzform
#let acs(key) = acronyms.at(key).first()

/// Langform
#let acl(key) = [#acronyms.at(key).last()]

/// Kurzform Plural (einfaches „s" angehängt)
#let acp(key) = [#acronyms.at(key).first()s]

// ─── Darstellung ─────────────────────────────────────────────────────────────
#heading(numbering: none, outlined: true)[Abkürzungsverzeichnis]

#table(
  columns: (6em, 1fr),
  stroke: none,
  inset: (x: 0pt, y: 3pt),
  ..{
    let cells = ()
    for (key, entry) in acronyms {
      cells.push(strong(entry.first()))
      cells.push([#entry.last()])
    }
    cells
  }
)
