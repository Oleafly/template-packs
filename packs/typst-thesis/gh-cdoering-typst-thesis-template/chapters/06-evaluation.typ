#import "../lib/i18n.typ": t
#import "../lib/helpers.typ": csv-table, code-listing

= #t.ch.evaluation

// Zeigt, ob das in Kapitel 4 und 5 Entwickelte die Zielsetzung erfuellt.

== #t.ch.eval_design

// Was genau wird gemessen, woran wird Erfolg festgemacht?
#lorem(90)

== #t.ch.eval_setup

// Aufbau so beschreiben, dass er reproduzierbar ist: Versionen, Parameter,
// Umgebung. Ein Beispiel fuer eine Abbildung mit Querverweis:
#lorem(70)

// Empfohlenes Muster: die Abbildung liegt in einer eigenen Datei neben dem
// Bild und wird hier nur eingebunden. Siehe figures/example-figure.typ.
#include "../figures/example-figure.typ"

// Querverweis auf die Abbildung. Wird die Abbildung geloescht, muss der
// Verweis mit -- sonst bricht die Kompilierung mit "label does not exist".
Ein Querverweis auf die Abbildung wird als @fig-example gesetzt, ein Verweis
auf einen Abschnitt als @sec-motivation.

== #t.ch.eval_results

// Ergebnisse darstellen, noch nicht interpretieren -- das gehoert in Kapitel 7.
#lorem(80)

#csv-table(
  csv("../data/generated/example_table.csv"),
  caption: [Beispieltabelle, aus einer CSV-Datei erzeugt.],
  label: <tab-example>,
)

// Quelltextverzeichnis ueber cfg.sections.listings aktivieren.
#code-listing(
  caption: [Beispiel fuer ein Quelltextlisting.],
  label: <lst-example>,
)[
  ```python
  def mittelwert(werte):
      return sum(werte) / len(werte)
  ```
]

