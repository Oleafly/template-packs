// Wenzhou-Kean University Thesis Template Library
// This is the main entry point for the WKU thesis template package

#import "@preview/cmarker:0.1.6": *

// Export all template functions and utilities

/// Helper function to read and render markdown content with figure support
#let wku-read-markdown(file) = {
  render(
    read(file), 
    raw-typst: true,
    scope: (
      image: (path, ..args) => figure(image(path, ..args), kind: image)
    )
  )
}

/// Cover page function
#let wku-cover(thesis-info, logo-width, university-name-size, thesis-type-size, thesis-title-size, student-info-size) = {
  set page(numbering: none, margin: 2.5cm)
  
  align(center)[
    // University logo
    #v(1cm)
    #image("assets/wku-logo.svg", width: logo-width)
    
    #v(1cm)
    
    // University name
    #text(size: university-name-size, weight: "bold")[
      WENZHOU-KEAN UNIVERSITY
    ]
    
    #v(2cm)
    
    // Thesis type
    #text(size: thesis-type-size, weight: "bold")[
      UNDERGRADUATE THESIS
    ]
    
    #v(3cm)
    
    // Thesis title
    #block(
      width: 80%,
      [
        #text(size: thesis-title-size, weight: "bold")[
          #thesis-info.at("title", default: "Thesis Title")
        ]
      ]
    )
    
    #v(4cm)
    
    // Student information table
    #table(
      columns: (auto, 1fr),
      stroke: none,
      align: left,
      column-gutter: 2em,
      row-gutter: 1.2em,
      
      [Student Name:], thesis-info.at("author", default: "Student Name"),
      [Student ID:], thesis-info.at("student-id", default: "Student ID"),
      [Major:], thesis-info.at("major", default: "Major"),
      [College:], thesis-info.at("college", default: "College Name"),
      [Supervisor:], thesis-info.at("supervisor", default: "Supervisor Name"),
    )
    
    #v(2cm)
    
    // Date
    #text(size: student-info-size)[
      #thesis-info.at("date", default: datetime.today().display("[month repr:long] [day], [year]"))
    ]
  ]
  
  pagebreak()
}

/// Declaration page function
#let wku-declaration(special-page-title-size) = {
  set page(numbering: none)
  
  align(center)[
    #text(size: special-page-title-size, weight: "bold")[
      DECLARATION
    ]
  ]
  
  v(2cm)
  
  text(size: 12pt)[
    I hereby declare that this thesis submitted is my own work and that, to the best of my knowledge and belief, it contains no material previously published or written by another person nor material which has been accepted for the award of any other degree or diploma of the university or other institute of higher learning, except where due acknowledgment has been made in the text.
    
    I understand that the legal consequences of this declaration are my responsibility.
    
    #v(3cm)
    
    Author's Signature: _________________ Date: _________________
    
    #v(2cm)
    
    Supervisor's Signature: _____________ Date: _________________
  ]
  
  pagebreak()
}

/// Abstract page function
#let wku-abstract(special-page-title-size, special-page-spacing) = {
  set page(numbering: "i")
  counter(page).update(1)
  
  align(center)[
    #text(size: special-page-title-size, weight: "bold")[
      ABSTRACT
    ]
  ]
  
  v(special-page-spacing)
  
  wku-read-markdown("content/abstract.md")
  
  pagebreak()
}

/// Acknowledgments page function
#let wku-acknowledgments(special-page-title-size, special-page-spacing) = {
  align(center)[
    #text(size: special-page-title-size, weight: "bold")[
      ACKNOWLEDGMENTS
    ]
  ]
  
  v(special-page-spacing)
  
  wku-read-markdown("content/acknowledgments.md")
  
  pagebreak()
}

/// Function to load chapter content
#let wku-load-chapters(content-dir: "content/", chapter-files: (), enable-dynamic-loading: false) = {
  if enable-dynamic-loading {
    // Use dynamically generated file list
    for file in chapter-files {
      let file-path = content-dir + file
      wku-read-markdown(file-path)
    }
  } else {
    // Fallback to manual loading
    wku-read-markdown("content/01-introduction.md")
    wku-read-markdown("content/02-literature-review.md")
    wku-read-markdown("content/03-methodology.md")
    wku-read-markdown("content/04-results.md")
    wku-read-markdown("content/05-discussion.md")
    wku-read-markdown("content/06-conclusion.md")
  }
}

