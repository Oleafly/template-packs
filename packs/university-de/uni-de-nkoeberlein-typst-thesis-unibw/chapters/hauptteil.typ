#import "../lib/styles.typ": img, imgcite, important, note, tbl, tip

= Hauptteil
<chap-hauptteil>

Der Hauptteil demonstriert die praktische Anwendung der Vorlage anhand konkreter Beispiele:
Abbildungen mit Quellenangabe, Code-Listings mit Syntax-Highlighting, nummerierte
mathematische Gleichungen und komplexere Tabellen.

== Methodik

Für die Erstellung dieser Beispiel-Arbeit wurde ein systematischer Ansatz gewählt. Das Ziel
war es, alle wichtigen Features der Vorlage in einem kohärenten Dokument zu demonstrieren.
Die Vorgehensweise gliedert sich in folgende Schritte:

1. *Strukturierung:* Festlegung der Kapitel und deren Inhalte in `main.typ`.
2. *Metadaten:* Eintragen persönlicher Angaben in `metadata.typ`.
3. *Inhaltserstellung:* Schreiben der Texte in `chapters/` mit realistischen Beispielen.
4. *Feature-Integration:* Einbindung von Bildern, Tabellen, Code und Formeln.
5. *Validierung:* Kompilierung mit `make build` und visuelle Prüfung des @pdf.

== Beispielabbildung

Ein zentrales Element wissenschaftlicher Arbeiten sind Abbildungen. Abbildung
@fig-regensburg zeigt den Campus der Universität Regensburg als Platzhalter für eigene Bilder.

#img(
  "regensburg-uni.jpg",
  width: 50%,
  caption: [Campus der Universität Regensburg als Beispiel für eine Bild-Einbindung],
  source: [#imgcite("placeholder1")],
) <fig-regensburg>

@fig-regensburg illustriert, wie Bilder mit `#img(...)` eingebunden werden. Die Funktion
erwartet den Dateinamen relativ zu `media/`, eine Caption und optional eine Quellenangabe.
Die Quelle erscheint kursiv unter der Bildunterschrift, wird aber *nicht* ins
Abbildungsverzeichnis übernommen. Lege eigene Bilder in den Ordner `media/` ab.

#tip[
  *Eigene Bilder einbinden:* Kopiere dein Bild nach `media/meinbild.png` und schreibe:
  ```typst
  #img("meinbild.png", width: 80%, caption: [Beschreibung], source: [#imgcite("quellenkey")])
  <fig-meinbild>
  ```
  Dann kannst du mit `@fig-meinbild` darauf verweisen.
]

== Nummerierte mathematische Gleichungen

Im Unterschied zu den abgesetzten Formeln in Kapitel @chap-grundlagen können Gleichungen
auch nummeriert werden — dafür wickelst du sie in `#figure(...)` ein:

#figure(
  $ E = m c^2 $,
  caption: [Einsteins Masse-Energie-Äquivalenz],
  supplement: [Gleichung],
) <eq-einstein>

Gleichung @eq-einstein ist wohl die bekannteste Formel der Physik. Ebenso klassisch ist
das Gaußsche Fehlerintegral:

#figure(
  $ integral_(-infinity)^(+infinity) e^(-x^2) dif x = sqrt(pi) $,
  caption: [Gaußsches Fehlerintegral],
  supplement: [Gleichung],
) <eq-gauss>

Gleichung @eq-gauss taucht in der Wahrscheinlichkeitstheorie und Signalverarbeitung
häufig auf. Das Label `<eq-gauss>` und der Verweis `@eq-gauss` folgen demselben Prinzip
wie bei Abbildungen und Tabellen.

== Code-Listings

Programmcode ist in vielen Arbeiten unverzichtbar. Typst bietet eingebautes
Syntax-Highlighting für über 100 Programmiersprachen — kein externes Paket nötig.

=== Python-Beispiel

Listing @lst-python zeigt eine iterative Python-Funktion mit Typ-Annotationen und
Docstring.

