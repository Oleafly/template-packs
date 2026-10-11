#import "templates/thesis_template.typ": *
#import "templates/cover.typ": *
#import "templates/titlepage.typ": *
#import "templates/disclaimer.typ": *
#import "acknowledgement.typ": *
#import "abstract.typ": *
#import "metadata.typ": *
#import "@preview/abbr:0.1.1"
// #cover(
//   title: title,
//   degree: degree,
//   author: author,
// )

#titlepage(
  title: title,
  degree: degree,
  supervisor: supervisor,
  advisors: advisors,
  author: author,
  startDate: startDate,
  submissionDate: submissionDate
)

#disclaimer(
  title: title,
  degree: degree,
  author: author,
  location: location,
  submissionDate: submissionDate
)

#acknowledgement()

#abstract()

// Abkürzungen
#abbr.make(
  ("DSGVO", "Datenschutz-Grundverordnung"),
)
#abbr.style(text)

#show: project.with(
  title: title,
  degree: degree,
  supervisor: supervisor,
  advisors: advisors,
  author: author,
  startDate: startDate,
  submissionDate: submissionDate
)

= Einleitung
#lorem(100) #abbr.a[DSGVO]
#lorem(100) #abbr.a[DSGVO]

= Zitieren
Dieser Satz wurde zitiert @bruegge2004object.

= Bilder
@logo_htwk zeigt ein Beispiel für ein Bild.
#figure(
  image("figures/logo.png", width: 25%),
  caption: [Logo der HTWK]
) <logo_htwk>

= Tabelle
#figure(
  table(
    columns: (1fr, 2fr),
    inset: 10pt,

    align: horizon,
    ["Erste Spalte"], ["Zweite Spalte"],
    ["Dritte Spalte"], ["Vierte Spalte"],
  ),
  caption: "Beispieltabelle"
)
