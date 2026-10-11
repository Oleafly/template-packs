#import "notwendig/globals.typ": *

= Ergebnisse und Diskussion <sec:ergebnisse>

== Ergebnisse <sec:erg_darstellung>

Hier werden die erzielten Ergebnisse sachlich dargestellt, zunächst ohne Interpretation. Messwerte werden in Tabellen oder Diagrammen zusammengefasst und im Text auf die wesentlichen Beobachtungen reduziert.

#figure(
  table(
    columns: (auto, auto, auto),
    align: (left, right, right),
    stroke: none,
    table.hline(y: 0, stroke: 1pt),
    table.hline(y: 1, stroke: 0.5pt),
    table.hline(y: 4, stroke: 1pt),
    [*Versuch*], [*Messwert*], [*RMSE*],
    [Versuch 1], [0,00], [0,00],
    [Versuch 2], [0,00], [0,00],
    [Versuch 3], [0,00], [0,00],
  ),
  caption: flex-caption(
    [Platzhalter für eine Ergebnistabelle. Dezimaltrennzeichen ist im Deutschen das Komma, nicht der Punkt.],
    [Platzhalter für eine Ergebnistabelle]
  ),
  alt: "Tabelle mit drei Versuchen sowie den zugehörigen Messwerten und RMSE-Werten."
) <tab:ergebnisse>

Die in @tab:ergebnisse zusammengefassten Werte wurden nach dem in @sec:auswertung beschriebenen Verfahren bestimmt.

== Diskussion <sec:erg_diskussion>

Hier werden die Ergebnisse eingeordnet und interpretiert. Der Abschnitt beantwortet, ob die in @sec:zielsetzung formulierten Teilziele erreicht wurden und wie sich die Ergebnisse zum Stand der Forschung aus @sec:grundlagen verhalten.

== Bewertung und Grenzen <sec:erg_grenzen>

Hier werden Aussagekraft und Grenzen der Ergebnisse kritisch bewertet. Dazu gehören Fehlerquellen, die Übertragbarkeit auf andere Randbedingungen sowie offen gebliebene Fragen.
