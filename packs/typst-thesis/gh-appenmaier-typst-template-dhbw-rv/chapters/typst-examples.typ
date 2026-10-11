= Typst-Beispiele

Dieses Kapitel zeigt die wichtigsten Typst-Elemente anhand konkreter Beispiele.

== Textformatierung

Text lässt sich *fett*, _kursiv_ oder *_fett und kursiv_* auszeichnen. Für Inline-Code steht `monospace` zur Verfügung.

Weitere Auszeichnungen: #underline[unterstrichen], #strike[durchgestrichen] und #highlight[hervorgehoben].

Die Schriftgröße ist anpassbar: #text(size: 10pt)[kleinerer Text] oder #text(size: 14pt)[größerer Text].

Ein Zeilenumbruch ohne neuen Absatz entsteht mit einem Backslash: \
diese Zeile folgt direkt.

Ein neuer Absatz entsteht durch eine Leerzeile.

== Überschriften

Überschriften werden mit `=`-Zeichen definiert. Level 1 startet eine neue Seite und erscheint im Inhaltsverzeichnis, Level 2 und 3 sind Unterebenen. Unnummerierte Überschriften sind ebenfalls möglich (wie „Anhang" oder „Literaturverzeichnis").

== Listen

=== Aufzählung

- Erster Punkt
- Zweiter Punkt
  - Eingerückter Unterpunkt
- Dritter Punkt

=== Nummerierte Liste

+ Erster Schritt
+ Zweiter Schritt
  + Unterschritt 2a
+ Dritter Schritt

=== Eigene Nummerierung

#enum(
  numbering: "a)",
  [Variante A],
  [Variante B],
  [Variante C],
)

== Abbildungen

Abbildungen werden mit `#figure()` eingebunden und erscheinen automatisch im Abbildungsverzeichnis. Die Beschriftung steht unterhalb, Querverweise funktionieren über Labels.

#figure(
  rect(width: 6cm, height: 3cm, stroke: 0.5pt, fill: luma(230), radius: 4pt),
  kind: image,
  caption: [Beispielabbildung – Platzhalter für ein Bild],
) <fig:beispiel>

Verweis im Text: @fig:beispiel zeigt einen Platzhalter.

== Tabellen

Tabellen werden ebenfalls mit `#figure()` umschlossen und erscheinen im Tabellenverzeichnis.

#figure(
  table(
    columns: (auto, 1fr, auto),
    stroke: 0.5pt,
    inset: (x: 6pt, y: 5pt),
    align: (center, left, right),
    table.header(
      strong[Nr.], strong[Beschreibung], strong[Wert],
    ),
    [1], [Erster Eintrag],  [42],
    [2], [Zweiter Eintrag], [7],
    [3], [Dritter Eintrag], [13],
  ),
  kind: table,
  caption: [Beispieltabelle mit drei Spalten],
) <tab:beispiel>

Zellen lassen sich horizontal oder vertikal verbinden:

#figure(
  table(
    columns: (1fr, 1fr, 1fr),
    stroke: 0.5pt,
    inset: (x: 6pt, y: 5pt),
    table.cell(colspan: 3)[Über alle drei Spalten verbunden],
    [A], [B], [C],
  ),
  kind: table,
  caption: [Tabelle mit verbundenen Zellen],
)

== Code-Listings

Einfache Code-Blöcke werden direkt im Text gesetzt und erscheinen *nicht* im Listingverzeichnis:

```python
def greet(name):
    return f"Hallo, {name}!"
```

Nummerierte Listings mit Beschriftung erscheinen im Listingverzeichnis und können referenziert werden:

#figure(
  raw(lang: "python", block: true,
"def greet(name):
    return f\"Hallo, {name}!\"

print(greet(\"Welt\"))"),
  kind: raw,
  caption: [Beispiel-Funktion in Python],
) <lst:beispiel>

Verweis im Text: @lst:beispiel zeigt eine einfache Grußfunktion.

== Verweise und Zitate

Literaturverweise werden direkt im Text platziert und erscheinen automatisch im Literaturverzeichnis. Querverweise auf Abbildungen, Tabellen und Listings funktionieren über Labels (z.B. @fig:beispiel, @tab:beispiel, @lst:beispiel).

Fußnoten stehen direkt am Text.#footnote[Dies ist eine Beispielfußnote.]

== Mathematik

Inline-Formeln stehen im Fließtext: Die bekannte Formel $E = m c^2$ von Einstein oder eine Summenformel $sum_(i=1)^n i = n(n+1)/2$.

Abgesetzte, nummerierte Gleichungen erscheinen zentriert:

$ integral_0^1 x^2 dif x = 1/3 $ <eq:beispiel>

Eine Fallunterscheidung:

$ f(x) = cases(
  x^2  & "wenn" x >= 0,
  -x^2 & "wenn" x < 0,
) $

Matrizen und Vektoren:

$ mat(a, b; c, d) dot vec(x, y) = vec(a x + b y, c x + d y) $

== Layout-Elemente

Eine horizontale Linie trennt Abschnitte visuell:

#line(length: 100%, stroke: 0.5pt)

Vertikaler Abstand lässt sich gezielt einfügen. #v(0.5cm) Zweispaltiges Layout eignet sich für Vergleiche oder kompakte Darstellungen:

#columns(2)[
  Linke Spalte mit etwas Text als Beispielinhalt.
  #colbreak()
  Rechte Spalte mit etwas Text als Beispielinhalt.
]

Umrahmte Boxen heben Inhalte hervor:

#rect(width: 100%, inset: 10pt, radius: 4pt, stroke: 0.5pt)[
  Dieser Text steht in einer umrahmten Box und fällt dadurch optisch auf.
]

== Sonderzeichen

Typst setzt Anführungszeichen automatisch typografisch: "Beispieltext".

Gedankenstriche: kurz -- wie hier, oder lang --- wie hier.

Ein nicht-trennbares Leerzeichen verhindert Zeilenumbrüche, z.B. bei Abb.~1 oder Tab.~2.
