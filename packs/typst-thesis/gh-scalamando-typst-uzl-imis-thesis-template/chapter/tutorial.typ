#import "/template/utils.typ": *

= Das Template

Die Struktur des Projektes wird in @lst:project-structure aufgeführt. In den
folgenden Abschnitten werden verschiedene Aspekte des Templates erläutert.

#show figure: set block(breakable: true)
#figure(
  ```txt
  ┣ addendum/            Anhang
  ┃  ┗ addendum.typ
  ┣ bibliography/        Bibliografien
  ┃  ┣ references.bib     Alle Quellen bis auf Normen
  ┃  ┗ normen.bib         Normen werden hier definiert
  ┣ chapter/             Verzeichnis für alle Kapitel
  ┃  ┗ ...
  ┣ template/            Template-Dateien
  ┃  ┣ imis-logo.png      IMIS Logo
  ┃  ┣ internal.typ       Interne Hilfsfunktionen
  ┃  ┣ thesis.typ         Template des Dokuments
  ┃  ┗ utils.typ          Sammlung nützlicher Funktionen
  ┣ abstract.typ         DE und ENG Variante des Abstracts
  ┣ acronym.typ          Definition von Abkürzungen
  ┣ foreword.typ         Vorbemerkung (falls benötigt)
  ┣ glossary.typ          Definition von Begriffen
  ┣ main.typ             Hauptdatei mit Metadaten
  ┗ software.typ         Verwendete Software (falls benötigt)
  ```,
  caption: [Verzeichnisstruktur des Projektes],
  placement: none,
) <project-structure>

== Referenzieren <chap:intro-ref>

In Typst können sämtliche Elemente im Text referenziert werden, solange ihnen
ein Label#footnote[https://typst.app/docs/reference/foundations/label/]
zugeordnet ist. Abbildungen, Tabellen und Code-Listings werden hierbei für
gewöhnlich in _figure_
Elemente#footnote[https://typst.app/docs/reference/model/figure/] eingebettet.
Eine kurze Übersicht, wie diese Funktionalitäten in Typst genutzt werden
können, wird im Folgenden präsentiert.

=== Abschnitte

Um Abschnitte wie bspw. @chap:intro-ref zu referenzieren, muss der
Abschnittsüberschrift ein Label nach dem Schema `<chap:name-des-labels>` zugewiesen werden (vgl. @lst:chap-ref).

#figure(
  ```typ
  == Referenzieren <chap:intro-ref>

  Um Abschnitte wie bspw. @chap:intro-ref zu referenzieren ...
  ```,
  caption: [Referenzieren von Abschnitten],
  placement: none,
) <chap-ref>

=== Abbildungen, Tabellen, Listings

Ähnlich zu Abschnitten können Abbildung wie bspw. @fig:imis-logo über ein Label
referenziert werden. Im Gegensatz zu Abschnitten wird das Label für Abbildungen
automatisch mit `fig:` geprefixt, was bei der Referenzierung anderswo beachtet
werden muss (vgl. @lst:fig-ref).

#figure(
  ```typ
  In @fig:imis-logo wird das Logo des IMIS gezeigt.

  #figure(
    image("../template/imis-logo.png", width: 80%),
    caption: [Das offizielle Logo des Institut für ...],
  ) <imis-logo>
  ```,
  caption: [Referenzieren von Abbildungen],
  placement: none,
) <fig-ref>

In @fig:imis-logo wird das Logo des IMIS gezeigt.

#figure(
  image("../template/imis-logo.png", width: 80%),
  caption: [Das offizielle Logo des Institut für Interaktive Menschzentrierte Systeme (IMIS).],
) <imis-logo>

=== Anhänge

Anhänge werden wir Abschnitte zitiert, wobei hier die Label aus der `addendum.typ` verwendet werden müssen.

```typ
@anhang-a
```

@anhang-a

== Literatur

Das Literaturverzeichnis sollte dem aktuellsten APA Standard entsprechen,
solange mit der Betreuer:in nichts anderes vereinbart wurde. In Typst können
Quellen über .bib Dateien eingebunden werden, welche in diesem Template im
Ordner _\/bibliography_ abgelegt werden müssen (vgl. @lst:project-structure).
Neue Einträge können in den Dateien _references.bib_ (alle Quellen bis auf
Normen) und _normen.bib_ (nur Normen) hinzugefügt werden. _Die beiden .bib Dateien werden in dern thesis.typ als Bibliographien geadded. Änderungen an den Dateiennamen oder zusätzliche Bibliograhpien müssen dort hinzugefügt werden._ 

