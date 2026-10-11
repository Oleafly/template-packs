// main.typ

#import "/globals.typ": *

//----------- Page format, header for reference number and page numbering format -----------

#set page(
  paper: "a4",
  margin: (x: 2.54cm, y: 2.54cm),
  header: align(
    right + horizon,
    ref_number
  ),
  // numbering: "第 1 頁，共 1 頁",
  numbering: "1 of 1",
  columns: 1,
  fill: rgb("#fffbf7"),
)

#set heading(numbering: "1.1. ")

//----------- Title, etc format -----------

#place(
  top + center,
  float: true,
  scope: "parent",
  clearance: 2em,
)[
  #align(center, text(17pt)[
    *#title* 
    ]
  )

  #align(center, text(14pt)[
    *#subtitle*
    ]
  )

  #align(
    center, text(12pt)[
      #affiliation
      ]
  )
  
  #align(center, text(12pt)[
    #author \ #send-email
    ]
  )

  #align(center, text(12pt)[
    #date
    ]
  )
]

#show heading: it => [
  #set align(center)
  #set text(13pt, weight: "regular")
  #block(smallcaps(it))
]

#show heading.where(
  level: 2
): it => text(
  size: 11pt,
  weight: "regular",
  style: "italic",
  it,
)

//----------- Link colour -----------

#show link: set text(fill: blue.darken(10%))

//----------- Table of Contents -----------

// --------------------
// #outline(title: "XX", indent: auto) can use this to change title of the outline (default as "Contents") to "XX"
// --------------------

#outline(depth: 2, indent: auto)

//----------- Author's footnote -----------

#place(
  left + bottom,
  dx: 10pt,
  float: true,
  scope: "parent",
  text(size: 8pt, super[\*] + "your qualifications"),
)

//----------- Contents -----------


#include "/sections/index.typ"