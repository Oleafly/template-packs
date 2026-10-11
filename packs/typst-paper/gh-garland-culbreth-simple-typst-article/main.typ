#import "report.typ": *
#show: report

#title[Report title]

#author(
  name: "Author One",
  position: "Position one",
  organization: "Affiliation one",
)
#author(
  name: "Author Two",
  position: "Position two",
  organization: "Affiliation two",
)

#abstract(heading: "Summary")[#lorem(100)]

= Heading level 1

#lorem(70) #cite(<strogatz2001exploring>).

#lorem(40) #cite(<newman2003structure>, form: "prose").

== Heading level 2

#lorem(70)

== Heading level 2

#lorem(70)

#figure(
    image("/images/placeholder.png", width: 100%),
    caption: [Example figure.],
) <fig:example>

#lorem(70)

= Heading level 1

#lorem(70)

#figure(
    table(
        columns: 3,
        table.header([Quantity], [20xx], [20xx]),
        [A], [120], [120],
        [B], [16], [16],
    ),
    caption: [Example table.],
)

#lorem(70)

== Heading level 2

#lorem(70)

== Heading level 2

#lorem(70)

= Heading level 1

#lorem(70)

#bibliography("references.yaml", style: "elsevier-harvard")
