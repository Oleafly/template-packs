#import "titulo-da-pagina.typ": titulo-da-pagina

#let formatar-explicacoes(titulo-da-lista, explicacoes) = {
  if explicacoes.len() == 0 {
    return none
  }
  let lista-flattened = explicacoes
    .sorted(key: t => t.at(0))
    .map(t => t.at(1))
    .map(t => (t.valor, t.descricao))
    .flatten()

  [
    #show: titulo-da-pagina.with(titulo: titulo-da-lista)
    #set align(right)
    #block(width: 90%)[
      #set align(left + horizon)
      #grid(
        columns: (1fr, 4fr),
        row-gutter: 8pt,
        column-gutter: 4pt,
        inset: 1pt,
        ..lista-flattened,
      )
    ]
  ]
}


#let checar-parametros(chave, valor, descricao) = {
  if chave == none or valor == none or descricao == none {
    panic("Chave, valor e descricao sao parametros necessarios.")
  }
}
