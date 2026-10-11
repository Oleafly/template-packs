// Report Template
// Author: Alejandro Cobos

// Default logo
// Replace path with the logo you wish to appear by default 
#let default-logo = image("assets/logoipsum-404.svg")

#let report(
  title: "Report Title",
  author: "Your Name",
  course: "Course Module",
  supervisor: none,

  logo: default-logo,
  show-toc: false,
  heading-numbering: true,
  bibliography-file: none,
  body,
) = {
  // Document settings
  set document(author: author, title: title)
  set page(
    paper: "a4",
    margin: (left: 2.5cm, right: 2.5cm, top: 2.5cm, bottom: 2.5cm),
  )
  
  // Font settings
  set text(font: "New Computer Modern", size: 11pt, lang: "en")
  
  // Paragraph settings
  set par(justify: true, leading: 0.65em)
  
  // Heading numbering (conditionally applied)
  set heading(numbering: if heading-numbering { "1.1." } else { none })
  
  // Heading styles
  show heading.where(level: 1): it => {
    set text(size: 18pt, weight: "bold", fill: rgb("#1e3a8a")) // Navy blue
    block(above: 1.5em, below: 1em, it)
  }
  
  show heading.where(level: 2): it => {
    set text(size: 14pt, weight: "bold", fill: rgb("#1e3a8a"))
    block(above: 1.2em, below: 0.8em, it)
  }
  
  show heading.where(level: 3): it => {
    set text(size: 12pt, weight: "bold", fill: rgb("#1e3a8a"))
    block(above: 1em, below: 0.6em, it)
  }
  
  show heading.where(level: 4): it => {
    set text(size: 11pt, weight: "bold", fill: rgb("#1e3a8a"))
    block(above: 0.8em, below: 0.5em, it)
  }
  
  // Link styling
  show link: set text(fill: rgb("#2563eb"))
  
  // Code block styling
  show raw.where(block: true): it => {
    set text(size: 9pt)
    block(
      fill: rgb("#f3f4f6"),
      inset: 10pt,
      radius: 4pt,
      width: 100%,
      it
    )
  }
  
  show raw.where(block: false): it => {
    box(
      fill: rgb("#f3f4f6"),
      outset: (y: 2pt, x: 2pt),
      radius: 2pt,
      it
    )
  }
  
  // --- FIGURE & TABLE STYLING ---

  // Separate numbering for images and tables
  show figure.where(kind: image): set figure(numbering: "1")
  show figure.where(kind: table): set figure(numbering: "1")
  
  // Position caption above tables
  show figure.where(kind: table): set figure.caption(position: top)

  // Figure styling
  show figure: it => {
    set align(center)
    if it.kind == table {
      it
      v(1em) // Space after the table
    } else {
      it
      v(0.5em) // Space after images
    }
  }
  
  // Figure reference styling (Fig. instead of Figure, separate counters)
  show ref: it => {
    let el = it.element
    if el != none and el.func() == figure {
      if el.kind == image {
        // For images, display as "Fig. X"
        let fig-counter = counter(figure.where(kind: image))
        let num = fig-counter.at(el.location()).first()
        link(it.target)[#text(fill: rgb("#2563eb"))[Fig. #num]]
      } else if el.kind == table {
        // For tables, display as "Table X"
        let tbl-counter = counter(figure.where(kind: table))
        let num = tbl-counter.at(el.location()).first()
        link(it.target)[#text(fill: rgb("#2563eb"))[Table #num]]
      } else {
        // For other figure types, just make them blue
        link(it.target)[#text(fill: rgb("#2563eb"))[#it]]
      }
    } else if el != none {
      // For headings and other elements with targets, make them blue
      link(it.target)[#text(fill: rgb("#2563eb"))[#it]]
    } else {
      // For citations and other references without elements, just display as-is
      // The bibliography will handle the styling
      it
    }
  }
  
  // Table styling
  set table(
    stroke: (x, y) => if y == 0 {
      (bottom: 1pt + black)
    } else {
      (bottom: 0.5pt + gray)
    },
  )
  
  // ==================
  // TITLE PAGE
  // ==================
  
  page(
    header: none,
    footer: none,
  )[
    #set align(center)
    
    // Logo at top
    #if logo != none {
      v(1.5cm)
      box(width: 40%, logo)
      v(1cm)
    } else {
      v(3cm)
    }
    
    // Title
    #v(2cm)
    #text(size: 24pt, weight: "bold", fill: rgb("#1e3a8a"))[
      #title
    ]
    
    #v(1.5cm)
    
    // Author
    #text(size: 14pt)[
      #author
    ]
    
    #v(0.8cm)
    
    // Course
    #text(size: 12pt, fill: rgb("#1f2937"))[
      #course
    ]
    
    // Optional Supervisor Field
    #if supervisor != none {
      v(0.2cm)
      text(size: 11pt, fill: rgb("#374151"))[
        #supervisor
      ]
    }

    #v(0.8cm)
    
    // Date
    #text(size: 11pt, fill: rgb("#374151"))[
      #datetime.today().display("[day] [month repr:long] [year]")
    ]
  ]
  
  // ==================
  // MAIN DOCUMENT
  // ==================
  
  // Set up headers and footers for main content
  set page(
    header: context {
      let page-num = counter(page).get().first()
      if page-num > 1 or (page-num == 1 and not show-toc) {
        grid(
          columns: (1fr, 1fr),
          align(left)[#text(size: 9pt, fill: gray)[#author]],
          align(right)[#text(size: 9pt, fill: gray)[#course]]
        )
        line(length: 100%, stroke: 0.5pt + gray)
      }
    },
    footer: context {
      let page-num = counter(page).get().first()
      if page-num > 1 or (page-num == 1 and not show-toc) {
        align(center)[
          #text(size: 9pt, fill: gray)[
            #counter(page).display("1")
          ]
        ]
      }
    },
  )
  
  // Reset page counter
  counter(page).update(1)
  
  // Table of Contents
  if show-toc {
    page[
      #outline(
        title: text(size: 20pt, weight: "bold", fill: rgb("#1e3a8a"))[Table of Contents],
        indent: auto,
        depth: 3,
      )
    ]
  } else {
    pagebreak()
    counter(page).update(2)
  }
  
  // Main body
  body
  
  // Bibliography
  if bibliography-file != none {
    pagebreak()
    set heading(numbering: none)
    bibliography-file
  }
}
