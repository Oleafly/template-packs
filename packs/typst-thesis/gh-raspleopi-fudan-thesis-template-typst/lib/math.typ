// Math and theorem helpers for the thesis template.

#let theorem-counter = counter("thesis-theorem")
#let definition-counter = counter("thesis-definition")
#let example-counter = counter("thesis-example")

#let chapter-index() = {
  let nums = counter(heading).get()
  if nums.len() == 0 { 0 } else { nums.first() }
}

#let numbered-block(kind, counter, body, title: none) = [
  #counter.step()
  #context {
    let label = if title == none {
      [#kind #chapter-index().#counter.get().first()]
    } else {
      [#kind #chapter-index().#counter.get().first()（#title）]
    }
    block(
      width: 100%,
      inset: (x: 0pt, y: 0.35em),
      [
        #strong(label)
        #h(0.5em)
        #body
      ],
    )
  }
]

#let theorem(body, title: none) = numbered-block("定理", theorem-counter, body, title: title)
#let lemma(body, title: none) = numbered-block("引理", theorem-counter, body, title: title)
#let proposition(body, title: none) = numbered-block("命题", theorem-counter, body, title: title)
#let corollary(body, title: none) = numbered-block("推论", theorem-counter, body, title: title)
#let definition(body, title: none) = numbered-block("定义", definition-counter, body, title: title)
#let example(body, title: none) = numbered-block("例", example-counter, body, title: title)

#let proof(body) = [
  #strong[证：]#h(0.5em)#body #h(1fr)$square$
]
