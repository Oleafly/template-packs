#set table(
  stroke: 1pt,
  gutter: 0.2em,
  fill: (x, y) => if x == 0 or y == 0 { gray },
  inset:0.5em,
)

#show table.cell: it => {
  if it.x == 0 or it.y == 0 {
    set text(white)
    strong(it)
  } else {
    it
  }
}

#figure(

  table(

  columns: 6, align: horizon + center,

  [A], [B], [C], [D], [E], [F],

  [G], [H], [I], [J], [K], [L],

  [M], [N], [O], [P], [Q], [R],

  [S], [T], [U], [V], [W], [X],

  [Y], [Z], [AA], [AB], [AC], [AD],

  [AE], [AF], [AG], [AH], [AI], [AJ]

), caption:[Autre exemple])
