#import "/parameters.typ": impressao-frente-e-verso
#import "/template/funcoes-auxiliares/titulo-da-pagina.typ": titulo-da-pagina

#let indices() = {
  let listas = state("listas", ())

  let adicionar-figuras(titulo-da-lista, target: none) = {
    listas.update(old => {
      old.push({
        show: titulo-da-pagina.with(titulo: titulo-da-lista)
        outline(target: target)
      })
      old
    })
  }

  let adicionar-explicacoes(explicacoes) = {
    listas.update(old => {
      old.push(explicacoes)
      old
    })
  }

  let imprimir-listas() = context {
    listas.get().reduce((acc, it) => acc + pagebreak(weak: true) + it)
    pagebreak(to: if impressao-frente-e-verso { "odd" } else { none })
  }

  (adicionar-figuras, adicionar-explicacoes, imprimir-listas)
}
