// assets/diagramas/arquitetura.typ — Diagrama da arquitetura (cetz).

#import "@preview/cetz:0.4.2"
#import "@preview/cetz:0.4.2": canvas
#import cetz.draw: *

#let arquitetura = canvas({
  import cetz.draw: *
  rect((-2.5, 0), (0, 1.5), name: "cliente")
  content("cliente", [Cliente Web])
  rect((1, 0), (3.5, 1.5), name: "api")
  content("api", [API Gateway])
  rect((4.5, -1.5), (7, 0), name: "auth")
  content("auth", [Serviço de \ Auth])
  rect((4.5, 1), (7, 2.5), name: "pedidos")
  content("pedidos", [Serviço de \ Pedidos])
  line("cliente.east", "api.west", mark: (end: ">"))
  line("api.east", "auth.west", mark: (end: ">"))
  line("api.east", "pedidos.west", mark: (end: ">"))
})
//#arquitetura