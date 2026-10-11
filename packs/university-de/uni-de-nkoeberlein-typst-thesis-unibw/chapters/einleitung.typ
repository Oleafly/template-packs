#import "../lib/styles.typ": important, note, tip, highlight

= Einleitung
<chap-einleitung>

Diese Arbeit dient als vollständiges Lernbeispiel für die Typst-Vorlage. Jedes Kapitel
demonstriert konkrete Features, die du für deine eigene wissenschaftliche Arbeit benötigst.
Laut @smith2023 gewinnt Typst in der akademischen Community zunehmend an Bedeutung, besonders
durch seine niedrige Einstiegshürde gegenüber traditionellen Systemen.

== Was ist Typst?

Typst ist ein modernes Textsatzsystem, das als Alternative zu LaTeX entwickelt wurde. Es
kombiniert professionellen Schriftsatz mit einer einfachen, Markdown-ähnlichen Syntax.
Das Ergebnis ist ein @pdf mit typografisch hochwertiger Formatierung.

Die wichtigsten Vorteile auf einen Blick:

- *Schnelle Kompilierung:* Änderungen werden sofort sichtbar (Live-Reload mit `make watch`).
- *Verständliche Fehlermeldungen:* Statt kryptischer Fehler bekommst du klare Hinweise.
- *Moderne Syntax:* Ähnlich wie Markdown, aber mit allen Features wissenschaftlichen Schriftsatzes.
- *Integriertes Syntax-Highlighting:* Über 100 Programmiersprachen werden nativ unterstützt.
- *Automatische Verzeichnisse:* Inhalts-, Abbildungs-, Tabellen- und Literaturverzeichnis
  werden aus dem Inhalt generiert.

== Forschungsfrage und Zielsetzung

Das Ziel dieser Beispiel-Arbeit ist es, die wichtigsten Features der Vorlage zu zeigen. Dabei
werden folgende Fragen beantwortet:

- *FF1:* Wie lassen sich wissenschaftliche Texte effizient mit Typst formatieren?
- *FF2:* Welche Vorteile bietet die Vorlage gegenüber manueller Formatierung?

== Aufbau der Arbeit

Die Arbeit ist in vier Hauptkapitel gegliedert:

1. *Einleitung* (Kapitel @chap-einleitung): Motivation, Zielsetzung und Typst-Grundlagen.
2. *Grundlagen* (Kapitel @chap-grundlagen): Theoretischer Hintergrund, Definitionen,
   Tabellen und Theorem-Umgebungen.
3. *Hauptteil* (Kapitel @chap-hauptteil): Methodik, Abbildungen, Code-Listings und
   mathematische Formeln mit Nummerierung.
4. *Schlussbetrachtung* (Kapitel @chap-schluss): Zusammenfassung, Limitationen und Ausblick.

Im Anhang befinden sich ein Glossar mit Abkürzungen wie @ki, @api und @ide sowie
ausführliche Code-Beispiele.

#note[
  *Tipp für den Start:* Öffne `metadata.typ` und trage deine persönlichen Daten ein.
  Das ist die einzige Datei, die du zu Beginn anpassen musst. Alle anderen Dateien enthalten
  das Layout und kannst du zunächst unverändert lassen.
]

== Typst-Grundlagen im Überblick

Dieser Abschnitt zeigt die wichtigsten Syntax-Elemente direkt am Beispiel — als
Nachschlagewerk für deine eigene Arbeit.

=== Textformatierung

In Typst kannst du Text auf mehrere Arten auszeichnen:

- *Fetter Text* mit Sternchen ohne Leerzeichen: `*fett*`
- _Kursiver Text_ mit Unterstrich: `_kursiv_`
- `Code im Fließtext` mit einfachen Backticks
- "Gänsefüßchen" werden automatisch in typografische Anführungszeichen umgewandelt.
- Hervorhebung durch #highlight[farbigen Hintergrund] mit `#highlight[...]`

#important[
  *Häufiger Fehler:* `* fett *` (mit Leerzeichen nach dem Stern) funktioniert *nicht*!
  Der Stern muss direkt am Wort kleben: `*fett*`.
]

=== Listen

Ungeordnete Listen mit Bindestrich — ideal für Aufzählungen ohne feste Reihenfolge:

- Erster Punkt
- Zweiter Punkt
  - Verschachtelter Unterpunkt (zwei Leerzeichen Einrückung)
  - Noch ein Unterpunkt
- Dritter Punkt

Geordnete Listen mit `+` — ideal für Schritt-für-Schritt-Anleitungen:

+ Schritt 1: `metadata.typ` anpassen
+ Schritt 2: Kapitel in `chapters/` schreiben
+ Schritt 3: Kompilieren mit `make build`
+ Schritt 4: `main.pdf` im PDF-Viewer öffnen

=== Querverweise und Zitate

Querverweise funktionieren mit Labels (`<name>`) und Verweisen (`@name`). Ein Label
setzt du direkt nach einem Element:

```typst
= Mein Kapitel <chap-mein-kapitel>
```

Dann verweist du mit `@chap-mein-kapitel` darauf, z. B.: „Siehe Kapitel @chap-einleitung."

*Literaturzitate* aus der `.bib`-Datei funktionieren genauso: `@smith2023` wird
automatisch als @smith2023 formatiert und ins Literaturverzeichnis übernommen.
Seitenangaben sind möglich: `[@doe2024, S. 42]` ergibt @doe2024[S. 42].

*Abbildungen und Tabellen* referenzierst du über ihr Label:
`@fig-regensburg` → Abbildung @fig-regensburg im Hauptteil.

=== Abkürzungen und Glossar

Abkürzungen verwaltest du in `chapters/anhang/glossary-entries.typ`. Im Text verwendest
du `@schluessel` — beim ersten Auftreten erscheint die Langform mit Kurzform in Klammern,
danach nur noch die Kurzform:

- Erste Nennung: `@ki` → @ki
- Zweite Nennung: `@ki` → @ki (nur Kurzform)
- Immer Langform erzwingen: `@ki:long` → @ki:long

Auch `@api`, `@ml` und `@ide` sind im Glossar definiert und werden bei erster Nennung
automatisch ausgeschrieben.

=== Fußnoten

Fußnoten fügt du direkt im Fließtext ein:#footnote[Dies ist eine Fußnote. Sie erscheint
automatisch am unteren Seitenrand und wird fortlaufend nummeriert.]

=== Informationsboxen

Für hervorgehobene Inhalte stehen drei Boxtypen zur Verfügung:

#important[
  *Wichtig-Box* (`#important[...]`): Für kritische Hinweise, Warnungen oder Anforderungen,
  die der Leser keinesfalls übersehen sollte.
]

#note[
  *Hinweis-Box* (`#note[...]`): Für ergänzende Informationen, Tipps zur Vertiefung oder
  Querverweise auf weiterführende Quellen.
]

#tip[
  *Tipp-Box* (`#tip[...]`): Für praktische Ratschläge und Empfehlungen aus der Erfahrung.
  Nutze diese Box sparsam für wirklich hilfreiche Hinweise.
]
