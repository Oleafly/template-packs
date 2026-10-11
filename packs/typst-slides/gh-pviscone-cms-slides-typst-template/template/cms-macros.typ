// Typst equivalents for settings/macros_user.tex and settings/macros_CMS_TDR.tex

// ---------- Text helpers ----------
#let TODO = (body) => text(weight: "bold", fill: rgb("335c99"))[(TODO: #body)]
#let ADDREF = text(size: 9pt, weight: "bold", fill: rgb("335c99"))[[add Ref.]]
#let FIXME = (body) => text(weight: "bold")[(FIXME: #body)]

#let Left = text(weight: "bold")[Left]
#let Middle = text(weight: "bold")[Middle]
#let Right = text(weight: "bold")[Right]
#let Top = text(weight: "bold")[Top]
#let Bottom = text(weight: "bold")[Bottom]

#let Fig = (label) => [Fig.~#ref(label)]
#let Eq = (label) => [Eq.~#ref(label)]
#let Tab = (label) => [Tab.~#ref(label)]

#let tabsubtitle = (body) => block(height: 13pt)[text(weight: "bold")[#body]]
#let phmin = h(0.6em)
#let myvec = (x) => [$arrow(#x)$]
#let defeq = [$:=$]

// ---------- Standard Model ----------
#let Lg = (x) => [$cal(L)_text(#x)$]
#let ff = (a, b) => [$#a _ text(#b)$]
#let aff = (a, b) => [$overline(#a) _ text(#b)$]

