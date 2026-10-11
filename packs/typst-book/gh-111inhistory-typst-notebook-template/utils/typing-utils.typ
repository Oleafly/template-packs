/// This file contains utilities function for convenience typing in physics.

#let conceal(prompt, it) = {
  [
    #sym.triangle.filled.r
    #text(prompt)
  ]
}

#let vt(it) = {
  math.accent(it, math.harpoon)
}

#let Arg = math.op("Arg")

#let ddot = math.dot.double
// #let ddot(m) = math.accent(m, math.dot.double)

#let vb(it) = {
  math.bold(math.upright(it))
}

#let load-bib(..args) = context {
  import "@preview/citegeist:0.2.0": load-bibliography
  let a = read(..args)
  state("__bib", ()).update(
    arr => if arr == none {
      load-bibliography(a)
    } else {
      arr.push(load-bibliography(a))
    },
  )
}

#let cases(..args) = math.cases(..args.named(), ..args.pos().map(math.display))

#let because = {
  set text(size: 1.35em)
  math.because
}

#let therefore = {
  set text(size: 1.35em)
  math.therefore
}

#let neq = math.eq.not

#let char-replace(doc) = {
  show "->": sym.arrow.long
  show "=>": sym.arrow.double.long
  show "<-": sym.arrow.l.long
  show "<=": sym.arrow.double.l.long
  show "!=": sym.eq.not
  show <->: it => [#it#sym.arrow.l.r.long]
  show "<=>": sym.arrow.double.l.r.long
  doc
}
