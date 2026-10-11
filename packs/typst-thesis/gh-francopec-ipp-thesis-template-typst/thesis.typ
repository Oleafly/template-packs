// File: thesis.typ
// Author: Franco Cordeiro
// Description: Contains the thesis template. This template is based on the Latex template provided by IPP for the cover pages and defines a style for the main text.
//
// IPP guidelines:
//
// https://jct.telecom-paris.fr/templates/
//
// Imports dependencies and macros
#import "definitions.typ": *

// Metadata
#let title = [PhD Thesis]
#let french-title = [Thèse de Doctorat]
#let author = "Author"
#let institute = [Institut]
#let specialization = [Spécialité]
#let city = [Ville]
#let zip = 91120
#let date = [2 janvier 2026]

#set document(title: title, author: author)
#set text(lang: "en", size: 12pt)

// Cover page
#[
  #set page(margin: 0pt)
  #set text(font: "Aileron")
  #let cover-fill = rgb(0%, 0%, 0%)
  #grid(
    columns: (31%, 4%, 60%, 5%),
    block({
      image(height: 100%, "figures/bande.png")
      place(
        center + top,
        dx: 13%,
        dy: 37%,
        rotate(270deg, origin: left)[
          #set text(fill: white, size: 15pt)
          *NNT : 20XXIPPAXXXX*
        ],
      )
    }),
    [],
    [
      #align(right + top)[
        #linebreak()
        #grid(
          columns: (75%, 25%),
          align: right + top,
          [], image("figures/etab/TP.png", width: 100%),
        )
        #text(fill: cover-fill, size: 24pt, title)

        #text(
          fill: black,
          size: 10pt,
          [
            #[
              #set par(spacing: .5em)
              Thèse de doctorat de l’Institut Polytechnique de Paris

              préparée à #institute
            ]
            #par(spacing: 1em)[]
            #[#set par(spacing: .5em)
              École doctorale n°626 École Doctorale de l’Institut Polytechnique de Paris (ED IP Paris)

              #set text(size: 9pt)
              Spécialité de doctorat : #specialization
            ]
            #par(spacing: 1em)[]
            #set text(size: 8pt)
            Thèse présentée et soutenue à #city, le #date, par],
        )

        #text(weight: "bold", size: 20pt, author)
      ]
      #align(left)[
        #set text(size: 9pt)
        Composition du Jury:

        #linebreak()

        #let member(name, assoc, role) = grid(
          align: bottom,
          columns: (74%, 27%),
          [
            #set par(spacing: 5pt)
            #text(size: 9pt)[#name.text.split(regex(" ")).at(0) #upper(name.text.split(regex(" ")).at(1))]

            #assoc
          ],
          [
            #align(left, text(size: 9pt, role))
          ],
        )

        #member(
          [Name LastName],
          [Status, Establishment (Research facility)],
          [Président],
        )

        #member(
          [Name LastName],
          [Status, Establishment (Research facility)],
          [Rapporteur],
        )

        #member(
          [Name LastName],
          [Status, Establishment (Research facility)],
          [Examinateur],
        )

        #member(
          [Name LastName],
          [Status, Establishment (Research facility)],
          [Directeur de thèse],
        )

        #member(
          [Name LastName],
          [Status, Establishment (Research facility)],
          [Co-directeur de thèse],
        )

        #member(
          [Name LastName],
          [Status, Establishment (Research facility)],
          [Invité],
        )

        #rect(fill: white, height: 15pt, width: 100%)
      ]
    ],
  )
]

#pagebreak()

// Prelude sections
#[
  // Prelude sections style
  #set par(justify: true)
  #set page(paper: "a4", margin: (x: 3.7cm, y: 4.7cm), numbering: none)

  #show heading: it => {
    align(center, text(weight: "bold", size: 18pt, it))
  }

  = Acknowledgements

  #pagebreak()
  = Résumé

  #pagebreak()
  = Abstract <sec:abstract>

]

// Main document style
#set page(paper: "a4", margin: (x: 2.5cm, y: 3cm), numbering: "1/1")
#set par(justify: true)

#show heading.where(level: 1): it => {
  pagebreak()
  text(size: 30pt, it)

  context {
    set text(size: 12pt, weight: "regular")
    show outline: it => {
      if query(it.target) != () {
        linebreak()
        line(start: (0%, 0%), end: (100%, 0%))
        set par(spacing: 0pt)
        text(size: 20pt, weight: "bold")[Table of Contents]
        linebreak()
        linebreak()
        it
        line(start: (0%, 0%), end: (100%, 0%))
      }
    }
    let chapter-num = counter(heading).at(here()).at(0)

    linebreak()
    outline(
      title: none,
      target: heading
        .where(numbering: "1.")
        .and(heading.where(level: 2).or(heading.where(level: 3)))
        .after(it.location())
        .before(heading.where(level: 1).and(heading.where(numbering: "1.")).after(inclusive: false, it.location())),
    )
  }
}
#show heading.where(level: 2): it => {
  text(size: 20pt, it)
}
#show heading.where(level: 3): it => {
  text(size: 16pt, it)
}
#show outline.entry.where(level: 1): it => {
  text(weight: "bold", it)
}

#show: show-theorion
#set-inherited-levels(0)
#set-theorion-numbering("1")

#set figure(placement: auto)
#set figure.caption(position: top)

#set heading(numbering: "1.")

// Table of contents
#outline(target: heading.where().after(inclusive: false, <sec:abstract>))

// Main document
#include "chapters/introduction.typ"
#include "chapters/chapter-one.typ"

// Bibliography can use any style
#set heading(numbering: none)
#bibliography(style: "ieee", "Bibliography.bib")

#pagebreak()

// Back cover style
#set page(margin: (x: 10mm, top: 3mm, bottom: 11mm), numbering: none)
#set text(size: 10pt, font: "Aileron")

// Back cover contents
#align(top + left, image("figures/ed-ipp.png", height: 24mm))
#grid(
  columns: (4%, 92%, 4%),
  [],
  [
    #set par(leading: 0.4em, spacing: 1.75em)
    #box(width: 100%, stroke: black, inset: .4em)[
      #set par(leading: 0.4em, spacing: 0.9em)
      *Titre :* #upper(french-title)

      *Mots clés :* Un; Deux; Trois


      #block(
        height: 31%,
        columns(2, gutter: 10pt)[
          #set par(spacing: 0.4em)
          *Résumé :*
        ],
      )
    ]

    #box(width: 100%, stroke: black, inset: .4em)[
      #set par(leading: 0.4em, spacing: 0.9em)
      *Title :* #upper(title)

      *Keywords :* One; Two; Three

      #block(
        height: 27%,
        columns(2, gutter: 10pt)[
          #set par(spacing: 0.4em)
          *Abstract :*],
      )
    ]],
  [],

  [],
)

// Back cover foot
#align(
  bottom,
  grid(
    columns: (50%, 50%),
    [
      #set align(left)
      #set par(spacing: .4em)
      *Institut Polytechnique de Paris*

      #zip #city, France

      #linebreak()
      #linebreak()
    ],
    [
      #align(right, image(width: 20mm, "figures/ipparis-logo.png"))
    ],
  ),
)
