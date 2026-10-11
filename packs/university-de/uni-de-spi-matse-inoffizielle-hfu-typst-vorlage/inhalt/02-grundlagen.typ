#import "../hfu/lib.typ": *

= Abbildungen, Tabellen und Quellcode

Dieses Kapitel zeigt die Bausteine, die die Vorlage zusätzlich zum Fließtext bereitstellt.
Abbildungen und Tabellen erzeugen automatisch Einträge in ihren Verzeichnissen.
Ein eigenes Quellcodeverzeichnis ist nicht Teil der vorgeschriebenen Dokumentstruktur.
Relevante Ausschnitte werden im Haupttext referenziert; umfangreicher Quellcode gehört in den Anhang.

== Abbildungen

Abbildungen werden mit `#abbildung(…)` eingebunden.
Die Beschriftung steht unterhalb und folgt dem Muster „Abbildung [Nummer]: [Titel]“ (§2.6).
Der Verweis auf @abb-beispiel erfolgt über ein Label.

#abbildung(
  rect(width: 8cm, height: 3cm, fill: luma(240), stroke: 0.5pt)[
    #align(center + horizon)[#set par(justify: false); Eigene schematische Darstellung]
  ],
  caption: [Beispiel für eine selbst erstellte Abbildung],
  alt: "Graues Rechteck als Platzhalter für eine selbst erstellte Abbildung.",
) <abb-beispiel>

Stammt eine Abbildung von Dritten, ist die Quelle verpflichtend anzugeben (§2.6).
Sie steht direkt unter der Beschriftung, gehört aber laut §3.7 nicht zum Abbildungstitel und erscheint deshalb nicht im Abbildungsverzeichnis:

#abbildung(
  rect(width: 8cm, height: 3cm, fill: luma(240), stroke: 0.5pt)[
    #align(center + horizon)[#set par(justify: false); Abbildungen unterstützen den zuvor erläuterten Text.]
  ],
  caption: [Rolle von Abbildungen in wissenschaftlichen Arbeiten],
  quelle: [Eigene Darstellung in Anlehnung an @hfu2024[S. 23]],
  alt: "Hinweis, dass Abbildungen den zuvor erläuterten Text unterstützen.",
)

== Tabellen

Tabellen werden ausschließlich abgesetzt eingebunden und unterhalb beschriftet (§2.7).
Der Tabelleninhalt ist laut Tabelle 2 der Richtlinie 10 pt groß; darum kümmert sich `#tabelle(…)`.

#tabelle(
  columns: (auto, 1fr),
  table.header([Rand], [Maß]),
  [Oben], [3 cm],
  [Unten], [2 cm],
  [Innen], [2,5 cm],
  [Außen], [2,5 cm],
  [Bundsteg], [1,5 cm],
  caption: [Seitenränder nach Tabelle 1 der Richtlinie],
  quelle: [@hfu2024[S. 2]],
)

== Quellcode

Kurze Listings lassen sich direkt im Text schreiben:

#quellcode(
  ```typst
  #abbildung(
    image("/bilder/diagramm.svg"),
    caption: [Ablauf der Verarbeitung],
  )
  ```,
  caption: [Einbinden einer Abbildung],
)

Längerer Quellcode gehört in den Ordner `code/` und wird von dort eingebunden.
Der Code bleibt dadurch ausführbar und wird nicht in die Arbeit hineinkopiert:

#quellcode-datei(
  path("/code/beispiel.py"),
  lang: "python",
  caption: [Iterative Berechnung der Fibonacci-Zahlen],
)
