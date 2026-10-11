// =============================================================
// Kapitel 3 - Konzept
// =============================================================
#import "../template.typ": *

= Konzept

== Anforderungsanalyse

...

== Loesungsansatz

...

== Abgrenzung von Alternativen

...

// Beispiel für eine Querformat-Seite im Konzeptkapitel
// Eignet sich z.B. für große Tabellen, Diagramme oder Architekturübersichten

#querformat[
  #heading(level: 2, numbering: none)[Architekturübersicht]

  #figure(
    table(
      columns: (auto, 1fr, 1fr, 1fr),
      align: (left, center, center, center),
      table.header(
        [*Komponente*], [*Technologie*], [*Schnittstelle*], [*Status*],
      ),
      [Frontend],   [React],      [REST API],   [produktiv],
      [Backend],    [Python],     [REST API],   [produktiv],
      [Datenbank],  [PostgreSQL], [SQL],        [produktiv],
      [Messaging],  [RabbitMQ],   [AMQP],       [in Entwicklung],
      [Monitoring], [Grafana],    [Prometheus], [geplant],
    ),
    caption: [Komponentenübersicht der Systemarchitektur],
  ) <tab-architektur>

  Wie in @tab-architektur dargestellt, besteht das System aus fünf Hauptkomponenten.
  Die Querformatseite eignet sich besonders für Tabellen, die im Hochformat zu breit
  wären.
]

Hier geht der Text nach der Querformat-Seite weiter. Das Layout kehrt automatisch zum Hochformat zurück, sodass die folgenden Abschnitte wie gewohnt weitergeführt werden können.

// -------------------------------------------------------------
// Beispiele: Mathematische Umgebungen (nach Einarbeiten löschen)
// -------------------------------------------------------------

== Beispiele

// Satz, Lemma und Definition teilen sich einen gemeinsamen kapitelweiten
// Zähler. Die Nummerierung erfolgt automatisch in der Reihenfolge des
// Auftretens im Text, unabhängig vom Typ (d.h. Def 4.1, Lemma 4.2, Satz 4.3).

Unnummerierte Formel:

$ f(x) = x^2 + 2x + 1 $

Nummerierte Formel mit Verweis:

$ E = m c^2 $ <eq-beispiel>

Wie in @eq-beispiel zu sehen, beschreibt die Formel die Äquivalenz von Masse und Energie.

#definition(name: "Beispieldefinition")[
  Sei $n in NN$. Eine Zahl $p > 1$ heißt prim, wenn sie nur durch $1$ und sich selbst teilbar ist.
]

#satz[
  Es gibt unendlich viele Primzahlen.
]

#beweis[
  Angenommen, es gäbe nur endlich viele. Ihr Produkt plus 1 ist durch keine von ihnen teilbar — Widerspruch. (vgl. [1, S. 17]) $square$
]

#lemma[
  Jede natürliche Zahl $n > 1$ besitzt mindestens einen Primteiler.
]