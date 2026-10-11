#import "template/fcen.typ": informe-labo

#import "secciones/caratula.typ": caratula

#import "config/metadata.typ": *

#caratula(
  universidad: universidad,
  facultad: facultad,
  titulo: titulo,
  tipo_de_documento: tipo_de_documento,
  laboratorio: laboratorio,
  autor: autor,
  director: director,
  codirector: co_director,
)

#show: informe-labo.with()

#include "secciones/00_resumen.typ"
#include "secciones/01_introduccion.typ"

#include "secciones/02_desarrollo_experimental.typ"

#include "secciones/03_resultados.typ"

#include "secciones/04_conclusiones.typ"


#bibliography("secciones/bibliografia.bib", title: "Bibliografía", full: true, style: "apa")




