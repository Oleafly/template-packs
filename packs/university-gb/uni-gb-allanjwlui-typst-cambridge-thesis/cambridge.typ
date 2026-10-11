// Helper functions
#let margin-digital = (
      inside: 25mm,
      outside: 25mm,
      top: 20mm,
      bottom: 20mm,
    )

// One Cambridge thesis-binding company, J.S. Wilson & Son, recommend on their web page to leave 30 mm margin on the spine and 20 mm on the other three sides of the A4 pages sent to them. About a centimetre of the left margin is lost when the binder stitches the pages together.
#let margin-printing = (
      inside: 30mm,
      outside: 20mm,
      top: 20mm,
      bottom: 20mm,
    )

#let margin-use = margin-printing

// Set height for triggering page break at headings (measured from top of page)
// Doesn't work very well, generally only works at percentages >= 87%
#let break-height = 87%

// Given a location at the start of a page, obtain the current
// heading. Current means:
// - The first heading on this page if present.
// - Else, the previous heading if one exists.
// - Else, return none.
#let get-current-heading(loc, level: 1) = {
  let heading-selector = heading.where(level: level)
  let el = query(heading-selector.after(loc)).at(0, default: none)
  if el != none and el.location().page() == loc.page() {
    return none
  } else {
    return query(heading-selector.before(loc)).at(-1, default: none)
  }
}

#let extract-text(content) = {
        if content.has("text") {
          content.text
        } else if content.has("children") {
          content.children.map(extract-text).join(" ").replace("  "," ")
        } else if content.has("body") {
          extract-text(content.body)
        } else {
          ""
        }
      }

// --- Truncation Logic --
#let truncate-words(content-body, max-len: 70) = {
  // 1. Convert the input content to a plain string.
  let full-text = extract-text(content-body)

  // 2. Return the original text if it's already short enough.
  if full-text.len() <= max-len {
    return full-text
  }

  // 3. Otherwise, perform word-boundary truncation.
  // Make a preliminary cut at the max length.
  let preliminary-cut = full-text.slice(0, max-len)
  // Split this substring by spaces to get an array of words.
  let words = preliminary-cut.split(" ")

  // 4. Check if a space was found.
  if words.len() > 1 {
    // If yes, rejoin all words except the last (partial) one.
    return words.slice(0, -1).join(" ") + "..."
  } else {
    // If no, fall back to a hard cut (for very long first words).
    return preliminary-cut + "..."
  }
}
// --- End of Logic ---

#let header-pageNo-prelim = {
  context {
      let current-page = counter(page).get().first()
      let current-chapter = get-current-heading(here())
      set par(spacing: 1em)
      if current-chapter != none {
        if calc.rem(current-page, 2) == 0 {
          [
            #strong[#counter(page).display()]
            #h(1fr)
            #emph[#current-chapter.body]
            #v(-0.5em)
            #line(length: 100%, stroke: 0.5pt)
          ]
        } else {
          [
            //#emph[#current-chapter.body]
            #h(1fr)
            #strong[#counter(page).display()]
            #v(-0.5em)
            #line(length: 100%, stroke: 0.5pt)
          ]
        }
      } else {
        if calc.rem(current-page, 2) == 0 {
          [
            #strong[#counter(page).display()]
            #h(1fr)
          ]
        } else {
          [
            #h(1fr)
            #strong[#counter(page).display()]
            #v(-0.5em)
          ]
        }
      }
    }
}

