#import "../template.typ": *

#show heading: none
#heading(level: 1, numbering: none)[Abstract]
#v(-8pt)

#align(center)[#sc("E.T.S. de Ingeniería de Telecomunicación, Universidad de Málaga")]

#v(39pt)
#text(
  size: 14.4pt, 
  tracking: 0pt
)[
  #set par(leading: 0.7em)
  #set align(center)
  #strong[#sc(titlenameENG)]
]

#v(44pt)
#block(width: 100%, inset: (left: 17.5pt))[
  #set par(first-line-indent: 0pt, spacing: 0pt)
  *Author:* #author
  #v(12pt)
  *Supervisor:* #tutor
  #v(12pt)
  *Co-supervisor:* 
  #v(12pt)
  *Department:* \<DEPARTAMENTO>
  #v(12pt) 
  *Degree:* Master's Degree in \<TITULACIÓN>
  #v(12pt) 
  *Keywords:* 
]
#v(46pt)
#align(center)[*Abstract*]
#v(9pt)

#lorem(30)

#chapterend()
