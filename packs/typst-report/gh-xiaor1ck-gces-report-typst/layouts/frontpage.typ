#let front-page(
  document-type: "Report",
  project-type: "Major",
  title: none,
  students : (),
  logo: none,
  date: none,
  supervisor: none
) = {
  set text(
    size: 14pt
  )
    align(center
  )[A #project-type Project #document-type on
  #v(0.5em)
  #text(size: 16pt)[*#title*]
  #v(0.5em)
  Submitted in partial fulfillment of the requirements for the degree of \ 
  Bachelor of Engineering in Computer Engineering at Pokhara University \
  #v(0.5em)
  _*By*_ \
  #for people in students [
    *#upper(people)* \
  ]
  #v(2em)
  *_Supervisor_* \
  *#upper(supervisor)*
  
  #v(3em)
  #logo
  #v(3em)
  *Department Of Research And Development* \
  *Gandaki College Of Engineering And Science*\
  Lamachaur, Pokhara, Kaski\
  (*#date.display("[month repr:short], [year]")*)
  #pagebreak()
]
}
