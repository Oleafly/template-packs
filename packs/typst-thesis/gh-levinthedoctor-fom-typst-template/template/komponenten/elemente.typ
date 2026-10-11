// =============================================================================
// FOM-Template: Abbildungen, Tabellen und Formeln (Leitfaden 2.3, 2.5)
// =============================================================================
// Alle Beschriftungen stehen OBERHALB des Elements (Leitfaden 2.3) und sind
// fett sowie linksbündig (Leitfaden 1.2 Nr. 8). Die Quellenangabe folgt
// unmittelbar unterhalb des Elements:
//   - übernommen:            quelle: [#zitat(<langguth2008>, seite: "8")]
//   - inhaltliche Anlehnung: quelle: [In Anlehnung an #zitat(<x>, seite: "8")]
//   - selbst erstellt:       quelle: "Eigene Darstellung"  (Standard)

#import "zitieren.typ": zitat

// Interne Hilfsfunktion: Quellenzeile unterhalb von Abbildung/Tabelle/Formel.
#let _quellenzeile(quelle) = {
  if quelle != none {
    align(left, block(above: 0.8em)[Quelle: #quelle])
  }
}

// Abbildung mit Überschrift (oberhalb) und Quellenangabe (unterhalb).
//   #abbildung(image("abbildungen/modell.png"), titel: [Titel], quelle: ...) <abb-modell>
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

// Formel (Leitfaden 2.5): um 1 cm eingerückt, fortlaufend nummeriert mit
// Nummer in runden Klammern am Zeilenende, Beschriftung und Quelle wie bei
// Abbildungen. Für Umformungen kann `zusatz: "a"` an die Nummer angehängt
// werden, die Nummerierung läuft dann nicht weiter (Formel 2 -> 2a).
#let formel(gleichung, titel: none, quelle: none, zusatz: none) = {
  if zusatz != none {
    counter(figure.where(kind: "fom-formel")).update(n => n - 1)
  }
  figure(
    {
      set math.equation(numbering: none)
      block(width: 100%, inset: (left: 1cm))[
        #grid(
          columns: (1fr, auto),
          align: (left + horizon, right + horizon),
          gleichung,
          context {
            let nummer = counter(figure.where(kind: "fom-formel")).get().first()
            [(#nummer#zusatz)]
          },
        )
      ]
      _quellenzeile(quelle)
    },
    kind: "fom-formel",
    supplement: "Formel",
    caption: titel,
  )
}
