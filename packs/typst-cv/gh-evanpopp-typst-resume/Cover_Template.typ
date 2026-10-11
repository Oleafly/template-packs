// 1. Page Setup & Background Color
#set page(
  paper: "us-letter",
  margin: (x: 0.5in, y: 0.5in),
  fill: rgb("#f4f1ea") 
)

// 2. Package Imports (UPDATED)
#import "@preview/fontawesome:0.6.2": *  // Updated to 0.4.0 to fix the locate error
#import "@preview/cades:0.3.1": qr-code  // Swapped to your preferred QR package

// 3. Exact Color & Font Definitions (UPDATED)
#let name-color = rgb("#342129")   
#let text-color = rgb("#333333")   
#let title-color = rgb("#3e3e3e")  
#let qr-color = rgb("#008c3a")     
#let line-color = rgb("#81b1a7")   

// Swapped to natively supported Typst fonts
#let serif-font = ("PT Serif")
#let sans-font = ("Roboto")

// Set base document text
#set text(font: serif-font, fill: text-color, size: 9.5pt)

// Match the bullet point indentation from your design
#set list(indent: 9.9pt, body-indent: 6pt)

//#show link: underline

// ==========================================
// HELPER FUNCTIONS (Keep your code clean)
// ==========================================

// 1. Formats the dark plum section titles
#let section-title(title) = {
  v(-8pt) // Pulls the title upwards closer to the dividing line above it
  text(font: sans-font, size: 14pt, fill: name-color, tracking: 1pt)[#upper(title)]
  v(-4pt)  // Shrinks the gap below the title before the content starts
}

// 2. Draws the teal divider lines
#let section-divider() = {
  line(length: 100%, stroke: 1.2pt + line-color)
}

// 3. Aligns the institution/dates and formats the subtitles/bullets
#let resume-entry(title, date, subtitle, body: none) = {
  block(width: 100%, breakable: false)[
    #grid(
      columns: (1fr, auto),
      align: (left, right),
      title,
      date
    )
    #v(-6pt)
    #text(fill: text-color)[#subtitle]
    #if body != none [
      #v(-4pt)
      #body
    ]
  ]
}

// 4. Header Layout Grid
#grid(
  columns: (1.5fr, auto, 1fr),
  gutter: 20pt,
  align: (left + horizon, left + horizon, right + horizon),
  
  // LEFT COLUMN
  [
    #text(font: serif-font, size: 30pt, fill: name-color, weight: "regular")[Evan Popp] \
    #v(2pt)
    #text(font: sans-font, size: 12pt, fill: title-color, weight: "bold", tracking: 0.5pt)[
      ELECTRICAL ENGINEER \
      (PHOTONICS)
    ]
  ],
  
  // MIDDLE COLUMN
  [
    #grid(
      columns: (auto, auto),
      gutter: 6pt,
      align: (center + horizon, left + horizon),
      
      fa-github(), [
        #link("https://github.com/evanpopp")[
          #text(fill: rgb("#0066cc"))[/evanpopp]
        ]
      ],
      fa-linkedin(), [
        #link("www.linkedin.com/in/evan-popp-ee")[
          #text(fill: rgb("#0066cc"))[/in/evan-popp-ee]
        ]
      ],
      fa-envelope(), [
        #link("mailto:contact@evanpopp.me")[
          #text(fill: rgb("#0066cc"))[contact\@evanpopp.me]
        ]
      ],
      fa-globe(), [
        #link("https://evanpopp.me")[
          #text(fill: rgb("#0066cc"))[evanpopp.me]
        ]
      ]
    )
  ], 

 // RIGHT COLUMN
  [
    #qr-code("https://evanpopp.me", color: qr-color, width: 2.2cm)
  ]
)
  #v(2pt)
  #line(length: 100%, stroke: 1.2pt + line-color)

// ==========================================
// COVER LETTER CONTENT
// ==========================================

#v(15pt)

#text(font: serif-font, fill: text-color, size: 13pt)[
Dear Hiring Team,

I am like really smart :)

#v(15pt)
Sincerely,


#text(weight: "bold")[Evan Popp] \
]