// PAGE DE GARDE EFREI, OPTIONNEL

#import "vars.typ": *

#set list(marker: "-")
#set par(leading: 1em)

#let points(size: 1fr, char: " . ") = {box(width: size, repeat(char))}

#reportLogo

#align(center, [
  #text(weight: "bold", size: 2em, upper(reportTitle))
])

#v(0.5em)#text(size: 1.4em, weight: "bold")[Apprenti]

#grid(columns: (1fr, 1fr),[Nom: #strong(authorLastName)], [Prénom: #strong(smallcaps(authorFirstName))])

Parcours: *Logiciels et Systèmes d'Information (LSI)*

#v(0.5em)#text(size: 1.4em, weight: "bold")[Titre du mémoire]

#text(documentTitle, size: 1.15em)

#v(0.5em)#text(size: 1.4em, weight: "bold")[Entreprise]#v(0.2em)

Nom: $quad quad$ *[NOM]*

Adresse:$quad$ _[ADDRESSE]_

#v(1em)

#text(size: 1.4em, weight: "bold")[Soutenance]

Composition du jury
#pad(left: 3em, [
  - Tuteur enseignant : #academicTutor
  - Tuteur entreprise : #companyTutor
])

#v(1em) #text(size: 1.4em, weight: "bold")[Confidentialité du mémoire]

  - Mémoire confidentiel: #points() $quad$ OUI #h(0.5em) / #h(0.5em) *NON* $quad$
  - L'entreprise autorise la diffusion du mémoire  : 
    - En version numérique sur l’espace Moodle de l’école    : #points(char: " . ") $quad$ *OUI* #h(0.5em) /#h(0.5em) NON $quad$
    - En version papier : #points() $quad$ *OUI* #h(0.5em) /#h(0.5em)  NON $quad$


#v(1em)
#align(right, table([Cachet de l'entreprise / Signature du responsable : #v(5em)]))


#pagebreak()