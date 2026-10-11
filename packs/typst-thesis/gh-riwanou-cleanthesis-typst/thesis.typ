// The thesis skeleton: metadata, then the pieces in reading order.
// All styling lives in cleanthesis.typ; chapters live in content/.
//
//   just build      (plain `typst compile` misses --font-path fonts)

#import "cleanthesis.typ": *


// --- Metadata ---------------------------------------------------------------

#let meta = (
  title:  "Mécanisme et politique dans le noyau : ordonnancement et gestion mémoire",
  author: "Prénom Nom",

  logos: ("gfx/sorbonne.pdf", "gfx/LogoLIP6.pdf"),
  degree:          "DOCTEUR de SORBONNE UNIVERSITÉ",
  speciality:      "Ingénierie / Systèmes Informatiques",
  doctoral-school: "Informatique, Télécommunication et Électronique Paris (ED130)",
  defense-date:    "1 janvier 2030",
  dedication:      "À qui de droit",
  license:         "https://creativecommons.org/licenses/by-nc-nd/4.0/",
  // order: Rapporteur, Examinateur, Invité, Directeur
  jury: (
    (first: "Prénom", last: "Nom", position: "Poste",
     affiliation: "Université", role: "Rapporteur"),
    (first: "Prénom", last: "Nom", position: "Poste",
     affiliation: "Université", role: "Rapporteur"),
    (first: "Prénom", last: "Nom", position: "Poste",
     affiliation: "Université", role: "Examinateur"),
    (first: "Prénom", last: "Nom", position: "Poste",
     affiliation: "Université", role: "Examinatrice"),
    (first: "Prénom", last: "Nom", position: "Poste",
     affiliation: "Entreprise", role: "Invité"),
    (first: "Prénom", last: "Nom", position: "Poste",
     affiliation: "Université", role: "Directeur de thèse"),
  ),
)

#show: cleanthesis.with(title: meta.title, author: meta.author)


// --- Front matter -----------------------------------------------------------

#set page(numbering: "i")
#pagestyle("empty")
#jury-page(meta)
#copyright-page(meta)
#cleardoublepage()

#pagestyle("plain")

#include "content/abstract-en.typ"
#cleardoublepage()

#include "content/abstract-fr.typ"
#cleardoublepage()

#toc()
#cleardoublepage()


// --- Body -------------------------------------------------------------------

#set page(numbering: "1")
#counter(page).update(1)
#pagestyle("scrheadings")

#include "content/introduction.typ"

#part[Fondations] <part:fondations>
#include "content/background.typ"

#part[Contributions] <part:contributions>
#include "content/design.typ"
#include "content/evaluation.typ"

#include "content/conclusion.typ"


// --- Back matter ------------------------------------------------------------

#thesis-bibliography("bib/main.bib", web: "bib/web.bib")
#cleardoublepage()

#glossary-list()
#cleardoublepage()

#list-of-figures()
#cleardoublepage()

#list-of-tables()
#cleardoublepage()

#list-of-listings()
#cleardoublepage()

#appendix()
#include "content/appendix.typ"
