#import "/lib.typ": *
#import "/utils.typ": *


#show: conf.with(
  degree: [
    Máster Universitario en Formación del Profesorado de Educación Secundaria
    Obligatoria, Bachillerato, Formación Profesional y Enseñanza de Idiomas
  ],
  subject: "Subject",
  year: (25, 26),
  semester: 2,
  project: "Actividad Evaluable 1",
  title: "La mejor memoria de la historia",
  group: 89,
  bibliography-content: bibliography("bib.bib", style: "apa"),
  // appendixes: include "apendixes.typ",
  authors: (
    (
      name: "Luis Daniel",
      surname: "Casais Mezquida",
    ),
  ),
  // team: "Los chungitos",
  professor: "Perico de los Palotes",
  toc: false,
  chapter-on-new-page: false
)


