// etc/blocking_notice.typ
// ═══════════════════════════════════════════════════════════════════════════
// Sperrvermerk (H 3.2) — OPTIONAL, "Ein Sperrvermerk sollte vermieden werden."
//
// WICHTIG: "Der in der Arbeit verwendete Sperrvermerk muss mit dieser Vorlage
// genau übereinstimmen." (H 3.2) Der Wortlaut unten ist wörtlich aus Anhang 5
// der Hinweise übernommen (Fassung für die Jahrgänge 2024 ff nach DHBW StuPrO
// 2024, Stand 16.07.2025) und darf NICHT verändert werden.
//
// Das Blatt wird nach dem Titelblatt eingeordnet, nicht in die Seiten-
// nummerierung aufgenommen und nicht im Inhaltsverzeichnis aufgeführt (H 3.2).
// Aktivierung über `has_blocking_notice: true` in main.typ.
// ═══════════════════════════════════════════════════════════════════════════

#let blocking_notice() = {
  align(center)[
    #heading(level: 1, numbering: none, outlined: false)[Sperrvermerk]
  ]

  v(1.5cm)

  [
    Der Inhalt dieser Arbeit darf weder als Ganzes noch in Auszügen Personen
    außerhalb des Prüfungsprozesses und des Evaluationsverfahrens zugänglich
    gemacht werden, sofern keine anderslautende Genehmigung des Dualen Partners
    vorliegt.
  ]
}
