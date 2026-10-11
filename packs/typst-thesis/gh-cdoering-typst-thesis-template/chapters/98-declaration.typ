#import "../config.typ": cfg
#import "../lib/i18n.typ": t

#heading(level: 1, numbering: none, outlined: false)[#t.declaration]
#v(0.5cm)

// Der Wortlaut ist hochschulspezifisch. Die verbindliche Formulierung steht
// in der Pruefungsordnung und ist dort zu uebernehmen.
//
// Das Datum kommt aus cfg.declaration_date. Bei auto ist es das Datum der
// Kompilierung -- praktisch beim Schreiben, aber es wandert bei jedem Lauf.
// Fuer die Abgabefassung dort ein festes Datum eintragen.

Ich versichere hiermit, dass ich die vorliegende Arbeit selbststaendig und ohne
fremde Hilfe verfasst und keine anderen als die angegebenen Quellen und
Hilfsmittel benutzt habe.

Die den benutzten Quellen woertlich oder inhaltlich entnommenen Stellen sind
als solche kenntlich gemacht.

Diese Arbeit wurde in gleicher oder aehnlicher Form noch bei keiner anderen
Pruefungsbehoerde eingereicht.

// Unterschriftenblock als Raster: links Ort und Datum, rechts die
// Unterschrift. Beide Spalten haben dieselbe feste Hoehe ueber der Linie,
// damit der Block unabhaengig von der Groesse des Signaturbildes haelt.
#let signature-height = 1.6cm
#let datum = if cfg.declaration_date == auto {
  datetime.today().display("[day padding:zero].[month padding:zero].[year]")
} else {
  cfg.declaration_date
}

#v(3em)

#grid(
  columns: (5.5cm, 1fr, 5.5cm),
  column-gutter: 1cm,
  row-gutter: 0.35em,

  // Zeile 1: Eintraege ueber der Linie, jeweils unten buendig
  box(height: signature-height, align(bottom + left)[#cfg.place, #datum]),
  [],
  box(
    height: signature-height,
    align(bottom + left, if cfg.signature != none { cfg.signature }),
  ),

  // Zeile 2: Unterschriftslinien
  line(length: 100%), [], line(length: 100%),

  // Zeile 3: Beschriftungen
  text(size: 10pt, t.place_date), [], text(size: 10pt, cfg.author),
)
