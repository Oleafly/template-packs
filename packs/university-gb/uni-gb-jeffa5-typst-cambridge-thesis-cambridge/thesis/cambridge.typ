// Given a location at the start of a page, obtain the current
// heading. Current means:
// - The first heading on this page if present.
// - Else, the previous heading if one exists.
// - Else, return none.
#let get-current-heading(loc, level: 1) = {
  let heading-selector = heading.where(level: level, outlined: true)
  let el = query(heading-selector.after(loc)).at(0, default: none)
  if el != none and el.location().page() == loc.page() {
    return none
  } else {
    return query(heading-selector.before(loc)).at(-1, default: none)
  }
}

#let figure_caption(it) = {
  strong[#it.supplement #it.counter.display(it.numbering)#it.separator]
  it.body
}

#let front-page(title, subtitle, author, college, college-shield) = {
  let lastline = "This thesis is submitted for the degree of Doctor of Philosophy"
  [
    #set par(justify: false)
    #align(center, image(width: 20em, "light-logo.svg"))
    #align(center + horizon, text(2.5em, title)) \
    #v(4em)
    #align(center + horizon, text(2em, subtitle)) \
    #v(4em)
    #align(center + horizon, [#text(1.5em, author) \ #image(width: 5em, college-shield) #text(1.3em, college)])
    #align(center + bottom, text(1em, lastline))
    #v(1em)
  ]
}

#let declaration(name, date) = [
  #heading(level: 1, outlined: false, "Declaration")
  #v(2em)

  This thesis is the result of my own work and includes nothing which is the outcome of work done in collaboration except as declared in the preface and specified in the text.
  It is not substantially the same as any work that has already been submitted, or is being concurrently submitted, for any degree, diploma or other qualification at the University of Cambridge or any other University or similar institution except as declared in the preface and specified in the text.
  It does not exceed the prescribed word limit for the relevant Degree Committee.

  #v(2em)

  #align(right, [#name \ #date])
]

#let summary-page(content) = [
  #heading(level: 1, outlined: false, "Summary")

  #content
]

#let acknowledgements-page(content) = [
  #heading(level: 1, outlined: false, "Acknowledgements")

  #content
]

#let glossary() = [
  #heading(level: 1, outlined: false, "Glossary")
]

#let index() = [
  #set heading(numbering: none)
  #show heading.where(level: 1): it => {
    set text(1.6em, weight: "regular")
    v(2em)
    it.body
    v(-0.5em)
    line(length: 100%, stroke: 0.5pt)
    v(2em)
  }
  #heading(level: 1, "Index")
]

#let clearpage(compact) = {
  if not compact {
    pagebreak(to: "odd")
  }
}

#let listoffigures(selector) = {
  outline(title: [List of figures], target: figure.where(kind: selector))
}

#let listoftables(selector) = {
  outline(title: [List of tables], target: figure.where(kind: selector))
}

#let listoflistings(selector) = {
  outline(title: [List of listings], target: figure.where(kind: selector))
}

#let tableofcontents() = {
  show outline.entry.where(level: 1): it => {
    strong(it)
  }
  outline(indent: auto, depth: 3)
}

