#import "../src/lib.typ": *
#import "sample-text.typ": sample-headings, sample-text

#show: tub-brochure.with(paper: "a5", theme: "blue-green")

#let partner(file) = box(fill: white, inset: 5pt, image(file, height: 20pt))

#title-page(
  title: [Innovationsmanagement an der Technischen Universität Berlin],
  subtitle: [Studienangebote, Forschung und Campusleben im Überblick],
  info: [Informationen für Studieninteressierte],
  picture: image("img/cover.jpg"),
  logos: (partner("img/internationales.png"), partner("img/dailabor.png")),
)

#picture-page(image("img/group.jpg"), badge: [Bewirb dich!])[
  = #sample-headings.at(1)
  == #sample-text(34)
  #columns(2, sample-text(120))
]

= #sample-headings.at(2)
== Eine Subheadline
#columns(2)[
  #sample-text(150)

  === Auf einen Blick
  - sieben Fakultäten
  - rund 35.000 Studierende
  - mehr als 100 Studiengänge

  #sample-text(90)
]

#back-page[
  Bei Rückfragen wenden Sie sich bitte an die Allgemeine Studienberatung.

  Technische Universität Berlin \
  Straße des 17. Juni 135 \
  10623 Berlin

  Telefon +49 (0)30 314 - 12345 \
  muster\@tu-berlin.de \
  www.tu.berlin
]
