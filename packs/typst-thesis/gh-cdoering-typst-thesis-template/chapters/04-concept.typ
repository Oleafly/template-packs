#import "../config.typ": cfg
#import "../lib/i18n.typ": t

= #t.ch.concept

// Der Entwurf vor der Umsetzung: was gebaut wird und warum so.

== #t.ch.requirements

// Funktionale und nicht-funktionale Anforderungen, nachvollziehbar hergeleitet.
#lorem(90)

== #t.ch.architecture

// Struktur, Komponenten, Schnittstellen. Abbildungen gehoeren hierher.
#lorem(90)

== #t.ch.design_decisions

// Alternativen benennen und die getroffene Wahl begruenden.
#lorem(80)

// Abgesetzte Formeln werden gemaess cfg.equation_numbering nummeriert und
// sind damit ueber ihr Label referenzierbar.
$ overline(x) = 1/n sum_(i=1)^n x_i $ <eq-mittelwert>

// Ohne Nummer laesst sich eine Formel nicht referenzieren -- Typst meldet
// dann "cannot reference equation without numbering". Der Verweis steht
// deshalb unter demselben Vorbehalt wie die Nummerierung selbst.
#if cfg.equation_numbering != none [
  Der Verweis auf die Formel wird als @eq-mittelwert gesetzt.
]

