#import "lib/acronym-lib.typ": init-acronyms, print-acronyms,
#import "lib/glossary-lib.typ": init-glossary, print-glossary

#import "pages/acronyms.typ": acronyms
#import "pages/glossary.typ": glossary
#import "template.typ": *

#show: template

//
// Init
//

#bib_state.update(none)

#init-acronyms(acronyms)
#init-glossary(glossary)

//
// Front pages
//

#include "pages/titlepage.typ"

#set page(numbering: "I", number-align: numbering-alignment)
#counter(page).update(1)

#include "pages/reading-information.typ"
#include "pages/declaration-of-authorship.typ"
#include "pages/abstract.typ"

// Outline
#context {
  heading("Inhaltsverzeichnis", supplement: none, outlined: false)
  show outline.entry.where(level: 1): it => {
    v(1.2em, weak: true)
    strong(it, delta: 200)
  }
  outline(title: none, indent: auto, depth: 3)
}

//
// Content
//

#set page(numbering: "1")
#counter(page).update(1)

#context {
  set heading(numbering: "1.1", supplement: [Kapitel])

  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    it
  }

  include "pages/chapters.typ"

  pagebreak(weak: true)
}

//
// Anhang
//

#context {
  counter(heading).update(0)
  set heading(numbering: "A", supplement: [Anhang])
  show heading.where(level: 1): it => {
    v(2em, weak: true)
    [#it.supplement #counter(heading).display(it.numbering)]
    linebreak()
    it.body
  }

  include "pages/appendix.typ"
  pagebreak(weak: true)
}

//
// Verzeichnisse
//

#context {
  heading("Abkürzungsverzeichnis", supplement: none)
  print-acronyms(2em)
  pagebreak(weak: true)
}

#context {
  heading("Glossar", supplement: none)
  print-glossary(2em)
  pagebreak(weak: true)
}

#context {
  let images = query(figure.where(kind: image))

  if (images.len() > 0) {
    heading("Abbildungsverzeichnis", supplement: none)
    outline(
      title: none,
      target: figure.where(kind: image),
    )
    pagebreak(weak: true)
  }
}

#context {
  let tables = query(figure.where(kind: table))

  if (tables.len() > 0) {
    heading("Tabellenverzeichnis", supplement: none)
    outline(
      title: none,
      target: figure.where(kind: table),
    )
    pagebreak(weak: true)
  }
}

#context {
  let tables = query(figure.where(kind: table))

  if (tables.len() > 0) {
    heading("Quellcodeverzeichnis", supplement: none)
    outline(
      title: none,
      target: figure.where(kind: raw),
    )
    pagebreak(weak: true)
  }
}

#context {
  heading("Hilfsmittelverzeichnis", supplement: none) // List of Tools and Resources
  include "pages/tools-and-resources.typ"
  pagebreak(weak: true)
}

#context {
  heading("Literatur", supplement: none)
  bibliography("sources.bib", title: none)
  pagebreak(weak: true)
}
