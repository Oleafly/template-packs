// ============================================================
//  template/back-matter.typ — Páginas de pós-texto
// ============================================================
//
//  Layouts e lógica para as seções finais do livro:
//  Notas globais do livro, Bibliografia e Colofão (Página Final).
// ============================================================

#import "../metadata/config.typ": titulo-capitulo


// ─── Renderização de Notas do Livro ──────────────────────────
// Renderiza todas as notas de livro coletadas pelo volume,
// agrupadas de forma premium por capítulo.
//
#let exibir-notas-livro() = {
  titulo-capitulo.update("Notas")
  
  context {
    let notas = query(<nota-livro>)
    if notas.len() > 0 [
      #pagebreak(to: "odd")

      = Notas

      #set text(size: 10pt)
      #for (i, nota) in notas.enumerate() [
        #let dados = nota.value
        #let mostrar-titulo = (i == 0 or notas.at(i - 1).value.capitulo != dados.capitulo)
        #if mostrar-titulo [
          #v(1.2em)
          #text(weight: "bold")[#dados.capitulo] \
          #v(0.4em)
        ]
        #super(str(i + 1)) #dados.corpo \
      ]
    ]
  }
}


// ─── Renderização da Bibliografia ────────────────────────────
// Carrega e renderiza a bibliografia com cabeçalho ornamentado
// e cabeçalho dinâmico ativo.
//
#let bibliografia() = {
  titulo-capitulo.update("Bibliografia")
  pagebreak(to: "odd")
  bibliography("../metadata/works.bib", title: "Bibliografia", style: "apa", full: true)
}


// ─── Página Final / Colofão ──────────────────────────────────
// Página final clássica de produção (Colofão) com os créditos
// tipográficos, papel e encadernação.
//
#let last_page(ficha) = {
  pagebreak(to: "even")
  set page(header: none, footer: none)
  set text(size: 8.5pt)
  set par(justify: false)

  align(center + top)[
    #image(
      "figures/blue_tag.png",
      width: 25%,
    )
  ]

  align(center + bottom)[
    Diagramado em #ficha.tipografia,\
    Impresso em #ficha.papel,\
    Encadernado por Quarto Seis Ateliê,\
    São Sebastião do Rio de Janeiro,\
    A. D. #ficha.ano
  ]
}
