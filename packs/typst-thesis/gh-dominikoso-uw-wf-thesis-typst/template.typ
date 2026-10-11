// template.typ - University of Warsaw Philosophy Thesis Template
// Typst Template v1.0 - Compatible with Typst 0.13+

// Define the main thesis function
#let thesis(
  title: "",
  title-english: "",
  author: "",
  student-id: "",
  degree-type: "licencjacka",
  field-of-study: "",
  supervisor: "",
  date: "",
  abstract: [],
  keywords: (),
  body
) = {

  // Set document metadata
  set document(
    title: title,
    author: author,
    date: auto
  )
  
  // Set page layout - A4 format with proper margins
  set page(
    paper: "a4",
    margin: (
      top: 2.5cm,
      bottom: 2.5cm,
      left: 3cm,
      right: 2cm
    ),
    numbering: none
  )
  
  // Set default text properties
  set text(
    font: "New Computer Modern",
    size: 12pt,
    lang: "pl",
    hyphenate: true
  )
  
  // Set paragraph properties
  set par(
    justify: true,
    leading: 1em,
    first-line-indent: 1.25cm
  )
  
  // Set heading properties
  set heading(
    numbering: none
  )
  
  show heading: it => {
    // Add space before and after headings
    v(24pt, weak: true)
    block[
      #set text(weight: "bold")
      #it
    ]
    v(12pt, weak: true)
  }
  
  // Title page
  page(
    header: none,
    footer: none,
    margin: 2.5cm,
    numbering: "1"
  )[
    #set align(center)
    
    // University name
    #text(size: 14pt, weight: "bold")[
      Uniwersytet Warszawski
    ]
    
    #v(0.5cm)
    
    // Faculty name
    #text(size: 14pt, weight: "bold")[
      Wydział Filozofii
    ]
    #v(3cm)
    
    // Author name
    #text(size: 14pt)[
      #author
    ]
        
    // Student ID
    #text(size: 12pt)[
      Nr albumu: #student-id
    ]
    
    #v(3cm)
    
    // Title
    #text(size: 24pt, weight: "bold")[
      #title
    ]
    
    #v(1.5cm)
    
    // Degree type
    #text(size: 12pt)[
      Praca #if degree-type == "licencjacka" [licencjacka] else [magisterska]
    ]
    

    
    // Field of study
    #text(size: 12pt)[
      na kierunku studiów #field-of-study
    ]
    
    #v(3cm)
    
    // Supervisor
    #text(size: 12pt)[
      #set align(right)
      Praca wykonana pod kierunkiem: \
      #supervisor \
      Wydział Filozofii UW
    ]
    
    #v(1fr)
    
    // Date and place
    #text(size: 12pt)[
      Warszawa, #date
    ]
  ]
  
  // Abstract and keywords page
  page(
    header: none,
    footer: none,
    margin: 2.5cm,
  )[
    #set align(center)
    #set par(justify: false, first-line-indent: 0cm)
    
    // Streszczenie heading
    #v(2cm)
    #text(size: 14pt, weight: "bold")[
      Streszczenie
    ]
    
    #v(0.2cm)
    #set align(left)
    #set par(justify: true, first-line-indent: 0cm, leading: 1.5em)
    
    // Abstract content
    #abstract
    
    #v(2cm)
    #set align(center)
    
    // Słowa kluczowe heading
    #text(size: 14pt, weight: "bold")[
      Słowa kluczowe
    ]
    
    #v(0.2cm)
    #set align(left)
    #set par(justify: false, first-line-indent: 0cm)
    
    // Keywords content
    #keywords.join(", ")
    
    #v(2cm)
    #set align(center)
    
    // English title heading
    #text(size: 14pt, weight: "bold")[
      Tytuł pracy w języku angielskim
    ]

    #v(0.2cm)
    #set align(left)
    #set par(justify: false, first-line-indent: 0cm)
    
    // English title content
    #title-english
  ]
  
// Table of contents
page(
  header: none,
  footer: none,
  margin: (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 2cm)
)[
  #outline(
    depth: 3,
    indent: auto,
  )
]

// Main content starts on page 1 with headers
set page(
  numbering: "1",
  header: none,
  footer: none,
  margin: (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 2cm)
)
counter(page).update(1)

// Level 1 chapter headings
show heading.where(level: 1): it => {
  pagebreak()
  v(3cm)
  text(size: 20pt, weight: "bold")[
    #it
  ]
  v(1cm)
}

// Level 2 section headings
show heading.where(level: 2): it => {
  v(1.5cm)
  text(size: 16pt, weight: "bold")[
    #it
  ]
  v(0.8cm)
}

// Level 3 subsection headings
show heading.where(level: 3): it => {
  v(1cm)
  text(size: 14pt, weight: "bold")[
    #it
  ]
  v(0.5cm)
}

body

}

#let dedication(content) = {
  page(
    header: none,
    footer: none,
  )[
    #v(1fr)
    #align(right)[
      #text(style: "italic")[
        #content
      ]
    ]
    #v(2fr)
  ]
}

#let acknowledgments(content) = {
  page[
    #heading(level: 1, numbering: none)[Podziękowania]
    #content
  ]
}

#let appendix(title: "", content) = {
  heading(level: 1, numbering: none)[Załącznik: #title]
  content
}