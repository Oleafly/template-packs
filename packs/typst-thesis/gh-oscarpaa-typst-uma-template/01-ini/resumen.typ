#import "../template.typ": *

#show heading: none
#heading(level: 1, numbering: none)[Resumen]
#v(-8pt)

#align(center)[#sc("E.T.S. de Ingeniería de Telecomunicación, Universidad de Málaga")]

#v(39pt)
#text(
  size: 14.4pt, 
  tracking: 0pt
)[
  #set par(leading: 0.7em)
  #set align(center)
  #strong[#sc(titlename)]
]

#v(44pt)
#block(width: 100%, inset: (left: 17.5pt))[
  #set par(first-line-indent: 0pt, spacing: 0pt)
  *Autor:* #author
  #v(12pt)
  *Tutor:* #tutor
  #v(12pt)
  *Cotutor:* 
  #v(12pt)
  *Departamento:* \<DEPARTAMENTO>
  #v(12pt) 
  *Titulación:* Máster en #titulacion
  #v(12pt) 
  *Palabras clave:* 
]
#v(46pt)
#align(center)[*Resumen*]
#v(9pt)

#lorem(30)

#chapterend()
