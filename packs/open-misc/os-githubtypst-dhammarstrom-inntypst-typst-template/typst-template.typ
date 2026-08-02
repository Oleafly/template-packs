#let innTypst(
  // The document title.
  title: "innTypst",
  // Logo in top right corner.
  typst-logo: none,
  // Course name and link
  course: none,
  course_link: none,
  // Page numbering, defaults to numbered pages, can be set to none
  page_numbering: "1",  
  // Bibliography heading
  bibliography_heading: "Bibliography",
  // Margin notes
  margin_notes: (:),  // Dictionary for additional margin notes
  // The document content.
  body
) = {
  // Set document metadata.
  set document(title: title)
  
  // Configure pages.
  set page(
    margin: (
      left: 2cm, 
      right: 2cm, 
      top: 2cm, 
      bottom: 2cm
    ),
    numbering: if page_numbering == "none" { none } else { page_numbering },  // Handle "none" specially
    number-align: right,
    background: place(right + top, rect(
      fill: rgb("#E9F5E7"),
      height: 100%,
      width: 4.8cm,
    )),
    // Add course info to the footer of every page
    footer: {
      if course != none {
        place(
          right,
          dx: 1.5cm,
          block(width: 2.5cm)[
            #if course_link != none {
              link(course_link)[#text(
                  size: 9pt,
                  weight: "light",
                  fill: rgb("#003F01"))[#course]]
            } else {
              text(
                size: 9pt,
                weight: "light",
                fill: rgb("#003F01"))[#course]
            }
          ]
        )
      }
    }
  )
  
  // Set the body font.
  set text(10pt, font: "Aptos")
  
  // Configure headings.
  show heading.where(level: 1): set block(below: 0.8em)
  show heading.where(level: 2): set block(above: 0.5cm, below: 0.5cm)
  
  // Links should be dark green.
  show link: set text(rgb("#003F01"))
  
  
  // Remove default bibliography heading and apply our custom one
  show bibliography: it => {
    // Add our custom heading
    heading(level: 1, numbering: none)[#bibliography_heading]
    
    // Display entries without trying to access .body
    set heading(level: 1, outlined: false, numbering: none)
    it
  }
  
  // Also hide any heading that contains exactly "Bibliography"
  show heading.where(level: 1, body: [Bibliography]): it => {
    // Hide the default bibliography heading
    []
  }
  
  // Place logo in sidebar if provided
  if typst-logo != none {
    place(
      right + top,
      dx: 1.2cm,  // Offset from right edge (places it in the sidebar)
      dy: 0cm,   // Offset from top edge
      image(typst-logo.path, width: 3cm)
    )
  }
  
  // Display additional margin notes if provided
  if margin_notes.len() > 0 {
    for (title, note) in margin_notes {
      place(
        right,
        dx: 1.5cm,  // Offset from the content area
        dy: note.position * 1cm,  // Convert the number to cm
        block(width: 3.5cm)[
          #text(weight: "thin", size: 12pt)[#title]
          #linebreak()
          #text(weight: "light", size: 9pt)[#note.content]
        ]
      )
    }
  }
  
  // Main content layout
  grid(
    columns: (1fr, 2cm),
    column-gutter: 2cm,
    // Title.
    pad(bottom: 1cm, text(font: "Aptos Display", 24pt, title)),
    // Empty placeholder where the logo used to be
    [],
    
    // The main body text.
    {
      set par(justify: true)
      body
      v(1fr)
    },
  )
}