#import "@preview/codelst:2.0.1": sourcecode
#import "@preview/drafting:0.2.0": * // For notes in margins

// The project function defines how your document looks.
// It takes your content and some metadata and formats it.
// Go ahead and customize it to your liking!
#let project(
  title: "",
  title_estonian: "",
  thesis_type: "",
  thesis_type_estonian: "",
  authors: (),
  supervisors: (),
  date: none,
  location: "",
  dev: false,
  logo: none,
  body,
) = {

  // Set the document's basic properties.
  let doc_authors = authors.map(author => author.name)
  set document(author: doc_authors, title: title)
  set text(font: "New Computer Modern", lang: "en")
  show math.equation: set text(weight: 400)
  show par: set block(spacing: 1.5em)
  show link: it => [
    #text(rgb("0000FF"))[#it]
  ]

  // Set up notes in margin
  // https://github.com/ntjess/typst-drafting
  set page(
    // Extra wide A4 to give extra room for notes
    margin: (left: 2.5cm, right: if dev { 6.5cm } else { 2.5cm}), paper: "a4", width: if dev {25cm} else {21cm}
  )
  set-page-properties()

  // Title page.
  align(center, text(1.2em, weight: 50, "TALLINN UNIVERSITY OF TECHNOLOGY"))
  align(center, text(1.2em, weight: 50, "School of Information Technologies"))

  
  // The page can contain a logo if you pass one with `logo: "logo.png"`.
  v(0.6fr)
  if logo != none {
    align(right, image(logo, width: 26%))
  }
  v(1fr)

   // Author information.
  pad(
    top: 0.7em,
    bottom: 2em,
    align(center,
      grid(
        rows: authors.len(),
        gutter: 3em,
        ..authors.map(author => align(right, 
          strong(author.name) + " " +
          author.student_code
        )),
      ),
    )
  )
  
  v(1.2em, weak: true)
  align(center, text(2em, weight: 700, title))

  v(2.4em, weak: true)
  align(center, text(1.8em, weight: 200, smallcaps(thesis_type)))

  // Supervisors
  pad(
    top: 0.7em,
    right: 10%,
    align(right,
      strong("Supervisor") +
      grid(
        rows: supervisors.len(),
        gutter: 1em,
        ..supervisors.map(supervisor => align(right, supervisor.name + linebreak() + supervisor.degree)),
      ),
    )
  )

  v(2.4fr)

  place(bottom+center)[
    #location #datetime.today().year()
  ]
  
  pagebreak()

    // Title page.
  align(center, text(1.2em, weight: 50, "TALLINNA TEHNIKAÜLIKOOL"))
  align(center, text(1.2em, weight: 50, "Infotehnoloogia teaduskond"))

  
  // The page can contain a logo if you pass one with `logo: "logo.png"`.
  v(0.6fr)
  if logo != none {
    align(right, image(logo, width: 26%))
  }
  v(1fr)

   // Author information.
  pad(
    top: 0.7em,
    bottom: 2em,
    align(center,
      grid(
        rows: authors.len(),
        gutter: 3em,
        ..authors.map(author => align(right, 
          strong(author.name) + " " +
          author.student_code
        )),
      ),
    )
  )
  
  v(1.2em, weak: true)
  align(center, text(2em, weight: 700, title_estonian))

  v(2.4em, weak: true)
  align(center, text(1.8em, weight: 200, smallcaps(thesis_type_estonian)))

  // Supervisors
  pad(
    top: 0.7em,
    right: 10%,
    align(right,
      strong("Juhendaja") +
      grid(
        rows: supervisors.len(),
        gutter: 1em,
        ..supervisors.map(supervisor => align(right, supervisor.name + linebreak() + supervisor.degree)),
      ),
    )
  )

  v(2.4fr)

  place(bottom+center)[
    #location #datetime.today().year()
  ]
  
  pagebreak()

  set page(numbering: "I", number-align: center)
  counter(page).update(1)

  // Authors declaration
  include "authors_declaration.typ"

  v(2em)
  text("Author: ")
  authors.map(author => author.name).join(", ")

  v(1em)
  text("Date: ") + datetime.today().display("[day].[month].[year]")

  pagebreak()

  

  // Abstract page.
  v(1fr)
  align(center)[
    #heading(
      outlined: false,
      numbering: none,
      text(1em, smallcaps[Abstract]),
    )
  ]
  par(justify: true, include("abstract.typ"))
  v(1.618fr)
  pagebreak()

  // Annotation page.
  v(1fr)
  align(center)[
    #heading(
      outlined: false,
      numbering: none,
      text(1em, smallcaps[Annotatsioon]),
    )
  ]
  par(justify: true, include("annotation.typ"))
  v(1.618fr)
  pagebreak()

  // Table of contents.
  outline(depth: 3, indent: true)

  // Main body.
  set par(justify: true)
  set page(numbering: "1", number-align: center, header: counter(footnote).update(0))
  
  counter(page).update(1)

  // Abbreviations
  // include("abbreviations.typ")

  // Heading numbering
  set heading(numbering: "1.1")
  show heading: it => {
    if (it.level == 1) {
      pagebreak()
    }
    
    if (it.level > 3) {
        block(it.body)
    } else {
        block(counter(heading).display() + " " + it.body)
    }
  }
  
  body

  bibliography("references.bib");

  // Hack to insert end label for page count
  text[#text(" ")<end>]

  show heading: none
  heading[Appendixes]
  
  set heading(numbering: "1.1", outlined: false)
  counter(heading).update(0)
  show heading: it => {
    if (it.level == 1) {
      pagebreak()
    }
    block("Appendix " + counter(heading).display() + ": " + it.body)
  }
  
  include("appendixes.typ")
}

#let todo(txt) = inline-note(
  stroke: blue,
  rect: rect.with(inset: 1em, radius: 0.5em, fill: blue.lighten(90%)),
  text[_Author_: #txt]
)
#let todo-supervisor(txt) = inline-note(
  stroke: orange,
  rect: rect.with(inset: 1em, radius: 0.5em, fill: orange.lighten(90%)),
  text[_Supervisor_: #txt]
)
#let note(note, txt) = margin-note(stroke: aqua, text(size: 0.7em, note)) + highlight(txt)
#let suggestion(old, new) = highlight(fill: red, old) + highlight(fill: green, new)

#let metric(name) = emph(name)
#let cite-footnote(title, accessed, url, archivedurl) = footnote[#title, Accessed: #accessed, #smallcaps("url:") #link(url)]