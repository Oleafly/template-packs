#let equacao(body) = { math.equation(block: true, numbering: "(1)", body) }
#let figura-equacao(body, caption: none) = figure(math.equation(block: true, numbering: "(1)", body), caption: caption, kind: math.equation, supplement: [Equação])

// Caixa de orientação para o aluno: explica o que a seção DEVE / NÃO DEVE conter.
// É andaime de escrita — apague cada #orientacao[...] quando a seção estiver escrita;
// orientação esquecida em seção pronta conta como texto de exemplo do template.
#let orientacao(body) = block(
  width: 100%,
  inset: 8pt,
  radius: 3pt,
  fill: luma(242),
  stroke: (left: 2pt + luma(140)),
  {
    set text(size: 10pt)
    set par(first-line-indent: 0pt, leading: 0.6em, spacing: 0.8em, justify: false)
    [*Orientação* (apague ao escrever a seção). ]
    body
  },
)
