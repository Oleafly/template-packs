#import "@preview/touying:0.6.1": *
#import "theme/custom-theme.typ": *

#show: custom-theme.with(
  aspect-ratio: "16-9",
  config-info(
    title: [Arbeitstitel],
    subtitle: [],
    author: [Max Mustermann],
    date: [01.01.2000],
  ),
)

#title-slide()

#slide(title: [Inhaltsverzeichnis])[
  #components.adaptive-columns(outline(title: none, depth: 1))
]

= Kontext

#slide(title: [Kontext zum Thema], notes: [
  - Hier Notizen rein
])[
  *Kontextfolie*

  - test 123
]

#slide(title: [Quellenbeispiel], notes: [
  Beispielhaft IEEE
])[
  Test @Vaswani2017
]

= Wissenschaftliche Methodik

#slide(title: [Wissenschaftliche Methodik], notes: [
  CRSIP-DM steht für Cross-Industry Standard Process for Data Mining
  Adsaption dieses Prozesses auf KI nach Bokranzt2023
  CRISP-DM wurde gewählt, da es zu KI passt, wegen datengetrieben
])[
  #align(center)[
    #figure(
      image("assets/crispdm-realising_the_promises.png", width: 90%, height: 80%, fit: "contain"),
      caption: "Auf KI adaptierter CRISP-DM Prozess " + cite(<Bokrantz2023>)
    )
  ]
]

#sources-slide("/refs/sources.bib")
