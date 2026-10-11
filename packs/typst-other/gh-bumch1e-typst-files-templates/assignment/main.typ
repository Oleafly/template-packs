#import "config.typ": *

/// setup
#set text(
  font: "New Computer Modern",
  lang: "es")
#set par(justify: true)
#set heading(numbering: none)

#coverpage()

#set page(
  margin: (top: 60pt, bottom: 20pt),
  header: [
    #set text(8pt)
    #smallcaps[#author#h(1fr)#subject_name#linebreak()#role#h(1fr)#subject_acronym]
    #line(length: 100%, stroke: (thickness: 0.1pt))
  ]
)

#pagebreak()

= Contenido

#lorem(19)
