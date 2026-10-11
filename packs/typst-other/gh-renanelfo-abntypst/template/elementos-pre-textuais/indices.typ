// #import "/conteudo/lista-de-abreviaturas.typ": abreviaturas
#include "/conteudo/lista-de-simbolos.typ"
#import "/template/funcoes-auxiliares/indices.typ": indices
#import "/template/funcoes-auxiliares/titulo-da-pagina.typ": titulo-da-pagina
#import "/template/funcoes-auxiliares/abreviaturas.typ": get-abreviaturas
#import "/template/funcoes-auxiliares/simbolos.typ": get-simbolos

#set outline(title: [])
#show outline.entry: it => link(
  it.element.location(),
  it.indented([#it.prefix() ---], [#it.inner()]),
)

#let (adicionar-figuras, adicionar-explicacoes, imprimir-listas) = indices()

#adicionar-figuras([Lista de ilustrações], target: figure.where(kind: image))
#adicionar-figuras([Lista de tabelas], target: figure.where(kind: table))
#adicionar-explicacoes(get-abreviaturas())
#adicionar-explicacoes(get-simbolos())
#imprimir-listas()

#show outline.entry: it => [
  #let size = if (
    type(it.element) == content and it.element.func() == heading
  ) {
    let level = it.element.level
    if level == 1 {
      1.4em
    } else if level == 2 {
      1.2em
    } else {
      1.0em
    }
  } else {
    1.0em
  }
  #set text(size: size)
  #grid(
    columns: (1fr, 7fr),
    align: bottom,
    it.prefix(), it.inner(),
  )
]
#show outline.entry: it => link(it.element.location(), it)
#show outline.entry: it => {
  if it.element.func() == heading and it.element.level == 1 {
    upper(it)
  } else {
    it
  }
}

#show: titulo-da-pagina.with(titulo: [Sumário])
#outline()
#pagebreak()
