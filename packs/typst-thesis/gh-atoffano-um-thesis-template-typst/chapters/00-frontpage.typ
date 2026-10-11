// chapters/00-frontpage.typ
#import "../metadata.typ": *

#v(1cm) 

#align(center)[
  #text(size: 18pt, font: "New Computer Modern Sans", rgb("#fe666a"), weight:"bold"
)[THÈSE POUR OBTENIR LE GRADE DE DOCTEUR\ DE L’UNIVERSITÉ DE MONTPELLIER]
  
  #v(0.5em)
  #text(weight: "bold")[#degree_field]
  
  #v(0.5em)
  École doctorale #doctoral_school \
  Unité de recherche #research_unit
  
  #v(2cm)
  
  #text(size: 17pt, weight: "bold", fill: rgb("#7798a7"))[#thesis_title]
  
  #v(2cm)
  
  Présentée par \
  #text(size: 15pt, weight: "bold")[#author_name]
  
  #v(0.5em)
  #text(size: 15pt)[Le #defense_date] 
  
  #text(size: 13pt)[Sous la direction de #supervisor \
  et #co_supervisor] 
]

#v(1fr) 

#text(weight: "bold")[Devant le jury composé de :]
#v(0.5em)

// Tableau du jury
#set text(size: 10pt)
#table(
  columns: (1fr, auto), 
  stroke: none,
  inset: (y: 4pt),
  
  [#strong[M. Prénom NOM], Titre, Établissement], 
  [Rapporteur],
  
  [#strong[Mme Prénom NOM], Titre, Établissement], 
  [Rapporteur],
  
  [#strong[M. Prénom NOM], Titre, Établissement], 
  [Examinateur],
  
  [#strong[Mme Prénom NOM], Titre, Établissement], 
  [Directeur de thèse],
  
  [#strong[Mme Prénom NOM], Titre, Établissement], 
  [Directeur de thèse],

  [#strong[M. Prénom NOM], Titre, Établissement], 
  [Invité],
)

#v(1cm)

#align(center)[
  #image("../assets/global/logo_um.png", width: 7.05cm, height: 2.22cm)
]