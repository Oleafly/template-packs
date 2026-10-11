#include "chapters/abstract.typ"
// ? main outline header settings: align to center and make it bigger
// make top level entries bold
#show outline: set text(size: 14pt)
#show outline.entry.where(level: 1): set text(weight: "bold")
// do not include appendices to main outline
#outline(target: selector(heading).before(<fst_appendix>, inclusive: false))

// ? outline for appendices
#set outline.entry(fill: none)
#outline(target: selector(heading).after(<fst_appendix>, inclusive: true), title: [Приложения])

#pagebreak()

// setup figure enumeration
#set figure(supplement: none)
#show figure: set place(clearance: 1cm)
#show figure: set block(spacing: 1cm)
// place listings and tables caption on top
#show figure: f => {
  if f.kind == table or f.kind == raw {
    set figure.caption(position: top)
    set align(left)
    set par(first-line-indent: (amount: 0pt, all: true))
    f
  } else {
    f
  }
}
#show figure.caption: it => context {
  // setup caption structure
  let custom-prefix = if it.kind == image {
    [Рисунок]
  } else if it.kind == table {
    [Таблица]
  } else if it.kind == raw {
    [Листинг]
  } else { [] }
  [
    #custom-prefix
    #it.counter.display(it.numbering)
    --
    #it.body
  ]
}
#set ref(supplement: it => {
  if it.func() == figure {
    if it.kind == image {
      "рис."
    } else if it.kind == table {
      "табл."
    } else {
      "лист."
    }
  } else if it.func() == heading {
    "разд."
  } else {
    ""
  }
})

// ? main content
#include "chapters/introduction.typ"
#include "chapters/chapter1.typ"
#include "chapters/chapter2.typ"
#include "chapters/chapter3.typ"
#include "chapters/chapter4.typ"
#include "chapters/conclusion.typ"

// ? insert bibliography
#show link: underline
#bibliography(
  "chapters/biblio.bib",
  title: [Список литературы],
  style: "chapters/gost-r-7-0-5-2008-numeric.csl",
  full: false,
)

#pagebreak()

// ? start of appendix section
#counter(heading).update(0)
#set heading(numbering: "A.1.", supplement: [Приложение])
#show figure: set block(breakable: true)
#include "appendices/appendix1.typ"
