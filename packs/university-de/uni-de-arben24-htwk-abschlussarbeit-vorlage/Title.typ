// ---------------------------------------------------------------------------
// Titelblatt im HTWK-Stil
// Alle Angaben stammen aus Daten.typ, hier muss in der Regel nichts geaendert
// werden.
// ---------------------------------------------------------------------------

#import "Daten.typ": *

#v(6mm)
#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  align: (left, right),
  // linke Spalte: Fakultaetsbezeichnung
  [#image("Abbildungen/logos/HTWK-Fakultaetszusatz_ing_schwarz_de.png", width: 70mm)],
  // rechte Spalte: HTWK-Block
  [#image("Abbildungen/logos/HTWK_Zusatz_de_V_Black_K.jpg", width: 50mm)]
)

#v(2cm)

#align(center)[
  #text(size: 22pt, weight: "bold")[#arbeit]
]

#v(1.5cm)

#table(
  columns: (5cm, 1fr),
  inset: 9pt,
  stroke: none,
  [*Thema:*], [#thema],
  [*vorgelegt von:*], [#vorname #name],
  [*Matrikelnummer:*], [#matrikelnummer],
  [*Studiengang:*], [#studiengang],
  [*Studienprofil:*], [#studienprofil],
)

#v(1cm)

#table(
  columns: (8cm, 1fr),
  inset: 9pt,
  stroke: none,
  [*verantwortlicher Hochschullehrer:*], [#professor],
  [*betrieblicher Betreuer:*], [#chef],
)

#v(1.8cm)

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  align: (left, right),
  [#text(size: 10pt)[Ausgabetermin: #ausgabetermin]],
  [#text(size: 10pt)[Abgabetermin: #abgabetermin]],
)

#v(1cm)

#text(size: 11pt)[#ort, #datum]
