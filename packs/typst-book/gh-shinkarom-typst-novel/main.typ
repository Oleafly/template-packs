#let book-title = "Your Novel Title"
#let book-subtitle = "A Novel"
#let book-author = "John Doe"

// DOCUMENT SETUP
#set document(title: "#book-title", description: "#book-subtitle")
#set page(
  paper: "us-trade", // 6" x 9"
  margin: (top: 0.75in, bottom: 1in, inside: 0.75in, outside: 0.75in),
)

// Professional typography with free fonts
#set text(
  font: "Garamond", // Free alternative to Minion Pro
  // Other good free options: "EB Garamond", "Libre Baskerville", "Gentium Book Plus"
  size: 14pt,
  lang: "en",
  hyphenate: true,
)

#set par(
  justify: true,
  first-line-indent: 1.2em,
)


#show heading.where(level: 1): it => {
  pagebreak(weak: true)
  v(1.5in)
  align(center)[
    #text(
      size: 32pt,
      weight: "bold",
      tracking: 0.1em,
    )[#emph[#it.body]]
    
    #v(1.5em)
    ]
  par(first-line-indent: 0pt)[] // No indent for first paragraph
}

// Include your style definitions
#include "styles.typ"
#set page(numbering: none)
// Front Cover
#page(margin: 20pt, fill: rgb("#1a1a1a"))[
  #set text(fill: white)
  
  // Top section with decorative line
  #place(top + center, dy: 60pt)[
    #line(length: 50%, stroke: (paint: white, thickness: 0.5pt))
  ]
  
  // Main title area
  #align(center + horizon)[
    #text(size: 42pt, weight: "bold", tracking: 2pt, hyphenate: false)[#upper(book-title)]
    
    #v(1.5em)
    
    #text(size: 28pt, style: "italic", weight: "light")[#book-subtitle]
    
  ]
  
  // Bottom decorative element
  #place(bottom + center, dy: -60pt)[
    #line(length: 30%, stroke: (paint: white, thickness: 0.5pt))
  ]
]
#pagebreak(to: "odd")
// FRONT MATTER

#align(center + horizon)[
  #set text(hyphenate: false)
  #text(size: 36pt, weight: "bold")[#upper(book-title)]
  
  #v(2em)
  
  #text(size: 24pt, style: "italic")[#book-subtitle]
  
  #v(4em)
  
  #text(size: 14pt)[© 2025]
]


// Copyright page
#pagebreak()
#set page(numbering: none)
#v(1fr)
#text(size: 10pt)[
  This is a work of fiction. Names, characters, places, and incidents either are the product of the author's imagination or are used fictitiously. Any resemblance to actual persons, living or dead, events, or locales is entirely coincidental.
  
  #v(1em)
  
  Copyright © 2025
  
]



// Blank page
//#pagebreak()
#v(1fr)



#set page(numbering: "i")
#counter(page).update(1)

#heading(level: 1, outlined: false)[CONTENTS]
#v(1em)

#outline(
  title: none,
  indent: auto,
  depth: 1,
)

// MAIN CONTENT
#set page(numbering: "1")
#counter(page).update(1)

// Simple running headers - just page numbers at top
#set page(
  footer: context {
    set text(size: 10pt)
    align(center)[#counter(page).display()]
  },
  header: none, // No footer in 80s style
)


#include "chapter-01.typ"

#pagebreak()
#set page(numbering: none)
#align(center + horizon)[
  #text(size: 18pt, tracking: 0.2em)[THE END]
]

// Back Cover
#page(margin: 40pt, fill: rgb("#1a1a1a"))[
  #set text(fill: white, size: 12pt)
  
  // Book description/blurb
  #align(top)[
    #text(size: 14pt, style: "italic")[
      // Add your book description here
      #book-title (#book-subtitle).
    ]
  ]
  
  #v(1fr)
 
  
  #v(2em)
  
  // ISBN and barcode area
  #align(bottom)[
    #grid(
      columns: (1fr, auto),
      gutter: 20pt,
      
      // Publisher info or category
      align(left)[
        #text(size: 10pt)[Fiction / Category]
      ],
      
      // ISBN placeholder
      align(right)[
        #rect(width: 100pt, height: 40pt, fill: white)[
          #align(center + horizon)[
            #text(fill: black, size: 8pt)[ISBN BARCODE]
          ]
        ]
      ]
    )
  ]
]