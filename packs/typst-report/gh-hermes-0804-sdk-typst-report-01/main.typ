// Imports
#import "lib.typ": *

// Template configuration
#show: report.with(
  project: (
    title: "Edificio La Familia",
    document: "Memoria Descriptiva",
    code: "250511-00-MD-001",
    discipline: "Instalaciones Sanitarias",
    specialist: "L. Torvalds",
    manager: "Sundekant",
    client: "Empresa S.A.C.",
    company: "Empresa Diseño",
    revision: "RevC",
    date: "01/03/2023",
  ),
  revisions: (
    (
      // Number of the revision
      one: "RevA",
      two: "RevB",
      three: "RevC",
    ),
    (
      //Person who elaborated the document
      one: "S. Woz",
      two: "S. Woz",
      three: "S. Woz",
    ),
    (
      // Reason ofr issuing the document
      one: "Emitido para revisión interna",
      two: "Emitido para aprobación del cliente",
      three: "Emitido para aprobación del cliente",
    ),
    (
      // Date of issuing the document
      one: "01/01/2023",
      two: "01/02/2023",
      three: "01/03/2023",
    ),
    (
      // Person who reviewed the document
      one: "S. Jobs",
      two: "S. Jobs",
      three: "S. Jobs",
    ),
    (
      // Person who aproved the document
      one: "B. Gates",
      two: "B. Gates",
      three: "B. Gates",
    ),
  ),
)

// INDEX
#outline()
#pagebreak()  

// TABLE INDEX
#outline(
  title: [Índice de Tablas],
  target: figure.where(kind: table),
)
#pagebreak()  

// IMAGEN INDEX
#outline(
  title: [Índice de Figuras],
  target: figure.where(kind: image)
)
#pagebreak()


// Document body

#align(center, text(24pt)[#smallcaps("Memoria Descriptiva")])

// Chapters

#include "body/Chapter 1.typ"

#include "body/Chapter 2.typ"


