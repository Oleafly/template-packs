// ============================================================
//  DHBW Stuttgart – Erklärungsseiten
//  Sperrvermerk, Ehrenwörtliche Erklärung, KI-Anmerkung
// ============================================================

#import "config.typ": *
#import "template.typ": dhbw-red

// ── Sperrvermerk ─────────────────────────────────────────────
#let confidentiality-notice() = {
  pagebreak()
  heading(numbering: none, level: 1)[Sperrvermerk]

  par[
    _Der Inhalt dieser Arbeit darf weder als Ganzes noch in Auszügen Personen außerhalb
    des Prüfungsprozesses und des Evaluationsverfahrens zugänglich gemacht werden,
    sofern keine anderslautende Genehmigung des Dualen Partners vorliegt._
  ]

  if confidentiality-duration != none and confidentiality-duration != "" {
    v(0.5em)
    par[
      Der Sperrvermerk ist auf #confidentiality-duration befristet.
    ]
  }
}

// ── Ehrenwörtliche Erklärung ─────────────────────────────────
#let declaration-of-honor() = {
  pagebreak()
  heading(numbering: none, level: 1)[Ehrenwörtliche Erklärung]

  v(0.5em)
  par[
    Ich versichere hiermit, dass ich die vorliegende Arbeit selbstständig verfasst und keine
    anderen als die angegebenen Quellen und Hilfsmittel verwendet habe und diese Arbeit bei
    keiner anderen Prüfung mit gleichem oder vergleichbarem Inhalt vorgelegt habe und diese
    bislang nicht veröffentlicht wurde.#if not electronic-only-submission [
      #sym.space Des Weiteren versichere ich, dass die eingereichte elektronische Fassung
      mit der gedruckten Ausfertigung übereinstimmt.
    ]
  ]

  if uses-ai-tools {
    v(0.5em)
    par[
      _Ich habe bei der Erstellung der Arbeit KI-Werkzeuge eingesetzt.
      Dies habe ich an den entsprechenden Stellen der Arbeit kenntlich gemacht._
    ]
  }

  v(2.5cm)

  // Unterschriftszeile
  grid(
    columns: (1fr, 1fr),
    gutter: 2cm,
    line(length: 100%, stroke: 0.5pt),
    line(length: 100%, stroke: 0.5pt),
    text(size: 9pt)[Ort, Datum],
    text(size: 9pt)[#author],
  )
}

// ── KI-Nutzung ───────────────────────────────────────────────
#let ai-usage-section() = {
  pagebreak()
  heading(numbering: none, level: 1)[
    Anmerkung zur Nutzung von Künstlicher Intelligenz
  ]

  v(0.5em)
  par[
    Bei der Erstellung dieser Arbeit wurden die folgenden KI-basierten Werkzeuge eingesetzt:
  ]
  v(0.5em)

  // Tabelle mit Rahmen
  figure(
    kind: table,
    caption: [Übersicht über die verwendeten KI-basierten Werkzeuge],
    table(
      columns: (4cm, 1fr),
      stroke: 0.5pt + black,
      inset: (x: 6pt, y: 5pt),
      table.header(
        strong[Werkzeug],
        strong[Beschreibung der Nutzung],
      ),
      ..ai-tools.map(tool => (tool.at(0), tool.at(1))).flatten(),
    )
  )
}
