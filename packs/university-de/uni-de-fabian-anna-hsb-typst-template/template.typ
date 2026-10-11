// The project function defines how your document looks.
// It takes your content and some metadata and formats it.
#let project(
  title: "",
  subtitle: "", 
  company: "",
  department: "",
  studyProgram: "",
  course: "",
  docType: "",
  authors: (),
  bibliography-file: "refs.bib", 
  logo: none, 
  body
) = {
  // Set the document's basic properties.
  set document(author: authors, title: title)
  set page(numbering: "1", number-align: end,
    margin:
      (
        top: 2cm,
        left: 2.5cm,
        right: 2.5cm,
        bottom: 2cm,
      )
  )
  set text(font: "Libertinus Serif", lang: "de")
  show link: underline

  // Title page.
  set page(numbering: none)
  let horizontalrule = [
    #line(start: (0%, 0%), end: (100%, 0%))
  ]
  set align(center)
  
  // Display logo if one is given, else use empty rect as placeholder
  rect(height: 100pt, width: 100%, stroke: none)[
    #if logo != none {
      image(logo, height: 100%)
    }
  ]

  // Show metadata
  set text(14pt)
  smallcaps[
    #if company != "" { company + linebreak() }
    #if department != "" { department + linebreak() }
    #if studyProgram != "" { studyProgram + linebreak() }
  ]
  v(1fr)
  
  set text(13pt)
  smallcaps[#if course != "" { course + linebreak() }]
  
  set text(17pt)
  strong[#if docType != "" { docType }]
  
  // Show Title
  horizontalrule
  text(size: 18pt )[#strong[
    #title
    #linebreak()
    #if subtitle != "" { "-" + subtitle + "-" }
  ]]
  horizontalrule

  v(1fr)
  // Show authors
  set text(14pt)
  for author in authors {
    author + linebreak()
  }

  v(3fr)

  datetime.today().display("[day].[month].[year]")

  pagebreak()

  // Abstract
  v(1fr)
  set align(start)
  set text(11pt)
  set par(justify: true)
  set heading(outlined: false)
  text[
    = Zusammenfassung
    Deine Zusammenfassung in deutsch kommt hier hin
    
    = Abstract
    Your abstract in english goes here
  ]
  v(1fr)
  set heading(outlined: true)

  pagebreak()

  // Table of contents and main body.
  set page(numbering: "I",
  margin:
        (
          top: 2cm,
          left: 2.5cm,
          right: 2cm,
          bottom: 2cm,
        )
    )
  counter(page).update(1)
  // Table of contents
  outline(depth: 2, indent: auto)
  
  linebreak()
  
  // List of figures
  outline(
    title: [Abbildungsverzeichnis],
    target: figure.where(kind: image),
  )
  linebreak()

  // List of tables and source code
  outline(
    title: [Tabellenverzeichnis],
    target: figure.where(kind: table).or(figure.where(kind: raw)),
  )
  v(1fr)
  pagebreak()

  // Main body.
  show heading.where(level: 1): it => {
    v(0.5em) // spacing before heading
    counter(heading).display()
    " "+it.body
    v(0.7em) //spacing after heading
  }

  show heading.where(level: 2): it => {
    v(0.5em) // spacing before heading
    counter(heading).display()
    " "+it.body
    v(0.5em) //spacing after heading
  }

  set heading(numbering: "1.")

  show figure: set block(breakable: true)
  
  // Main body.
  set par(justify: true)

  set page(numbering: "1")
  counter(page).update(1)
  set align(start)
  set text(11pt)
  
  body

  set page(numbering: "A")
  counter(page).update(1)

  pagebreak()

  counter(heading).update(0) 
  // Bibliography
  set bibliography(style: "harvard-cite-them-right")
  show bibliography: set heading(numbering: "A")
  show bibliography: set text(9pt, lang: "de"); 
  show bibliography: pad.with(x: 0.5pt)
  bibliography(bibliography-file)

  set heading(numbering: "A")
  // include "appendix.typ"
}
