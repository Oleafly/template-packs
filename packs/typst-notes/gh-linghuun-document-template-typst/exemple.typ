#import "doc_template.typ": *

#show: doc.with(
  title: "Homework 1",
  subtitle: lorem(3),
  name: "Linghuun",
  date: "1er janvier 1970")

= First Part

#def(
  title: "Ceci est un sous titre",
  lorem(25)
)

On peut aussi écrire normalement entre les blocs.

#prop(
  [
    Pas de sous-titre cette fois !

    - #lorem(10)

    #lorem(30)
  ]
)
== First subsection !

#def(
  lorem(3)
)

#ex(title: "This is an exemple",  numbered: true, [Cet exemple est numéroté 1.])
#ex([Celui ci n'est pas numéroté.])
#ex(numbered: true, [Le numérotage reprend là où il s'était arrêté.])

#rem(title: "Ceci est une Remarque", numbered: true, [Les objets sont numérotés indépendamment les uns des autres])

#algo(title: "Ceci est un algorithme",
name: "ExponentiationRapide",
params: ($a$, $n$),
  [
  + Ceci est du pseudocode qui fonctionne parfaitement !
    + #lorem(2)
  ]
)



