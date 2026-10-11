#import "notwendig/globals.typ": *

= Konzept und Anforderungen <sec:konzept>

== Beschreibung des betrachteten Systems <sec:system>

Hier wird das System, der Prozess oder der Gegenstand beschrieben, auf den sich die Arbeit bezieht. Der Abschnitt schafft die Grundlage, um die nachfolgenden Anforderungen nachvollziehen zu können.

== Ableitung der Anforderungen <sec:anforderungen>

Hier werden aus der Zielsetzung (@sec:zielsetzung) und dem Stand der Forschung (@sec:grundlagen) die Anforderungen an die Lösung abgeleitet. Sinnvoll ist eine Trennung in funktionale und nichtfunktionale Anforderungen sowie eine eindeutige Kennzeichnung, damit später auf einzelne Anforderungen verwiesen werden kann.

#figure(
  table(
    columns: (auto, 1fr, auto),
    align: (left, left, center),
    stroke: none,
    table.hline(y: 0, stroke: 1pt),
    table.hline(y: 1, stroke: 0.5pt),
    table.hline(y: 4, stroke: 1pt),
    [*Nr.*], [*Anforderung*], [*Priorität*],
    [A1], [Hier steht die erste Anforderung an das System.], [hoch],
    [A2], [Hier steht die zweite Anforderung an das System.], [mittel],
    [A3], [Hier steht die dritte Anforderung an das System.], [gering],
  ),
  caption: flex-caption(
    [Platzhalter für eine Anforderungsliste mit fortlaufender Nummerierung und Priorisierung.],
    [Platzhalter für eine Anforderungsliste]
  ),
  alt: "Tabelle mit drei nummerierten Anforderungen A1 bis A3 und der jeweiligen Priorität."
) <tab:anforderungen>

== Konzeptauswahl <sec:konzeptauswahl>

Hier werden mögliche Lösungskonzepte gegen die Anforderungen aus @tab:anforderungen geprüft und die getroffene Auswahl begründet.
