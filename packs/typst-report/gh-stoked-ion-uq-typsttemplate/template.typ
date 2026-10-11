// The project function defines how your document looks.
// It takes your content and some metadata and formats it.
// Go ahead and customize it to your liking!
#let project(
  tag1: "",
  title: "",
  abstract: [],
  authors: (),
  logo: "logo.jpg",
  PAdvisor: "",
  Advisor1: "",
  Advisor2: "",
  tag2: "",
  tag3: "",
  body,
) = {
  // Set the document's basic properties.
  set document(author: authors.map(a => a.name), title: title)
  set page(
    margin: (left: 20mm, right: 20mm, top: 30mm, bottom: 30mm),
  
    number-align: center,
  )
  set text(font: "New Computer Modern", lang: "en")
  show math.equation: set text(weight: 400)
  set math.equation(numbering: "(1)")
  

  // Title page.
  // The page can contain a logo if you pass one with `logo: "logo.png"`.
  v(0.1fr)
  if logo != none {
    align(center, image(logo, width: 78%))
  }
  v(0.4fr)
  set align(center)
  
  text(1.6em, weight: 70, smallcaps(tag1))
  linebreak()
  
  v(0.25fr)
  text(2em, weight: 700, title)

  // Author information.
  v(0.25fr)
  text(1.6em, weight: 70, authors.map(a => a.name).join(", "))
  // Advisor information.
  v(0.9fr)
  text(1.1em, weight: 70, PAdvisor)
  v(0.1fr)
  text(1.1em, weight: 70, Advisor1)
  v(0.1fr)
  text(1.1em, weight: 70, Advisor2)

  v(2fr)
  text(1.4em, weight: 70, tag2)
  v(0.1fr)
  text(1.3em, weight: 70, tag3)
  pagebreak()

  // Abstract page.
  set par(justify: true)
  v(1fr)
align(center)[
    #heading(
      outlined: false,
      numbering: none,
      text(0.85em, smallcaps[Abstract]),
    )
    
    #abstract
  ]
  
  v(1.618fr)
  pagebreak()

  // Table of contents.
  outline(depth: 3, title: "Table of Contents")
  pagebreak()

  // Main body.
  counter(page).update(1)
  set page(numbering: "1")
  set align(left)
  set par(justify: true,
          leading: 0.9em,
          )
  set heading(numbering: "1.1",)

// Custom chapter heading styling
show heading.where(level: 1): it => {
  line(length: 100%)
  strong(text(1.5em, "Chapter " + str(counter(heading).at(it.location()).at(0))))
  linebreak()
  linebreak()
  strong(text(2em, it.body))
  line(length: 100%)
  v(0.8em)
}

// Custom table caption styling to place the caption before the table content
show figure.where(kind: table): set figure.caption(position: top)

  body
  set page(numbering: none)

  // Bibliography.
  pagebreak()
  show heading.where(level: 1): it => {
    line(length: 100%)
    //linebreak()
    v(0.8em)
    strong(text(2em, it.body))
    linebreak()
    line(length: 100%)
    v(0.5em)
  }
  bibliography("Bibliography.bib")
  pagebreak()

  // Appendices.

  // Create the appendices heading with standard styling
  heading("Appendices", numbering: none)

  // Reset the counter and apply custom styling only for content after the Appendices heading
  counter(heading).update(0)  // Start at 0 so first heading will be A.1

  // Apply custom styling for appendix section headings only
  show heading: it => {
    if it.level == 1 {
      block[
        #v(1em)
        #text(weight: "bold", size: 1.1em, 
          [Appendix A.#str(counter(heading).at(it.location()).at(0)): #it.body])
        #v(0.5em)
      ]
    } else {
      block[
        #v(0.8em)
        #text(weight: "bold", size: 1em, 
          [A.#str(counter(heading).at(it.location()).at(0)).#str(counter(heading).at(it.location()).at(1)): #it.body])
        #v(0.4em)
      ]
    }
  }
  counter(heading).update(0)  // Start at 0 so first heading will be A.1

  import "appendix.typ": appendixContent
  appendixContent
}