/// Main template function that sets up the thesis document
/// 
/// Parameters:
/// - title: The thesis title
/// - author: Author name
/// - student-id: Student ID number
/// - major: Academic major
/// - college: College name
/// - supervisor: Supervisor name
/// - date: Thesis date
/// - keywords: Array of keywords
/// - paper-size: Paper size (default: "a4")
/// - margins: Page margins dictionary
/// - fonts: Font configuration dictionary
/// - body: The document content
#let wku-thesis(
  // Thesis information
  title: "Thesis Title",
  author: "Student Name",
  student-id: "Student ID",
  major: "Major",
  college: "College Name",
  supervisor: "Supervisor Name",
  date: none,
  keywords: ("keyword1", "keyword2", "keyword3"),
  
  // Layout settings
  paper-size: "a4",
  margins: (
    top: 2.5cm,
    bottom: 2.5cm,
    left: 3cm,
    right: 2cm
  ),
  
  // Typography settings
  fonts: (
    main: "Times New Roman",
    code: "Consolas"
  ),
  text-size: 12pt,
  line-spacing: 1.5em,
  
  // Heading settings
  chapter-font-size: 18pt,
  section-font-size: 16pt,
  subsection-font-size: 14pt,
  
  // Cover page settings
  logo-width: 4cm,
  university-name-size: 24pt,
  thesis-type-size: 20pt,
  thesis-title-size: 18pt,
  student-info-size: 14pt,
  
  // Special pages
  special-page-title-size: 18pt,
  special-page-spacing: 1.5cm,
  
  // Figure and code settings
  caption-text-size: 10pt,
  code-background-color: "#f5f5f5",
  code-padding: 1em,
  code-corner-radius: 0.3em,
  
  // Content
  body
) = {
  // Create thesis info dictionary
  let thesis-info = (
    title: title,
    author: author,
    "student-id": student-id,
    major: major,
    college: college,
    supervisor: supervisor,
    date: if date != none { date } else { datetime.today().display("[month repr:long] [day], [year]") },
    keywords: keywords
  )
  
  // Document metadata
  set document(
    title: title,
    author: author,
    keywords: keywords
  )
  
  // Page layout
  set page(
    paper: paper-size,
    margin: margins,
    numbering: "1",
    number-align: center,
    header: context {
      if counter(page).get().first() > 1 [
        #align(center)[Wenzhou-Kean University Thesis]
        #line(length: 100%)
      ]
    }
  )
  
  // Typography
  set text(
    font: fonts.main,
    size: text-size,
    lang: "en"
  )
  
  // Paragraph formatting
  set par(
    justify: true,
    leading: line-spacing,
    first-line-indent: 0em
  )
  
  // Heading styles
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    v(2em)
    align(center)[
      #set text(size: chapter-font-size, weight: "bold")
      #it.body
    ]
    v(1.5em)
  }
  
  show heading.where(level: 2): it => {
    v(1.5em)
    set text(size: section-font-size, weight: "bold")
    it
    v(0.5em)
  }
  
  show heading.where(level: 3): it => {
    v(1em)
    set text(size: subsection-font-size, weight: "bold")
    it
    v(0.5em)
  }
  
  // Figure captions
  show figure.caption: it => {
    set text(size: caption-text-size)
    it
  }
  
  // Code blocks
  show raw.where(block: true): it => {
    set text(font: fonts.code)
    block(
      fill: rgb(code-background-color),
      inset: code-padding,
      radius: code-corner-radius,
      width: 100%,
      it
    )
  }
  
  // Cover page
  wku-cover(thesis-info, logo-width, university-name-size, thesis-type-size, thesis-title-size, student-info-size)
  
  // Declaration page
  wku-declaration(special-page-title-size)
  
  // Abstract page
  wku-abstract(special-page-title-size, special-page-spacing)
  
  // Table of contents
  pagebreak()
  outline(
    title: [Table of Contents],
    depth: 3,
    indent: auto
  )
  
  // List of figures
  pagebreak()
  outline(
    title: [List of Figures],
    target: figure.where(kind: image)
  )
  
  // List of tables
  pagebreak()
  outline(
    title: [List of Tables],
    target: figure.where(kind: table)
  )
  
  // Main content begins
  pagebreak()
  counter(page).update(1)
  
  // Document body
  body
}

// Export utility functions
#let read-markdown = wku-read-markdown
#let load-chapters = wku-load-chapters
#let make-cover = wku-cover
#let make-declaration = wku-declaration
#let make-abstract = wku-abstract
#let make-acknowledgments = wku-acknowledgments