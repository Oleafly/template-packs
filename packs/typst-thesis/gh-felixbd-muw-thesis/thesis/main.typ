#import "@preview/bookly:2.0.0": *

#import "./custom-theme.typ": custom as custom-theme, part as custom-part, minitoc as custom-minitoc

#import "./preamble.typ" as preamble
#include "./preamble.typ"

#import "preamble.typ": *
// #show: document => my-config(document)
#show: doc => my-config(doc)

#let config-colors = (
  primary: preamble.dunkelblau,
  secondary: rgb("#dddddd").darken(15%)
)

#let muw-logo(..args) = image("./images/logo/MedUni-Wien.svg", ..args)

#show: bookly.with(
  author: "Author Name",
  theme: classic,  // classic fancy modern orly pretty (custom-theme)
  // tufte: true,
  lang: "en",
  colors: config-colors,
  logo: muw-logo(),  
  
  // title-page: book-title-page(
  //   series: "Typst book series",
  //   institution: "Typst community",
  //   logo: image("images/typst-logo.svg"),
  //   cover: image("images/book-cover.jpg", width: 45%)
  // )

  title-page: include "cover.typ",

)

#show: doc => my-config(
  is-draft: false,
  doc
)

#show: front-matter

#include "front_matter/front_main.typ"

#tableofcontents

= Glossary

// Split in
// Acronyms / abbreviations
// and Mathematical symbols / notation

#import "@preview/glossarium:0.5.10": *
#show: make-glossary

#let glossary = (
  (
    key: "cnn",
    short: "CNN",
    long: "Convolutional Neural Network",
    description: "Deep learning architecture for image tasks",
    group: "Abbreviations",
  ),
  (
    key: "mu",
    short: $mu$,
    description: "Population mean",
    group: "Symbols",
  ),
)

#register-glossary(glossary)

// TODO: add groups as headings -> include in toc
#print-glossary(glossary, show-all: true)


#show: main-matter


#custom-part("First part")

#include "chapters/ch_main.typ"

#custom-part("Second part")

#show: appendix

// TODO:
// #set-theorion-numbering("A.1")

#custom-part("Appendix", show-number: false)

#include "appendix/app_main.typ"

= some math

#figure(
  $ tau  $,
  kind: math.equation,
  caption: [hello]
) <eq:fufufufuf>

- - -

#math.equation(
  alt: "a squared plus b squared equals c squared",
  block: true,
  $ a^2 + b^2 = c^2   tau $,
)

- - - -

#[

  #import "@preview/equate:0.3.2": equate

  #show: equate.with(breakable: true, sub-numbering: true)
  #set math.equation(numbering: "(1.1)")


  #math.equation(
    alt: "a squared plus b squared equals c squared",
    block: true,
    $ a^2 + b^2 = c^2 \ tau $,
  ) <eq:heeeeelo>

  $ a^2 + b^2 = c^2 \ tau $ <eq:abc>

]

- - - -

$ a^2 + b^2 = c^2 \ tau $


= code

#figure(
  kind: raw,
  caption: [python foo pass]
)[
```py
def foo(n: int) -> None:
  pass
```
]



#listoffigures

#listoftables

#outline(
  title: [List of listings],
  target: figure.where(kind: raw),
  // indent: 10%, depth: 1,
)


#outline(
  title: [List of theorems],
  target: figure.where(kind: "thm-group")
)


#{
  show outline.entry: it => if it.prefix().fields().children.last().text.trim().len() > 0 [
    #link(it.element.location())[
      #it.prefix()
      #context smallcaps(str(
        it.element.at(
          "label",
          default: "")
        ).replace("eq:", "")
      )
      #it.element.alt
      #box(width: 1fr, it.fill)
      #it.page() \
    ]
  ] else [ ] 
  
  outline(
    title: [List of equations],
    target: math.equation  // .where(block: true),
  )
}

/*
  TODO:
  - https://github.com/typst/typst/pull/7277
  - https://github.com/typst/typst/issues/1097
*/
// #bibliography("bibliography/sample.yml")
#bibliography("bibliography/sample.bib")




#back-cover(
  abstracts: (
    (title: [Abstracts], text: lorem(100)),
    (title: [#set text(lang: "de"); Zusammenfassung], text: lorem(100)),
  ),
  logo: (
    align(left)[#muw-logo(width: 70%)],
    align(right)[#image("images/typst-logo.svg", width: 50%)]
  )
)
