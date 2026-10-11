#let main-heading(
  title: "Document Title: A Title For My Poster",
  author: "Author Name",
  supervisor: "Supervisor Name",
  tutor: "Tutor Name",
  email: "mail@email.edu",
  phdcycle: "XLI",
  logo-left: "Unimib.png",
  logo-right: none,
  body
) = [
///////////////////////////////////////////////////////////////////////// 
/// 1. Global Document Settings
/////////////////////////////////////////////////////////////////////////
  #set text(font: ("Arial", "Noto Serif"), size: 28pt)
  #show figure.caption: set align(left)
  #set page("a0", margin: (x: 3cm, y: 3cm))
  


///////////////////////////////////////////////////////////////////////// 
/// 2. The Header Layout
/////////////////////////////////////////////////////////////////////////
  #grid(
    columns: (16cm, 1fr, 16cm), 
    column-gutter: 4cm,        
    align: horizon,
    
    // Column 1: University Logo
    if logo-left != none { image(logo-left, width: 90%) } else { [] },
    
    // Column 2: Dynamic Title & Metadata
    align(center, [
      #text(size: 80pt, weight: "bold", fill: rgb("#777457"))[#title] \
      #v(8pt)
      #set par(spacing: 0.4em)
      #text(size: 44pt, fill: black)[#author] \
      #text(size: 36pt, fill: black)[Supervisor: #supervisor] \
      #text(size: 36pt, fill: black)[Tutor: #tutor]
    ]),
    
    // Column 3: Research Group Logo
    if logo-right != none { image(logo-right, width: 90%) } else { [] }
  )

  #v(-2cm)

  #grid(
    columns: (18cm, 1fr, 18cm),
    align: horizon,
  
    [],
  
    align(center, [
      #text(size: 36pt, fill: black)[Department of Informatics, Systems and Communication DISCo] \
      #text(size: 36pt, fill: black)[Ph.D. Program in Computer Science, #phdcycle Cycle]
    ]),
  
    align(left,
      text(size: 36pt, fill: black, font: ("Courier New", "Noto Serif"))[#email]
    )
  )

  #line(length: 100%, stroke: 2mm + rgb("#777457"))

  #body
]

///////////////////////////////////////////////////////////////////////// 
/// 3. Dual Grid
/////////////////////////////////////////////////////////////////////////
#let dual-grid(
  title1, body1,
  title2, body2,
  title-size: 44pt
) = {
  
  v(-0.8cm)
  let quadrant(title, body) = [
    #v(-1.2cm)
    #box(
      stroke: 2mm + rgb("#777457"),
      inset: 32pt,
      width: 100%,
      align(center)[
        #text(size: title-size, weight: "bold", fill: rgb("#777457"))[#title]
      ]
    )
    #v(-0.4cm)
    #set par(justify: true)
    #text()[#body]
  ]

  grid(
    columns: (1fr, 1fr),
    inset: (x, y) => (
      top: 36pt,
      bottom: 36pt,
      left: if x == 0 { 0pt } else { 48pt },
      right: if x == 1 { 0pt } else { 48pt },
    ),

    stroke: (x, y) => (
      right: if x < 1 { 2mm + rgb("#777457") },
      bottom: if y < 1 { 2mm + rgb("#777457") },
    ),
    
    // Populate the cells
    quadrant(title1, body1),
    quadrant(title2, body2),
  )
}



///////////////////////////////////////////////////////////////////////// 
/// 4. Wide Section
/////////////////////////////////////////////////////////////////////////

#let wide-section(
  title,
  left-body,
  right-body,
  title-size: 44pt
) = [
  #v(-0.8cm)
  
  // 1. Full-width stretched title box
  #box(
    stroke: 2mm + rgb("#777457"), 
    inset: 32pt, 
    width: 100%,
    align(center)[
      #text(size: title-size, weight: "bold", fill: rgb("#777457"))[#title]
    ]
  )
  #v(-0.4cm) 

  // 2. Two-column grid layout for the text
  #grid(
    columns: (1fr, 1fr),
    column-gutter: 96pt,
    [
      #set par(justify: true)
      #text()[#left-body]
    ],
    [
      #set par(justify: true)
      #text()[#right-body]
    ]
  )
  #line(length: 100%, stroke: 2mm + rgb("#777457"))
]