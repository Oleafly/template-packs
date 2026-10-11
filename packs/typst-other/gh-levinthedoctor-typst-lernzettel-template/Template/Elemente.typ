// =============================================================================
// Lernzettel: Abbildungen und Tabellen mit Beschriftung und Quelle
// =============================================================================
// Die Beschriftung steht oberhalb des Elements, die Quellenangabe unmittelbar
// darunter:
//   - übernommen:            quelle: [#zitat(<langguth2008>, seite: "8")]
//   - inhaltliche Anlehnung: quelle: [In Anlehnung an #zitat(<x>, seite: "8")]
//   - selbst erstellt:       quelle: "Eigene Darstellung"  (Standard)
//   - ohne Quellenzeile:     quelle: none
//
// Nur über diese beiden Funktionen gesetzte Elemente landen im Abbildungs-
// bzw. Tabellenverzeichnis.

#import "Zitieren.typ": zitat

// Interne Hilfsfunktion: Quellenzeile unterhalb von Abbildung/Tabelle.
#let _quellenzeile(quelle) = {
  if quelle != none {
    align(left, block(above: 0.8em, text(size: 0.85em)[Quelle: #quelle]))
  }
}

// Abbildung mit Überschrift (oberhalb) und Quellenangabe (unterhalb).
//   #abbildung(image("/Assets/Images/modell.png"), titel: [Titel]) <abb-modell>
#let abbildung(inhalt, titel: none, quelle: "Eigene Darstellung") = {
  figure(
    {
      inhalt
      _quellenzeile(quelle)
    },
    kind: image,
    supplement: "Abbildung",
    caption: titel,
  )
}

// Tabelle mit Überschrift (oberhalb) und Quellenangabe (unterhalb).
//   #tabelle(stdtable(columns: (1fr, 1fr), header: (...), ...), titel: [Titel])
#let tabelle(inhalt, titel: none, quelle: "Eigene Darstellung") = {
  figure(
    {
      inhalt
      _quellenzeile(quelle)
    },
    kind: table,
    supplement: "Tabelle",
    caption: titel,
  )
}
