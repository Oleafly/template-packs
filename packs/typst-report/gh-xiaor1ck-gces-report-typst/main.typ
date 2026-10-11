
#import "lib.typ": generate-report, set-style

#show: doc => set-style(doc)

#let refs = bibliography("refs.bib")
#show: generate-report.with(
  info : (front-matter:(
  "Abstract.typ",
  "ack.typ"
),
bib: refs)
)

//#set page(numbering: "1")
= CHAPTER 1 \ INTRODUCTION
== SubHeading 1
#lorem(100)
=== SubSub Heading
This is a referencr test. @Yoder_2014
#pagebreak()

= CHAPTER 2 \ METHODOLOGY
#lorem(20)

#lorem(20)

== Figure Check
#figure(
  caption: "Gces Logo",
  image("assets/gces-logo.png", height: 10%),
)

#figure(
  table[][A & B \\ 1 & 2],
  caption: "Example table",
  
)
#figure(
  table[][A & B \\ 1 & 2],
  caption: "Example table",
  
)

== Another Heading
#link("https://typst.app/docs/guides/tables/")[click here] for detailed guide on tables.
#figure(
  table(
  columns: (auto, auto, 1fr),
  table.header[*Date*][*°No*][*Description*],
  [24/01/03], [813], [Filtered participant pool],
  [24/01/03], [477], [Transitioned to sec. regimen],
  [24/01/11], [051], [Cycled treatment substrate],
),
  caption: "A more detailed table",
  
)
