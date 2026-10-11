#import "../template.typ": kind

#heading(outlined: false, "Lesehinweise")

#let thesis-degree = "Wissenschaftliche Arbeit"

#{
  if kind == "Bachelor" {
    thesis-degree = "Bachelorarbeit"
  } else if kind == "Master" {
    thesis-degree = "Masterarbeit"
  } else {
    thesis-degree = "Projektarbeit"
  }
}

#v(1em)

Die folgenden Hinweise sollen das Lesen dieser #thesis-degree erleichtern und spezielle Formatierungen definieren:
- Aus Gründen der besseren Lesbarkeit wird in dieser #thesis-degree auf die gleichzeitige Verwendung weiblicher und männlicher Sprachformen verzichtet. Sämtliche Personenbezeichnungen gelten gleichwohl für alle Geschlechter. In der vorliegenden Arbeit wird das generische Maskulinum verwendet.
- Um eine bessere Übersichtlichkeit zu erzielen, wird nach jedem Hauptkapitel eine neue Seite begonnen.
- Quellcode, Dateinamen oder Konsolenbefehle werden in `Schreibmaschinenschrift` geschrieben bzw. in einer anderen Farbe hervorgehoben (z.B. ```js if count > 10``` ).

#v(1em)

#pagebreak(weak: true)
