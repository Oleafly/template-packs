#import "../template/thesis.typ": thesis

#let author = "Max Mustermann"
#let version = "1.0"
#let title = "Titel der Thesis"
#let subtitle = "Hier steht ein Untertitel"
#let typeOfWork = "Art der Arbeit (Semesterarbeit / Bachelorthesis / etc.)"
#let courseOfStudy = "BSc Informatik"
#let supervisor = "Super Max"
#let client = "Ferdinat Käufer"
#let expert = "Max Maxpert"
#let departement = "Technik und Informatik"

#let abbreviations = (
  "e.g.": "Exempli gratia",
  "TA": "Test abbreviation",
)

#let glossary = (
  "Developer": "Fachkraft, die ein Computerprogramm entwickelt.",
  "Long explanation": lorem(50),
  "Long term (Lorem ipsum dolor sit amet)": lorem(10),
)

#show: thesis.with(
  author: author,
  version: version,
  title: title,
  subtitle: subtitle,
  typeOfWork: typeOfWork,
  courseOfStudy: courseOfStudy,
  supervisor: supervisor,
  client: client,
  expert: expert,
  departement: departement,
  coverImage: image("assets/img/cover.png", width: 100%),
  signatureImage: image("assets/img/signature.png"),
  datePlaceImage: image("assets/img/place-date.png"),
  abstract: [
    = Managment Summery
    #lorem(150)
  ],
  abbreviations: abbreviations,
  glossary: glossary,
  bibliography: bibliography("assets/works.yaml", title: "Literatur- und Quellenverzeichnis", style: "ieee"),
  appendice: [
    = Anhang
    #lorem(250)
  ],
)

// --- Your content goes here ---
= Einleitung
#lorem(90) @snippets-theme
#figure(
  image("assets/img/cover.png"),
  caption: "Generated Example Image"
)

== Motivation
#lorem(140)

== Problem
#lorem(50)

#figure(
  table(
    columns: (auto, auto),
    inset: 10pt,
    align: horizon,
    table.header(
      [*Volume*], [*Parameters*],
    ),
    $ pi h (D^2 - d^2) / 4 $,
    [
      $h$: height \
      $D$: outer radius \
      $d$: inner radius
    ],
    $ sqrt(2) / 12 a^3 $,
    [$a$: edge length]
  ),
  caption: "Example Table"
)