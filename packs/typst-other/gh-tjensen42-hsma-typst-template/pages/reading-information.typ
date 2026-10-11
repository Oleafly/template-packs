#import "../template.typ": degree

#heading(outlined: false, "Lesehinweise")

#let thesis-degree = "Masterarbeit";

#{if degree == "Bachelor"{
  thesis-degree = "Bachelorarbeit";
}}

#v(1em)

Die folgenden Hinweise sollen das Lesen dieser #thesis-degree erleichtern und spezielle Formatierungen definieren:
- Aus Gründen der besseren Lesbarkeit wird in dieser #thesis-degree auf die gleichzeitige Verwendung weiblicher und männlicher Sprachformen verzichtet. Sämtliche Personenbezeichnungen gelten gleichwohl für alle Geschlechter. In der vorliegenden Arbeit wird das generische Maskulinum verwendet.
- Hochgestellte Ziffern weisen auf Fußnoten am Seitenende hin.
- Um eine bessere Übersichtlichkeit zu erzielen, wird nach jedem Hauptkapitel eine neue Seite begonnen.
- Quellcode, Dateinamen oder Konsolenbefehle werden in `Schreibmaschinenschrift` geschrieben bzw. in einer anderen Farbe hervorgehoben (z.B. ```python if count > 10``` ).

#v(1em)

#pagebreak(weak: true)
