#import "@preview/algo:0.3.4": algo, i, d, comment, code

/*
 * algorithm
 */

#let algo = algo.with(line-numbers: false)
#let specified(
  name,
  params,
  spec,
  body,
) = [
  #let usn = us(name)
  $#usn (#params)$: #spec
  #algo(
    header: [$us(#name)(#params)$#i],
    {
      if type(body) == content { body } else { body(usn) }
      [#d \ end *algorithm*]
    },
  )
]


// cryptography terms
#let poly = math.op("poly")
#let polylog = math.op("polylog")
#let negl = math.op("negl")
#let secpar = $lambda$
#let zo = ${0, 1}$

// calligraphic letters
#let cA = $cal("A")$
#let cB = $cal("B")$
#let cC = $cal("C")$
#let cD = $cal("D")$
#let cE = $cal("E")$
#let cF = $cal("F")$
#let cG = $cal("G")$
#let cH = $cal("H")$
#let cI = $cal("I")$
#let cJ = $cal("J")$
#let cK = $cal("K")$
#let cL = $cal("L")$
#let cM = $cal("M")$
#let cN = $cal("N")$
#let cO = $cal("O")$
#let cP = $cal("P")$
#let cQ = $cal("Q")$
#let cR = $cal("R")$
#let cS = $cal("S")$
#let cT = $cal("T")$
#let cU = $cal("U")$
#let cV = $cal("V")$
#let cW = $cal("W")$
#let cX = $cal("X")$
#let cY = $cal("Y")$
#let cZ = $cal("Z")$


// bold letters
#let bA = $upright(bold("A"))$
#let bB = $upright(bold("B"))$
#let bC = $upright(bold("C"))$
#let bD = $upright(bold("D"))$
#let bE = $upright(bold("E"))$
#let bF = $upright(bold("F"))$
#let bG = $upright(bold("G"))$
#let bQ = $upright(bold("Q"))$
#let bU = $upright(bold("U"))$
#let bV = $upright(bold("V"))$
#let bX = $upright(bold("X"))$
#let bY = $upright(bold("Y"))$
#let br = $upright(bold("r"))$

// fraktur letters
#let fP = $frak("P")$
#let fR = $frak("R")$
#let fX = $frak("X")$

// functions
#let func(x) = $cF_sans(x)$
#let fcom = func("com")
#let fot = func("ot")

// 'family'
#let ancest = $sans("Ancestors")$
#let sibs = $sans("Siblings")$
#let parent = $sans("parent")$
#let leaves = $sans("leaves")$

// math symbols


#let emptyset = $diameter$
#let oc = $thin circle.small thin$

#let length = math.op("length")
#let dom = math.op("dom")
#let img = math.op("im")


#let inv = math.op(math.sans("inv"))
#let ll = $cal(L)$
#let nil = $sans("nil")$
#let us(x) = $underline(sans(#x))$


#let dist(x) = $lr(angle.l #x angle.r)$
#let ip(x, y) = $lr(angle.l #x , #y angle.r)$


#let concat = oc

#let nin = $in.not$

#let argmax = math.op("argmax")
#let argmin = math.op("argmin")

#let spnorm(x) = $lr(|| #x ||)$

#let entails = math.tack.r.double

#let event(x) = $sans(x)$
#let supp = $sans("Supp")$

#let prob = math.op("Pr")
#let given = $mid(|)$
#let var = math.op("Var")
#let cov = math.op("Cov")
#let iid = "i.i.d"

#let getsr = $limits(<-)^\$$
#let drawn = $~$

// big/small O-Theta-omega
#let bo = $cal(O)$
#let bt = $Theta$
#let bm = $Omega$

#let so = $cal(o)$
#let st = $theta$
#let sm = $omega$

#let rv(x) = $upright(bb(#x))$


#let so = $bold(sans(Omega))$
#let rs(i) = $bold(sans(Omega_#i))$

#let rvA = $rv("A")$
#let rvB = $rv("B")$
#let rvC = $rv("C")$
#let rvD = $rv("D")$
#let rvG = $rv("G")$
#let rvP = $rv("P")$
#let rvQ = $rv("Q")$
#let rvR = $rv("R")$
#let rvS = $rv("S")$
#let rvT = $rv("T")$
#let rvU = $rv("U")$
#let rvV = $rv("V")$
#let rvW = $rv("W")$
#let rvX = $rv("X")$
#let rvY = $rv("Y")$
#let rvZ = $rv("Z")$

#let rvm = $rv("m")$
#let rvr = $rv("r")$
#let rvx = $rv("x")$
#let rvy = $rv("y")$
#let rvc = $rv("c")$

// algorithms & predicates
#let pred(x) = $op(sans(#x))$
#let mac = $pred("Mac")$
#let sk = $pred("sk")$
#let pk = $pred("pk")$
#let gen = $pred("Gen")$
#let enc = $pred("Enc")$
#let dec = $pred("Dec")$
#let SK = $pred("sk")$
#let wt = $pred("wt")$
#let esk = $op(enc_sk)$
#let dsk = $op(enc_sk)$

#let capprox = $approx^((c))$
#let tag = $pred("Tag")$
#let sign = $pred("Sign")$
#let ver = $pred("Ver")$
#let simu = $pred("Sim")$
#let ball = $pred("Ball")$
#let vol = $pred("Vol")$

#let ext = $pred("Ext")$
