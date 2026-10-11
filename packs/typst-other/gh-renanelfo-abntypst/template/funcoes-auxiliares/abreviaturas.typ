#import "explicacoes.typ": checar-parametros, formatar-explicacoes

#let abreviaturas() = {
  let lista-de-abreviaturas = state("abreviaturas", (:))

  let adicionar-abreviatura(
    chave: none,
    valor: none,
    descricao: none,
    artigo: none,
  ) = {
    checar-parametros(chave, valor, descricao)
    lista-de-abreviaturas.update(old => {
      old.insert(
        chave,
        (valor: valor, descricao: descricao, artigo: artigo, first: true),
      )
      old
    })
  }

  let abreviatura(chave, plural: false) = context {
    let lista = lista-de-abreviaturas.get()
    let element = lista.at(chave)
    if element.at("first") {
      lista-de-abreviaturas.update(old => {
        old.at(chave).at("first") = false
        old
      })
      [#element.at("artigo") #element.at("descricao") (#element.at("valor"))]
    } else [
      #element.at("artigo") #element.at("valor")
    ]
  }

  let get-abreviaturas() = context {
    formatar-explicacoes(
      [Lista de abreviaturas e siglas],
      lista-de-abreviaturas.final().pairs(),
    )
  }

  (adicionar-abreviatura, abreviatura, get-abreviaturas)
}
#let (adicionar-abreviatura, abreviatura, get-abreviaturas) = abreviaturas()
