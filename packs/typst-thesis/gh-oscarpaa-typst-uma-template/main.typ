#import "template.typ": *

#show: project

#set page(numbering: "I")
#counter(page).update(1)

#include "01-ini/portada.typ"
#include "01-ini/resumen.typ"
#include "01-ini/abstract.typ"

#include "01-ini/dedicatoria.typ"
#include "01-ini/agradecimiento.typ"

#include "01-ini/acronimos.typ"

#show: index_style
#include "02-toc/tableofcontent.typ"
#include "02-toc/tableoffigures.typ"
#include "02-toc/tableoftables.typ"

#set page(numbering: "1")
#counter(page).update(1)

#include "03-cap/capitulo1.typ"
#include "03-cap/capitulo2.typ"

#show: appendices
#include "04-ape/apendiceA.typ"

#include "05-bib/bibliografia.typ"
