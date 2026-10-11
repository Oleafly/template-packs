#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge, shapes.triangle
#import "@preview/lovelace:0.3.0": *
#import "@preview/cetz:0.4.1"

// ====================
// MATHEMATICAL SYMBOLS
// ====================

// has to be here so as to not mess with my bb
#let mathbb(b) = $bb(#b)$
// Caligraphic letters
#let cA = $cal(A)$
#let cB = $cal(B)$
#let cC = $cal(C)$
#let cD = $cal(D)$
#let cE = $cal(E)$
#let cF = $cal(F)$
#let cG = $cal(G)$
#let cH = $cal(H)$
#let cI = $cal(I)$
#let cJ = $cal(J)$
#let cK = $cal(K)$
#let cL = $cal(L)$
#let cM = $cal(M)$
#let cN = $cal(N)$
#let cO = $cal(O)$
#let cP = $cal(P)$
#let cQ = $cal(Q)$
#let cR = $cal(R)$
#let cS = $cal(S)$
#let cT = $cal(T)$
#let cU = $cal(U)$
#let cV = $cal(V)$
#let cW = $cal(W)$
#let cX = $cal(X)$
#let cY = $cal(Y)$
#let cZ = $cal(Z)$

// Bold letters (uppercase)
#let bA = $bold(A)$
#let bB = $bold(B)$
#let bC = $bold(C)$
#let bD = $bold(D)$
#let bE = $bold(E)$
#let bF = $bold(F)$
#let bG = $bold(G)$
#let bH = $bold(H)$
#let bI = $bold(I)$
#let bJ = $bold(J)$
#let bK = $bold(K)$
#let bL = $bold(L)$
#let bM = $bold(M)$
#let bN = $bold(N)$
#let bO = $bold(O)$
#let bP = $bold(P)$
#let bQ = $bold(Q)$
#let bR = $bold(R)$
#let bS = $bold(S)$
#let bT = $bold(T)$
#let bU = $bold(U)$
#let bV = $bold(V)$
#let bW = $bold(W)$
#let bX = $bold(X)$
#let bY = $bold(Y)$
#let bZ = $bold(Z)$

// Bold letters (lowercase)
#let ba = $bold(a)$
#let bb = $bold(b)$
#let bc = $bold(c)$
#let bd = $bold(d)$
#let be = $bold(e)$
#let bf = $bold(f)$
#let bg = $bold(g)$
#let bh = $bold(h)$
#let bi = $bold(i)$
#let bj = $bold(j)$
#let bk = $bold(k)$
#let bl = $bold(l)$
#let bm = $bold(m)$
#let bn = $bold(n)$
#let bo = $bold(o)$
#let bp = $bold(p)$
#let bq = $bold(q)$
#let br = $bold(r)$
#let bs = $bold(s)$
#let bt = $bold(t)$
#let bu = $bold(u)$
#let bv = $bold(v)$
#let bw = $bold(w)$
#let bx = $bold(x)$
#let by = $bold(y)$
#let bz = $bold(z)$

#let b0 = $bold(0)$
#let b1 = $bold(1)$
#let id1 = $mathbb(1)$

#let bRP = $bR bP$
#let bBPP = $bB bP bP$
#let bNP = $bN bP$
#let bPCP = $bP bC bP$

#let ZZ = $bold(Z)$

// ====================
// ARROW SYMBOLS
// ====================

// Better arrows
#let to      = $stretch(->)$
#let ot      = $stretch(<-)$
#let too     = $stretch(-->)$
#let oot     = $stretch(<--)$
#let bito    = $stretch(<->)$
#let iff     = $stretch(<==>)$
#let implies = $stretch(==>)$

// Special arrow types
#let incl  = $stretch(#sym.arrow.r.hook)$
#let surj  = $stretch(#sym.arrow.r.twohead)$
#let rincl = $stretch(#sym.arrow.l.hook)$
#let mto   = $stretch(#sym.arrow.r.bar)$
#let rmto  = $stretch(#sym.arrow.l.bar)$

