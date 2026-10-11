#import "../styles.typ": *

= Résultats <chap:resultats>

Introduction et annonce du plan du chapitre.
#lorem(90)

== Section 1 <sec:titre_section1>

Paragraphe.
#lorem(90)

== Section 2 <sec:titre_section2>

Paragraphe.
#lorem(160)

Les statistiques... (tableau @tab:cellules_fusionnees).

#figure(
  caption: [Tableau avec des cellules fusionnées],
  table(
    columns: 3,
    align: left,
    inset: (x: 8pt, y: 5pt),
    table.hline(),
    [*Type de variable*], [*Nom*], [*Abréviation*],
    table.hline(),
    [Dépendante], [Dioxyde d'azote (µg/m#super[3])], [NO#sub[2]],
    table.hline(),
    [Variable de contrôle], [Température (°C)], [Temp],
    [], [Humidité (%)], [Humid],
    [], [Vitesse du vent (km/h)], [Vitesse],
    table.hline(),
    [Variable explicative], [Nombre d'intersections (N)], [Inters],
    [], [Localisation géographique], [XY],
    [], [Vitesse (km/h)], [Vitesse],
    table.hline(),
  ),
) <tab:cellules_fusionnees>

#lorem(60) (figure @fig:plusieurs_vignettes).

#figure(
  image("../figures/figureavecplusieursvignettes.png", width: 80%),
  caption: flex-caption(
    [Figure avec plusieurs vignettes. *(a)* Description. *(b)* Description. *(c)* Description. (d) Description. Figure adaptée de #cite(<apparicio2021cycling>, form: "prose", supplement: [p.~2]).],
    [Figure avec plusieurs vignettes],
  ),
) <fig:plusieurs_vignettes>
