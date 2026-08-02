#let ut-thesis(
  title, 
  author, 
  degree, 
  department, 
  year, 
  abstract,
  ack,
  abbrev,
  body
) = {
  // constants
  let rest-margin = 0.75in
  let left-margin = 1.25in
  let font-size = 12pt
  let font = "New Computer Modern"
  
  // Set the document's basic properties
  set document(author: author, title: title)
  set page(
    paper: "us-letter",
    margin: (left: left-margin, rest: rest-margin),
    numbering: "i",
    number-align: center,
  )
  set text(font: font, size: font-size, lang: "en")
  set par(leading: 1.5em, justify: true, first-line-indent: 2em)

  // Table captions go above the table
  show figure.where(
    kind: table
  ): set figure.caption(position: top)
  
  // Title page (no page number shown)
  page(numbering: none)[
    #set par(leading: 0.65em)
    #align(center)[
      #v(2in-rest-margin)
      #smallcaps(text(weight: "regular", 1.25em, title))
      #v(1.5in)
      by
      #v(1.5in)
      #author
      #v(1.5in)
      A thesis submitted in conformity with the requirements\
      for the degree of #degree
      #v(0.5em)
      #department\
      University of Toronto
      #v(3cm)
      © Copyright by #author #year
      #v(1.25in-rest-margin)
    ]
  ]

  // Abstract page (starts with page number ii)
  page(numbering: "i")[
    #set par(leading: 0.65em)
    #block(width: 100%)[
      #align(center)[
        #title \
        
        #author \
        #degree \
        
        #department \
        University of Toronto \
        #year \
      ]
      
    ]

    #set align(center)
    #heading(
      outlined: false, 
      numbering: none, 
      "Abstract"
    )
    #v(1em)
    #set align(left)
    #set par(leading: 2em)
    #abstract
  ]

  // Acknowledgments
  page[
    #set align(center)
    #heading(outlined: false, numbering: none, "Acknowledgments")
    #v(1em)
    #set align(left)
    #ack
  ]

  // Table of contents
  page[
    #heading(outlined: false, numbering: none, "Table of Contents")
    #outline(depth: 3, indent: true, title: "")
  ]

  // List of Tables
  page[
    #heading(outlined: false, numbering: none, "List of Tables")
    #outline(
      title: "",
      target: figure.where(kind: table),
    )
  ]

  // List of Figures
  page[
    #heading(outlined: false, numbering: none, "List of Figures")
    #outline(
      title: "",
      target: figure.where(kind: image),
    )
  ]

  // List of Abbreviations
  page[
    #heading(outlined: false, numbering: none, "List of Abbreviations")
    #v(2.5em)
    #abbrev
  ]

  // Main body (switch to Arabic numerals)
  set page(numbering: "1")
  counter(page).update(1)

  // Heading Configuration
  set heading(numbering: "1.")
  
  show heading.where(level: 1): it => [
    // we layout rather large Chapter Headings, e.g:
    //
    //  Chapter 1. 
    //  Introduction
    //
    #pagebreak()
    #v(2in-rest-margin)
    #block[
      #if it.numbering != none [
        #set text(size: 24pt)
        Chapter #counter(heading).display() \
        #set text(size: 32pt)
        #it.body
      ]
      #if it.numbering == none [
        #set text(size: 32pt)
        #it.body
      ]
      #v(1cm)
    ]
    #v(1cm, weak: true)
  ]
  
  show heading.where(level: 2): it => [
    #set text(size: 20pt)
    #block[
      #v(0.5cm)
      #counter(heading).display()
      #it.body
    ]
    // some space after the heading 2 (before text)
    #v(0.5em)
  ]

  show heading.where(level: 3): it => [
    #set text(size: 16pt)
    #block[
      #v(0.5cm)
      #counter(heading).display()
      #it.body
    ]
    // some space after the heading 3 (before text)
    #v(0.5em)
  ]

  show heading.where(level: 4): it => [
    #set text(size: 12pt)
    #block[
      #v(0.5cm)
      #counter(heading).display()
      #it.body
    ]
    // some space after the heading 4 (before text)
    #v(0.5em)
  ]
  
  // Main body content
  body
}

#let appendix(body) = {
  set heading(numbering: "A.1.", supplement: [Appendix])
  counter(heading).update(0)
  show heading.where(level: 1): it => [
    #pagebreak()
    #v(2in-0.75in)
    #block[
      #if it.numbering != none [
        #set text(size: 24pt)
        Appendix #counter(heading).display() \
        #set text(size: 32pt)
        #it.body
      ]
      #if it.numbering == none [
        #set text(size: 32pt)
        #it.body
      ]
      #v(1cm)
    ]
    #v(1cm, weak: true)
  ]
  body
}