#let header-pageNo = {
  context {
      let current-page = counter(page).get().first()
      let current-chapter = get-current-heading(here())
      let current-section = get-current-heading(here(), level: 2)
      if current-chapter != none {
        set par(spacing: 1em)
        if calc.rem(current-page, 2) == 0 {

          [
            #strong[#counter(page).display()] 
            #h(1fr)
            #emph[Chapter #counter(heading.where(level: 1)).display(). #truncate-words(current-chapter.body, max-len: 80)]
            
            #v(-0.5em)
            #line(length: 100%, stroke: 0.5pt)
          ]
        } else {
          let current-section-text = if current-section == none {[]} else {
          emph[#numbering(current-section.numbering, ..counter(heading).at(current-section.location())). #truncate-words(current-section.body, max-len: 85)]
          }
          [
            #current-section-text
            #h(1fr)
            #strong[#counter(page).display()]
            #v(-0.5em)
            #line(length: 100%, stroke: 0.5pt)
          ]
        }
      } else {[]}
    }
}
#let header-pageNo-appendix = {
  context {
      let current-page = counter(page).get().first()
      let current-chapter = get-current-heading(here())
      let current-section = get-current-heading(here(), level: 2)
      if current-chapter != none {
        set par(spacing: 1em)
        if calc.rem(current-page, 2) == 0 {

          [
            #strong[#counter(page).display()]
            #h(1fr)
            #emph[Appendix #counter(heading).display().first(). #truncate-words(current-chapter.body, max-len: 75)]
            #v(-0.5em)
            #line(length: 100%, stroke: 0.5pt)
          ]
        } else {
          [
            #h(1fr)
            #strong[#counter(page).display()]
            #v(-0.5em)
            #line(length: 100%, stroke: 0.5pt)
          ]
        }
      } else {[]}
    }
}

#let table-format(
  header: 1,
  hyphenate: false,
  ..args
  ) = {
    set par(justify: false, leading: 0.75em)
    set text(hyphenate: hyphenate)
    show table.cell.where(x: 0): strong
    show table.cell: it => {
      if it.y < header {
        strong(it)
      } else {
        it
      }
    }
    let fill = (x, y) => (
      if calc.odd(header) {
          if y > header - 1 and calc.odd(y) { luma(245) }
          else { white }
      } else {
          if y > header - 1 and calc.even(y) { luma(245) }
          else { white }
      }
      )
    let stroke = (x, y) => (
        top: if y == 0 { 1pt } else if y == header { 0.5pt } else { 0pt },
        bottom: if y < header { 0.5pt } else { 1pt }
      )

    table(..args, fill: fill, stroke: stroke)
}

#let figure-with-description(
  content, 
  caption: none, 
  description, 
  kind: auto,
  supplement: auto,
  spacing: 0.75em, 
  leading: 0.75em,
  below: 2.5em,
  breakable: false) = {
    //set block(above: above, below: below)
    set block(below: below)
    let supplement = (
      if kind != auto { kind } else {supplement}
    ) 
    set par(spacing: spacing, leading: leading)
    block(breakable: breakable)[
      #set block(above:spacing, below: spacing)
    #figure(content, caption: [#caption], kind: kind, supplement: supplement)
     #if description != none [
      #text[#description] 
    ]
  ]
  
}

#let caption-style(
  it, 
  alignment: left,
  spacing: 0.75em, 
  leading: 0.75em) = {
  set align(alignment)
  set par(spacing: spacing, leading: leading)
  strong[
    #it.supplement 
    #context it.counter.display(it.numbering)#it.separator
    #it.body
  ]
}

#let section-heading(it, section: "Chapter", leading: 1.25em) = {
  pagebreak(weak: true)
  set text(1em, weight: "bold")
  set block(above: leading, below: leading)
  v(leading)
  h(1fr)
  [#section #counter(heading).display()]
  set text(1.6em, weight: "regular", hyphenate: false)
  line(length: 100%, stroke: 0.5pt)
  set par(leading: 0.5em, justify: false)
  smallcaps[
    #it.body
  ]
  line(length: 100%, stroke: 0.5pt)
}



// Thesis formatting
#let front-page(title, author, department, college, college-shield, date) = {
  let lastline = [This dissertation is submitted for the degree of \ _Doctor of Philosophy_]
  [
    #set page(header: none, footer: none)
    #set par(justify: false, leading: 1em)
    #align(center + horizon, [#text(title, 2.25em, weight: "bold")])
    #align(center + horizon, [
      #image(width: 10em, "CollegeShields/CUniNoText.svg") \




      #text(author, 1.5em, weight: "bold") \
      
      #text(department, 1.5em) \
      #text([University of Cambridge], 1.5em)
      ])
    #align(center + bottom, text(lastline, 1.2em))
    #align(left + bottom, [#text(college, 1.2em) #h(1fr) #text(date, 1.2em)] )
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
  #heading(level: 1, outlined: false, "Abstract")

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
    set page(header: none, footer: none)
    pagebreak(to: "odd")
  }
}
#let listof(selector, label: none) = {
  [= List of #label]
  for kind in selector {
    outline(title: none, target: figure.where(kind: kind))
  }
}


