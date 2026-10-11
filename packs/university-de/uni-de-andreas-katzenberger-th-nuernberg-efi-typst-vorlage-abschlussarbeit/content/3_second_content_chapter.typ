#import "../lib.typ": *

= Second Chapter with Content <ch:secondContentChapter>
Hier kann beispielsweise die Methodik vorgestellt werden.
Bevor jedoch direkt mit der Vorstellung der Methode gestartet wird, sollte auch hier wieder eine Hinführung zum Thema erfolgen und die Notwendigkeit / der Grund für die Auswertung aufgezeigt werden.
Ein Verweis auf ein vorheriges Kapitel, beispielsweise Kapitel #ref(<ch:firstContentChapter>, supplement: none), kann dabei ebenfalls eingebaut werden.

Im Falle einer Evaluation wird zunächst der Aufbau der Analyse vorgestellt.
Anschließend werden die einzelnen Bereiche der Auswertung durchgeführt und bewertet (z.B. Vergabe von Punkten auf einer Skala von 0 bis 10).
Sind alle Unterpunkte behandelt, können alle Bewertungen zusammen getragen werden und jeweils ein Score anhand der anfangs festgelegten Gewichtungen aufgestellt werden.
Daraufhin sollte noch erklärt werden, was nun aus der Evaluation folgt und welchen Einfluss es für nachfolgende Kapitel hat (zum Beispiel, dass der "Sieger" der Evaluation verwendet wird und in den folgenden Kapiteln eine Lösung mit diesem ausgearbeitet wird).

Dabei bietet es sich an, Tabellen einzufügen.
Tabelle #ref(<tab:kategorienUndGewichte>, supplement: none) zeigt dafür ein Beispiel zur Visualisierung der Aufteilung der Gewichte:

#figure(
  table(
    columns: 7,
    align: center + horizon,
    table.cell(colspan: 4, fill: grey)[*Kategorie 1 (50%)*],
    table.cell(colspan: 2, fill: grey)[*Kategorie 2 \ (30%)*],
    table.cell(colspan: 1, fill: grey)[*Kategorie 3 \ (20%)*],
    table.cell(colspan: 3, fill: lightgrey)[Subkategorie 1.1 \ (30%)],
    table.cell(colspan: 1, fill: lightgrey)[Subkategorie 1.2 \ (20%)],
    table.cell(colspan: 2, fill: lightgrey)[Kategorie 2 \ (30%)],
    table.cell(colspan: 1, fill: lightgrey)[Kategorie 3 \ (20%)],
    [Kategorien- \ name \ (15%)], [Kategorien- \ name \ (7.5%)], [Name \ (7.5%)],
    [Name \ (20%)], [Name \ (20%)], [Name \ (10%)], [Name \ (20%)],
  ),
  caption: [Farbige Tabelle für Kategorie- und Gewichteinteilung],
) <tab:kategorienUndGewichte>

#pagebreak(weak: true)
In Tabelle #ref(<tab:bewertungKategorien>, supplement: none) sind exemplarisch einige weitere Möglichkeiten demonstriert.

#figure(
  table(
    columns: (auto, auto, auto, auto, auto, auto, auto, auto, 3pt, auto),
    align: center + horizon,
    // Kopfzeile 1
    table.cell(stroke: none)[], table.cell(colspan: 3)[*Subkategorie 1.1*],
    [*Subkat. 1.2*], table.cell(colspan: 2)[*Kategorie 2*], [*Kat. 3*], table.cell(stroke: none)[], table.cell(stroke: none)[],
    // Kopfzeile 2
    [*Tool*], [*Name \ 1.1.1*], [*Name \ 1.1.2*], [*Name \ 1.1.3*], [*Name \ 1.2*],
    [*Name \ 2.1*], [*Name \ 2.2*], [*Name 3*], table.cell(inset: 0.75pt)[], [*Score*],
    // Daten
    [Tool1], [10], [10], [10], [10], [8], [10], [0], table.cell(inset: 0.75pt)[], [7.60],
    [Tool2], [10], [5], [10], [10], [6], [0], [0], table.cell(inset: 0.75pt)[], [5.83],
    [Mehr- \ zeiliges \ Tool3], [10], [0], [0], [10], [5], [5], [10], table.cell(inset: 0.75pt)[], [7.00],
    [Tool4], [10], [10], [10], [0], [10], [10], [10], table.cell(inset: 0.75pt)[], [#text(fill: green)[8.00]],
    // Gewichtungszeile
    table.cell(stroke: none)[], [15%], [7.5%], [7.5%], [20%], [20%], [10%], [20%], table.cell(stroke: none)[], table.cell(stroke: none)[],
  ),
  caption: [Exemplarische punktebasierte Bewertung der gewichteten Kategorien],
) <tab:bewertungKategorien>

Außerdem können einzelne Zellen fabig hinterlegt werden oder Bilder in die Zellen gepackt werden, wie in Tabelle #ref(<tab:praktischerToolVergleich>, supplement: none):

#figure(
  table(
    columns: 5,
    align: center + horizon,
    // Kopfzeile mit Bildern
    table.cell(stroke: none)[],
    table.cell(inset: (x: 1.5pt, y: 1.5pt))[#image("/figures/03_Second_Content_Chapter/01_Tool1.png", width: 60%)],
    table.cell(inset: (x: 1.5pt, y: 1.5pt))[#image("/figures/03_Second_Content_Chapter/02_Tool2.png", width: 60%)],
    table.cell(inset: (x: 1.5pt, y: 1.5pt))[#image("/figures/03_Second_Content_Chapter/03_Tool3.png", width: 60%)],
    table.cell(inset: (x: 1.5pt, y: 1.5pt))[#image("/figures/03_Second_Content_Chapter/04_Tool4.png", width: 60%)],
    // Daten
    [*Kriterium 1*], text(fill: green)[*Ja*], text(fill: green)[*Ja*], text(fill: green)[*Ja*], text(fill: green)[*Ja*],
    [*Kriterium 2*], text(fill: green)[*Frei \ konfigurierbar*], text(fill: green)[*Frei \ konfigurierbar*], text(fill: green)[*Frei \ konfigurierbar*], text(fill: red)[*Eingeschränkte \ Nutzung*],
    [*Kriterium 3*], text(fill: red)[*Nein*], text(fill: green)[*Ja*], text(fill: green)[*Ja*], table.cell(fill: grey)[],
    [*Kriterium 4*], table.cell(fill: grey)[], text(fill: red)[*Nicht frei \ konfigurierbar*], text(fill: green)[*Nur leicht \ eingeschränkt*], table.cell(fill: grey)[],
  ),
  caption: [Praktischer Vergleich der Tools],
) <tab:praktischerToolVergleich>