// Text arrows
#let tto  = "->"
#let tot  = "<-"
#let ttoo = "-->"
#let toot = "<--"

// ====================
// RELATION SYMBOLS
// ====================

#let sim   = sym.tilde
#let hom   = sym.tilde.eq
#let iso   = sym.tilde.equiv

// ====================
// OPERATORS
// ====================

#let mult = scale(60%, reflow: true)[$#sym.bullet$]
#let cup  = box(
  pad(x: 2pt)[
    #scale(y: 150%)[
      #rotate(90deg, reflow: true)[
        $)$
      ]
    ]
  ]
)
#let ip(u, v) = $lr(chevron.l #u, #v chevron.r)$
#let over(s) = $overline(#s)$

// ====================
// GREEK LETTERS & MATH SYMBOLS
// ====================

#let pm     = $plus.minus$
#let mp     = $minus.plus$
#let leq    = $<=$
#let geq    = $>=$
#let eps    = $epsilon$
#let pmod   = $quad mod$
#let pprime = $prime prime$
#let argmin = $arg min$
#let argmax = $arg max$
#let mid    = $bar$
#let sl     = $slash$

#let im1    = $i - 1$
#let ip1    = $i + 1$

#let tm1    = $t - 1$
#let tp1    = $t + 1$

// ====================
// TEXT SHORTCUTS
// ====================

// Common words
#let id        = "id"
#let inj       = "inj"
#let tor       = "or"
#let tif       = "if"
#let tand      = "and"
#let diag      = "diag"
#let triu      = "triu"
#let tril      = "tril"
#let span      = "span"
#let tfor      = "for"
#let twith     = "with"
#let wlog      = "without loss of generality"
#let Wlog      = "Without loss of generality"
#let otherwise = "otherwise"

#let err = "err"
#let ML = "ML"
#let conv = "conv"
#let VC = "VC"

#let sign = "sign"
#let poly = "poly"
#let OPT = "OPT"
#let LP = "LP"
#let Var = "Var"
#let UNSAT = "UNSAT"

#let support = "support"
#let trace = "trace"
#let vol = "vol"

#let reviewed     = text(fill: purple)[REVIEWED]
#let not-reviewed = text(fill: blue)[NOT REVIEWED]
#let not-done     = text(fill: orange)[NOT DONE]
#let no-notes     = text(fill: orange)[NO NOTES]

// ====================
// VARIABLE NAMES
// ====================

#let vv = "v"
#let uu = "u"

// ====================
// CATEGORY THEORY & TOPOLOGY
// ====================

#let catlim   = $limits(lim)_(oot)$
#let catcolim = $limits(lim)_(too)$

#let nbd = $"nbd"$

