#set page(margin: (top: 2.5cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm))
#set enum(indent: 1.2em)

// Fill in your details here
#let author = "(Author)"
#let matriculationNumber = "(Matriculation Number)"
#let semester = "(Semester)"


#align(center)[
  = Final Report – Interactive Learning Practical Course
  *Artemis Issue Review & PR Testing*
]

#v(1em)

== Student Information

#grid(
  columns: (1fr, 2fr),
  gutter: 8pt,
  [*Student Name:*], [#author],
  [*Matriculation Number:*], [#matriculationNumber],
  [*Semester:*], [#semester],
)

#v(1.2em)

== 1. Created Issues

List all issues you have created during the semester.

+ \#12345: #link("https://github.com/ls1intum/Artemis/issues/12345")[Issue Title]
+ _Add more issues in the format above as needed._


#v(1.2em)

== 2. Reviewed / Tested Pull Requests

List all pull requests you have reviewed and/or tested.

+ \#12345: #link("https://github.com/ls1intum/Artemis/pull/12345")[PR Title]
+ _Add more pull requests in the format above as needed._

== 3. Reviewed Issues

List all issues you have reviewed during the semester.

+ \#12345: #link("https://github.com/ls1intum/Artemis/issues/12345")[Issue Title]
+ _Add more issues in the format above as needed._