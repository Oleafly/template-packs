// components/macros.typ
// Common mathematical shortcuts and notation helpers modeled after Charlie's macros.tex and letterfonts.tex

// Blackboard bold number sets
#let RR = $bb(R)$
#let NN = $bb(N)$
#let ZZ = $bb(Z)$
#let QQ = $bb(Q)$
#let CC = $bb(C)$
#let FF = $bb(F)$
#let PP = $bb(P)$
#let HH = $bb(H)$
#let EE = $bb(E)$

// Aliases matching Charlie's LaTeX notation
#let bbR = RR
#let bbN = NN
#let bbZ = ZZ
#let bbQ = QQ
#let bbC = CC
#let bbF = FF

// Greek epsilon shorthands
#let eps = $epsilon$
#let veps = $epsilon.alt$

// Bold symbols / vectors
#let bs(x) = $bold(#x)$

// Set operations & empty set
#let emptyset = $diameter$

// Common math functions & operators
#let Var = $op("Var")$
#let Cov = $op("Cov")$
#let span = $op("span")$
#let id = $op("id")$
#let Id = $op("Id")$
#let null = $op("null")$
#let range = $op("range")$
#let dim = $op("dim")$

// Delimiters
#let norm(x) = $||#x||$
#let abs(x) = $|#x|$
#let floor(x) = $floor.l #x floor.r$
#let ceil(x) = $ceil.l #x ceil.r$
#let inner(x, y) = $chevron.l #x, #y chevron.r$

// Calculus derivatives
#let dv(y, x) = $(dif #y) / (dif #x)$
#let pdv(y, x) = $(partial #y) / (partial #x)$
#let pdvn(n, y, x) = $(partial^(#n) #y) / (partial #x^(#n))$
