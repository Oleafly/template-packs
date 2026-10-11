// etc/declaration.typ
// ═══════════════════════════════════════════════════════════════════════════
// Ehrenwörtliche Erklärung (H 3.3)
//
// WICHTIG: "Die in der Arbeit verwendete Erklärung muss mit dieser Vorlage
// genau übereinstimmen." (H 3.3) Der Wortlaut unten ist wörtlich aus Anhang 6
// der Hinweise übernommen (Fassung für die Jahrgänge 2024 ff nach DHBW StuPrO
// 2024, Stand 16.07.2025) und darf NICHT verändert werden.
//
// Einzige Abweichung: In Anhang 6 steht der Tippfehler "veröffentlich", hier
// korrekt "veröffentlicht".
//
// Die Erklärung steht nach dem Titelblatt (ggf. nach dem Sperrvermerk) und vor
// dem Inhaltsverzeichnis, wird nicht im Inhaltsverzeichnis aufgeführt und nicht
// in die Seitennummerierung aufgenommen (H 3.3).
// ═══════════════════════════════════════════════════════════════════════════

#let _fmt_date(d) = if type(d) == datetime {
  d.display("[day].[month].[year]")
} else { d }

#let declaration(
  declaration_location: "",
  declaration_date: none,
  signature: none,
  ai_declaration: false,
) = {
  align(center)[
    #heading(level: 1, numbering: none, outlined: false)[Ehrenwörtliche Erklärung]
  ]

  v(1.5cm)

  [
    Ich versichere hiermit, dass ich die vorliegende Arbeit selbstständig
    verfasst und keine anderen als die angegebenen Quellen und Hilfsmittel
    verwendet habe und diese Arbeit bei keiner anderen Prüfung mit gleichem
    oder vergleichbarem Inhalt vorgelegt habe und diese bislang nicht
    veröffentlicht wurde.
  ]

  // ── Optionaler Zusatz zur Nutzung KI-gestützter Werkzeuge ────────────────
  // Standardmäßig ausgeschaltet, damit die Erklärung exakt dem Wortlaut aus
  // Anhang 6 entspricht. Die Dokumentation der KI-Nutzung erfolgt im
  // Hilfsmittelverzeichnis (H 3.13). Nur einschalten, wenn die Betreuung
  // diesen Zusatz ausdrücklich verlangt (Parameter `ai_declaration: true`).
  if ai_declaration {
    v(1em)
    [
      Ich bin mir bewusst, dass die Nutzung generativer KI-Werkzeuge keine
      Gewährleistung für die Qualität der erzeugten Inhalte bietet. Für etwaige
      fehlerhafte Inhalte sowie für Verstöße gegen Datenschutzrecht,
      Urheberrecht oder gegen die Regeln wissenschaftlichen Arbeitens (z. B. in
      Form von Plagiaten, erfundenen Quellen, falschen Belegen usw.) trage ich
      die volle Verantwortung. Ich versichere zudem, dass KI-gestützte Werkzeuge
      ausschließlich als unterstützende Hilfsmittel eingesetzt wurden, dass mein
      eigener gestalterischer Beitrag den wesentlichen Anteil an der Arbeit
      darstellt und dass ich die eingesetzten Werkzeuge, deren Zwecke sowie den
      Umfang der Nutzung im Hilfsmittelverzeichnis transparent dargelegt und
      kritisch reflektiert habe.
    ]
  }

  v(3cm)

  // Ort, Datum und Unterschrift im Original (H 3.3). Bei elektronischer Abgabe
  // wird die PDF-Fassung mit einer eingescannten eigenhändigen Unterschrift
  // versehen → Parameter `signature` in main.typ setzen.
  grid(
    columns: (auto, 1fr, 7cm),
    align: (left + bottom, center, center + bottom),
    [#declaration_location, #_fmt_date(declaration_date)],
    [],
    [
      #if signature != none {
        image(signature, height: 1.6cm)
      } else {
        v(1.6cm)
      }
      #line(length: 100%, stroke: 0.5pt)
      #v(0.2em)
      #text(size: 10pt)[(Unterschrift)]
    ],
  )
}