Für die Verwaltung der BibLaTeX-Datein wird ein Quellenverwaltungstool wie
Zotero#footnote[https://www.zotero.org/] stark empfohlen. Das
Literaturverzeichnis wird automatisch erstellt, sobald die Quellen im Text
verwendet werden.

Typst unterstützt die Unterteilung des Literaturverzeichnisses in mehrere
Bereiche, um beispielsweise Online-Quellen gesondert aufzuführen. Wichtig zu
beachten ist, dass Normen in _normen.bib_ definiert werden müssen und alle
anderen Quellen in _references.bib_ damit sie im entsprechenden Bereich
auftauchen.

Im Text gibt es folgende Möglichkeiten, Quellen zu zitieren:

=== Parenthical citation

```typ
Im Vergleich zu SAGAT @endsley_situation_1988 ...
```
_Im Vergleich zu SAGAT @endsley_situation_1988 ..._

==== Multi Citation

```typ
Mehrere Quellen @endsley_situation_1988 @Nielsen1990 ...
```
_Mehrere Quellen @endsley_situation_1988 @Nielsen1990 ..._

=== Narrative citation

```typ
#tc(<abeele2021>) diskutieren, dass ...
```
_ #tc(<abeele2021>) diskutieren, dass ..._

=== Collapsed citation

```typ
Irgendeine Aussage @endsley_situation_1988 @endsley_systematic_2021 @Nielsen1990 @abeele2021
```
_Irgendeine Aussage @endsley_situation_1988 @endsley_systematic_2021 @Nielsen1990 @abeele2021 _

Je nach zitierter Dokumentsorte, sieht die Referenz im Literaturverzeichnis
anders aus:

- Beispiel für einen Konferenzband @Nielsen1990
- Beispiel für einen Journal-Artikel @hollan2000
- Beispiel für ein Buch @zobel2014writing
- Beispiel für eine Norm @ISO9241
- Beispiel für eine Webseite @webimis

== Utils

Die Utilities (kurz Utils) sind eine Ansammlung an nützlichen Funktionen. Sie
müssen am Anfang jeder Datei, in der sie verwendet werde sollen, importiert werden
(vgl. @lst:utils-import)

#figure(
  ```typ
  #import "/template/utils.typ": *
  ```,
  caption: [Import der Utils Funktionen],
  placement: none,
) <utils-import>

Um einen Überblick über die verfügbaren Hilfsfunktionen zu gewinnen, wird ein
Blick in die _template/utils.typ_ empfohlen. Im Folgenden werden einige
Funktionen exemplarisch vorgestellt.

=== Abkürzungen

Verschiedene Funktionen des acrotastic packages werden in Kurzform über die Utils bereitgestellt.

```typ
#acf("VR")
```
#acf("VR")

=== Glossar

Verschiedene Funktionen des glossarium packages werden in Kurzform über Utils
bereitgestellt.

```typ
@thumbstick:long:pl
```
@thumbstick:long:pl

=== Zitation

Zitationen eines Papers (prose)

```typ
#tc(<abeele2021>)
```
#tc(<abeele2021>)

=== Randnotizen

#lorem(20)#side-note[Das hier ist auch möglich] #lorem(20)

=== Text notes

Inline Needs Citation label

```typ
#needs-citation
```
#needs-citation

#line(length: 100%)

```typ
#todo[]
```

#todo[]

#line(length: 100%)

```typ
#todo-b[#lorem(20)]
```
#todo-b[#lorem(20)]

#line(length: 100%)

```typ
#wip[]
#wip-b[#lorem(20)]
```

#wip[]
#wip-b[#lorem(20)]

#line(length: 100%)

```typ
#question[#lorem(20)]
#question[#lorem(20)
  #answer[42]
]
```

#question[#lorem(20)]
#question[#lorem(20)
  #answer[42]
]

#line(length: 100%)

```typ
#done[]
```

#done[]
