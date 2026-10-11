#import "lib/acronym.typ": init-acronyms, print-acronyms
#import "acronyms.typ": acronyms

// Fix some random linter error
#set heading()

#import "template.typ": *

#show: template

/////////////////
//    INIT     //
/////////////////

#bib_state.update(none)
#init-acronyms(acronyms)

/////////////////
// FRONT PAGES //
/////////////////
#include "pages/titlepage.typ"

#set page(numbering: "I", number-align: numbering-alignment)
#counter(page).update(1)

#include "pages/intro.typ"

// Outline //
#context {
  heading("Inhaltsverzeichnis", supplement: none, outlined: false)
  show outline.entry.where(level: 1): it => {
    v(2em, weak: true)
    strong(it, delta: 200)
  }
  outline(title: none, indent: auto, depth: 3)
}

// Verzeichnisse //
#pagebreak()

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
  let tables = query(figure.where(kind: raw))

  if (tables.len() > 0) {
    heading(
      "Quellcodeverzeichnis",
      supplement: none,
    )
    outline(
      title: none,
      target: figure.where(kind: raw),
    )
    pagebreak(weak: true)
  }
}

#context {
  heading("Abkürzungsverzeichnis", supplement: none)
  print-acronyms(4em)
  pagebreak(weak: true)
}

/////////////////
//   CONTENT   //
/////////////////

#set page(numbering: "1")
#counter(page).update(1)

#context {
  set heading(numbering: "1.1", supplement: [Kapitel])

  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    it
  }

  include "pages/content.typ"

  pagebreak(weak: true)
}

/////////////////
//  APPENDIX   //
/////////////////

// Anhang //
#context {
  counter(heading).update(0)
  set heading(numbering: "A", supplement: [Anhang])
  show heading.where(level: 1): it => {
    pagebreak() // Ensure each main section starts on a new page
    v(2em, weak: true)
    [#it.supplement #counter(heading).display(it.numbering)]
    linebreak()
    it.body
  }

  include "pages/appendix.typ"

  pagebreak(weak: true)
}

// #context {
//   heading(
//     "Hilfsmittelverzeichnis",
//     supplement: none,
//   ) // List of Tools and Resources
//   include "pages/tools-and-resources.typ"
//   pagebreak(weak: true)
// }

#context {
  heading("Literaturverzeichnis", supplement: none)
  bibliography(
    "literature.bib",
    title: none,
    // style: "ctr12_apa_custom.csl",
  )
  pagebreak(weak: true)
}

// Decl. of authorship
#pagebreak()
#set page(footer: {})
#include "pages/declaration-of-authorship.typ"
