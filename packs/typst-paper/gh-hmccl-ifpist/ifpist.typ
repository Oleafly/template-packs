#let ifpist(
  // Dados da instituição
  instituto: [Instituto Federal de Educação, Ciência e Tecnologia do Piauí],
  campus: [Campus Teresina Central],
  curso: [Análise e Desenvolvimento de Sistemas],
  cidade: "Teresina",
  // Dados do autor
  autor: "",
  autor-pronome: "",
  autor-email: "",
  // Título
  titulo: [],
  subtitulo: none,
  tipo-trabalho: "TCC",
  // Dados do orientador
  orientador: "",
  orientador-pronome: "",
  orientador-bio: [],
  orientador-instituto: [Instituto Federal de Educação, Ciência e Tecnologia do Piauí],
  orientador-email: "",
  // Dados do coorientador (opcional)
  coorientador: none,
  coorientador-pronome: none,
  coorientador-bio: none,
  coorientador-instituto: [Instituto Federal de Educação, Ciência e Tecnologia do Piauí],
  coorientador-email: none,
  // Resumo e palavras-chave (pt e en)
  resumo: [],
  palavras: (),
  abstract: [],
  keywords: (),
  // Data de apresentação
  data: datetime.today(),
  // Corpo do texto
  body,
) = {
  // Metadados
  set document(author: autor, title: titulo, keywords: palavras)
  // Margens
  set page(margin: (top: 3cm, bottom: 2cm, left: 3cm, right: 2cm))
  // Parágrafo para Elementos Pré-textuais
  set par(leading: 0.65em, spacing: 0.65em, justify: true)
  // Tamanho da fonte e idioma
  set text(size: 12pt, lang: "pt")
  // Seção
  set heading(numbering: "1.1")
  show heading: it => {
    set text(size: 12pt)
    block(
      spacing: 3em,
      smallcaps(it),
    )
  }
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    it
  }
  // Notas de rodapé
  set footnote.entry(indent: 0em)
  show footnote.entry: set text(size: 10pt)
  // Sumário
  set outline(indent: 0em)
  show outline: it => {
    show heading: set align(center)
    smallcaps(it)
  }
  show outline.entry.where(
    level: 1,
  ): it => {
    set block(above: 1.5em)
    it
  }

  // Variáveis
  let titulo-subtitulo = if subtitulo != none [
    #upper(titulo): #subtitulo
  ] else [
    #upper(titulo)
  ]

  let descricao = if tipo-trabalho == "EP" [
    Projeto de Pesquisa apresentado como exigência para aprovação
    na disciplina Elaboração de Projeto do #curso do #instituto, #campus.
  ] else if tipo-trabalho == "TCC" [
    Trabalho de Conlusão de Curso apresentado como exigência parcial para obtenção
    do diploma do curso de #curso do #instituto, #campus.
  ] else [Tipo de trabalho inválido.]

  let apresentacao-orientador = if orientador-pronome == "M" [
    Orientador: #orientador.
  ] else if orientador-pronome == "F" [
    Orientadora: #orientador.
  ] else [Pronome do orientador inválido.]

  let apresentacao-coorientador = if coorientador != none [
    #if coorientador-pronome == "M" [
      Coorientador: #coorientador.
    ] else if coorientador-pronome == "F" [
      Coorientadora: #coorientador.
    ] else [Pronome do orientador inválido.]
  ]

  let autor-bio = if autor-pronome == "M" [Graduando em ] else if autor-pronome == "F" [Graduanda em ]
  let autor-footnote = [#autor-bio #curso. #instituto. #link("mailto:" + autor-email)]
  let orientador-footnote = [#orientador-bio #orientador-instituto. #link("mailto:" + orientador-email)]
  let coorientador-footnote = [#coorientador-bio #coorientador-instituto. #link("mailto:" + coorientador-email)]
  let lista-palavras = for value in palavras { value + if value == palavras.last() [.] else [; ] }
  let lista-keywords = for value in keywords { value + if value == keywords.last() [.] else [; ] }

  // Capa
  page[
    #align(center)[
      #image("img/ifpi-logo-vertical.png", width: 36%)
      #text(weight: "bold")[
        #upper(instituto) \
        #upper(campus) \
        #upper(curso)
        #v(1fr)
        #upper(autor)
        #v(1fr)
        #titulo-subtitulo
        #v(3fr)
        #upper(cidade) \
        #datetime.today().year()
      ]
    ]
  ]

  // Folha de Rosto
  page[
    #align(center)[
      #upper(autor)
      #v(1fr)
      #titulo-subtitulo
      #v(1fr)
      #align(left)[
        #pad(left: 50%)[
          #descricao
          #v(1em)
          #apresentacao-orientador \
          #apresentacao-coorientador
        ]
      ]
      #v(3fr)
      #upper(cidade) \
      #datetime.today().year()
    ]
  ]

  // Sumário
  // outline()

  // Resumo e Abstract
  page[
    #align(center)[
      #text(weight: "bold")[#titulo-subtitulo]
    ]
    #align(right)[
      #autor #footnote(autor-footnote) \
      #orientador #footnote(orientador-footnote) \
      #if coorientador != none [#coorientador #footnote(coorientador-footnote)]
    ]
    #v(1em)
    #align(center)[
      #text(weight: "bold")[#smallcaps("Resumo")]
    ]
    #v(1em)
    #resumo \
    #text(weight: "semibold")[Palavras-chave:]
    #lista-palavras
    #v(1em)
    #align(center)[
      #text(lang: "en", weight: "bold")[#smallcaps("Abstract")]
    ]
    #v(1em)
    #text(lang: "en", abstract) \
    #text(lang: "en", weight: "semibold")[Keywords:]
    #text(lang: "en", weight: "regular")[#lista-keywords]
    #v(1.5em)
    #text(weight: "medium")[Data de aprovação: #data.display("[day]/[month]/[year]")]
  ]

  // Formatação para Elementos Textuais
  // Numeração
  set page(numbering: "1", number-align: top + right)
  // Parágrafos com indentação
  set par(
    first-line-indent: (
      amount: 1.25cm,
      all: true,
    ),
  )
  // Citação
  set quote(block: true)
  show quote: set par(leading: 0.55em, spacing: 0.55em)
  show quote: set pad(left: 4cm)
  show quote: set text(size: 10pt)
  show quote: set block(spacing: 2em)
  // Alínea e Subalínea
  set enum(numbering: "a)")
  set enum(indent: 1.25cm)
  set list(marker: [ -- ])
  set list(indent: 0.75cm)
  // Figuras
  show figure: set figure.caption(position: top, separator: [ --- ])
  show figure: set block(spacing: 2em)
  show figure.caption: set text(size: 12pt)
  // Tabelas
  show table: set text(size: 10pt)
  set table(
    stroke: (_, y) => (
      if y == 0 {
        (top: 1pt, bottom: 1pt)
      }
    ),
  )
  // Equações
  set math.equation(numbering: "(1)")
  show math.equation: set text(size: 12pt)
  show math.equation.where(block: true): set block(spacing: 2em)
  // Código fonte
  set raw(theme: none)
  show raw: set text(size: 8pt)
  show raw.where(block: true): set par(leading: 0.55em, spacing: 0.55em)
  show raw.where(block: true): block.with(stroke: 0.5pt + black, inset: 10pt)
  // Referências
  show bibliography: it => {
    show heading: set align(center)
    it
  }
  set bibliography(
    title: [Referências],
    style: "associacao-brasileira-de-normas-tecnicas",
  )

  // Corpo do texto
  body
}

// Fonte para figura ABNT
#let fonte(body) = {
  set align(left)
  set text(size: 10pt)
  set par(first-line-indent: (amount: 0pt, all: false))
  [
    #v(-1em)
    Fonte: #body
  ]
}

// Elementos Pós-textuais
#let pos-textual(body) = {
  set heading(numbering: none)
  show heading: set align(center)
  body
}

// Elementos auxiliares
#let rascunho(body) = {
  set text(style: "italic", fill: olive.darken(25%))
  body
}
