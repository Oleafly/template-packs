#import "@preview/nth:1.0.1": *

// Custom functions
#let my-date(date) = nth(date.day()) + date.display(" [month repr:long] [year]")

#let active(reference) = {
  cite(reference, form: "prose", style: "apa")
}

#let passive(reference) = {
  cite(reference, form: "normal", style: "apa")
}

#let table-note(content, table-content: none, spacing: 1em) = context [
  #align(left)[
    #set par(leading: 1em)

    #let parent-width = if table-content != none {
      measure(table-content).width
    } else {
      page.width - page.margin.inside - page.margin.outside
    }
    
    #box(width: parent-width)[
      #text(size: 10pt)[
        #emph("Note"): #content
      ]
    ]
    #v(spacing)
  ]
]


// Main template
#let conf(
  title: "Your title",
  program: "Name of your program",
  name: "Your name",
  student_number: "123456",
  supervisor: "Name of your supervisor",
  second_assessor: "Name of your second assessor",
  date: my-date(datetime.today()),
  abstract: lorem(100),
  university: "Erasmus University Rotterdam",
  faculty: "Erasmus School of Economics",
  logo: "figures/eur.png",
  disclaimer: "The content of this thesis is the sole responsibility of the author and does not reflect the view of the supervisor, second assessor, Erasmus School of Economics or Erasmus University.",
  doc
) = {
  //// General page settings
  
  // Font
  set text(
    font: "New Computer Modern",
    size: 11pt
  )

  // Margin
  set page(
    margin: 2.5cm,
  )

  // Table
  let frame(stroke) = (x, y) => (
    top: if y < 2 { stroke } else { 0pt },
    bottom: stroke,
  )

  set table(
    stroke: frame(rgb(black)),
  )

  // Equation numbering
  set math.equation(numbering: "(1)")

  //// Document structure

  // Title page
  set align(center)
  block[
    #smallcaps[#university]

    #smallcaps[#faculty]

    #program
  ]
  v(0.8fr)

  // Title and author
  line(length: 100%)

  block[
    #set text(18pt)
    #title

    #set text(14pt)

    #name (#student_number)
  ]

  line(length: 100%)
  v(0.8fr)

  // University logo
  box(image(logo, height: 15.0%))
  v(0.8fr)

  // Information table
  table(
    stroke: (x, y) => if y == 2 {
      (bottom: 0.7pt + black)
    } else if y == 0 {
      (top: 0.7pt + black)
    },
    align: (left, left,),
    columns: 2,
    [Supervisor:], [#supervisor],
    [Second assessor:], [#second_assessor],
    [Date final version:], [#date]
  )


  set par()
  v(1fr) // Fill to the bottom
  disclaimer

  // Abstract
  if abstract != "" {
    pagebreak()
    block[
    #set heading(outlined: false)
    = Abstract
    #set par(
      justify: true,
    )
    #set align(left)
    #abstract
    ]
  }

  set align(left)

  // Table of contents
  pagebreak()
  set page(numbering: "1")
  counter(page).update(1)

  show outline.entry.where(
    level: 1
  ): it => {
    v(12pt, weak: true)
    strong(it)
  }

  outline(indent: auto)

  // Settings that are only applied to the main document
  set heading(numbering: "1.1")
  set par(
    justify: true,
    leading: 1.5em, // Line spacing
    first-line-indent: 2em, // Paragraph tab
  )

  // Make a normal white line spacing for tables
  show table.cell: it => {
    set par(leading: 0.3em)  
    it
  }

  // Set line spacing to 1 for captions
  show figure.caption: it => {
    set text(size: 10pt)
    set par(leading: 1em)
    it
  }

  // Make table caption appear on top
  show figure.where(
    kind: table
  ): set figure.caption(position: top)

  set page(margin: (
    inside: 1in,
    outside: 1in,
    top: 1in,
    bottom: 1in,
  ))

  // Center figure caption, but left-align the text
  show figure.caption: it => {
    align(box(align(it, left)), center)
  }

  // Cap width of figure caption to the width of the figure
  show figure: it => {
    if "subpar" in repr(it.body) {
      // For subpar grids, don't constrain caption width
      set par(justify: true)
      it
    } else {
      // For regular figures, use width constraint
      let item_width = measure(it.body).width
      let page_width = page.width - page.margin.inside - page.margin.outside
      let w = calc.min(item_width, page_width)
      set par(justify: true)
      show figure.caption: cap => box(width: w, cap)
      it
    }
  }

  // Main document appears now
  doc
}