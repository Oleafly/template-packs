#import "../Template/Lernzettel.typ": *

= Sortierverfahren <sec-sortierverfahren>

Sortierverfahren ordnen eine Menge von Elementen nach einer Ordnungsrelation. Welche Auswahl sinnvoll ist, hängt von Datenmenge, Vorordnung und Speicherbedarf ab #vgl(<cormenIntroductionAlgorithms2022>, seite: "5"). Die Sprache _Python_ nutzt standardmäßig *Timsort* #vgl(<pythonTimsort2024>).

== Grundlagen

Die wichtigsten Begriffe sind _stabil_ und _in-place_. Ein stabiles Verfahren erhält die Reihenfolge gleicher Elemente #zit(<knuthArtComputerProgramming1998>, seite: "12"). Die Abkürzung #abk("KI") spielt hier eine Rolle, und #abk("KI") auch ein zweites Mal.

#infobox(title: [Stabilität])[Ein Verfahren heißt *stabil*, wenn Elemente mit gleichem Schlüssel ihre relative Reihenfolge behalten. Das ist wichtig bei mehrstufigen Sortierungen.]

#merksatz(title: [Satz von Pythagoras])[
  In einem rechtwinkligen Dreieck gilt: $a^2 + b^2 = c^2$.
]

== Verfahren im Vergleich

#stdtable(
  columns: (auto, 1fr, 1fr),
  header: ([Algorithmus], [Komplexität], [Bemerkung]),
  [Bubble Sort], [$O(n^2)$], [Einfach, aber langsam],
  [Merge Sort], [$O(n "log" n)$], [Stabil, zusätzlicher Speicher],
  [Quicksort], [$O(n "log" n)$], [In-place, nicht stabil],
)

#tabelle(
  stdtable(
    columns: (auto, 1fr),
    header: ([Begriff], [Bedeutung]),
    [stabil], [gleiche Schlüssel behalten Reihenfolge],
    [in-place], [kein nennenswerter Zusatzspeicher],
  ),
  titel: [Wichtige Fachbegriffe],
  quelle: "Eigene Darstellung",
)

#procon(
  pro: ([Schnelle Average-Case-Laufzeit], [Kein Zusatzspeicher]),
  con: ([Worst Case $O(n^2)$], [Rekursion tief bei ungünstigen Pivots]),
)

== Ablauf am Beispiel Quicksort

#process(
  [Pivot-Element wählen],
  [Menge in kleiner und größer partitionieren],
  [Teilmengen rekursiv sortieren],
)

#beispiel(title: [Quicksort auf [3, 1, 4, 1, 5]])[
  Pivot = 3, links: [1, 1], rechts: [4, 5] — danach werden beide Hälften rekursiv sortiert.
]

#aufgabe(title: [Laufzeitanalyse])[
  Bestimmen Sie die Zeitkomplexität von Bubblesort im schlechtesten Fall.
]

#warnbox(title: [Typischer Fehler])[
  Der Worst Case von Quicksort tritt bei bereits sortierten Daten auf, wenn stets das erste Element Pivot ist.
]

== Zusammenfassung

#konzeptkarte(title: [Was merken?])[
  #zweispaltig(
    [**Stabil:** Merge Sort, Timsort],
    [**In-place:** Quicksort, Heapsort],
  )
]