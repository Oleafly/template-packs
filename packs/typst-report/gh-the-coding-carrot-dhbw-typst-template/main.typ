#import "config.typ": *
#import "util.typ": *

#set document(title: titel)
#set text(lang: language)
#set par(justify: true)

#include "cover.typ"

#set page(
  margin: (top: 4cm),
  numbering: "1",
  header: grid(
    columns: 2, 
    rows: 2, 
    pad(bottom: 1em)[
    #header_heading
  ], 
  grid.cell(
    align: horizon + right, 
    pad(image("images/DHBW-Logo.svg", width: 12em), 
    bottom: 1em)
    ), 
    grid.cell(
      colspan: 2, 
      [#line(length: 100%)]
    )
  )
)
#show heading: it => {
  set block(below: 1em)
  it
  active_heading.update(it.body)
  }

#show raw: set block(fill: rgb(245, 245, 245), inset: 1em, width: 100%)
#show raw.where(block: false): box.with(fill: luma(240), inset:(x: 0.4em), outset: (y: 0.3em), radius: 2pt)

#show ref.where(form: "normal"): set ref(supplement: x => {
  if x.func() == heading and language == "de" [Kapitel] 
  else if x.func() == heading and language == "en" [Chapter]
  else {x.supplement}
})

#set bibliography(title: [Literaturverzeichnis]) if language == "de"

#counter(page).update(1)

#if show_abstract == true {
  include "content/abstract.typ"
}
#pagebreak()

#set heading(
  numbering: "1."
)
#{
  set footnote.entry(separator: none)
  show footnote.entry: none
  show ref: it => {if show_ref_in_outline == false {none} else {it}}
  show footnote: none

  if language == "de" {
    outline()
    pagebreak()
    if show_figure_outline == true {
      outline(target: figure.where(kind: image), title: "Abbildungsverzeichnis")
      pagebreak()
    }
  } else {
    outline()
    pagebreak()
    if show_figure_outline == true {
      outline(target: figure.where(kind: image), title: "Figures")
      pagebreak()
    }
  }

  counter(footnote).update(0)
}


#include "content/content.typ"

#if show_bibliography == true {
  pagebreak()
  bibliography("bibliography.bib")
}
