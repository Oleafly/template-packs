= Einleitung

== Zitieren von Quellen

Hier wird @Neumann:1977 zitiert. Zitate können direkt in den Text eingebunden werden @darwin oder in Klammern gesetzt werden [@Fox:2002].

Weitere Beispiele: Bücher wie @R:Chambers:1998, Artikel aus Fachzeitschriften @meulman, oder Tagungsbände @banzhaf96effect.

== Einbinden von Grafiken

Die @fig:Gauss zeigt ein Beispiel für eine eingebundene Grafik. Typst positioniert Abbildungen automatisch optimal im Dokument.

#figure(
  image("/figures/karl_friedrich_gauss.jpg", width: 30%),
  caption: [Ein jpeg-Bild, hier mit Gauß darauf],
) <fig:Gauss>

#lorem(50)

#lorem(250)

#lorem(100)

== Tabellen

Tabellen können mit der `table` Funktion erstellt werden:

#figure(
  table(
    columns: 3,
    [Parameter],        [Wert],  [Einheit],
    [Temperatur],       [23.5],  [°C],
    [Druck],            [101.3], [kPa],
    [Luftfeuchtigkeit], [65],    [%],
  ),
  caption: [Beispiel einer einfachen Tabelle]
) <tab:beispiel>

Referenz zur Tabelle: siehe @tab:beispiel.

#lorem(50)

#lorem(100)

#lorem(50)

#lorem(50)
