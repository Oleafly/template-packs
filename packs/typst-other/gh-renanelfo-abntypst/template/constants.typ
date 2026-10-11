#import "/parameters.typ" as param

#let MONTHS = (
  "janeiro",
  "fevereiro",
  "março",
  "abril",
  "maio",
  "junho",
  "julho",
  "agosto",
  "setembro",
  "outubro",
  "novembro",
  "dezembro",
)

#let DATA = (
  dia: param.data-de-aprovacao.day(),
  mes: MONTHS.at(param.data-de-aprovacao.month() - 1),
  ano: param.data-de-aprovacao.year(),
)
#let LOCAL-E-DATA = align(center, upper(strong[
  #param.localidade\
  #DATA.mes, #DATA.ano
]))
#let TEXTO-DA-FOLHA-DE-ROSTO = grid(
  columns: (1fr, 1fr),
  [],
  [
    #set align(left)
    #param.tipo-de-trabalho apresentada ao #param.curso da #param.instituicao,
    como parte dos requisitos para obtenção do título de #param.nome-do-titulo.
  ],
)

#let SINGLE-SPACING = 0.15em
#let ONE-AND-HALF-SPACING = 0.5em
#let DOUBLE-SPACING = 1.0em
