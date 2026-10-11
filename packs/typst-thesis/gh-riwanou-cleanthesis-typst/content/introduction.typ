#import "../cleanthesis.typ": *

= Introduction <ch:intro>

Un #gls("os") a deux rôles difficiles à concilier : isoler les applications les
unes des autres, et leur laisser le matériel sous la main. Ce chapitre pose le
problème et annonce le plan. Tout le texte de ce squelette est du remplissage :
remplacez-le, gardez la structure.

== Contexte <sec:intro:contexte>

Depuis @ritchie1974unix, l'interface entre application et noyau a peu changé,
alors que le matériel a changé du tout au tout : plusieurs dizaines de cœurs,
mémoire #gls("numa"), cartes réseau capables de saturer un #gls("cpu") à elles
seules. Les architectures alternatives explorées par @engler1995exokernel et
@baumann2009multikernel partent toutes du même constat.

#paragraph[Le coût de l'abstraction][
Chaque couche traversée coûte des cycles. Les travaux sur les plans de données
en espace utilisateur @belay2014ix @peter2014arrakis montrent que l'essentiel du
coût n'est pas le calcul utile mais le chemin qui y mène.
]

#paragraph[Le coût du partage][
À l'inverse, retirer le noyau du chemin critique rend le partage plus difficile.
La règle de commutativité @clements2013scalable donne un critère pour savoir
quand une interface peut passer à l'échelle.
]

== Contributions <sec:intro:contributions>

Ce manuscrit contient deux contributions, une par partie.

La partie @part:fondations rassemble les éléments nécessaires : modèle
d'exécution, hiérarchie mémoire, et les outils de mesure utilisés partout
ensuite. La partie @part:contributions présente l'ordonnanceur et le chemin
d'allocation, puis les évalue.

== Organisation du manuscrit <sec:intro:plan>

Le chapitre @ch:background décrit l'architecture d'un noyau monolithique
moderne. Le chapitre @ch:design présente la conception. Le chapitre
@ch:evaluation en mesure les performances. Le chapitre @ch:conclusion conclut.