#let U = (n, sub: none) => {
	if sub == none { [$text("U")(#n)$] } else { [$text("U")_text(#sub)(#n)$] }
}
#let SU = (n, sub: none) => {
	if sub == none { [$text("SU")(#n)$] } else { [$text("SU")_text(#sub)(#n)$] }
}

#let GSM = [$text("SU")_text("C")(3) × text("SU")_text("L")(2) × text("U")_text("Y")(1)$]
#let Ggauge = [$G_text("gauge")^text("global")$]
#let YW = [$Y$]
#let JW = [$J_text("W")$]
#let thetaW = [$theta_text("W")$]
#let thetaC = [$theta_text("C")$]
#let VCKM = [$V_text("CKM")$]
#let CKM = [CKM]
#let CMS = [CMS]
#let GF = [$G_text("F")$]
#let MW = [$M_text("W")$]
#let MZ = [$M_text("Z")$]
#let db = (a, b) => [$mat(delim: "(", #a; #b)$]
#let tb = (a, b, c) => [$mat(delim: "(", #a; #b; #c)$]
#let C = [$C$]
#let Par = [$P$]
#let CP = [CP]
#let hc = [h.c.]

// ---------- Common particles / final states ----------
#let to = [#sym.arrow.r]
#let tauh = [$tau_text("h")$]
#let tt = [$tau tau$]
#let ll = [$ell ell'$]
#let ee = [$e e$]
#let mumu = [$mu mu$]
#let emu = [$e mu$]
#let ltau = [$ell tau_text("h")$]
#let etau = [$e tau_text("h")$]
#let mutau = [$mu tau_text("h")$]
#let tautau = [$tau tau$]
#let ditau = [$tau_text("h") tau_text("h")$]
#let btau = [$b tau$]
#let LQ = [LQ]
#let ALQ = [$overline(text("LQ"))$]
#let Zjets = [$Z$#phmin+$text("jets")$]
#let Wjets = [$W$#phmin+$text("jets")$]
#let jtf = [$j → tau_text("h")$]
#let ltf = [$ell → tau_text("h")$]

// ---------- Common variables ----------
#let BF = [$cal(B)$]
#let ST = [$S_text("T")$]
#let muR = [$mu_text("R")$]
#let muF = [$mu_text("F")$]
#let mvis = [$m_text("vis")$]
#let mll = [$m_(ell ell)$]
#let mtauh = [$m_(tau_text("h"))$]
#let mLQ = [$m_text("LQ")$]
#let Irel = [$I_text("rel")$]
#let Njets = [$N_text("jets")$]

// ---------- Statistics ----------
#let DNLL = [$-2 Delta ln(cal(L))$]
#let CL = [CL]
#let CLs = [$text("CL")_text("s")$]
#let CLsb = [$text("CL")_text("s+b")$]

// ---------- CMS TDR: text ----------
#let etal = [et al.]
#let ie = [i.e.]
#let eg = [e.g.]
#let etc = [etc.]

// ---------- CMS TDR: common macros ----------
#let PNfix = h(-0.04em)
#let DOI = (id) => link("http://dx.doi.org/" + id, text(font: "mono")[doi:#id])
#let NA = [—]
#let cmsTable = (body) => box(width: 100%)[#body]

// ---------- CMS TDR: units ----------
#let mus = [$text("µs")$]
#let mum = [$text("µm")$]
#let cm = [$text("cm")$]
#let MeV = [$text("MeV")$]
#let GeV = [$text("GeV")$]
#let TeV = [$text("TeV")$]
#let fbinv = [$text("fb")^(-1)$]

// ---------- CMS TDR: software programs ----------
#let GEANTfour = [Geant4]
#let GEANTthree = [geant3]
#let GEANT = [geant]
#let FASTJET = [FastJet]
#let FEWZ = [fewz]
#let Toppp = [Top++]
#let HERWIG = [herwig]
#let PYTHIA = [pythia]
#let MADGRAPH = [MadGraph]
#let MADSPIN = [MadSpin]
#let MLM = [MLM]
#let FXFX = [FxFx]
#let aMCATNLO = [aMC\@NLO]
#let MCATNLO = [mc@nlo]
#let MGvATNLO = [MadGraph5_aMC@NLO]
#let POWHEG = [powheg]
#let TAUOLA = [tauola]
#let DeepTau = [DeepTau]
#let DeepCSV = [DeepCSV]
#let DeepJet = [DeepJet]
#let Djet = [$D_text("jet")$]
#let DeepTauVSe = [DeepTau2017v2p1VSe]
#let DeepTauVSmu = [DeepTau2017v2p1VSmu]
#let DeepTauVSjet = [DeepTau2017v2p1VSjet]

// ---------- CMS TDR: particle pennames ----------
#let Pl = [$ell$]
#let PAl = [$overline(ell)$]
#let Pe = [$e$]
#let PGm = [$mu$]
#let PGt = [$tau$]
#let PGn = [$nu$]
#let PGnl = [$nu_ell$]
#let PGne = [$nu_e$]
#let PGnGm = [$nu_mu$]
#let PGnGt = [$nu_tau$]
#let PAGnl = [$overline(nu)_ell$]
#let PAGne = [$overline(nu)_e$]
#let PAGnGm = [$overline(nu)_mu$]
#let PAGnGt = [$overline(nu)_tau$]
#let PQu = [$u$]
#let PQd = [$d$]
#let PQc = [$c$]
#let PQs = [$s$]
#let PQt = [$t$]
#let PQb = [$b$]
#let PAQu = [$overline(u)$]
#let PAQd = [$overline(d)$]
#let PAQc = [$overline(c)$]
#let PAQs = [$overline(s)$]
#let PAQt = [$overline(t)$]
#let PAQb = [$overline(b)$]
#let PQq = [$q$]
#let PGg = [$gamma$]
#let Pg = [$g$]
#let PW = [$W$]
#let PZ = [$Z$]
#let PH = [$H$]
#let Zg = [$Z/gamma^*$]
#let PGp = [$pi$]
#let PGr = [$rho$]
#let Pa = [$a$]
#let PK = [$K$]
#let PAK = [$overline(K)$]
#let Pp = [$p$]
#let Pn = [$n$]
#let PD = [$D$]
#let PB = [$B$]
#let PAB = [$overline(B)$]
#let PJGy = [$J/psi$]
#let PGU = [$Upsilon$]

// ---------- CMS TDR: combinations ----------
#let bsln = [$b → c ell overline(nu)_ell$]
#let bstn = [$b → c tau overline(nu)_tau$]
#let ttbar = [$t overline(t)$]
#let bbbar = [$b overline(b)$]
#let nunu = [#PGnl#PGnl]
#let EE = [$e^+ e^-$]
#let MM = [$mu^+ mu^-$]
#let TT = [$tau^+ tau^-$]
#let LL = [$ell^+ ell^-$]

// ---------- CMS TDR: symbols ----------
#let lumi = [$cal(L)$]
#let DR = [$Delta R$]
#let ET = [$E_text("T")$]
#let kt = [$k_text("T")$]
#let pt = [$p_text("T")$]
#let ptvec = [$arrow(p)_text("T")$]
#let ptmiss = [$p_text("T")^text("miss")$]
#let ptvecmiss = [$arrow(p)_text("T")^text("miss")$]
#let ptvecvis = (sub: none) => {
	if sub == none { [$arrow(p)_text("T")^text("vis")$] }
	else { [$arrow(p)_text("T,#sub")^text("vis")$] }
}
#let MET = [MET]
#let ETmiss = [$E_text("T")^text("miss")$]
#let PT = pt
#let mT = [$m_text("T")$]
