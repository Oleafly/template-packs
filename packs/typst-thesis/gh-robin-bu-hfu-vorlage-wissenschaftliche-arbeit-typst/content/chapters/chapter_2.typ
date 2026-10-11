// Zweites Beispielkapitel: Formeln, Code und Theorem-Umgebungen.

// Listing- und Theorem-Hilfsbefehle sowie Quellenangabe aus der Vorlage
#import "../../template.typ": listing, beispiel, definition, these, source

#let chapter-2 = {
  [= Formeln, Code und Definitionen]

  [== Mathematische Formeln]

  [
    Formeln lassen sich direkt im Fließtext setzen, etwa die Energie-Masse-
    Äquivalenz $E = m c^2$ oder ein Bruch wie $1 / 2$. Abgesetzte (nummerierte)
    Gleichungen werden mit Leerzeichen innerhalb der Dollarzeichen erzeugt und
    sind über ihr Label referenzierbar -- siehe @eq-pythagoras:
  ]

  [
    $ a^2 + b^2 = c^2 $ <eq-pythagoras>
  ]

  [
    Auch komplexere Ausdrücke mit Summen, Brüchen und griechischen Buchstaben
    sind möglich:
  ]

  [
    $ sum_(i=1)^n i = (n (n + 1)) / 2 $ <eq-summe>
  ]

  [== Quellcode]

  [
    Kurze Code-Schnipsel im Fließtext werden mit einfachen Backticks gesetzt und
    erscheinen in Monospace-Schrift, etwa `print("Hallo Welt")` oder der Aufruf
    `add(2, 3)`. Längere, zusammenhängende Quelltexte gehören in einen
    Code-Block mit Beschriftung (siehe @lst-add).
  ]

  [
    #listing(
      ```python
      def add(a, b):
          # zwei Zahlen addieren
          return a + b

      print(add(2, 3))  # -> 5
      ```,
      caption: [Einfache Additionsfunktion in Python],
    ) <lst-add>

    #source[Eigene Darstellung]
  ]

  [== Definitionen, Beispiele und Thesen]

  [
    Für klar abgegrenzte Aussagen stehen nummerierte Umgebungen bereit. Eine
    Definition führt einen Begriff ein:
  ]

  definition[
    Eine #emph[Primzahl] ist eine natürliche Zahl größer als 1, die nur durch 1
    und sich selbst teilbar ist.
  ]

  [Ein Beispiel veranschaulicht die Definition:]

  beispiel[
    Die Zahl 7 ist eine Primzahl, da sie ausschließlich durch 1 und 7 teilbar
    ist. Die Zahl 8 ist hingegen keine Primzahl.
  ]

  [Eine These formuliert eine zu prüfende Annahme:]

  these[
    Mit zunehmender Größe der Zahlen werden Primzahlen seltener.
  ]
}
