// ##################################################
// Hauptdatei: bindet das Template sowie die einzelnen Bestandteile ein
// und legt die Reihenfolge des Dokuments fest.
// ##################################################

#import "template.typ": thesis, unnumbered-chapter, plain-unnumbered-chapter, anhang
#import "content/framework/title.typ": title-page
#import "content/framework/abstract.typ": abstract
#import "content/framework/blocking_notice.typ": blocking-notice
#import "content/framework/abbreviations.typ": abbreviations
#import "content/framework/index.typ": index
#import "content/framework/affirmation_de.typ": affirmation-de
#import "content/framework/affirmation_en.typ": affirmation-en
#import "content/chapters/chapter_1.typ": chapter-1
#import "content/chapters/chapter_2.typ": chapter-2

// Globale Stile anwenden
#show: thesis

// ##################################################
// Titelblatt
// ##################################################
#title-page

// ##################################################
// Vorspann -- roemische Seitenzahlen
// ##################################################
// Zuerst auf die naechste rechte Seite umbrechen, dort den Zaehler auf I
// zuruecksetzen -> Abstract = Seite I (recto), roemische Seitenzahlen.
#pagebreak(to: "odd", weak: true)
#set page(numbering: "I")
#counter(page).update(1)

// Abstract
#abstract

// Inhaltsverzeichnis -- listet alle Ueberschriften inkl. sich selbst (Tabelle 6)
#unnumbered-chapter("Inhaltsverzeichnis", outlined: true)
// Zeilenabstand im Verzeichnis 1-zeilig (Tabelle 6), max. 3 Gliederungsebenen
#{
  set par(leading: 0.65em)
  outline(title: none, depth: 3)
}

// Sperrvermerk
#blocking-notice

// Abbildungsverzeichnis (nur wenn Abbildungen vorhanden sind, Richtlinie 2.6)
#context if query(figure.where(kind: image)).len() > 0 {
  unnumbered-chapter("Abbildungsverzeichnis")
  outline(title: none, target: figure.where(kind: image))
}

// Tabellenverzeichnis (nur wenn Tabellen vorhanden sind, Richtlinie 2.7)
#context if query(figure.where(kind: table)).len() > 0 {
  unnumbered-chapter("Tabellenverzeichnis")
  outline(title: none, target: figure.where(kind: table))
}

// Codeblockverzeichnis (optional -- nur wenn Code-Bloecke vorhanden sind)
#context if query(figure.where(kind: "listing")).len() > 0 {
  unnumbered-chapter("Codeblockverzeichnis")
  outline(title: none, target: figure.where(kind: "listing"))
}

// Abkuerzungsverzeichnis
#abbreviations

// ##################################################
// Hauptteil -- arabische Seitenzahlen, Zaehler zurueckgesetzt
// ##################################################
#pagebreak(to: "odd", weak: true)
#set page(numbering: "1")
#counter(page).update(1)

// Kapitel (per import eingefuegt)
#chapter-1
#chapter-2

// ##################################################
// Reihenfolge laut Tabelle 3:
//   Inhaltlicher Teil -> Literaturverzeichnis -> Stichwortverzeichnis
//   -> Eidesstattliche Erklaerung
// ##################################################

// Literaturverzeichnis (ab hier 1-zeilig); Zitierstil IEEE (2.9.5)
// Innerhalb einer Quelle 1-zeilig, zwischen Quellen weiterhin Absatzabstand.
#set par(leading: 0.65em)
#bibliography("bibtex.bib", title: "Literaturverzeichnis", style: "ieee")

// Schlagwortverzeichnis (Index / Stichwortverzeichnis)
#index

// ##################################################
// Eidesstattliche Erklaerung (openright deaktiviert)
// Davor ein leeres Trennblatt einfuegen (2.11)
// ##################################################
// Leeres Trennblatt (ohne Kopfzeile) vor der Versicherung
#page(header: none)[]
#affirmation-de
#affirmation-en

// ##################################################
// Anhang (Tabelle 3 / 2.13) -- eigene Seitennummerierung (A-1, B-1, ...).
// Davor ein leeres Trennblatt einfuegen.
// ##################################################
#page(header: none)[]
#anhang("A", "Beispiel-Fragebogen")[
  Der Anhang enthält weiterführende Informationen, die den Lesefluss der Arbeit
  stören würden -- etwa Fragebögen, transkribierte Interviews oder umfangreiche
  Tabellen. Jeder Anhang trägt einen eigenen Buchstaben und eine eigene
  Seitennummerierung (hier A-1, A-2, ...).
]
#anhang("B", "Weitere Tabellen")[
  Ein weiterer Anhang beginnt mit dem nächsten Buchstaben und setzt die
  Seitennummerierung bei B-1 neu auf.
]
