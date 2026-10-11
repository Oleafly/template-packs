#import "../cleanthesis.typ": *

#abstract("Résumé")[
Les noyaux modernes doivent faire deux choses à la fois : isoler les charges de
travail les unes des autres, et ne pas leur faire obstacle. Ce résumé est un
texte de remplissage. Il est assez long pour montrer le rendu de la page, et
assez court pour tenir sur une seule.

La première contribution porte sur l'ordonnancement. Nous mesurons le
comportement du #glsshort("cfs") lorsque la machine est sur-souscrite, et
montrons où ses heuristiques d'équilibrage perdent la propriété de conservation
du travail sur une architecture #glsshort("numa").

La seconde contribution est un chemin d'allocation mémoire fondé sur
#glsshort("ebpf"), qui permet de changer de politique sans recompiler le noyau.
Sur nos tests, il égale l'allocateur intégré à faible charge et améliore la
latence de queue sous pression.

#v(4mm)
*Mots-clés :*
systèmes d'exploitation, noyau, ordonnancement, gestion mémoire, eBPF, NUMA
]
