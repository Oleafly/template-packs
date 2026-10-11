#import "../utils/mod.typ":*

#let note(
  title: "",
  subtitle: "",
  author: "",
  abstract: none,
  accent: dvdcolors.at(6),
  body,
) = {
  show:show-utils
  
  set document(title: title)

  set page(
    numbering: "1",
    number-align: center,
    header: context {
      if here().page() == 1 {
        return
      }
      box(stroke: (bottom: 0.7pt+luma(230)), inset: 0.4em)[#text(font: en-font-sans)[#author #h(1fr)#title]]
    },
  )

  set heading(numbering: "1.")
  show heading: it => {
    set text(font: en-font-sans)
    set par(first-line-indent: 0em)

    if it.numbering != none {
      text(accent, weight: 500)[#sym.section]

      text(accent)[#counter(heading).display() ]
    }
    it.body
  }

  // Title row.
  align(center)[
    #set text(font: en-font-sans)
    #block(text(weight: 700, 25pt, title))
    #v(0.4em, weak: true)
    #if subtitle != none [#text(18pt, weight: 500)[#subtitle]]
    #v(0.3em, weak: true)
    #if author != none [#text(14pt)[by #author]]

  ]

  if abstract != none [#align(center)[#abstract]]

  set outline(indent: 1em)

  show outline: set heading(numbering: none)
  show outline: set par(first-line-indent: 0em)

  show outline.entry.where(level: 1): it => {
    text(font: en-font-sans, accent)[#strong[#it]]
  }
  show outline.entry: set text(font:en-font-sans, fill: dvdcolors.at(9))

  // Main body.
  set par(
    justify: true
  )

  body
}

