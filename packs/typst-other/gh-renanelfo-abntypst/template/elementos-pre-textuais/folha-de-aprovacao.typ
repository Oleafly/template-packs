#import "../constants.typ" as const
#import "/parameters.typ" as param
#set align(center)
#text(size: 14em / 12, param.nome-do-autor)

#v(1cm)
#block(width: 90%, strong(text(size: 16em / 12, param.titulo-do-trabalho)))

#v(1cm)
#const.TEXTO-DA-FOLHA-DE-ROSTO

#v(1cm)
#let dia = const.DATA.dia
#let dia = if dia != 1 [#dia] else [1º]
#align(left)[
  Aprovado(a) em: #dia de #lower(const.DATA.mes) de
  #const.DATA.ano
]

#v(1cm)
#[
  #set align(center)
  #upper()[Banca Examinadora]
]

#v(1cm)
#{
  set text(hyphenate: false)
  set block(width: 6cm, inset: (top: 0.3cm), stroke: (top: 1pt))
  block[#param.orientador#linebreak()Orientador -- #param.instituicao]
  linebreak()
  for coorientador in param.coorientadores {
    block[#coorientador#linebreak()Coorientador -- #param.instituicao]
    linebreak()
  }
  block[#param.nome-do-autor#linebreak()#param.instituicao]
}

#pagebreak()
