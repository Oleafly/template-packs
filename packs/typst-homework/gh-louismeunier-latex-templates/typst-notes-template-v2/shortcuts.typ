// ! general
#let st = " s.t. "
#let implies = $arrow.r.double$
#let iff = $arrow.l.r.double$
#let vbar(height) = grid(columns: 1, rows: 1, 
  v(height)
  , grid.vline(x: 0, start: 0, end: 2))


// ! algebra
#let Hom = "Hom"
#let ip(x, y) = $lr(angle.l #x, #y angle.r)$

// ! analysis
#let borel = $frak(B)_RR$
#let card = $"card"$
#let RRR = $overline(RR)$

#let impliedby = $arrow.l.double$

#let dv(a, b) = $(dif #a)/(dif #b)$
#let pdv(a, b) = $(diff #a)/(diff #b)$

#let exists = $thin exists thin$
#let forall = $thin forall thin$
#let nothing = $diameter$