#let thesis(
  title: none,
  author: none,
  college: none,
  college-shield: none,
  subtitle: none,
  short-title: none,
  short-author: none,
  date: none,
  summary: none,
  acknowledgements: none,
  compact: false,
  figure-selector: image,
  table-selector: table,
  listing-selector: raw,
  use-glossary: true,
  use-index: true,
  techreport: false,
  body,
) = {
  let leading = if compact or techreport { 0.8em } else { 1.5em }

  set page(
    paper: "a4",
    // One Cambridge thesis-binding company, J.S. Wilson & Son, recommend on their web page to leave 30 mm margin on the spine and 20 mm on the other three sides of the A4 pages sent to them. About a centimetre of the left margin is lost when the binder stitches the pages together.
    margin: (
      inside: 30mm,
      outside: 20mm,
      top: 20mm,
      bottom: 20mm,
    ),
  )

  show heading: set block(above: leading, below: leading)
  show heading.where(level: 1): it => {
    set text(1.6em, weight: "regular")
    v(leading)
    it.body
    v(-0.5em)
    line(length: 100%, stroke: 0.5pt)
    v(leading)
  }

  set par(leading: leading, first-line-indent: leading, justify: true)

  if techreport {
    counter(page).update(3)
  } else {
    front-page(title, subtitle, author, college, college-shield)
    clearpage(compact)
    declaration(author, date)
    clearpage(compact)
  }
  summary-page(summary)
  clearpage(compact)
  acknowledgements-page(acknowledgements)
  clearpage(compact)

  tableofcontents()
  clearpage(compact)

  if figure-selector != none {
    listoffigures(figure-selector)
    clearpage(compact)
  }

  if table-selector != none {
    listoftables(table-selector)
    clearpage(compact)
  }

  if listing-selector != none {
    listoflistings(listing-selector)
    clearpage(compact)
  }

  if use-glossary {
    glossary()
    clearpage(compact)
  }

  set page(numbering: "1", header: {
      context {
          let current-page = counter(page).get().first()
          let current-chapter = get-current-heading(here())
          let current-section = get-current-heading(here(), level: 2)
          if current-chapter != none {
            if calc.rem(current-page, 2) == 0 {
              let current-section-text = if current-section == none {[]} else {
                emph[#numbering(current-section.numbering, ..counter(heading).at(current-section.location())). #current-section.body]
              }
              [
                #h(1fr)
                #current-section-text
                #v(-0.5em)
                #line(length: 100%, stroke: 0.5pt)
              ]
            } else {
              [
                #emph[Chapter #counter(heading.where(level: 1)).display(). #current-chapter.body]
                #h(1fr)
                #v(-0.5em)
                #line(length: 100%, stroke: 0.5pt)
              ]
            }
          } else {[]}
        }
    })
  set heading(numbering: "1.1")

  show heading.where(level: 1, numbering: "1") : it => {
    set text(1em, weight: "regular")
    v(leading)
    h(1fr)
    [Chapter #counter(heading).display()]
    set text(1.6em, weight: "regular")
    line(length: 100%, stroke: 0.5pt)
    block[
      #it.body
    ]
    line(length: 100%, stroke: 0.5pt)
    v(leading)
  }
  show heading.where(level: 2): it => {
    set text(1.2em)
    it
  }
  show heading.where(level: 3): it => {
    set text(1.1em)
    it
  }
  show heading.where(level: 4): it => {
    set text(1em)
    it
  }
  show figure.where(kind: table): set figure.caption(position: top)
  // show figure.caption: figure_caption

  body

  if use-index {
    clearpage(compact)
    index()
  }
}

// For rendering chapters separately.
#let chapter(
  compact: false,
  techreport: false,
  body,
) = {
  let leading = if compact or techreport { 0.8em } else { 1.5em }

  set page(
    paper: "a4",
    // One Cambridge thesis-binding company, J.S. Wilson & Son, recommend on their web page to leave 30 mm margin on the spine and 20 mm on the other three sides of the A4 pages sent to them. About a centimetre of the left margin is lost when the binder stitches the pages together.
    margin: (
      inside: 30mm,
      outside: 20mm,
      top: 20mm,
      bottom: 20mm,
    ),
  )

  show heading: set block(above: leading, below: leading)
  show heading.where(level: 1): it => {
    set text(1.6em, weight: "regular")
    v(leading)
    it.body
    v(-0.5em)
    line(length: 100%, stroke: 0.5pt)
    v(leading)
  }

  set par(leading: leading, first-line-indent: leading, justify: true)

  set page(numbering: "1", header: {
      context {
          let current-page = counter(page).get().first()
          let current-chapter = get-current-heading(here())
          let current-section = get-current-heading(here(), level: 2)
          if current-chapter != none {
            if calc.rem(current-page, 2) == 0 {
              let current-section-text = if current-section == none {[]} else {
                emph[#numbering(current-section.numbering, ..counter(heading).at(current-section.location())). #current-section.body]
              }
              [
                #h(1fr)
                #current-section-text
                #v(-0.5em)
                #line(length: 100%, stroke: 0.5pt)
              ]
            } else {
              [
                #emph[Chapter #counter(heading.where(level: 1)).display(). #current-chapter.body]
                #h(1fr)
                #v(-0.5em)
                #line(length: 100%, stroke: 0.5pt)
              ]
            }
          } else {[]}
        }
    })
  set heading(numbering: "1.1")

  show heading.where(level: 1) : it => {
    set text(1em, weight: "regular")
    v(leading)
    h(1fr)
    [Chapter #counter(heading).display()]
    set text(1.6em, weight: "regular")
    line(length: 100%, stroke: 0.5pt)
    block[
      #it.body
    ]
    line(length: 100%, stroke: 0.5pt)
    v(leading)
  }
  show heading.where(level: 2): it => {
    set text(1.2em)
    it
  }
  show heading.where(level: 3): it => {
    set text(1.1em)
    it
  }
  show heading.where(level: 4): it => {
    set text(1em)
    it
  }
  show figure.where(kind: table): set figure.caption(position: top)
  // show figure.caption: figure_caption

  body
}
