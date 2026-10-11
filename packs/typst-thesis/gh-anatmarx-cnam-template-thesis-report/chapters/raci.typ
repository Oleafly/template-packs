// Exemple de matrice RACI

#set table(
  stroke: 1pt,
  gutter: 0.2em,
  fill: (x, y) => if (x == 0 and y!=4) or y == 5 { gray },
  inset:0.5em,
)

#let R = table.cell(
  fill: green.lighten(20%),
)[R]
#let A = table.cell(
  fill: red.lighten(20%),
)[A]
#let C = table.cell(
  fill: blue.lighten(20%),
)[C]
#let I = table.cell(
  fill: yellow.lighten(20%),
)[I]

#show table.cell: it => {
  if (it.x == 0 and it.y>4) or it.y == 5 {
    set text(white)
    strong(it)
  } else {
    it
  }
}

// Abréviations : 
// R = Réalisateur (en charge de faire)
// A = Approbateur (valide et prend les décisions)
// C = Consultant (consulté pour son expertise)
// I = Informé (tenu informé)

#figure(
  table(
  columns: (2.4fr,..(1fr,)*5),align:horizon+center,
  
  R, table.cell(colspan:2)[Réalisateur],table.cell(colspan:3,stroke:none)[],
  A, table.cell(colspan:2)[Approbateur],table.cell(colspan:3,stroke:none)[],
  C, table.cell(colspan:2)[Consultant],table.cell(colspan:3,stroke:none)[],
  I, table.cell(colspan:2)[Informé],table.cell(colspan:3,stroke:none)[],
  
  table.cell(colspan:6,stroke:none)[],
  [Tâche], [Moi], [Tuteur], [A], [B], [C],

  [Tâche 1], I, R, I, C, I,
  [Tâche 2], R, A, I, I, I,
  [Tâche 3], R, A, I, I, I,

), caption:[Exemple de matrice RACI])<raci>