#let tableofcontents() = {
  show outline.entry.where(level: 1): it => {
    strong(it)
  }
  outline(indent: auto, depth: 10)
}


#let thesis(
  title: none,
  author: none,
  department: none,
  college: none,
  college-shield: none,
  short-title: none,
  short-author: none,
  date: none,
  summary: none,
  acknowledgements: none,
  compact: false,
  figure-selector: (image, "Supplementary Figure"), // Array must contain at least 2 elements if used
  table-selector: (table, "Supplementary Table"), // Array must contain at least 2 elements if used
  listing-selector: none, // Array must contain at least 2 elements if used
  use-glossary: false,
  use-index: false,
  techreport: false,
  body,
  biblio: none,
  style: none,
  appendix: none
) = {
  //set text(font: "STIX Two Text")
  let leading = if compact or techreport { 0.75em } else { 1.25em }
  set page(
    paper: "a4",
    margin: margin-use
  )
  set par(leading: leading, spacing: leading*2, justify: true)

  show heading: set block(above: leading*2, below: leading*1.2)
  set page(
    numbering: "i", footer: none,
    header: header-pageNo-prelim
  )
  show heading.where(level: 1): it => {
    //pagebreak(weak: true)
    set text(1.6em, weight: "regular")
    set block(above: leading, below: leading)
    v(leading)
    smallcaps[#it.body]
    v(-0.5em)
    line(length: 100%, stroke: 0.5pt)
    //v(leading)
  }


  if techreport {
    counter(page).update(3)
  } else {
    front-page(title, author, department, college, college-shield, date)
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
    listof(figure-selector, label: [Figures])
    clearpage(compact)
  }

  if table-selector != none {
    listof(table-selector, label: [Tables])
    clearpage(compact)
  }

  if listing-selector != none {
    listof(listing-selector, label: [Listings])
    clearpage(compact)
  }

  if use-glossary {
    glossary()
    clearpage(compact)
  }

  set page(numbering: "1", header: header-pageNo)
  set heading(numbering: "1.1")
  show heading: it => {
    metadata("loc")
    context {
      let m = query(metadata.where(value: "loc").before(here())).last()
      if m.location().position().y > page.height * break-height {
        pagebreak()
      }
    }
    set par(leading: 0.75em)
    it
  }
  show heading.where(level: 1) : it => section-heading(it, section: "Chapter")
  show heading.where(level: 2): set text(1.1em)
  show heading.where(level: 3): set text(1.1em)
  show image: it => { box(it, width: 100%) } // Ensure figure captions align to the left of the page rather than to the figure only, while images align to center of page.
  show figure: set figure.caption(separator: [.])
  show figure.caption: it => {caption-style(it, leading: 0.75em)}
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: "Supplementary Table"): set figure.caption(position: top)
  show figure.where(kind: table): set par(leading: 0.75em, spacing: 0.75em)
  set enum(spacing: 1.25em, indent: 0.75cm)
  set table(columns: auto)
  show table: set align(horizon)
  //show table: set par(justify: false, leading: 0.75em)
  //show table: set text(hyphenate: true)
  //show table: set align(left)
  //show table.cell.where(y: 0): strong
  //show table.cell.where(x: 0): strong
  //set table(
  //    fill: (x, y) => (
  //          if y > 0 and calc.odd(y) { luma(245) }
  //          else { white }
  //      ),
  //    stroke: (x, y) => (
  //        top: if y == 0 { 1pt } else if y == 1 { 0.5pt } else { 0pt },
  //        bottom: if y < 1 { 0.5pt } else { 1pt }
  //      )
  //)
  counter(page).update(1)

  body

  if use-index {
    clearpage(compact)
    index()
  }
  clearpage(compact)
  set page(header: header-pageNo-appendix)
  if biblio != none {
    show bibliography: set heading(numbering: "1.")
    set par(leading: 0.75em, spacing: 1.25em)
    bibliography(biblio, full: false, style: style)
    clearpage(compact)
  }
  if appendix != none {
  counter(heading).update(0)
  set heading(numbering: "A")
  show heading.where(level: 1): it => section-heading(it, section: "Appendix")
  appendix
  }
}

