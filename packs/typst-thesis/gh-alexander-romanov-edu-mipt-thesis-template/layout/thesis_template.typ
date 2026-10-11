#import "/layout/cover.typ": *
#import "/layout/abstract.typ": *
#import "/utils/print_page_break.typ": *
#import "/layout/fonts.typ": *
#import "/utils/diagram.typ": in-outline

#let thesis(
  title: "", degree: "", program: "", supervisor: "", advisors: (), author: "", class: "", startDate: datetime, submissionDate: datetime, abstract_en: "", acknowledgement: "", transparency_ai_tools: "", is_print: false, print_appendix: false, list_figures: false, body,
) = {
  cover(
    title: title, degree: degree, program: program, author: author, class: class, supervisor: supervisor, date: datetime(year: 2025, month: 5, day: 30),
  )

  print_page_break(print: is_print)

  abstract(title: title, author: author)

  print_page_break(print: is_print)

  set page(
    margin: (left: 30mm, right: 15mm, top: 30mm, bottom: 20mm), numbering: "1", number-align: center, header: grid(columns: (1fr), align: (center), v(5mm), title, v(2mm), grid.hline()),
  )

  set text(font: fonts.body, size: 12pt, lang: "ru")

  show math.equation: set text(weight: 400)

  // --- Headings ---
  show heading: set block(below: 0.85em, above: 1.75em)
  show heading: set text(font: fonts.body)
  set heading(numbering: "1.1")
  // Reference first-level headings as "chapters"
  show ref: it => {
    let el = it.element
    if el != none and el.func() == heading and el.level == 1 {
      link(
        el.location(), [Глава #numbering(el.numbering, ..counter(heading).at(el.location()))],
      )
    } else {
      it
    }
  }

  // --- Paragraphs ---
  set par(leading: 1em)

  show figure: set text(size: 0.85em)

  // --- Table of Contents ---
  show outline.entry.where(level: 1): it => {
    v(15pt, weak: true)
    strong(it)
  }
  outline(title: {
    text(font: fonts.body, 1.5em, weight: 700, "Содержание")
    v(15mm)
  }, indent: 2em)

  v(2.4fr)
  pagebreak()

  // Main body. Reset page numbering.
  set par(justify: true, first-line-indent: (amount: 2em, all: true))

  body

  // List of figures.
  if list_figures {
    pagebreak()
    heading(numbering: none)[List of Figures]
    show outline: it => { // Show only the short caption here
      in-outline.update(true)
      it
      in-outline.update(false)
    }
    outline(title: "", target: figure.where(kind: image))
  }
  // List of tables.
  context[
    #if query(figure.where(kind: table)).len() > 0 {
      pagebreak()
      heading(numbering: none)[List of Tables]
      outline(title: "", target: figure.where(kind: table))
    }
  ]

  // Appendix.
  if print_appendix {
    pagebreak()
    heading(numbering: none)[Appendix A: Supplementary Material]
    include("/layout/appendix.typ")
  }

  pagebreak()
  set cite(style: "alphanumeric")
  bibliography("/bib.yml", full: true, title: "Список Литературы", style: "ieee")
}
