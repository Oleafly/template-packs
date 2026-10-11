#import "wiar.typ": *

#show: wiar-arbeit.with(
  titel: "Titel",
  untertitel: "(evt. Untertitel, Foto usw.)",
  art: "Semesterarbeit: Wissenschaftliches Arbeiten",
  autor: "Vorname und Name des/r Studenten/in",
  ort-datum: "Wohnort, Datum",
  studiengang: "Studiengang XY",
  // kopfzeile: "Evtl. Kopfzeile",
)

// --- Abstract ----------------------------------------------------------------

#verzeichnis("Abstract", im-inhaltsverzeichnis: false)

Kurze Zusammenfassung der Arbeit: Fragestellung, Vorgehen, wichtigste
Ergebnisse. Der Abstract erscheint bewusst nicht im Inhaltsverzeichnis.

// --- Inhaltsverzeichnis ------------------------------------------------------

#inhaltsverzeichnis()

// --- Abkuerzungen ------------------------------------------------------------

#verzeichnis("Abkürzungen")

#abkuerzungsverzeichnis((
  ("Hrsg.", "Herausgeber"),
  ("NN", "nomen nominandum (Namen nicht bekannt)"),
  ("o. J.", "ohne Jahrgang"),
))

// --- Hauptteil: ab hier arabische Seitenzahlen ab 1 --------------------------

#show: hauptteil

= Überschrift 1

Fliesstext im Blocksatz, Arial 11 pt, Zeilenabstand 1.5 -- so wie es die
Word-Vorlage vorgibt. Quellenangaben werden als Zitat gesetzt
@ffhs-leitfaden.

== Überschrift 2

Ein Verweis auf @abb-beispiel zeigt, wie Abbildungen referenziert werden.

#figure(
  rect(width: 6cm, height: 3cm, stroke: 0.5pt, fill: luma(245))[
    #align(center + horizon)[Platzhalter]
  ],
  caption: [Beispielabbildung mit Bildunterschrift],
) <abb-beispiel>

=== Überschrift 3

Tabellen erhalten eine Beschriftung oberhalb oder unterhalb; hier wie bei
Abbildungen unterhalb, damit beide Verzeichnisse einheitlich aussehen
@zitiernorm.

#figure(
  table(
    columns: (1fr, 1fr),
    stroke: 0.5pt,
    inset: (x: 0.19cm, y: 0.12cm),
    table.header(strong[Spalte A], strong[Spalte B]),
    [Wert 1], [Wert 2],
    [Wert 3], [Wert 4],
  ),
  caption: [Beispieltabelle mit Tabellenbeschriftung],
) <tab-beispiel>

// --- Verzeichnisse im Anschluss ----------------------------------------------

#abbildungsverzeichnis()

#tabellenverzeichnis()

#verzeichnis("Literaturverzeichnis")

#bibliography("literatur.bib", title: none, style: "apa")

#verzeichnis("Hilfsmittelverzeichnis")

#hilfsmittelverzeichnis((
  ("Bezahltes Lektorat", "Rechtschreibkorrektur", "Gesamtes Dokument"),
  ("Google Translate", "Übersetzung von Textpassagen", "Kapitel 5.3, Seite 25-26"),
  ("ChatGPT", "Kapitelstruktur", "Kapitel 5, Seiten 23-39"),
  ("", "", ""),
))

#verzeichnis("Anhang")

Anhang A: ergänzende Materialien.

#selbstaendigkeitserklaerung()
