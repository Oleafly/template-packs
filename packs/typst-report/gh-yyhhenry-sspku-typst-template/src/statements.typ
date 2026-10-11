// Numbered statements with native Typst labels and references.
#let show-statement(it) = block(width: 100%, breakable: true)[
  #set align(left)
  #strong[#it.supplement #context it.counter.display(it.numbering)（#it.caption.body）。] #it.body
  #parbreak()
]

#let statement(kind, title, body) = {
  let supplements = (
    proposition: box[命题],
    lemma: box[引理],
    theorem: box[定理],
  )
  figure(
    body,
    kind: kind,
    supplement: supplements.at(kind),
    numbering: "1",
    caption: title,
  )
}
