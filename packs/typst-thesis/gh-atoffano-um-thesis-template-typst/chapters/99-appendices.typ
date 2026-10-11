// chapters/99-appendices.typ


= Annexes
// chapters/99-annexes.typ

// Configuration pour les annexes
#counter(heading).update(0)
#set heading(numbering: "A.1.") // Format de numérotation, changer si besoin

= Introduction

== Une figure annexe
#figure(
  image("../assets/global/logo_um.png", width: 60%),
  caption: [#lorem(10)]
) <fig:annexe-logo>

#v(1cm)

== Une autre annexe
#lorem(40)
#table(
  
)