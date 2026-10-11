= Chapitre d'exemple <ch:example>

#import "../templates/prelude.typ": *

Ce chapitre illustre les principales fonctionnalités du modèle de thèse
bilingue avec export HTML. Il contient un théorème, une preuve, une figure,
une note de bas de page et une équation.

#theoreme("Exemple")[
  Soit $n in NN$ un entier naturel. Alors $n^2 >= 0$.
] <thm:example>

#demo[
  La preuve découle directement du fait que le carré de tout nombre réel
  est positif ou nul, et que $NN subset RR$.
]

On peut aussi écrire des équations en mode bloc#footnote[Les équations sont
numérotées automatiquement.] :

$ sum_(k=0)^n k = n(n+1) / 2 $ <eq:gauss>

#figure(
  rect(width: 6cm, height: 3cm, stroke: 0.5pt, fill: luma(240))[
    #align(center + horizon)[_Placeholder pour une figure_]
  ],
  caption: [Une figure d'exemple.],
) <fig:example>

Comme le montre la @fig:example, on peut référencer les figures, théorèmes
(@thm:example) et équations (@eq:gauss) de manière standard.
