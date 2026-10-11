#import "template.typ": unsa-report

#show: unsa-report.with(
  course_name: "Nombre del Curso",
  lab_title: "Práctica 01",
  lab_number: "01",
  instructor_name: "Nombre del Docente",
  members: (
    "Nombre del Estudiante",
  ),
)

#include "sections/1-solucion-resultados.typ"
#v(0.8em)
#include "sections/2-retroalimentacion.typ"
#v(0.8em)
#include "sections/3-referencias.typ"