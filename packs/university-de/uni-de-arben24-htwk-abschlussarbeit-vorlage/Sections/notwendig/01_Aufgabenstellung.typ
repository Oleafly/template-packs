#import "../../Daten.typ": *

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  align: (left, right),
  [#image("../../Abbildungen/logos/HTWK-Fakultaetszusatz_ing_schwarz_de.png", width: 70mm)],
  [#image("../../Abbildungen/logos/HTWK_Zusatz_de_V_Black_K.jpg", width: 50mm)]
)

#align(center)[
  #v(1cm)
  #text(size: 20pt, weight: "bold")[Aufgabenstellung zur Abschlussarbeit]
]

#v(0.8cm)
#table(
  columns: (auto, 1fr),
  inset: 7pt,
  stroke: none,
  [*von:*], [#vorname #name],
  [*Thema:*], [#thema],
)

#v(1cm)
#grid(
  columns: (3cm, 1fr),
  gutter: 0cm,
  [*Erläuterung:*],
  [
    // TODO: Hier die mit der betreuenden Person abgestimmte Aufgabenstellung
    // einsetzen. In der Regel wird das offizielle Formular der Fakultaet
    // eingescannt oder der Text daraus uebernommen.
    Dieser Abschnitt beschreibt Ausgangslage und Zielstellung der Arbeit in
    wenigen Sätzen. Anschließend werden die zu bearbeitenden Teilaufgaben
    aufgelistet.

    Teilaufgaben:
    - [PLATZHALTER Teilaufgabe 1]
    - [PLATZHALTER Teilaufgabe 2]
    - [PLATZHALTER Teilaufgabe 3]
    - [PLATZHALTER Teilaufgabe 4]
  ],
)
