#import "../constants.typ" as const
#import "/parameters.typ" as param
#set align(center)
#text(size: 14em / 12, param.nome-do-autor)

#v(3cm)
#block(width: 90%, strong(text(size: 16em / 12, param.titulo-do-trabalho)))

#v(3cm)
#const.TEXTO-DA-FOLHA-DE-ROSTO

#v(3cm)
#param.instituicao

#v(3cm)
#[
  Orientador: #param.orientador\
  #for coorientador in param.coorientadores [
    Coorientador: #coorientador\
  ]
]

#v(1fr)
#const.LOCAL-E-DATA
#pagebreak()
