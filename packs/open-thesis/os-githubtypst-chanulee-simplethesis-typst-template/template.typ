#let thesis(
  title: "",
  author: "",
  degree1: "",
  degree2: "",
  department: "",
  school1: "",
  school2: "",
  institution1: "",
  institution2: "",
  date: datetime(year: 0001, month: 01, day: 01,),
  advisor: "",
  committee: (),
  abstract: [],
  signature: [],
  acknowledgements: [],
  dedication: none,
  publications: (),
  showSignatures: true,
  showCommittee: true,
  showDedication: true,
  showAcknowledgements: true,
  showPublications: false,
  body,
) = {
  // Document metadata
  set document(author: author, title: title)
  
  // Page setup for A4
  set page(
    paper: "a4",
    margin: (left: 30mm, right: 30mm, top: 30mm, bottom: 30mm),
    numbering: none,
  )
  
  // Text formatting
  set text(
    font: "times",
    size: 12pt,
    weight: "regular"
  )
  
  // Paragraph spacing and formatting
  set par(
    leading: 1.5em,
    justify: true,
    first-line-indent: 0em,
    spacing: 3em  // Space between paragraphs
  )
  
  // Heading spacing configuration
  show heading: it => {
    set block(spacing: 2em)
    set text(weight: "bold")
    v(1em) // Add space before heading
    it
  }
  
  // Initialize heading counters
  let heading-counter = counter("heading")
  // Front matter
  align(center)[
  
    #text(size: 18pt, weight: "bold")[#title]
    
    *#author*
    #v(6em)
    Submitted
    \
    in partial fulfillment of the
    requirements for the degree of
    \
    #degree1
    \ at the #upper[#institution1]
    \
    and
    \
    #degree2
    \
    at the #upper[#institution2]
    
    #v(6em)
    #school1
    \
    #institution1
    
    #school2
    \
    #institution2
    
    #date.display("[month repr:long] [year]")
  ]
  // Abstract
  page[
    #heading(level: 1, "Abstract")
    #abstract
  ]
  // Optional sections
  if showSignatures and signature != [] {
    pagebreak()
    align(left)[
      #v(8em)
      #signature
    ]
  }
  if showDedication and dedication != none {
    pagebreak()
    align(center)[
      #v(8em)
      #dedication
    ]
  }
  if showAcknowledgements and acknowledgements != [] {
    page[
      #heading(level: 1, "Acknowledgements")
      #acknowledgements
    ]
  }
  if showCommittee and committee != () {
    page[
      #heading(level: 1, "Committee")
      #for member in committee {
        member
        v(0.5em)
      }
    ]
  }
  if showPublications and publications != () {
    page[
      #heading(level: 1, "Publications")
      #for pub in publications {
        pub
        v(0.5em)
      }
    ]
  }
  // Table of Contents
  page[
    #outline(
      title: "Table of Content",
      target: heading,
      indent: true
    )
  ]
  // Lists of Figures and Tables
  page[
    #heading(level: 1, "List of Figures")
    #outline(
      title: none,
      target: figure.where(kind: image),
    )
  ]
  page[
    #heading(level: 1, "List of Tables")
    #outline(
      title: none,
      target: figure.where(kind: table),
    )
  ]
  // Main content
  set page(numbering: "1")
  counter(page).update(1)
  
  // Apply numbered headings to main content
  set heading(numbering: "1.1")
  
  // Show the main content
  body
}