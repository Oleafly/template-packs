

// = set theory, relations

#let ni = sym.in.rev
#let subseteq = sym.subset.eq
#let supseteq = sym.supset.eq
#let subsetneq = sym.subset.neq
#let supsetneq = sym.supset.neq
#let isom = sym.tilde.equiv
#let cong = sym.equiv
#let neq = sym.eq.not
// tilde
// approx
#let geq = sym.gt.eq
#let leq = sym.lt.eq
#let trige = sym.gt.tri
#let trile = sym.lt.tri
#let trigeq = sym.gt.tri.eq
#let trileq = sym.lt.tri.eq
#let trilneq = {
    trileq
    place(line(start: (-0.8em, 0.5em), end: (-0.5em, 0.05em), stroke: 0.05em))
}
#let trigneq = {
    trigeq
    place(line(start: (-0.8em, 0.5em), end: (-0.5em, 0.05em), stroke: 0.05em))
}

// = category theory

// im
#let ker = math.op("ker")
#let coker = math.op("coker")
#let otimes = sym.times.o
#let tensor = sym.times.o
#let oplus = sym.plus.o
#let dirsum = sym.plus.o
#let ominus = sym.minus.o
#let ob = math.op("ob")
#let Aut = text("Aut")


// = arrows

// #let monoarr = sym.arrow.l.

#let to = sym.arrow
#let mapsto = sym.arrow.bar
#let iff = sym.arrow.double.l.r


//AlGe
#let cone = text("cone")
#let char = text("char")
#let spec = text("spec")


// = ABC


#let ev = text("ev")


// == cal
#let cA = math.cal("A")
#let cB = math.cal("B")
#let cC = math.cal("C")
#let cD = math.cal("D")
#let cE = math.cal("E")
#let cF = math.cal("F")
#let cG = math.cal("G")
#let cH = math.cal("H")
#let cI = math.cal("I")
#let cJ = math.cal("J")
#let cK = math.cal("K")
#let cL = math.cal("L")
#let cM = math.cal("M")
#let cN = math.cal("N")
#let cO = math.cal("O")
#let cP = math.cal("P")
#let cQ = math.cal("Q")
#let cR = math.cal("R")
#let cS = math.cal("S")
#let cT = math.cal("T")
#let cU = math.cal("U")
#let cV = math.cal("V")
#let cW = math.cal("W")
#let cX = math.cal("X")
#let cY = math.cal("Y")
#let cZ = math.cal("Z")

#let ca = math.cal("a")
#let cb = math.cal("b")
#let cc = math.cal("c")
#let cd = math.cal("d")
#let ce = math.cal("e")
#let cf = math.cal("f")
#let cg = math.cal("g")
#let ch = math.cal("h")
#let ci = math.cal("i")
#let cj = math.cal("j")
#let ck = math.cal("k")
#let cl = math.cal("l")
#let cm = math.cal("m")
#let cn = math.cal("n")
#let co = math.cal("o")
#let cp = math.cal("p")
#let cq = math.cal("q")
#let cr = math.cal("r")
#let cs = math.cal("s")
#let ct = math.cal("t")
#let cu = math.cal("u")
#let cv = math.cal("v")
#let cw = math.cal("w")
#let cx = math.cal("x")
#let cy = math.cal("y")
#let cz = math.cal("z")

// == frak
#let fA = math.frak("A")
#let fB = math.frak("B")
#let fC = math.frak("C")
#let fD = math.frak("D")
#let fE = math.frak("E")
#let fF = math.frak("F")
#let fG = math.frak("G")
#let fH = math.frak("H")
#let fI = math.frak("I")
#let fJ = math.frak("J")
#let fK = math.frak("K")
#let fL = math.frak("L")
#let fM = math.frak("M")
#let fN = math.frak("N")
#let fO = math.frak("O")
#let fP = math.frak("P")
#let fQ = math.frak("Q")
#let fR = math.frak("R")
#let fS = math.frak("S")
#let fT = math.frak("T")
#let fU = math.frak("U")
#let fV = math.frak("V")
#let fW = math.frak("W")
#let fX = math.frak("X")
#let fY = math.frak("Y")
#let fZ = math.frak("Z")

#let fa = math.frak("a")
#let fb = math.frak("b")
#let fc = math.frak("c")
#let fd = math.frak("d")
#let fe = math.frak("e")
#let ff = math.frak("f")
#let fg = math.frak("g")
#let fh = math.frak("h")
#let fi = math.frak("i")
#let fj = math.frak("j")
#let fk = math.frak("k")
#let fl = math.frak("l")
#let fm = math.frak("m")
#let fn = math.frak("n")
#let fo = math.frak("o")
#let fp = math.frak("p")
#let fq = math.frak("q")
#let fr = math.frak("r")
#let fs = math.frak("s")
#let ft = math.frak("t")
#let fu = math.frak("u")
#let fv = math.frak("v")
#let fw = math.frak("w")
#let fx = math.frak("x")
#let fy = math.frak("y")
#let fz = math.frak("z")

#let sdh = math.cal()[SDH]
#let rep = math.op[rep]
#let gldim = math.op[gldim]
#let Iso = math.op[Iso]
#let Ext = math.op[Ext]
#let Hom = math.op[Hom]
#let add = math.op[add]
#let mt = math.op[mt]
#let leqext = math.attach(math.scripts(leq), b: $Ext$)
#let fromto = math.arrows.rl
#let Cone = math.op[cone]
#let dh = math.cal("DH")
#let attarrows(toplabel, bottomlabel) = math.attach(math.arrows.rl, t: toplabel, b: bottomlabel)
#let ac = math.italic[ac]
#let roof = math.op[roof]
