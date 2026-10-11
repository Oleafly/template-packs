#import "boxes.typ": *
#import "layout.typ": *
#import "num.typ": *
#import "macros.typ": *
#set text(lang: "en")
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

\
\
\
#align(center)[
    #text(size: 25pt, weight: "semibold")[
        Titel]

    \
    \
    #set text(size: 18pt)
    von

    Ester Cleusters

    \
    \
    \
    \
    \
    Masterarbeit in Mathematik
    \
    \
    \
    \
    vorgelegt der\
    Fakultät für Mathematik, Informatik und Naturwissenschaften\
    der Rheinisch-Westfälischen Technischen Hochschule Aachen

    \
    im März 2026

    \
    angefertigt am Lehrstuhl für Algebra und Darstellungstheorie\
]

#pagebreak()


#show: doc => layout_config(doc, alternating_layout: true, author: "Ester Cleusters", title: "Master thesis")

#let todo = text("todo")

//for 2-periodic complexes in diagrams
#let fromto(toplabel, bottomlabel) = (
    edge(vertices: (auto, auto), toplabel, shift: 3pt, marks: "->")
        + edge(vertices: (auto, auto), bottomlabel, shift: -3pt, label-side: right, marks: "<-")
)

#show: doc => box-env(doc, global_numbering: true)
#show: body => {
    for elem in body.children {
        if elem.func() == math.equation and elem.block {
            let numbering = if "label" in elem.fields().keys() { "(1)" } else { none }
            set math.equation(numbering: numbering)
            elem
        } /*else if {
              for subelem in elem.children {
                if subelem.func() == math.equation and subelem.block {
                  let numbering = if "label" in subelem.fields().keys() { "(1)" } else { none }
                  set math.equation(numbering: numbering)
                  subelem
                } else {
                  subelem
                }
            }
          }*/ else { elem }
    }
}

#show ref: it => {
  let el = it.element
  if el != none and el.func() != heading {
    link(el.location(), el.supplement)
  } else {
    it
  }
}

#set math.frac(style: "horizontal")
#set heading(numbering: "1.1")

#set page(numbering: "I")
#outline()
#pagebreak()

#counter(page).update(1)
#set page(numbering: "1")

#let lt = math.op("lt")
#let ft = math.op("ft")
#let nil = math.op("nil")
#let hom = math.op("Hom")
#let Ob = math.op("Ob")

= Introduction
See @chapter_ref for details.
#pagebreak()

= Chapter <chapter_ref>

#def(cite(<gorskydiss>))[
    An *example definition* is a definition where all expected relations hold.
]

#prop(none, lable: "proposition")[
    This is well-defined.
]
#proof[@proposition][ @proposition
    Left as an exercise.
]
#pagebreak()

#bibliography("bib.bib", full: false, style: "din-alphanumeric.csl")
