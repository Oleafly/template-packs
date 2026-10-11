#let sailor_red = rgb("#FA0109")

#let conf(
  lista: [],
  disciplina: [],
  doc,
) = {
  set page(
    paper: "a4",
    fill: rgb("F9F6EE"),
    numbering: "1",
  )
  set par(justify: true)
  set text(
    font: "Libertinus Serif",
    size: 11pt,
  )
  grid(
    columns: (3fr, 1fr),
    align(left, text(60pt, font: "Mea Culpa", fill: sailor_red)[
      Lista #lista
    ]),
    align(right, text(12pt, font: "New Computer Modern", top-edge: "baseline")[
      #v(15pt)#disciplina #v(0pt) Vitor Nirschl #v(0pt) 13685771
    ])
  )
  v(20pt)
  doc
}

#let problem(
  numero: [],
  enunciado: [],
  resposta
) = {
  box(baseline: 100%)[
    #box(fill: luma(180))[Problema #numero]
    #line(start: (13%, -2.4%), end: (100%, -2.4%), stroke: 0.8pt)
  ]
  v(-15pt)
  block[#enunciado]
  v(10pt)
  [*Resolução*]

  block[#resposta]
  v(15pt)
} 

#let nonum(eq) = math.equation(block: true, numbering: none, eq)

#let versor(param) = math.hat(math.upright(math.bold(param)))