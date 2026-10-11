#import "../metadata.typ": *

#let project(body) = {
  // Set document metadata - single font for entire document
  set text(font: "Times New Roman", size: 13pt)
  
  // ===== TRANG BÌA (Title Page) =====
  set page(paper: "a4", margin: (x: 2cm, y: 2cm))
  
  // Header - University names centered
  align(center)[
    #text(weight: "bold", size: 10pt)[
      VIETNAM NATIONAL UNIVERSITY HO CHI MINH CITY \
      HO CHI MINH CITY UNIVERSITY OF TECHNOLOGY \
      FACULTY OF COMPUTER SCIENCE AND ENGINEERING
    ]
  ]
  
  v(1cm)
  
  // Logo
  align(center)[
    #image("../assets/hcmut.png", width: 3cm)
  ]
  
  v(1cm)
  
  // Course title with horizontal lines
  align(center)[
    #block[
      #align(center)[
        #text(weight: "bold", size: 14pt)[#course_code]
      ]
      #v(0.3em)
      #line(length: 100%, stroke: 0.5pt)
      #v(0.5em)
      #align(left)[
        #text(weight: "bold", size: 14pt)[Assignment]
      ]
      #v(0.5em)
      #text(weight: "bold", size: 24pt)[#title]
      #v(0.3em)
      #text(weight: "bold", size: 24pt)[#title_line2]
      #v(0.5em)
      #line(length: 100%, stroke: 0.5pt)
    ]
  ]
  
  v(3cm)
  
  // Advisor and Students info
  align(center)[
    #table(
      columns: (5cm, auto, auto),
      stroke: none,
      align: (right, left, left),
      [], [Advisor:], [#advisor],
      [], [Students:], [#members.at(0).name - #members.at(0).id numbers.],
      [], [], [#members.at(1).name - #members.at(1).id numbers.],
    )
  ]
  
  v(1fr)
  
  // Date and location
  align(center)[
    #text(size: 10pt)[#date_location]
  ]
  
  pagebreak()
  
  // ===== THIẾT LẬP CHO CÁC TRANG NỘI DUNG =====
  set page(
    paper: "a4",
    margin: (x: 2cm, top: 3cm, bottom: 2.5cm),
    header: {
      grid(
        columns: (auto, 1fr),
        align: (left, right),
        gutter: 0pt,
        [
          #grid(
            columns: (auto, auto),
            gutter: 8pt,
            align: (center, left),
            [#image("../assets/hcmut.png", width: 8mm)],
            [
              #text(weight: "bold", size: 9pt)[Ho Chi Minh City University of Technology] \
              #text(weight: "bold", size: 9pt)[Faculty of Computer Science and Engineering]
            ]
          )
        ],
        []
      )
      line(length: 100%, stroke: 0.3pt)
    },
    footer: {
      line(length: 100%, stroke: 0.3pt)
      v(0.3em)
      grid(
        columns: (1fr, auto),
        align: (left, right),
        [#text(size: 9pt)[Assignment for Discrete Structures for Computing - Academic year #academic_year]],
        context [#text(size: 9pt)[Page #counter(page).display() / #counter(page).final().first()]]
      )
    },
    header-ascent: 30%,
    footer-descent: 30%,
  )
  
  // Reset page counter for content pages
  counter(page).update(1)
  
  // Heading styles
  set heading(numbering: "1.1")
  show heading.where(level: 1): it => {
    v(0.5em)
    text(size: 16pt, weight: "bold")[
      #counter(heading).display() #h(0.5em) #it.body
    ]
    v(0.5em)
  }
  show heading.where(level: 2): it => {
    v(0.3em)
    text(size: 12pt, weight: "bold")[
      #counter(heading).display() #h(0.5em) #it.body
    ]
    v(0.3em)
  }
  
  // Mục lục
  align(left)[
    #text(size: 18pt, weight: "bold")[Mục lục]
  ]
  v(1em)
  outline(
    title: none,
    indent: 2em
  )
  pagebreak()
  
  // Nội dung chính
  body
}