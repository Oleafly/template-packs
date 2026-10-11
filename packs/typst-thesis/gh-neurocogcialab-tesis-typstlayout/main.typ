// Documento principal

#import "typst/template/template.typ": *
#import "typst/meta.typ": meta

#show: template.with(
  titulo: meta.titulo,
  autor: meta.autor,
  fecha: meta.fecha,
)

// Contenido - los usuarios editan estos archivos
#include "contenido/01-introduccion.typ"
#include "contenido/02-metodos.typ"
#include "contenido/03-resultados.typ"
#include "contenido/04-discusion.typ"

// Descomentar cuando exista el archivo de bibliografía
// #bibliography("bibliografia/referencias.bib")
