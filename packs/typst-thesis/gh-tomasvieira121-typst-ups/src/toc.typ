// Table of contents functions for INVICTA thesis

// Helper function for table of contents
#let make-toc() = {
  
  outline(
    title: auto,
    depth: 3,
    target: selector(heading).after(<main-content>),
  )
  
  pagebreak()
  
  outline(
    title: auto,
    target: selector(figure.where(kind: image)).after(<main-content>),
  )
  
  pagebreak()
  
  outline(
    title: auto,
    target: selector(figure.where(kind: table)).after(<main-content>),
  )
  
  pagebreak()
}

