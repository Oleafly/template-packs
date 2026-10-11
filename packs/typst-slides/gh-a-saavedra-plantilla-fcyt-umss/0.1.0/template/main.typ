#import "../lib.typ": *

#show: fcyt-theme.with(
  titulo: [Notación y Operaciones],
  subtitulo: [Teoría de Autómatas - UMSS],
  autor: [S. Alex - Ing. Informática],
  tema: "gris", // "oscuro" "claro" "gris"
)

= Introducción

== Chuleta del Día 1
Como vimos en la sesión del 08 de enero, la cerradura de Kleene es fundamental:

#formula_box("oscuro", $ L^* = union.big_{k=0}^infinity L^k $)

== Diagrama de Proceso
#align(center)[
  #stack(
    dir: ltr, spacing: 1cm,
    diagrama_box("oscuro", [Alfabeto $Sigma$]),
    align(center + horizon)[$arrow.r$],
    diagrama_box("oscuro", [Lenguaje $L$])
  )
]