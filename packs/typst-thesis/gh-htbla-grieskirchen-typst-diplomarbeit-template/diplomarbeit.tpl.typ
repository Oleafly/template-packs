#import "style.tpl.typ": *
#import "structure.tpl.typ": *

#let diplomarbeit(
  fachrichtung: "",
  schuljahr: "",
  class: "",
  authors: (),
  betreuer-name: "",
  doc
) = context {
  show: base-style
  show: diplomarbeit-structure.with(
    fachrichtung: fachrichtung,
    schuljahr: schuljahr,
    class: class,
    authors: authors,
    betreuer-name: betreuer-name,
  )
  show: main-style

  front-matter
  
  doc

  back-matter(authors: authors.filter(author => author.at("written-chapters", default: none) != none))
}

#let authors = (
  (name: "John Doe", catalognumber: "0115", written-chapters: ("Kapitel 1", "Kapitel 2")),
  (name: "Max Mustermann", catalognumber: "0116", written-chapters: ("Kapitel 3", "Kapitel 4")),
  (name: "Jane Doe", catalognumber: "0117", written-chapters: ("Kapitel 5", "Kapitel 6")),
)

#set document(
  title: "Document Dataset Synthesizer",
  author: authors.map(author => author.name),
  date: auto,
  keywords: ("Document Dataset Synthesizer", "DDS"),
  description: "This is a description of the document",
)
#show: diplomarbeit.with(
  fachrichtung: "Medizin-Informatik",
  schuljahr: "2025/2026",
  class: "5AHBGM",
  authors: authors,
  betreuer-name: "Prof. Dr. John Doe",
)


= Individualarbeitsrecht

#lorem(40)

== Das Arbeitsverhältnis

#lorem(30)

#lorem(35)

===	Arten von Arbeitsverhältnissen

==== Unterscheidung nach Art der Verwendung

_Angestellter (Gehalt)_

Darunter fallen alle Arbeitnehmer, welche
- kaufmännische
- höhere nicht kaufmännische oder
- Kanzleiarbeiten erledigen

*gesetzliche Grundlage:* Angestelltengesetz (AngG) 

*Beispiele:* Buchhalterin, Sekretär

_Arbeiter (Lohn)_

#lorem(25)

#lorem(150)

====	Unterscheidung nach Dauer

#lorem(250)

= Neue Sektion die richtig cool ist

#lorem(1000)

= Dritte Sektion


