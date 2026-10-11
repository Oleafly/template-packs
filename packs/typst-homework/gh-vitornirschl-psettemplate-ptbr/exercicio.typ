#import "conf.typ": problem
#import "@preview/physica:0.9.5": *
#set enum(numbering: "a)")
#set math.equation(numbering: none, supplement: [Eq.], number-align: bottom)

#show: problem.with(
  numero: 1,
  enunciado: [
    Enunciado
  ]
)