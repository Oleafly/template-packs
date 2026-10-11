#import "../cleanthesis.typ": *

= Architecture d'un noyau monolithique <ch:background>

Ce chapitre décrit les sous-systèmes que les contributions viennent modifier. Il
sert aussi de démonstration : figure simple, figure large, grille de
sous-figures, schéma de paquet annoté, tableau et listing y sont tous utilisés.

== Vue d'ensemble <sec:bg:overview>

La figure @fig:layers donne la vue classique en couches. Une application
n'atteint le matériel qu'en traversant l'interface d'appels système, puis le
sous-système concerné. #lorem(60)

#figure(
  placement: auto,
  image("../figures/kernel-layers.svg", width: 90%),
  caption: [Couches traversées par une application, de l'espace utilisateur au
    matériel.],
) <fig:layers>

#lorem(70)

Le tableau @tab:subsystems résume les sous-systèmes et l'unité qu'ils partagent.

#figure(
  placement: auto,
  table(
    columns: (auto, auto, 1fr),
    stroke: none,
    align: (left, left, left),
    table.hline(),
    table.header([*Sous-système*], [*Unité*], [*Difficulté principale*]),
    table.hline(stroke: 0.5pt),
    [Ordonnanceur], [tâche], [équité sous sur-souscription],
    [Mémoire virtuelle], [page], [localité #gls("numa")],
    [#gls("vfs")], [inode], [cohérence du cache],
    [Réseau], [paquet], [coût par interruption],
    [Pilotes], [périphérique], [#gls("dma") et #gls("iommu")],
    table.hline(),
  ),
  caption: [Sous-systèmes du noyau et unité de partage.],
) <tab:subsystems>

=== Chemin d'un paquet <subsec:bg:packet>

Le trajet d'un paquet entrant est donné figure @fig:pipeline : la carte
#gls("nic") lève une #gls("irq"), le traitement est différé en _softirq_, puis
remis au socket. #lorem(45)

#figure(
  image("../figures/pipeline.svg", width: 90%),
  caption: [Chemin d'un paquet entrant, de la carte réseau à l'application.],
) <fig:pipeline>

=== Descripteurs d'anneau <subsec:bg:descriptor>

#let lbl = bf-label.with(size: 7.5pt)

La figure @fig:descriptor annote le descripteur avec des accolades de
regroupement et des notes latérales : les deux premiers mots forment l'en-tête
lu par le pilote, les deux suivants l'adresse et la longueur du tampon.

#figure(
  box(width: 100%, bytefield(
    bpr: 32,
    bitheader("bytes", text(size: 6pt)[0], text(size: 6pt)[8],
              text(size: 6pt)[16], text(size: 6pt)[24]),
    group(left, 2, [en-tête]),
    bits(8, lbl[TYPE]), bits(8, lbl[FLAGS]), bits(16, lbl[LONGUEUR]),
    bits(32, lbl[IDENTIFIANT]),
    note(right, [rempli par le pilote]),
    group(left, 2, [tampon]),
    bits(32, lbl[ADRESSE PHYSIQUE (bas)]),
    bits(32, lbl[ADRESSE PHYSIQUE (haut)]),
    note(right, [écrit par le #gls("dma")]),
    bits(16, lbl[CHECKSUM]), bits(16, fill: colors.gray-lighter, lbl[RÉSERVÉ]),
  )),
  caption: [Descripteur d'anneau de réception, avec ses deux groupes de champs.],
) <fig:descriptor>

=== Formats comparés <subsec:bg:formats>

La figure @fig:formats place trois formats côte à côte : les deux premiers,
plus courts, sont empilés à gauche ; le troisième occupe la colonne de droite.

#let short-a = bitfield(
  bf-header(..range(16)),
  bits(16)[Longueur], flag(lbl[V]), flag(lbl[R]), bits(14, lbl[TYPE]),
)
#let short-b = bitfield(
  bf-header(..range(16)),
  bits(8, lbl[CLASSE]), bits(8, lbl[CODE]), bits(16, lbl[SÉQUENCE]),
)
#let long-c = bitfield(
  bf-header(..range(16)),
  bits(16)[Identifiant],
  bits(16)[Longueur totale],
  bits(16)[Décalage],
  bits(8, lbl[TTL]), bits(8, lbl[PROTOCOLE]),
  bits(16)[Somme de contrôle],
)

#figure(
  placement: auto,
  grid(
    columns: (1fr, 1fr), align: (left + horizon, right + horizon),
    stack(
      spacing: 1.1em,
      subfig("a", short-a, [En-tête court, variante à drapeaux]),
      subfig("b", short-b, [En-tête court, variante à codes]),
    ),
    subfig("c", long-c, [En-tête complet, tel qu'il circule sur le lien]),
  ),
  caption: [Trois formats d'en-tête, alignés sur la même grille de 16 bits.],
) <fig:formats>

== Le chemin d'ordonnancement <sec:bg:sched>

Le #gls("cfs") maintient un arbre rouge-noir ordonné par temps d'exécution
virtuel @lozi2016linux. Le listing @lst:enqueue en donne la forme générale. La
documentation du noyau @kernel-docs décrit les points d'extension disponibles.

#listing(caption: [Insertion d'une tâche dans la file d'exécution.])[
```c
static void enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
{
        struct cfs_rq *cfs_rq;
        struct sched_entity *se = &p->se;

        for_each_sched_entity(se) {
                cfs_rq = cfs_rq_of(se);
                enqueue_entity(cfs_rq, se, flags);
                cfs_rq->h_nr_running++;
        }
        add_nr_running(rq, 1);
}
```
] <lst:enqueue>

Les verrous protégeant cette structure sont pris par cœur ; la lecture sans
verrou repose sur #gls("rcu") @mckenney2013rcu. #lorem(50)

== Conclusion <sec:bg:ccl>

Ces trois chemins — ordonnancement, allocation, réception — se partagent les
mêmes structures. La partie suivante s'y attaque.
