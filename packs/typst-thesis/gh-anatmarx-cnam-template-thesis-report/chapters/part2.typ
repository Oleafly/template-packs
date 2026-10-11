= -- 2ème grande partie<part2>
== Exemple de tableau
// #v(1.3em)

Voici un exemple de tableau :
#set table(
  stroke: 1pt,
  // gutter: 0.2em,
  fill: (x, y) =>
    if x == 0 or y == 0 { gray },
  inset: 0.5em,
)

#show table.cell: it => {
  if it.x == 0 or it.y == 0 {
    set text(white)
    strong(it)
  } else {
    it
  }
}


#figure(table(align:horizon,

  columns: 4,

  [Indicateur], [Catégorie], [Données], [Description],

  [A], [B], [C], [D],

  [E], [F], [G], [H],

  [I], [J], [K], [L],

  [M], [N], [O], [P],

  [Q], [R], [S], [T],

  [U], [V], [W], [X],

  [Y], [Z], [AA], [AB],

  [AC], [AD], [AE], [AF],

),caption: "Exemple de tableau possible") 



=== Autre exemple de tableau
Voici un autre exemple de tableau
#include "table_example_2.typ"

