#import "/layout/thesis_template.typ": *
#import "/metadata.typ": *

#set document(title: titulo, author: nombreAlumno)

#show: thesis.with(
  titulo: titulo,
  ciudad: ciudad,
  nombreAlumno: nombreAlumno,
  nombreProfesor: nombreProfesor,
  nombreCorreferente: nombreCorreferente,
  mesExamen: mesExamen,
  anioExamen: anioExamen,
  dedicatoria: include "/content/dedicatoria.typ",
  agradecimientos: include "/content/acknowledgement.typ",
  resumen: include "/content/resumen.typ",
  resumenIngles: include "/content/abstract_en.typ",
  palabrasClave: "Cinco es el máximo de palabras clave para describir los temas tratados en la memoria, ponerlas separadas por punto y comas.",
  palabrasClaveIngles: "Corresponde a la traducción al idioma inglés de Palabras Clave anteriores.",
  glosario: include "/content/glosario.typ",
)

#include "/content/introduction.typ"
#include "/content/definicion_problema.typ"
#include "/content/marco_conceptual.typ"
#include "/content/solucion_propuesta.typ"
#include "/content/validacion.typ"
#include "/content/conclusiones.typ"
#include "/content/anexos.typ"
