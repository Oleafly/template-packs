#import "../cleanthesis.typ": *

= Évaluation expérimentale <ch:evaluation>

Ce chapitre mesure les deux mécanismes du chapitre @ch:design. Il montre trois
styles de tableau : cellules fusionnées, lignes teintées, et matrice de
critères à en-têtes pivotés.

== Dispositif <sec:eval:setup>

Les mesures utilisent deux machines, décrites tableau @tab:machines. Les charges
sont générées avec les outils de @perf-tools, les machines virtuelles par
@qemu-docs. #lorem(45)

#figure(
  table(
    columns: (auto, auto, auto, auto, auto, 1fr),
    stroke: none,
    align: (left + horizon, center + horizon, center + horizon, center + horizon,
            left + horizon, left + horizon),
    inset: (x: 6pt, y: 4.5pt),
    table.hline(),
    table.header(
      table.cell(rowspan: 2, align: bottom + left)[*Machine*],
      table.cell(colspan: 3, align: center)[*Matériel*],
      table.cell(rowspan: 2, align: bottom + left)[*Rôle*],
      table.cell(rowspan: 2, align: bottom + left)[*Noyau*],
      table.hline(start: 1, end: 4, stroke: 0.4pt),
      [*Cœurs*], [*Mémoire*], [*Nœuds*],
    ),
    table.hline(stroke: 0.5pt),
    table.cell(rowspan: 2)[A], table.cell(rowspan: 2)[64],
    table.cell(rowspan: 2)[256 Gio], table.cell(rowspan: 2)[2],
    [charge], [Linux 6.9, _defconfig_],
    [mesure], [Linux 6.9, #gls("ebpf") activé],
    table.cell(rowspan: 2)[B], table.cell(rowspan: 2)[16],
    table.cell(rowspan: 2)[64 Gio], table.cell(rowspan: 2)[2],
    [charge], [Linux 6.9, _defconfig_],
    [témoin], [Linux 6.1 LTS, non modifié],
    table.hline(),
  ),
  caption: [Machines utilisées. Les deux sont bi-socket, donc #gls("numa").],
) <tab:machines>

Chaque machine exécute les trois allocateurs, sous trois politiques et sept
tailles d'objet. Le tableau @tab:params récapitule ce plan d'expérience ; il est
tracé en grille, avec filets verticaux, plutôt qu'en style _booktabs_.

#figure(
  table(
    columns: (1fr, auto, 2.1fr),
    stroke: 0.5pt + colors.black,
    align: center + horizon,
    inset: (x: 6pt, y: 5pt),
    table.header([*Allocateur*], [*Politique*], [*Tailles d'objet (octets)*]),
    table.cell(rowspan: 3)[Par classes\ (#gls("slab"))],
    [LIFO], table.cell(rowspan: 3)[16 / 32 / 64 / 128 / 256 / 512 / 1024],
    [FIFO],
    [#glsshort("lru")],
    table.cell(rowspan: 3)[Par binômes],
    [LIFO], table.cell(rowspan: 3)[16 / 32 / 64 / 128 / 256 / 512 / 1024],
    [FIFO],
    [#glsshort("lru")],
    table.cell(rowspan: 3)[Hybride\ (#gls("ebpf"))],
    [LIFO], table.cell(rowspan: 3)[16 / 32 / 64 / 128 / 256 / 512 / 1024],
    [FIFO],
    [#glsshort("lru")],
  ),
  caption: [Plan d'expérience : trois allocateurs × trois politiques × sept tailles.],
) <tab:params>

== Débit <sec:eval:throughput>

#figure(
  placement: auto,
  image("../figures/throughput.svg", width: 100%),
  caption: [Débit soutenu, en milliers d'opérations par seconde.],
) <fig:throughput>

La figure @fig:throughput donne le débit des quatre variantes. Le gain se lit
d'abord sur le cache, puis sur le traitement par lots ; les deux se composent.
#lorem(40)

== Latence <sec:eval:latency>

#figure(
  placement: auto,
  image("../figures/latency.svg", width: 100%),
  caption: [Latence en fonction de la charge, pour deux configurations.],
) <fig:latency>

La série _A_ de la figure @fig:latency reste sous le seuil visé jusqu'à la
saturation ; la série _B_ décroche plus tôt.

Le tableau @tab:results reprend ces chiffres. L'écart à la référence est coloré :
vert pour un gain, rouge pour une régression. La meilleure valeur de chaque
colonne est en gras.

#let good = rgb("#1FAA00")
#let bad  = rgb("#9B0000")
#let delta(v) = text(fill: if v.starts-with("−") { bad } else { good }, weight: "medium", v)
#let best(v) = strong(v)

#figure(
  table(
    columns: (1fr, auto, auto, auto, auto),
    stroke: none,
    align: (left, right, right, right, right),
    inset: (x: 7pt, y: 4.5pt),
    table.hline(),
    table.header([*Variante*], [*Débit*], [*Δ débit*], [*p50*], [*p99*]),
    table.hline(stroke: 0.5pt),
    [référence],      [118], text(fill: colors.gray)[—], [42 µs], [310 µs],
    [cache seul],     [164], delta("+39 %"),  [38 µs], [240 µs],
    [lots seuls],     [203], delta("+72 %"),  [36 µs], [180 µs],
    [cache et lots],  best[241], delta("+104 %"), best[31 µs], best[120 µs],
    [politique naïve], [96], delta("−19 %"),  [55 µs], [410 µs],
    table.hline(),
  ),
  caption: [Débit (kops/s) et latences par variante, écart relatif à la référence.],
) <tab:results>

== Comparaison aux travaux existants <sec:eval:compare>

Le tableau @tab:criteria compare notre approche aux systèmes de l'état de
l'art sur cinq critères. Les en-têtes sont pivotés pour tenir en largeur.

#let crit-good = rgb("#1FAA00")
#let crit-part = rgb("#E8A200")
#let crit-bad  = rgb("#9B0000")

#let yes = box(baseline: 10%, height: 8pt, width: 9pt, {
  place(line(start: (0.4pt, 4.2pt), end: (3.2pt, 7pt), stroke: 1.6pt + crit-good))
  place(line(start: (3.2pt, 7pt), end: (8.6pt, 0.6pt), stroke: 1.6pt + crit-good))
})
#let mid = text(fill: crit-part, weight: "bold", size: 1.25em, "~")
#let no  = text(fill: crit-bad, weight: "bold", size: 1.2em, "\u{00D7}")

#let crit(name) = table.cell(align: bottom + center,
  rotate(-90deg, reflow: true, box(text(size: 9.5pt, name))))

#figure(
  table(
    columns: (1fr,) + (auto,) * 5,
    stroke: none,
    align: (left + horizon,) + (center + horizon,) * 5,
    inset: (x: 5pt, y: 4pt),
    table.hline(stroke: 0.7pt),
    table.header(
      table.cell(align: bottom + left)[*Système*],
      crit[Isolation], crit[Compatibilité], crit[Transparence],
      crit[Efficacité], crit[Reconfigurable],
    ),
    table.hline(stroke: 0.4pt),
    [Noyau monolithique @ritchie1974unix],   yes, yes, yes, mid, no,
    [Exokernel @engler1995exokernel],        mid, no,  no,  yes, yes,
    [Multikernel @baumann2009multikernel],   yes, no,  no,  yes, mid,
    [Plan de données @belay2014ix],          mid, no,  no,  yes, no,
    [Virtualisation @barham2003xen],         yes, yes, mid, mid, no,
    [Cette thèse],                           yes, yes, yes, yes, yes,
    table.hline(stroke: 0.7pt),
  ),
  caption: [Respect des cinq critères, par système. #yes satisfait, #mid partiel,
    #no non satisfait.],
) <tab:criteria>

== Synthèse <sec:eval:synthese>

#lorem(70)
