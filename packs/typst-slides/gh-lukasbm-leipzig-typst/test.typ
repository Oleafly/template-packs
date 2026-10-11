#import "leipzig-typst.typ": *

#show: leipzig-theme.with(
  aspect-ratio: "16-9",
  config-info(
    title: [Leipzig Typst Theme],
    subtitle: [Eine Vorlage im Corporate Design],
    author: [Lukas Böhm],
    institution: [Institut für Informatik],
    place: [Leipzig],
    date: datetime.today(),
    logos: (
      image("assets/logo_leipzig.svg", height: 1.2cm),
    ),
  ),
)

#title-slide()

= Einführung

== Formatierungsanmerkung

#slide(subheader: [Wie alles funktioniert])[
  Überschriften, Zwischenüberschriften und Fließtext werden automatisch
  formatiert.

  - Aufzählungen nutzen orangefarbene Striche
  - Nach einem Umbruch erscheint ein weiteres Aufzählungszeichen
    - Die zweite Ebene ist etwas kleiner
      - und die dritte noch tiefer

  *Titel und Fußzeile* der Präsentation werden automatisch für alle Folien
  gesetzt.
]

== Ein einfaches Beispiel

Diese Folie hat keine explizite `#slide`-Funktion, sondern folgt direkt auf
die Überschrift.

- Punkt eins
- Punkt zwei

= Hauptteil

== Inhalt

#slide[
  Eine Folie ganz ohne Unterüberschrift.

  #lorem(30)
]

#focus-slide[
  Vielen Dank!
]