#figure(
  ```python
  def fibonacci(n: int) -> int:
      """
      Berechnet die n-te Fibonacci-Zahl iterativ.

      Args:
          n: Index der Fibonacci-Zahl (nicht-negativ)

      Returns:
          Die n-te Fibonacci-Zahl
      """
      if n < 0:
          raise ValueError("n muss nicht-negativ sein")
      a, b = 0, 1
      for _ in range(n):
          a, b = b, a + b
      return a

  # Hauptprogramm
  if __name__ == "__main__":
      for i in range(10):
          print(f"F({i}) = {fibonacci(i)}")
  ```,
  caption: [Iterative Fibonacci-Berechnung in Python],
  kind: raw,
  supplement: [Code],
) <lst-python>

=== JSON-Konfiguration

Auch Konfigurationsdateien lassen sich gut darstellen, wie Listing @lst-json zeigt.

#figure(
  ```json
  {
    "project": "wissenschaftliche-arbeit",
    "author": "Max Mustermann",
    "settings": {
      "language": "de",
      "font_size": 11,
      "line_spacing": 1.2
    },
    "dependencies": {
      "glossarium": "0.5.10",
      "alexandria": "0.2.2"
    }
  }
  ```,
  caption: [Beispiel einer JSON-Konfigurationsdatei],
  kind: raw,
  supplement: [Code],
) <lst-json>

=== Shell-Skript

Listing @lst-bash demonstriert ein praktisches Shell-Skript für die Arbeit mit Typst.

#figure(
  ```bash
  #!/bin/bash
  # Kompilierungsskript für wissenschaftliche Arbeiten

  echo "Starte Typst-Kompilierung..."

  # Einmalig kompilieren (mit Bookerly-Font)
  typst compile --font-path fonts main.typ output.pdf

  # Oder: Live-Vorschau bei Änderungen
  # typst watch --font-path fonts main.typ

  if [ $? -eq 0 ]; then
      echo "Kompilierung erfolgreich!"
  else
      echo "Fehler bei der Kompilierung." >&2
      exit 1
  fi
  ```,
  caption: [Bash-Skript zur Typst-Kompilierung],
  kind: raw,
  supplement: [Code],
) <lst-bash>

== Datenanalyse in Tabellenform

Komplexere Tabellen mit Kopfzeile und unterschiedlicher Spaltenausrichtung lassen sich
mit `#tbl(table(...), caption: [...])` erstellen. Tabelle @tab-metriken fasst verschiedene
Metriken zusammen.

#tbl(
  table(
    columns: (2fr, 1fr, 1fr, 1fr, 2fr),
    align: (left, right, right, right, left),
    table.header([Metrik], [Minimum], [Mittelwert], [Maximum], [Anmerkung]),
    [Kompilierzeit (s)], [0.1], [0.45], [1.2], [Sehr schnell],
    [Dokumentgröße (MB)], [0.5], [2.3], [8.7], [Abhängig von Bildern],
    [Zeilen pro Kapitel], [50], [320], [1200], [Variiert stark],
    [Anzahl Fußnoten], [0], [4], [15], [Optional],
  ),
  caption: [Vergleich verschiedener Dokumentmetriken],
) <tab-metriken>

== Ergebnisse und Interpretation

Die Ergebnisse lassen sich wie folgt zusammenfassen:

- Die Typst-Vorlage ermöglicht eine *professionelle Formatierung* mit minimalem Aufwand.
- *Automatische Nummerierung* von Abbildungen, Tabellen, Gleichungen und Code-Listings
  funktioniert zuverlässig über das Label-/Referenzsystem.
- Die *Integration von Glossarium* für Abkürzungen reduziert Redundanzen im Text.
- Das *Literaturverzeichnis* wird automatisch aus der `references.bib` generiert.
- *Querverweise* auf Kapitel, Abbildungen, Tabellen und Gleichungen sind einfach und stabil.

#note[
  *Trennung von Inhalt und Layout:* Ein besonderer Vorteil dieser Vorlage ist die klare
  Trennung. Du konzentrierst dich auf das Schreiben — die Vorlage kümmert sich um
  Formatierung, Verzeichnisse, Nummerierung und typografische Details.
]
