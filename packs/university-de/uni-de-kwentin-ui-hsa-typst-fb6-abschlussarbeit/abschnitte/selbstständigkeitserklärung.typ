= Selbstständigkeitserklärung
#import "deckblatt.typ": abgabedatum, textfeld
Hiermit erkläre ich, dass die Arbeit selbstständig verfasst, in gleicher oder ähnlicher Fassung noch nicht in einem anderen Studiengang als Prüfungsleistung vorgelegt wurde und keine anderen, als die angegebenen Hilfsmittel und Quellen, einschließlich der angegebenen und beschriebenen Software, verwendet wurden.

#v(8%)
#grid(
  columns: (1fr, 2fr),
  textfeld([Köthen, #abgabedatum], [Ort, Datum]),
  textfeld(rect(height: 0.7em, width: 100%, stroke: none), [Unterschrift]),
)

#v(3cm)
#heading([Sperrvermerk], level: 2, outlined: false)

// Hier einstellen ob Sperrvermerk
#let sperrvermerk = false

// Bei keinem Sperrvermerk kann der folgende Abschnitt ggf. auch auskommentiert werden

#let haken = align(center + horizon, text(sym.crossmark, size: 2em))
#grid(
  columns: (1fr, 1fr, 1fr),
  align: left + horizon,
  [Sperrvermerk],
  [Ja #box(baseline: if sperrvermerk { -21% } else { 0% }, rect(width: 1cm, height: 1cm, if sperrvermerk { haken } else { [] }))],
  [Nein #box(baseline: if not sperrvermerk { -21% } else { 0% }, rect(width: 1cm, height: 1cm, fill: none, if not sperrvermerk { haken } else { [] }))],
)

#v(8%)
#grid(
  columns: (1fr, 2fr),
  textfeld([Köthen, #abgabedatum], [Ort, Datum]),
  textfeld(rect(height: 0.7em, width: 100%, stroke: none), [Unterschrift des/der betrieblichen Betreuers/-in]),
)
