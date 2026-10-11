#import "@preview/ornamentalyst:0.1.0": ornament


// ─── Metadados do livro ───────────────────────────────────────

#let titulo-livro = "A Sinfonia dos Elementos"
#let autor-livro = "Vicente de Alencar"
#let sobrenome-autor = "ALENCAR"
#let prenome-autor = "Vicente de"
#let subtítulo = "Sobre a união matemática entre a tipografia, a física quântica e a encadernação de almas"
#let edição = "1ª edição"
#let ano-edição = "2026"


// ─── Formatação geral ─────────────────────────────────────

#let fonte-principal = "EB Garamond"
#let tamanho-fonte = 13pt
#let papel = "a5"
#let margem-interna = 2.5cm
#let margem-externa = 2.0cm
#let margem-topo = 2.0cm
#let margem-base = 2.0cm
#let margem-titulo = 1.0cm  // recuo lateral extra nos títulos de capítulo


// ─── Estado interno ──────────────────────────────────────────
//  titulo-capitulo: título do capítulo atual → cabeçalho das páginas ímpares.
//  em-frontmatter: true enquanto estamos no pré-texto; false a partir do 1º capítulo.
//  Ambos são atualizados automaticamente pela função `capitulo()` em template/chapter.typ.

#let titulo-capitulo = state("titulo-cap", "")
#let em-frontmatter  = state("em-frontmatter", true)


// ─── Função de template ──────────────────────────────────────
//  Aplica todas as configurações globais ao documento.
//  Use em main.typ com:  #show: template

#let template(body) = {
  set par(justify: true)
  set text(font: fonte-principal, size: tamanho-fonte)
  set page(
    paper: papel,
    binding: left,
    margin: (
      inside: margem-interna,
      outside: margem-externa,
      top: margem-topo,
      bottom: margem-base,
    ),

    // Rodapé: número de página, alinhado conforme paridade.
    // Suprimido no pré-texto (dedicatória, agradecimentos, etc.)
    footer: context {
      if em-frontmatter.get() { return }
      let n = counter(page).get().first()
      let pos = if calc.even(n) { left } else { right }
      align(pos)[#n]
    },

    // Cabeçalho: título do livro (pares) / capítulo atual (ímpares).
    // Suprimido no pré-texto.
    header: context {
      if em-frontmatter.get() { return }
      let n = counter(page).get().first()
      let pos = if calc.even(n) { left } else { right }
      let texto = if calc.even(n) { titulo-livro } else { titulo-capitulo.get() }
      align(pos)[#smallcaps[#texto]]
    },
  )

  // Títulos: ornamentos + smallcaps + peso regular

  show heading: set par(justify: false)
  show heading: set align(center)
  show heading: it => block[
    #if it.numbering != none [
      #context counter(heading).display(it.numbering)
      #h(0.5em)
    ]
    #it.body
  ]

  show heading.where(level: 1): set text(size: 24pt, weight: "medium")
  show heading.where(level: 1): it => pad(x: margem-titulo, block[
    #ornament(60, height: 20pt, collection: "pgfhan")

    #smallcaps(it.body)

    #ornament(60, height: 20pt, collection: "pgfhan", symmetry: "h")
  ])

  show heading.where(level: 2): set text(size: 20pt, weight: "medium")

  show heading.where(level: 3): set text(size: 16pt, weight: "medium")
  show heading.where(level: 3): set align(left)


  body
}
