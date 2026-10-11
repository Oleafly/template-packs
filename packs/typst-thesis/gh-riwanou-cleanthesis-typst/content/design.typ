#import "../cleanthesis.typ": *

= Conception <ch:design>

Ce chapitre décrit les deux mécanismes proposés. Il montre au passage les
sous-figures en colonne, les figures larges et le placement flottant.

== Principe <sec:design:principe>

L'idée tient en une phrase : déplacer la politique hors du noyau, garder le
mécanisme dedans. C'est la séparation défendue par @engler1995exokernel, appliquée
ici à l'allocation mémoire plutôt qu'au matériel. #lorem(55)

#paragraph[Mécanisme][
Le noyau conserve la propriété des pages et l'invariant d'isolation. Rien de ce
qui suit ne peut le violer, puisque le vérificateur #gls("ebpf") rejette tout
programme dont la terminaison n'est pas prouvée @corbet2019bpf @bpf-docs.
]

#paragraph[Politique][
Le choix de la liste, de l'ordre et du seuil de récupération est délégué à un
programme chargé à l'exécution. Le changer ne demande pas de recompilation.
]

== Allocation <sec:design:alloc>

La figure @fig:alloc empile trois stratégies, une par ligne, pour que les axes
se comparent verticalement. La sous-figure #subref(<fig:alloc>, "a") montre
l'allocateur par classes @bonwick1994slab ; #subref(<fig:alloc>, "b"),
l'allocateur par binômes ; #subref(<fig:alloc>, "c"), l'hybride proposé.

#subfigures(
  placement: auto,
  caption: [Occupation mémoire des trois allocateurs, à charge identique.],
  columns: 1,
  (image("../figures/memory-slab.svg", width: 85%), [Par classes (#gls("slab"))]),
  (image("../figures/memory-buddy.svg", width: 85%), [Par binômes]),
  (image("../figures/memory-hybrid.svg", width: 85%), [Hybride, politique en #gls("ebpf")]),
) <fig:alloc>

Le comportement diffère surtout en queue de distribution, ce que le
chapitre @ch:evaluation quantifie. #lorem(60)

== Ordonnancement <sec:design:sched>

La figure @fig:timeline montre deux cœurs sur une fenêtre de 50 ms. La tâche
_A_ est préemptée deux fois ; la tâche _C_ migre de CPU 1 vers CPU 0.

#figure(
  placement: auto,
  wide(image("../figures/scheduler-timeline.svg", width: 90%), width: 95%),
  caption: [Trace d'ordonnancement sur deux cœurs. Chaque bloc est un quantum.],
) <fig:timeline>

La migration visible au milieu de la trace est le cas que @lozi2016linux décrit
comme une perte de conservation du travail ; @lwn-scheduler en donne une
lecture plus récente. #lorem(45)

== Conclusion <sec:design:ccl>

Les deux mécanismes partagent la même structure : un point d'attache dans le
noyau, une politique remplaçable. Reste à les mesurer.
