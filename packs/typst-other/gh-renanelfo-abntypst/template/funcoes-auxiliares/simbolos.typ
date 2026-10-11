#import "explicacoes.typ": checar-parametros, formatar-explicacoes

#let simbolos() = {
  let lista-de-simbolos = state("simbolos", (:))

  let adicionar-simbolo(
    chave: none,
    valor: none,
    descricao: none,
    tipo: none,
  ) = {
    checar-parametros(chave, valor, descricao)
    lista-de-simbolos.update(old => {
      old.insert(chave, (valor: valor, descricao: descricao))
      old
    })
  }

  let get-simbolos() = context {
    formatar-explicacoes(
      [Lista de símbolos],
      lista-de-simbolos.final().pairs(),
    )
  }

  (adicionar-simbolo, get-simbolos)
}
#let (adicionar-simbolo, get-simbolos) = simbolos()
