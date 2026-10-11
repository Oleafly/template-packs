#import "/layout/titlepage.typ": *
#import "/layout/disclaimer.typ": *
#import "/layout/acknowledgement.typ": acknowledgement as acknowledgement_layout
#import "/layout/abstract.typ": *
#import "/utils/print_page_break.typ": *
#import "/layout/fonts.typ": *
#import "@preview/glossarium:0.5.4": make-glossary, register-glossary, print-glossary, gls, glspl
#import "@preview/acrostiche:0.5.1": *
#import "@preview/abbr:0.2.3"
#import "/layout/billOfMaterials.typ":*


#let thesis(
  titleGerman: "",
  submissionDate: "",
  professor: "",
  professorship: "",
  title: "",
  degree: "",
  faculty: "",
  author: "",
  supervisor: "",
  abstract_body: "",
  introduction: "",
  is_print: false,
  billOfMaterials_body: "",
  body,
) = {

  titlepage(
    title: title,
    degree: degree,
    author: author,
    supervisor: supervisor,
    submissionDate: submissionDate,
    professorship: professorship,
    professor: professor,
    faculty: faculty,
  )

  pagebreak(to: "odd", weak: false)


  disclaimer(
    title: title,
    degree: degree,
    author: author,
    submissionDate: submissionDate,
  )
  pagebreak(to: "odd", weak: false)


  abstract(body: abstract_body, lang: "en")


  set page(
    margin: (left: 30mm, right: 30mm, top: 60mm, bottom: 40mm),
    numbering: none,
    number-align: center,
  )

  set text(
    font: fonts.body,
    size: 11pt,
    lang: "en"
  )

  show math.equation: set text(weight: 400)

  // --- Headings ---
  show heading: set block(below: 2.1em, above: 1.75em)
  show heading: set text(font: fonts.body,  1.6em, weight: "semibold")
  show: make-glossary

  set heading(numbering: "1.1")
  // Reference first-level headings as "chapters"
  show ref: it => {
    let el = it.element
    if el != none and el.func() == heading and el.level == 2 {
      link(
        el.location(),
        [Chapter #numbering(
          el.numbering,
          ..counter(heading).at(el.location())
        )]
      )
    } else {
      it
    }
  }

  // --- Paragraphs ---
  set par(leading: 1em)

  // --- Citations ---
  set cite(style: "alphanumeric")

  // --- Figures ---
  show figure: set text(size: 0.85em)
    pagebreak(to: "odd", weak: false)
  // --- Table of Contents ---
  show outline.entry.where(level: 1): it => {
    v(15pt, weak: true)
    strong(it)
  }

  outline(
    title: {
      text(font: fonts.body, "Contents")
      v(15mm)
    },
    indent: 2em
  )


  v(2.4fr)
    pagebreak(to: "odd", weak: false)


    outline(
    title: {
      text(font: fonts.body, "List of Figures")
            v(15mm)

    }, target: figure.where(kind: image))

  pagebreak()

  pagebreak()

    outline(
    title: {
      text(font: fonts.body,  "List of Tables")
      v(15mm)

    }, target: figure.where(kind: table))

  pagebreak(to: "odd", weak: false)

    // Main body. Reset page numbering.
  counter(page).update(1)
  set page(numbering: "1")

  set par(justify: true, first-line-indent: 2em)
  body
  pagebreak(to: "odd", weak: false)
    bibliography("/thesis.bib")
    
  pagebreak(to: "odd", weak: false)
  abbr.list(title:"Acronyms")
    pagebreak(to: "odd", weak: false)

    set heading(numbering: none)
    billOfMaterials(body: billOfMaterials_body)

}