#import "../constants.typ" as const
#import "/parameters.typ" as param

#set align(bottom + center)
#let number-of-pages = context [#counter(page).final().at(0)]
#let mes = const.DATA.mes.replace(regex("^\w"), it => upper(it.text))
#rect(inset: (y: 0.5cm), width: 13.5cm)[
  #set align(left)
  #set par(first-line-indent: 0pt)
  #set text(size: 11em / 12)
  #param.nome-do-autor\
  #h(0.5cm)
  #param.titulo-do-trabalho/ #param.nome-do-autor. -- #param.localidade, #mes,
  #const.DATA.ano\-\
  #h(0.5cm)
  #number-of-pages\p. : il. (algumas color.) ; 30cm.

  #h(0.5cm)
  Orientador: #param.orientador\
  #for coorientador in param.coorientadores [
    #h(0.5cm)
    Coorientador: #coorientador\
  ]

  #h(0.5cm)
  #param.tipo-de-trabalho -- #param.instituicao, #mes, #const.DATA.ano.

  #h(0.5cm)
  #for (index, palavra) in param.palavras-chave.enumerate() [
    #(index + 1). #palavra.
  ]
  I. #param.orientador
  #for (index, coorientador) in param.coorientadores.enumerate() [
    #numbering("I.", (index + 2)) #coorientador.
  ]
  #numbering("I.", param.coorientadores.len() + 2) #param.instituicao
  #numbering("I.", param.coorientadores.len() + 3) #param.titulo-do-trabalho.
]

#pagebreak()
