#import "template.typ": *

#show: project.with(
  course: "Kursnamn: Beskrivning", // Går ofta att hitta på kurssidan
  title: "Titel",

  authors: (
    (name: "Förnamn Efternamn", email: "liuid123@student.liu.se"),
  ),

  table_of_contents: true,

  term: "Höstterminen 2020",
  version: "1.0",
  date: "2020-01-01",
)



= Revisionshistorik
#table(
  columns: (5.5em, 1fr, 5.5em),
  inset: 4pt,
  stroke: 0.5pt,
  [*Version*], [*Revisionsbeskrivning*], [*Datum*],
  [1.0], [Första utkast], [2020-01-01],
)

= Introduktion
#lorem(50)

= Exempel
#lorem(50)
