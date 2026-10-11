#import "../lib.typ": *

= Fourth Chapter with Content <ch:fourthContentChapter>
Achte darauf, dass im englischen alle aktiven Taten im aktiv mit 'we' formuliert werden, während Fakten im Passiv aufgezählt werden können.

Eine tolle Möglichkeit, die Arbeit schön zu gestalten und verständlich für Leser zu machen, ist die Verwendung von Grafiken.
Hier werden ein paar Varianten aufgezeigt, wie man diese einzeln oder gemeinsam mit verschiedenen Einstellungen einbettet.

Zunächst einmal zeigt @fig:flugWeltkarte eine simple Abbildung mittig auf der Seite.

#fig-image(
  "figures/05_Fourth_Content_Chapter/01_Veranschaulichung_Flug.pdf",
  width: 75%,
  caption: [Flug-Visualisierung auf Weltkarte],
  label: <fig:flugWeltkarte>,
)

Natürlich kann man auch auf Bilder verweisen und diese in den Anhang setzen.
Dazu fuege ich hier einen Verweis zu @fig:ohmLogo ein, welches zum Ohm-Logo im Anhang führt.

#pagebreak(weak: true)
Um bestimmte Teile der Grafik noch zu betiteln kann man auch wie in @fig:prozessZusammenhaenge zusätzliche Textzeilen unter die Abbildung packen.

#figure(
  grid(
    columns: (1fr),
    row-gutter: 3.0mm,
    align(center)[
      #image("/figures/05_Fourth_Content_Chapter/02_Prozess.pdf", width: 80%)
    ],
    align(center)[
      #box[
        #set align(left)
        1: Beschreibung von Aktivität 1 \
        2: Beschreibung von Aktivität 2 \
        3: Beschreibung von Aktivität Nummer 3
      ]
      #v(2mm)
    ],
  ),
  caption: [Prozess XY],
) <fig:prozessZusammenhaenge>

Und nun noch ein Beispiel, wie man mehrere Bilder nebeneinander darstellt (@fig:balkendiagrammVorher und @fig:balkendiagrammNachher).

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  [#figure(
    image("/figures/05_Fourth_Content_Chapter/03_Linkes_Balkendiagramm.pdf", width: 97.5%),
    caption: [Statistik XY - Vorher],
  ) <fig:balkendiagrammVorher>],
  [#figure(
    image("/figures/05_Fourth_Content_Chapter/04_Rechtes_Balkendiagramm.pdf", width: 97.5%),
    caption: [Statistik XY - Nachher],
  ) <fig:balkendiagrammNachher>],
)