// Topology/category theory functions
#let natTran(A,F,G,B) = $#box(baseline: 40%,
diagram(
  mark-scale: 80%,
  label-size: 0.6em,
  node((0, 0), $#A$, name: <A>),
  node((1, 0), $#B$, name: <B>),
  edge(<A>, <B>, $#F$, "->", shift: + 3pt),
  edge(<A>, <B>, $#G$, "->", shift: - 3pt, label-side: right),
))$

#let natTranA(A,F,G,B,alpha) = $#box(baseline: 40%,
diagram(
  mark-scale: 80%,
  label-size: 0.6em,
  node((0, 0), $#A$, name: <A>),
  node((1.2, 0), $#B$, name: <B>),
  node((0.6, - 0.4), $$, name: <F>),
  node((0.6, + 0.4), $$, name: <G>),
  edge(<A>, "->", <B>, $#F$, bend: + 30deg),
  edge(<A>, "->", <B>, $#G$, bend: - 30deg, label-side: right),
  edge(<F>, "=>", <G>, $#alpha$, label-side: left)
))$

#let natTranAB(A,F,G,H,B,alpha,beta) = $#box(baseline: 40%, 
diagram(
  mark-scale: 80%,
  label-size: 0.6em,
  let h = 0.55,
  node((0, 0),  $#A$, name: <A>),
  node((2, 0),  $#B$, name: <B>),
  node((1, -h), [],   name: <F>),
  node((1, 0),  [],   name: <G>, outset: 5pt),
  node((1, h),  [],   name: <H>),
  edge(<A>, "->", <B>, $#F$,    bend: + 50deg),
  edge(<A>, "->", <B>, $#G$,    label-anchor: "center", label-sep: 0pt),
  edge(<A>, "->", <B>, $#H$,    bend: - 50deg,          label-side: right),
  edge(<F>, "=>", <G>, $#alpha$, label-side: left),
  edge(<G>, "=>", <H>, $#beta$,  label-side: left),
))$

// Basic symbols
#let pt = $p t$
#let ob = "ob"
#let op = "op"

// Complexes and spaces
#let VR = $VV RR$     // vietoris-rips complex
#let RP = $RR P$      // real projective space

#let Int = $bold("Int")$

// Category names
#let Ab     = $bold("Ab")$
#let Ch     = $bold("Ch")$
#let Set    = $bold("Set")$
#let Hom    = $bold("Hom")$
#let Grp    = $bold("Grp")$
#let Fun    = $bold("Fun")$
#let Top    = $bold("Top")$
#let CAT    = $bold("CAT")$
#let Mon    = $bold("Mon")$
#let Ring   = $bold("Ring")$
#let CRing  = $bold("CRing")$
#let Vect   = $bold("Vect")$
#let vec    = $bold("vec")$
#let FDVect = $bold("FDVect")$
#let GrAb   = $bold("GrAb")$
#let Toph   = $bold("Toph")$
#let HoTop  = $bold("HoTop")$
#let chAb   = $"ch"bold("Ab")$
#let ssSet  = $bold("ssSet")$
#let cDelta = $bold(Delta)$

// ====================
// COMPUTATIONAL TOPOLOGY
// ====================

#let barc = "barc"
// Star and link operations
#let St    = "St"
#let Lst   = "Lst"
#let Ust   = "Ust"

#let Lk    = "Lk"
#let Llk   = "Llk"
#let Ulk   = "Ulk"

// Complexes and constructions
#let Sin   = "Sin"
#let Del   = "Del"
#let Vor   = "Vor"
#let Ball  = "Ball"

// Linear algebra
#let rank  = "rank"
#let rk    = "rk"
#let coker = "coker"

// Persistent homology
#let Pers  = "Pers"
#let Dgm   = "Dgm"
#let dgm   = "dgm"

// Matrix operations
#let row   = "row"
#let col   = "col"
#let low   = "low"

#let rep   = "rep"
#let pivot = "pivot"

// ====================
// HOMOLOGY & COHOMOLOGY
// ====================

#let hg(n, U, A: none) = {
  if A == none {
    $H_(#n) (#U)$
  }
  else {
    $H_(#n) (#U ; #A)$
  }
}

#let chg(n, U, A: none) = {
  if A == none {
    $H^(#n) (#U)$
  }
  else {
    $H^(#n) (#U ; #A)$
  }
}

#let hgsum(n, U, V) = $H_(#n) (#U) xor H_(#n) (#V) $

// ====================
// UTILITY FUNCTIONS
// ====================

// Spaced dots function
#let sparsedots(n, style: "c") = {
  h(0.25em) 
  for i in range(0, n) {
    if style == "c" {
      $dot.c$
    } else {
      $dot.basic$
    }
    if i < n - 1 {
      h(0.25em)
    }
  }
  h(0.25em) 
}

// Layout utilities
#let sep     = line(length: 100%)
#let npage   = pagebreak()
#let qquad   = $quad quad$
