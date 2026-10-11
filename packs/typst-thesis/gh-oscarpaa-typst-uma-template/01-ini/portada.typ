#import "../template.typ": *

#set align(center)

#text(size: 16pt)[#sc("Universidad de Málaga")]
#v(8pt)
#block(width: 100%)[
  #set par(leading: 0.7em) 
  #text(size: 16pt)[#sc("Escuela Técnica Superior de") \ #sc("Ingeniería de Telecomunicación")]
]

#v(100pt)

#text(size: 16pt)[TRABAJO FIN DE MÁSTER]

#v(77pt)

// --- TÍTULO ---
#block(width: 80%)[
  #set par(leading: 0.8em)
  #text(size: 24pt)[
    #sc(titlename)
  ]
]

#v(85pt)

// --- TITULACIÓN ---
#block(width: 60%)[
  #set par(leading: 0.7em)
  #text(size: 16pt)[
    #sc("Máster en " + titulacion)
  ]
]

#v(75pt) 

// --- AUTOR Y FECHA (Alineado a la derecha) ---
#align(right)[
  #set text(size: 14pt)
  #sc(author) \
  #sc("Málaga, " + anno)
]

#chapterend()
