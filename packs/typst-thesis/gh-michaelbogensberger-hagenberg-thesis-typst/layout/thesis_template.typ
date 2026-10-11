#import "/layout/copyright.typ": *
#import "/layout/declaration.typ": *
#import "/layout/fonts.typ": *


#let thesis(
  title: "",
  degree: "",
  program: "",
  supervisor: "",
  author: "",
  submissionDate: datetime,
  university: "",
  location: "",
  abstract_en: "",
  abstract_de: "",
  acknowledgement: "",
  preface: "",
  glossary: "",
  transparency_ai_tools: "",
  body,
) = {
  
  // 1. Title page
  set page(margin: (left: 30mm, right: 30mm, top: 25mm, bottom: 25mm), numbering: none)
  set text(font: fonts.body, size: 12pt)
  
  // Title page content
  align(center)[
    #v(30mm)
    #text(size: 14pt, weight: "bold")[#title]
    #v(13mm)
    #text(size: 12pt)[#author]
    #v(13mm)    
    // Logo 
    #image("/figures/fhooe_logo.jpg", width: 30mm)
    
    #v(13mm)
    #text(size: 14pt, weight: "bold", tracking: 1pt)[#upper(degree) THESIS]
    #v(15mm)
    
    #text(size: 11pt)[
      submitted to the \
      Bachelor's Degree Program \
      #program \
    ]

    #v(5mm)

    #text(size: 11pt)[
      at the \
      #university \
      in #location
    ]
    
    #v(10mm)
    #text(size: 12pt)[#submissionDate.year()]
    #v(10mm)
    #text(size: 11pt)[Supervisor: #supervisor]
    #v(15mm)
  ]

  pagebreak()

  // Paragraph formatting for the entire document
  set par(justify: true)

  // Heading formatting
  show heading: set text(font: fonts.body)
  show heading: set block(below: 1.2em, above: 1.75em)
  
  // 2. Copyright page
  copyright(
    author: author,
    submissionDate: submissionDate,
  )

  // 3. Declaration
  declaration(
    author: author,
    location: location,
    submissionDate: submissionDate,
  )

  // 4. Contents
  heading(level: 1)[Contents]
  show outline.entry.where(level: 1): it => {
    v(15pt, weak: true)
    strong(it)
  }
  outline(
    title: none,
    indent: 2em
  )
  
  pagebreak()

  // 5. Glossary / List of Abbreviations
  if glossary != "" {
    glossary
    pagebreak()
  }

  // 6. Preface
  if preface != "" {
    preface
    pagebreak()
  }

  // 7. Acknowledgement
  if acknowledgement != "" {
    acknowledgement
    pagebreak()
  }

  // 8. Abstract
  include("/content/abstract_en.typ")
  pagebreak()
  
  // 9. Abstract in German  
  include("/content/abstract_de.typ")
  pagebreak()
  
  // 10. Transparency of AI Usage
  if transparency_ai_tools != "" {
    transparency_ai_tools
    pagebreak()
  }

  // Main content setup - Chapter numbering and page numbers start here
  set page(
    margin: (left: 30mm, right: 30mm, top: 40mm, bottom: 40mm),
    numbering: "1",
    number-align: center,
  )
  counter(page).update(1)
  counter(heading).update(0)
  set heading(numbering: "1.1")

  set text(
    font: fonts.body, 
    size: 12pt, 
    lang: "en"
  )
  
  show math.equation: set text(weight: 400)
  
  // Reference first-level headings as "chapters"
  show ref: it => {
    let el = it.element
    if el != none and el.func() == heading and el.level == 1 {
      link(
        el.location(),
        [Chapter #numbering(
          el.numbering,
          ..counter(heading).at(el.location())
        )]
      )
    } else {
      it
    }
  }

  // Citations
  set cite(style: "alphanumeric")

  // Figures
  show figure: set text(size: 0.85em)

  body

  // List of figures
  pagebreak()
  heading(numbering: none)[List of Figures]
  outline(
    title: none,
    target: figure.where(kind: image),
  )

  // List of tables
  context[
    #if query(figure.where(kind: table)).len() > 0 {
      pagebreak()
      heading(numbering: none)[List of Tables]
      outline(
        title: none,
        target: figure.where(kind: table)
      )
    }
  ]

  // Appendix
  pagebreak()
  heading(numbering: none)[Appendix A: Supplementary Material]
  include("/layout/appendix.typ")

  // Bibliography
  pagebreak()
  bibliography("/thesis.yml")
}
