#set document(
  title: "Typst Template Example",
  author: ("Annhilati"),
  date: datetime(day: 11, month: 04, year: 2026)
)
#set heading(numbering: "1.")
#set figure(supplement: [Figur])
#set text(font: "New Computer Modern", lang: "de")
#set page(numbering: "1")


#align(center)[
  #text(28pt, weight: "bold")[#context document.title]
  #v(0em)
  #text(14pt)[#context document.author.join(", ")]
  #v(1em)
  #text(10pt)[#context document.date.display("[day]. [month repr:long] [year]")]
  #v(3em)
]

#heading(level: 1, numbering: none)[Abstract]

#outline()

#pagebreak()

#include "chapters/examples.typ"

#bibliography("references.yaml", style: "angewandte-chemie")