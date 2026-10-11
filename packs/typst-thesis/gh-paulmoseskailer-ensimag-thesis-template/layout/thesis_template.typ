#import "/layout/titlepage.typ": *
#import "/layout/acknowledgement.typ": *
#import "/layout/abstract.typ": *
#import "/utils/print_page_break.typ": *
#import "/layout/fonts.typ": *

#let thesis(
  title: "",
  titleFrench: "",
  degree: "",
  program: "",
  specialization: "",
  supervisor: "",
  author: "",
  startDate: datetime,
  submissionDate: datetime,
  presentationDate: datetime,
  abstract_en: "",
  acknowledgement_content: "",
  abstract_fr: "",
  is_print: false,
  body,
) = {
  titlepage(
    title: title,
    titleFrench: titleFrench,
    degree: degree,
    program: program,
    specialization: specialization,
    supervisor: supervisor,
    author: author,
    startDate: startDate,
    submissionDate: submissionDate,
    presentationDate: presentationDate
  )

  print_page_break(print: is_print, to: "even")

  print_page_break(print: is_print)

  set page(
    margin: (left: 40mm, right: 40mm, top: 30mm, bottom: 30mm),
    numbering: none,
    number-align: center,
  )
  
  abstract(lang: "en")[#abstract_en]
  acknowledgement()[#acknowledgement_content]
  abstract(lang: "fr")[#abstract_fr]

  pagebreak()
  print_page_break(print: is_print)

  set page(
    margin: (left: 30mm, right: 30mm, top: 40mm, bottom: 40mm),
    numbering: none,
    number-align: center,
  )

  set text(
    font: fonts.body, 
    size: 12pt, 
    lang: "en"
  )
  
  show math.equation: set text(weight: 400)

  // --- Headings ---
  show heading: set block(below: 0.85em, above: 1.75em)
  show heading: set text(font: fonts.body)
  set heading(numbering: "1.1")

  // --- Paragraphs ---
  set par(leading: 1em)

  // --- Citations ---
  set cite(style: "alphanumeric")

  // --- Figures ---
  show figure: set text(size: 0.85em)
  
  // --- Table of Contents ---
  set page(
    margin: (left: 30mm, right: 30mm, top: 60mm, bottom: 40mm),
    numbering: none,
    number-align: center,
  )
  show outline: it => {
    show heading: set align(center)
    it
  }
  show outline.entry.where(level: 1): it => {
    show repeat: none
    v(15pt, weak: true)
    strong(it)
  }
  outline(
    title: {
      v(5mm)
      text(font: fonts.sans, 1.2em, weight: 700, "Contents")
      v(15mm)
    },
    indent: 2em
  )
  
  
  v(2.4fr)
  pagebreak()
  pagebreak()


  // Main body. Reset page numbering.
  set page(numbering: "1")
  counter(page).update(1)
  set par(justify: true, first-line-indent: 2em)

  // Configure section headings
  show heading: it => {
    if it != none and it.func() == heading and it.level == 1 {
      set text(font: fonts.sans, 1.2em, weight: 500)
      set align(center)
      let thin_bar = [#text(weight: 100)[#sym.bar.h]]
      thin_bar + " " + counter(heading).display() + " " + thin_bar + linebreak()
      it.body
    } else {
      set text(font: fonts.sans, 1.1em)
      it
    }
  }

  body

  // Appendix.
  set heading(numbering: "A")
  counter(heading).update(0)
  pagebreak()
  heading(numbering: "A")[Appendix]
  include("/layout/appendix.typ")

  pagebreak()
  show bibliography: bibliography => {
    set heading(numbering: none)
    [#align(center, text(font: fonts.sans, 1.2em, weight: 500)[Bibliography])]
    bibliography
  }
  bibliography("/thesis.bib")
}
