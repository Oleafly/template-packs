#import "theme.typ": theme
#import "@preview/codly:1.3.0" as codly

#let problem-counter = counter("problem")

#let problem(body, title: none) = {
  problem-counter.step()
  block(above: 1.3em, below: 0.6em)[
    #strong[Problem #context problem-counter.display()#if title != none [ — #title]]

    #body
  ]
}

#let solution(body) = block(
  inset: (left: 1em),
  stroke: (left: 2pt + theme.rule),
  above: 0.6em,
  below: 1.2em,
)[
  #text(style: "italic", fill: theme.muted)[Solution.] #body
]

#let thm-counter = counter("theorem")

#let _thm(kind, body, title: none) = {
  thm-counter.step()
  block(above: 1em, below: 1em)[
    #strong[#kind #context thm-counter.display()]#if title != none [ (#emph(title))]. #body
  ]
}

#let theorem(body, title: none) = _thm("Theorem", body, title: title)
#let lemma(body, title: none) = _thm("Lemma", body, title: title)
#let definition(body, title: none) = _thm("Definition", body, title: title)

#let proof(body) = block(above: 0.8em, below: 1.2em)[
  #emph[Proof.] #body #h(1fr) #box(width: 0.55em, height: 0.55em, stroke: 0.6pt + theme.muted)
]

#let kv(key, value) = [#strong[#key:] #value]

#let code(source, file: none, lang: auto, lines: none) = {
  let l = if lang != auto { lang } else if file != none { file.split(".").last() } else { none }
  if lines == none {
    raw(source, lang: l, block: true)
  } else {
    codly.local(range: lines)[#raw(source, lang: l, block: true)]
  }
}

// Apply this once in the document setup to turn on codly for every code block.
#let code-setup = doc => {
  show: codly.codly-init.with()
  codly.codly(
    stroke: 0.5pt + theme.rule,
    radius: 4pt,
    inset: (x: 0.55em, y: 0.36em),
    lang-fill: theme.head-fill,
    lang-stroke: 0.5pt + theme.rule,
    number-align: right,
  )
  doc
}
