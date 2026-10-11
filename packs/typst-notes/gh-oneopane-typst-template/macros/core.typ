// Core reusable notation and math helpers.

// ---------- Blackboard Bold ----------
#let bbA = $bb(A)$
#let bbB = $bb(B)$
#let bbC = $bb(C)$
#let bbD = $bb(D)$
#let bbE = $bb(E)$
#let bbF = $bb(F)$
#let bbG = $bb(G)$
#let bbH = $bb(H)$
#let bbI = $bb(I)$
#let bbJ = $bb(J)$
#let bbK = $bb(K)$
#let bbL = $bb(L)$
#let bbM = $bb(M)$
#let bbN = $bb(N)$
#let bbO = $bb(O)$
#let bbP = $bb(P)$
#let bbQ = $bb(Q)$
#let bbR = $bb(R)$
#let bbS = $bb(S)$
#let bbT = $bb(T)$
#let bbU = $bb(U)$
#let bbV = $bb(V)$
#let bbW = $bb(W)$
#let bbX = $bb(X)$
#let bbY = $bb(Y)$
#let bbZ = $bb(Z)$

// ---------- Calligraphic ----------
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

// ---------- Math Operators ----------
#let argmax = math.op("arg max")
#let argmin = math.op("arg min")
#let rank = math.op("rank")
#let trace = math.op("tr")
#let diag = math.op("diag")
#let span = math.op("span")
#let supp = math.op("supp")
#let dom = math.op("dom")
#let codom = math.op("codom")
#let img = math.op("im")
#let ker = math.op("ker")

// ---------- Delimiter Helpers ----------
#let abs(x) = $lr(|#x|)$
#let norm(x) = $lr(||#x||)$
#let inner(x, y) = $chevron.l #x, #y chevron.r$
// Typst reserves `set` as a keyword, so the set-builder helper is named `setof`.
#let setof(x) = $lr({#x})$
#let ceil(x) = $lr(⌈#x⌉)$
#let floor(x) = $lr(⌊#x⌋)$
