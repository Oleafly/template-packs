#import "notwendig/globals.typ": *

== Zweites Themenfeld <sec:themenfeld_b>

=== Theoretische Grundlagen <sec:theorie>

Hier werden die für die Arbeit benötigten theoretischen Zusammenhänge hergeleitet. Formeln werden fortlaufend nummeriert und erhalten eine Marke, damit im Text auf sie verwiesen werden kann. Ein einfaches Beispiel ist der Zusammenhang zwischen Kraft $F$, Masse $m$ und Beschleunigung $a$:

$ F = m dot a $ <eq:newton>

Die in @eq:newton verwendeten Formelzeichen sind im Symbolverzeichnis aufgeführt. Verweise auf Gleichungen erscheinen in dieser Vorlage nur als eingeklammerte Nummer, das Wort "Gleichung" wird bei Bedarf im Text ergänzt.

Mehrzeilige Formeln werden über eine Ausrichtung gesetzt:

$ x(t) &= x_0 + v_0 dot t + 1/2 a t^2 \
  dot(x)(t) &= v_0 + a t $ <eq:bewegung>

=== Vergleich bestehender Ansätze <sec:vergleich>

Hier werden die betrachteten Ansätze systematisch gegenübergestellt. @tab:beispiel_vergleich zeigt den Aufbau einer solchen Vergleichstabelle. Die Beschriftung steht bei Tabellen oberhalb.

#figure(
  table(
    columns: (auto, auto, auto),
    align: (left, center, center),
    stroke: none,
    table.hline(y: 0, stroke: 1pt),
    table.hline(y: 1, stroke: 0.5pt),
    table.hline(y: 4, stroke: 1pt),
    [*Kriterium*], [*Ansatz A*], [*Ansatz B*],
    [Kriterium 1], [hoch], [gering],
    [Kriterium 2], [gering], [hoch],
    [Kriterium 3], [mittel], [mittel],
  ),
  caption: flex-caption(
    [Platzhalter für eine Vergleichstabelle mit drei Bewertungskriterien und zwei gegenübergestellten Ansätzen.],
    [Platzhalter für eine Vergleichstabelle]
  ),
  alt: "Tabelle mit drei Kriterien, die für zwei Ansätze jeweils mit hoch, gering oder mittel bewertet werden."
) <tab:beispiel_vergleich>

Aus dem Vergleich in @tab:beispiel_vergleich wird die für diese Arbeit gewählte Vorgehensweise abgeleitet und begründet.
