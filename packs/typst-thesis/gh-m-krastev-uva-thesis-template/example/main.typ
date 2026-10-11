// #import "@preview/uva-thesis:0.0.1": *
#import "../template/main.typ": *

#show: uva-thesis

#show: uva-titlepage.with(
  title: "The Answer to Life, the Universe, and Everything",
  author: "John Q. Public",
  student-number: "12345678",
  supervisors: ("John Smith",),
  examiner: "Jane Doe",
  second-reader: "John Doe",
  degree: "MSc Artificial Intelligence",
  credits: "42 EC",
  // date: datetime(day: 1, month: 1, year: 1971),
  date: datetime.today(),
  period: "Period in which the research was carried out"
)

#uva-abstract[  
  #lorem(150)
]

#outline()

#uva-chapter("Introduction")

#lorem(50)

== Background <background>

#lorem(50)

== Literature

We use standard results from @BRV2001:Modal. Also relevant for our work is
@BB1999:IPGames, where it was proven that Logic is great.

#lorem(50)

== Criticism

#lorem(50)

#uva-chapter("My Logic")

#lorem(50)

== Syntax

#definition[
  We defined the language $cal(L)$ as follows:

  $ phi.alt ::= top | p | phi.alt and phi.alt $
]

#lorem(50)

== Semantics

== Axioms

== Soundness

== Completeness

#uva-chapter("Examples")

== Figures

We illustrate the protagonist of this thesis. in @protagonist.

#figure(caption: "The protagonist.", numbering: "1.1")[
  #emoji.person
]<protagonist>

== Tables

In @cities we compare some cities.

#figure(caption: "An overview of cities.")[
  #table(
    columns: 3,
    stroke: (x, y) => if x == 0 { (right: black) },
    table.hline(),
    table.header([City],[Population],[area ($"km"^2$)]),
    table.hline(),
    [Amsterdam],[851573],[219],
    [Groningen],[200952],[ 83],
    [Utrecht  ],[321989],[100],
    table.hline()
  )
]<cities>

#uva-chapter("Conclusions")

As we discussed in @background, Logic is great.

#lorem(50)

#pagebreak()
#bibliography("references.bib")
