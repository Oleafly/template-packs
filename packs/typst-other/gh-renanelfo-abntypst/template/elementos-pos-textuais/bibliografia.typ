#import "/template/funcoes-auxiliares/titulo-da-pagina.typ": titulo-da-pagina
#import "/parameters.typ" as parameters

#pagebreak()
#show bibliography: it => {
  show heading: h => none
  show: titulo-da-pagina.with(titulo: it.title)
  it
}
#bibliography(
  "referencias.bib",
  title: [Referências],
  style: if parameters.referencias-numericas {
    "referencias-numericas.csl"
  } else {
    "referencias.csl"
  },
)
