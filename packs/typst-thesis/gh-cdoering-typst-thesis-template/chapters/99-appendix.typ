#import "../lib/i18n.typ": t
#import "../lib/helpers.typ": csv-table, landscape, appendix-numbering

// Der Anhang wird mit Buchstaben nummeriert (A, B, C, ... beziehungsweise
// A.1, A.2). Die set-Regel gilt ab hier bis zum Ende dieser Datei.
#counter(heading).update(0)
#set heading(numbering: appendix-numbering)

// Ueberschreibt das global gesetzte Supplement, damit Querverweise als
// "Anhang A" statt "Kapitel A" erscheinen.
#show heading.where(level: 1): set heading(supplement: t.appendix)

#heading(level: 1, numbering: none, outlined: true)[#t.appendix]

// Ergaenzende Materialien, die fuer die Nachvollziehbarkeit relevant sind,
// den Lesefluss des Haupttexts aber ueberfrachten wuerden.
#lorem(60)

= #t.ch.appendix_intro <app-material>

#lorem(90)

// Breite Tabellen im Querformat -- typisch fuer erweiterte Ergebnistabellen.
// Der Block beginnt und endet mit einem Seitenumbruch.
#landscape[
  = Beispiel im Querformat

  #csv-table(
    csv("../data/generated/example_table.csv"),
    caption: [Dieselbe Tabelle im Querformat.],
    label: <tab-example-quer>,
  )
]

