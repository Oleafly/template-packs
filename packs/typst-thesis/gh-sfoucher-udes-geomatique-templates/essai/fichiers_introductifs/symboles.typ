#import "../styles.typ": *

// --- Liste des symboles ---
#chapitre-nn[Liste des symboles]

#text(fill: eclipsepurple)[*Le texte en violet est fourni à titre informatif et doit être retiré de la version finale du document.* Le fichier `symboles.typ` contient trois sections : la liste des symboles, la liste des formules chimiques et la liste des unités de mesure. Vous pouvez ajuster, reformater ou supprimer chacune de ces sections selon vos besoins.]

#{
  show table: set text(size: 12pt)
  table(
    columns: (1.5cm, 1fr),
    stroke: none,
    inset: (x: 2pt, y: 4pt),
    $sigma$, [Écart-type de la population],
    $overline(x)$, [Moyenne pour une population],
    $R^2$, [Coefficient de détermination],
    $I$, [Indice d'autocorrélation spatiale de Moran],
    $kappa$, [Indice de concordance kappa],
  )
}

// --- Liste des formules chimiques ---
#chapitre-nn[Liste des formules chimiques]
#{
  show table: set text(size: 12pt)
  table(
  columns: (1.5cm, 1fr),
  stroke: none,
  inset: (x: 2pt, y: 4pt),
  [NO#sub[2]], [Dioxyde d'azote],
  [O#sub[3]], [Ozone],
  [CO], [Monoxyde de carbone],
  )
}
// --- Liste des unités de mesure ---
/*
#chapitre-nn[Liste des unités de mesure]
#{
  show table: set text(size: 12pt)
  table(
    columns: (1.5cm, 1fr),
    stroke: none,
    inset: (x: 2pt, y: 4pt),
    [°C], [Degré Celsius],
    [dB], [Décibel],
    [µg/m#super[3]], [Microgramme par mètre cube],
    [ha], [Hectare],
    [km], [Kilomètre],
    [km#super[2]], [Kilomètre carré],
    [m], [Mètre],
    [m/s], [Mètre par seconde],
    [mol/L], [Mole par litre],
    [Pa], [Pascal],
    [ppm], [Partie par million],
  )
}
*/

