#let titulo-da-pagina(it, titulo: none) = {
  {
    set text(weight: "bold")
    align(center)[#text(size: 2em, titulo)]
  }
  it
}