// For rendering chapters separately.
#let chapter(
  compact: false,
  techreport: false,
  body,
) = {
  let leading = if compact or techreport { 0.75em } else { 1.25em }
  set page(
    paper: "a4",
    margin: margin-use
  )
  set par(leading: leading, spacing: leading*2, justify: true)
  set page(numbering: "1", header: header-pageNo)
  set heading(numbering: "1.1")
  show heading: it => {
    metadata("loc")
    context {
      let m = query(metadata.where(value: "loc").before(here())).last()
      if m.location().position().y > page.height * break-height {
        pagebreak()
      }
    }
    set block(above: leading*2, below: leading*1.2)
    set par(leading: 0.75em)
    it
  }
  show heading.where(level: 1) : it => section-heading(it, section: "Chapter")
  show heading.where(level: 2): set text(1.1em)
  show heading.where(level: 3): set text(1.1em)
  show image: it => { box(it, width: 100%) } // Ensure figure captions align to the left of the page rather than to the figure only.
  show figure: set figure.caption(separator: [.])
  show figure.caption: it => {caption-style(it, leading: 0.75em)}
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: "Supplementary Table"): set figure.caption(position: top)
  show figure.where(kind: table): set par(leading: 0.75em, spacing: 0.75em)
  set enum(spacing: 1.25em, indent: 0.75cm)
  set table(columns: auto)
  show table: set align(horizon)
  //show table: set par(justify: false, leading: 0.75em)
  //show table: set text(hyphenate: true)
  //show table: set align(left)
  //show table.cell.where(y: 0): strong
  //show table.cell.where(x: 0): strong
  //set table(
  //    fill: (x, y) => (
  //          if y > 0 and calc.odd(y) { luma(245) }
  //          else { white }
  //      ),
  //    stroke: (x, y) => (
  //        top: if y == 0 { 1pt } else if y == 1 { 0.5pt } else { 0pt },
  //        bottom: if y < 1 { 0.5pt } else { 1pt }
  //      )
  //)

  body
}

#let appendix(
  compact: false,
  techreport: false,
  body,
) = {
  let leading = if compact or techreport { 0.75em } else { 1.25em }
  set page(
    paper: "a4",
    margin: margin-use
  )
  set par(leading: leading, spacing: leading*2, justify: true)
  set page(numbering: "1", header: header-pageNo)
  set heading(numbering: "1.1")
  show heading: it => {
    metadata("loc")
    context {
      let m = query(metadata.where(value: "loc").before(here())).last()
      if m.location().position().y > page.height * break-height {
        pagebreak()
      }
    }
    set block(above: leading*2, below: leading*1.2)
    set par(leading: 0.75em)
    it
  }
  show heading.where(level: 1) : it => section-heading(it, section: "Appendix")
  show heading.where(level: 2): set text(1.1em)
  show heading.where(level: 3): set text(1.1em)
  show image: it => { box(it, width: 100%) } // Ensure figure captions align to the left of the page rather than to the figure only.
  show figure: set figure.caption(separator: [.])
  show figure.caption: it => {caption-style(it, leading: 0.75em)}
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: "Supplementary Table"): set figure.caption(position: top)
  show figure.where(kind: table): set par(leading: 0.75em, spacing: 0.75em)
  set enum(spacing: 1.25em, indent: 0.75cm)
  set table(columns: auto)
  show table: set align(horizon)
  //show table: set par(justify: false, leading: 0.75em)
  //show table: set text(hyphenate: true)
  //show table: set align(left)
  //show table.cell.where(y: 0): strong
  //show table.cell.where(x: 0): strong
  //set table(
  //    fill: (x, y) => (
  //          if y > 0 and calc.odd(y) { luma(245) }
  //          else { white }
  //      ),
  //    stroke: (x, y) => (
  //        top: if y == 0 { 1pt } else if y == 1 { 0.5pt } else { 0pt },
  //        bottom: if y < 1 { 0.5pt } else { 1pt }
  //      )
  //)
  body
}