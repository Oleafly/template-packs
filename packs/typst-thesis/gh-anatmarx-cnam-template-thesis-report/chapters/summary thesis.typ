// 4ème de couverture
#set page(
  header: none,
  footer: none
) // Désactivation numérotation et partie supérieure
#set par(first-line-indent: 0em) // Désactivation des alinéas



#context(document.title). #h(0.5em)Mémoire d’ingénieur·e Cnam, Ville, année.

#grid(
rows:(1fr,1fr),
[
  #align(center+horizon)[
    #upper()[*résumé*]
  ]
  Ce mémoire présente le projet #lorem(50)
  
  _Mots-clés : premier mot-clé, second mot-clé... _
],
[
    #align(center)[
    #line(length:80%)
    #upper()[*summary*]
  ]
This thesis presents #lorem(50)

  _Keywords: first keyword, second keyword..._
]
)