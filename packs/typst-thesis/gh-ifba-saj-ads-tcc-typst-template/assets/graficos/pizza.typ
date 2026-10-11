// assets/graficos/pizza.typ — Gráfico de pizza (cetz-plot).

#import "@preview/cetz:0.4.2": canvas
#import "@preview/cetz-plot:0.1.3": chart

#let pizza = canvas({
  chart.piechart(
    (
      (label: "Python", value: 40),
      (label: "JavaScript", value: 35),
      (label: "Java", value: 15),
      (label: "Outros", value: 10),
    ),
    value-key: "value",
    label-key: "label",
    radius: 2
  )
})