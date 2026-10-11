/***
 *
 * Function definitions for the typst files in this folder (or elsewhere).
 *
***/

#let vector(v) = $bold(upright(#v))$

#let matrix(M) = $bold(upright(#M))$

#let unitvec(v) = $hat(vector(#v))$

#let nvec = $vector(n)$

#let unvec = $unitvec(n)$

#let pos = $vector(r)$

#let Avec = $vector(A)$

#let force = $vector(f)$

#let der(f,x, inline:false) = if inline [
	$dif #f \/ dif #x$
] else [
	$(dif #f) / (dif #x)$
]

#let pder(f,x, inline:false) = if inline [
	$partial #f \/ partial #x$
] else [
	$(partial #f) / (partial #x)$
]

#let divdot = $nabla dot$

#let grad = $nabla$

#let boundary = $partial$

#let verteq = rotate(90deg)[$=$]

#let vertapprox = rotate(90deg)[$approx$]

#let bra(x) = $lr(angle.l #x bar.v)$

#let ket(x) = $lr(bar.v #x angle.r)$

#let braket(a,b) = $lr(angle.l #a mid(bar.v) #b angle.r)$

#let ketbra(a,b) = $lr(bar.v #a mid(angle.r) mid(angle.l) #b bar.v)$

#let braopket(a,O,b) = $lr(angle.l #a mid(bar.v) #O mid(bar.v) #b angle.r)$

#let mean(x) = $lr(angle.l #x angle.r)$

#let transpose(x) = $#x^(upright(T))$

#let conj(x) = $scripts(#x)^*$

#let udiff = $arrow.t.b.double$

#let udeq = rotate(90deg)[$=$]

#let unitdistance = 0.1em

#let unit(symbol) = $#h(unitdistance,weak:true)upright(symbol)$

#let restriction(a,b) = $lr(( #a mid(bar.v) #b ))$

#let probability = $P$

#let probOf(x) = $probability lr((#x))$

#let condProbOf(a,b) = $probability restriction(#a,#b)$

#let lfMat = $matrix(L)$
