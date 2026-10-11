#import "@preview/cetz:0.4.0": *
#import "@preview/cetz-plot:0.1.2": plot
#import "colors.typ": *

// Spacing
#let thinhalf = h(math.thin.amount * 0.5, weak: false)
#let thin = h(math.thin.amount, weak: false)
#let thin2 = h(math.thin.amount * 2, weak: false)

// Symbols
#let cm = sym.checkmark


// Font sizes
#let font-size-xs = 12pt
#let font-size-s = 16pt
#let font-size-m = 20pt
#let font-size-l = 24pt
#let font-size-xl = 28pt
#let font-size-xxl = 32pt
#let font-size-xxxl = 34pt

// General math stuff
#let mb(x) = {$bold(upright(#x))$}  // math bold
#let Ab = mb("A")
#let ab = mb("a")
#let Bb = mb("B")
// #let bb = mb("b")
#let Cb = mb("C")
#let cb = mb("c")
#let Db = mb("D")
#let db = mb("d")
#let Eb = mb("E")
#let eb = mb("e")
#let Fb = mb("F")
#let fb = mb("f")
#let Gb = mb("G")
#let gb = mb("g")
#let Hb = mb("H")
#let hb = mb("h")
#let Ib = mb("I")
#let ib = mb("i")
#let Jb = mb("J")
#let jb = mb("j")
#let Kb = mb("K")
#let kb = mb("k")
#let Lb = mb("L")
#let lb = mb("l")
#let Mb = mb("M")
// #let mb = mb("m")  // overrides mb(x) (mathbold) -- let's see if we even need this
#let Nb = mb("N")
#let nb = mb("n")
#let Ob = mb("O")
#let ob = mb("o")
#let Pb = mb("P")
#let pb = mb("p")
#let Qb = mb("Q")
#let qb = mb("q")
#let Rb = mb("R")
#let rb = mb("r")
#let Sb = mb("S")
#let sb = mb("s")
#let Tb = mb("T")
#let tb = mb("t")
#let Ub = mb("U")
#let ub = mb("u")
#let Vb = mb("V")
#let vb = mb("v")
#let Wb = mb("W")
#let wb = mb("w")
#let Xb = mb("X")
#let xb = mb("x")
#let Yb = mb("Y")
#let yb = mb("y")
#let Zb = mb("Z")
#let zb = mb("z")


// Random variable stuff
#let val(x) = {$mb("val")\(#x\)$}
#let Var = math.op("Var") // Variance
#let Cov = math.op("Cov") // Covariance
#let ind = math.bb($1$) // Indicator

// Argmax/min operator
#let argmin = math.op("argmin", limits: true)
#let argmax = math.op("argmax", limits: true)



#let mystroke = (thickness: 0.5pt)
#let sc = 15%
