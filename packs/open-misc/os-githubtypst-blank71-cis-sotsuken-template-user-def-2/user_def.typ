#let emph_color(color, body) = {
  show emph: it => {
    set text(color)
    it.body
  }
  emph(body)
}
#let underline_color(color, body) = { underline(stroke: 1pt + color, [#body]) }
#let emph_red(body) = {
  emph_color(red, body)
}
#let underline_red(body) = { underline_color(red, body) }
#let underline_blue(body) = { underline_color(blue, body) }

#let theorem-counter = counter("theorem")
#let lemma-counter = counter("lemma")
#let definition-counter = counter("definition")
#let proof-counter = counter("proof")

#let theorem(body) = {
  set par(first-line-indent: (amount: 0em))
  theorem-counter.step()
  v(0.35em)
  context [*定理 #theorem-counter.display().* #h(0.65em)]
  body
}

#let lemma(body) = {
  set par(first-line-indent: (amount: 0em))
  lemma-counter.step()
  v(0.35em)
  context [*補題 #lemma-counter.display().* #h(0.65em)]
  body
}

#let definition(body) = {
  set par(first-line-indent: (amount: 0em))
  definition-counter.step()
  v(0.35em)
  context [*定義 #definition-counter.display().* #h(0.65em)]
  body
}

#let proof(body) = {
  set par(first-line-indent: (amount: 0em))
  v(0.35em)
  [*証明.* #h(0.65em)]
  body
}

#let rmP = [$"P"$]
#let rmNP = [$"NP"$]
