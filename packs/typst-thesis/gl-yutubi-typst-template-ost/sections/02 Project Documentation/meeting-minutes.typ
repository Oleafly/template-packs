#let main_doc = [
  == Sitzungsprotokolle

  #include "../../protocols/protocols.typ"
]

#let protocols_doc = [
  #import "../../lib/lib.typ": *

  #show: article

  #context { counter(page).update(1) }
  #set page(
    header: context [
      #text(
        meta.title
          + " | "
          + context languages.at(curlang.get()).protocol + " | " + authors-text,
      )
    ],
    footer: context [
      #table(
        columns: (1fr, auto, 1fr),
        stroke: none,
        inset: 0mm,
        [],
        [
          #counter(page).display(
            "1",
            both: false,
          )
        ],
        [],
      )
    ],
  )

  #title-without-numbering(title: meta.title)

  In diesem Dokument sind sämtliche Protokolle des Projekts aufgelistet.

  #title-without-numbering(depth: 2, title: context languages
    .at(curlang.get())
    .protocol)

  #include "../../protocols/protocols.typ"
]
