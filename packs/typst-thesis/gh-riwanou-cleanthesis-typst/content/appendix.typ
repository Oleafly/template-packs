#import "../cleanthesis.typ": *

= Détails d'implémentation <ch:annexe>

Cette annexe existe pour montrer que la numérotation bascule en lettres après
#raw("#appendix()").

== Paramètres de compilation <sec:ann:flags>

#listing(caption: [Options de compilation du noyau utilisées pour les mesures.])[
```sh
make defconfig
scripts/config --enable CONFIG_BPF_SYSCALL
scripts/config --enable CONFIG_NUMA_BALANCING
scripts/config --set-val CONFIG_HZ 1000
make -j"$(nproc)"
```
]

== Table des symboles <sec:ann:symbols>

#figure(
  table(
    columns: (auto, 1fr),
    stroke: none,
    table.hline(),
    table.header([*Symbole*], [*Signification*]),
    table.hline(stroke: 0.5pt),
    [$n$], [nombre de cœurs actifs],
    [$lambda$], [taux d'arrivée des requêtes],
    [$mu$], [taux de service par cœur],
    table.hline(),
  ),
  caption: [Symboles utilisés dans les modèles.],
) <tab:symbols>
