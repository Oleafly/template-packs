#import "/template/funcoes-auxiliares/simbolos.typ": adicionar-simbolo
#import "/template/funcoes-auxiliares/simbolos.typ": get-simbolos

#adicionar-simbolo(
  chave: "coracao",
  tipo: "simbolo",
  valor: text(fill: rgb("#cc3333"), sym.suit.heart),
  descricao: [Coraçãozinho],
)
#adicionar-simbolo(
  chave: "espada",
  tipo: "simbolo",
  valor: sym.suit.spade,
  descricao: [Espadinha],
)
#adicionar-simbolo(
  chave: "paus",
  tipo: "simbolo",
  valor: sym.suit.club,
  descricao: highlight(fill: black)[Piroquinha] + [ Redatado],
)
#adicionar-simbolo(
  chave: "ouros",
  tipo: "simbolo",
  valor: text(fill: rgb("#cc3333"), sym.suit.diamond),
  descricao: [Losanguinho],
)
#adicionar-simbolo(
  chave: "sigma",
  tipo: "grego",
  valor: $sigma$,
  descricao: "Constante de Stefan-Boltzmann",
)
#adicionar-simbolo(
  chave: "x",
  tipo: "subscrito",
  valor: $f_x$,
  descricao: [Derivada de $f$ em relação a $x$],
)
#adicionar-simbolo(
  chave: "tensor",
  tipo: "sobrescrito",
  valor: $arrow(arrow("A"))$,
  descricao: [Tensor de segunda ordem de A.],
)
