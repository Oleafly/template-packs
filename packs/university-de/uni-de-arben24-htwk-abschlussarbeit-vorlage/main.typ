// ---------------------------------------------------------------------------
// Hauptdatei der Arbeit. Diese Datei kompilieren bzw. in der Live-Vorschau
// oeffnen.
//
// Aufbau: Das Dokument besteht ausschliesslich aus #include-Anweisungen.
// Einzelne Bestandteile lassen sich durch Auskommentieren aus dem Dokument
// entfernen (z. B. der Sperrvermerk, falls nicht benoetigt).
// ---------------------------------------------------------------------------

#import "template.typ": project
#import "@preview/hydra:0.6.2": hydra

#show: project[
  // --- Titelblatt (ohne Kopf-, Fusszeile und Seitenzahl) ---
  #set page(header: none, footer: none, numbering: none)
  #include "Title.typ"
  #pagebreak()

  // --- Vorspann: roemische Seitenzahlen ---
  #set page(
    numbering: "I",
    header: context [
      // skip-starting: true sorgt dafuer, dass auf der ersten Seite eines
      // Kapitels kein Kapitelname in der Kopfzeile steht
      #align(right, text(fill: luma(50%), hydra(1, skip-starting: false)))
      #line(length: 100%, stroke: 0.5pt)
    ],
    footer: context [
      #line(length: 100%, stroke: 0.5pt)
      #v(2mm)
      #align(right)[#counter(page).display()]
    ],
  )

  #counter(page).update(1)

  // Sperrvermerk nur bei Arbeiten mit Vertraulichkeitsvereinbarung
  // #include "Sections/notwendig/00_Sperrvermerk.typ"
  // #pagebreak()

  #include "Sections/notwendig/01_Aufgabenstellung.typ"
  #pagebreak()

  #include "Sections/notwendig/02_Abstract.typ"
  #pagebreak()

  #include "Sections/notwendig/02_01_Abstract_EN.typ"
  #pagebreak()

  #outline(title: [Inhaltsverzeichnis], indent: auto, depth: 3)
  #pagebreak()

  #outline(title: [Abbildungsverzeichnis], target: figure.where(kind: image))

  #outline(title: [Tabellenverzeichnis], target: figure.where(kind: table))
  #pagebreak()

  #include "Sections/notwendig/03_Abkuerzungsverzeichnis.typ"
  #pagebreak()

  #include "Sections/notwendig/04_Symbolverzeichnis.typ"
  #pagebreak()

  // --- Hauptteil: arabische Seitenzahlen, Zaehler beginnt neu bei 1 ---
  #set page(numbering: "1")
  #counter(page).update(1)

  #include "Sections/01_Einleitung.typ"
  #pagebreak()

  #include "Sections/02_00_Grundlagen.typ"
  #pagebreak()

  #include "Sections/03_00_Konzept_und_Anforderungen.typ"
  #pagebreak()

  #include "Sections/04_00_Methodik.typ"
  #pagebreak()

  #include "Sections/05_00_Umsetzung.typ"
  #pagebreak()

  #include "Sections/06_00_Ergebnisse.typ"
  #pagebreak()

  #include "Sections/07_Fazit_und_Ausblick.typ"
  #pagebreak()

  #include "Sections/08_Anhang.typ"
  #pagebreak()

  #include "Sections/notwendig/09_Literaturverzeichnis.typ"
  #pagebreak()

  // Auf der abschliessenden Erklaerung steht kein Kapitelname in der
  // Kopfzeile, da sie keinem Kapitel des Hauptteils angehoert.
  #set page(header: none)

  // Eigenstaendigkeitserklaerung und Erklaerung zur Nutzung von
  // KI-Werkzeugen stehen gemeinsam auf einer Seite. Die Tabelle der
  // eingesetzten Werkzeuge laesst sich innerhalb der Datei ueber den
  // Schalter zeige-werkzeugtabelle ein- und ausblenden.
  #include "Sections/notwendig/10_Erklaerungen.typ"
]
