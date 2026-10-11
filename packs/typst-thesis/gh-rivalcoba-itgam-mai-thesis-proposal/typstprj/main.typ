#import "data.typ": thesis
#import "styles.typ": document-style
#import "cover.typ": cover

// Aplicar la configuración general a todo el documento.
#show: body => document-style(thesis, body)

// Portada.
#cover(thesis)

// Reiniciar la numeración después de la portada.
#counter(page).update(1)

// Índice.
#include "sections/00-indice.typ"
#pagebreak()
// Contenido académico.
#include "sections/01-resumen.typ"
#include "sections/02-planteamiento.typ"
#include "sections/03-objetivos.typ"
#include "sections/04-estado-arte.typ"
#include "sections/05-metodologia.typ"
#include "sections/06-plan-trabajo.typ"
#include "sections/07-resultados.typ"
#include "sections/08-recursos.typ"
// Referencias bibliográficas.
#include "sections/09-referencias.typ"
// Anexos.
#include "sections/10-anexos.typ"
