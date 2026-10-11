// lib.typ - Typst Template for Academic Documents

// Global State
#let project-meta = state("project-meta", (
  campus: [],
  type: [],
  title: [],
  by: (),
  supervisor: [],
  department: [],
  faculty: [],
  address: [],
  date: [],
))

// Function to create cover page
#let coverpage(
  campus: [],
  type: [],
  title: [],
  by: (),
  department: [],
  address: [],
  date: [],
) = {
  page(numbering: none, [
    #set align(center)

    #image("logo.png", width: 20%)
    #v(1.2cm)

    // University header
    #text(size: 14pt, weight: "bold")[
      TRIBHUVAN UNIVERSITY \
      INSTITUTE OF ENGINEERING \
      #upper(campus) \
    ]

    #v(2cm)

    // Project type and title
    #text(size: 14pt, weight: "bold")[
      #upper(type) \
      #v(0.5cm)
      #upper(title)
    ]

    #v(1.8cm)

    // Authors section
    #text(size: 14pt, weight: "bold")[
      BY \
      #v(0.3cm)
      #for author in by [
        #author \
      ]
    ]

    #v(1.2cm)

    // Department and address
    #align(horizon, [
    #text(size: 13pt, weight: "bold")[
      #upper(department) \
      #upper(campus) \
      #upper(address) \
    ]])

    // Date
    #align(bottom, [
      #text(size: 13pt, weight: "bold")[
        #upper(date)
      ]])
  ])
}

// Function to create title page
#let titlepage(
  campus: [],
  title: [],
  by: (),
  supervisor: [],
  department: [],
  faculty: [],
  address: [],
  date: [],
) = {
  page(paper: "a4", margin: (top: 3cm, bottom: 2cm, left: 3.2cm, right: 2.5cm), numbering: none, [
    #set par(justify: true)

    #align(center)[
      #text(weight: "bold")[#upper(title)]
    ]

    #align(center)[
      #v(3cm)
      #upper[by]

      #for member in by [
        #upper(member)\
      ]

      #v(3cm)
      Project Supervisor\
      #supervisor

      #v(4cm)
      A project submitted to the #department in partial fulfillment of the requirements for the Bachelor's Degree in #faculty Engineering
    ]

    #align(center+bottom)[
      #department\
      #campus, Institute of Engineering\
        Tribhuvan University, #address

      #v(1cm)
      #date
    ]
  ])
}

// Main template rule
#let project(
  campus: [],
  type: [],
  title: [],
  by: (),
  supervisor: [],
  department: [],
  faculty: [],
  address: [],
  date: [],
  show-coverpage: true,
  show-titlepage: true,
  body
) = {
  // Update the global state so it's accessible anywhere
  project-meta.update(x => (
    campus: campus,
    type: type,
    title: title,
    by: by,
    supervisor: supervisor,
    department: department,
    faculty: faculty,
    address: address,
    date: date,
  ))

  // Global Font settings
  set text(
    font: "Times New Roman",
    size: 12pt,
    lang: "en"
  )

  if show-coverpage {
    coverpage(
      campus: campus,
      type: type,
      title: title,
      by: by,
      department: department,
      address: address,
      date: date,
    )
  }

  if show-titlepage {
    titlepage(
      campus: campus,
      title: title,
      by: by,
      supervisor: supervisor,
      department: department,
      faculty: faculty,
      address: address,
      date: date,
    )
  }

  // Document settings
  set page(
    paper: "a4",
    margin: (left: 3.81cm, right: 2.54cm, top: 2.54cm, bottom: 2.54cm),
    numbering: "i",
    number-align: center,
  )

  // Heading settings
  show heading.where(level: 1): it => {
    align(center)[
        #upper(it.body)
    ]
    v(24pt)
  }

  set heading(
    supplement: [Chapter],
  )
  
  // Paragraph settings
  set par(
    leading: 1.2em,
    spacing: 20pt,
    first-line-indent: 0pt,
    justify: true
  )
  
  // Figure and table numbering
  set figure(numbering: "1.1")
  
  body
}

// To conditionally include files with path resolution
#let include-if-exists(path) = context {
  // Adjust path to be relative to the calling file, not this lib file
  let adjusted-path = if path.starts-with("./") {
    "../" + path.slice(2)
  } else if not path.starts-with("../") and not path.starts-with("/") {
    "../" + path
  } else {
    path
  }
  
  let path-label = label(adjusted-path)
  let first-time = query((context {}).func()).len() == 0
  if first-time or query(path-label).len() > 0 {
    [
      #include adjusted-path 
      #path-label
    ]
  }
}
