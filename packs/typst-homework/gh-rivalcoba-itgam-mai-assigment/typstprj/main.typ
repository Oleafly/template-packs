#import "data.typ": report
#import "styles.typ": document-style
#import "cover.typ": cover

// Configuración general del documento.
#show: body => document-style(report, body)

// Portada institucional.
#cover(report)

// El cuerpo comienza en una página nueva y reinicia su numeración.
#pagebreak()
#counter(page).update(1)

// Resumen e índice.
#include "sections/00-resumen.typ"
#pagebreak()

#outline(
  title: [Contenido],
  depth: 3,
  indent: 8mm,
)
#pagebreak()

// Estructura IMRAD.
#include "sections/01-introduccion.typ"
#include "sections/02-metodos.typ"
#include "sections/03-resultados.typ"
#include "sections/04-discusion.typ"
#include "sections/05-conclusiones.typ"

// Bibliografía.
#pagebreak()
#bibliography(
  "referencias.bib",
  title: [Referencias],
  style: "ieee",
)

// Material complementario.
#include "sections/06-anexos.typ"