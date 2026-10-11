#import "conf.typ": conf
#show: conf.with(
  title: "Your title",
  program: "Name of your program",
  name: "Your name",
  student_number: "123456",
  supervisor: "Name of your supervisor",
  second_assessor: "Name of your second assessor",
)

// Chapters
#set heading(numbering: "1.1")
#set par(justify: true)

#pagebreak()
#include "chapters/introduction.typ"

#pagebreak()
#include "chapters/data.typ"

#pagebreak()
#include "chapters/methodology.typ"

#pagebreak()
#bibliography("bibliography.bib", title: "References")

// Appendix
#pagebreak()
#counter(heading).update(0)
#set heading(level:1, numbering: "A")
== Programming code
