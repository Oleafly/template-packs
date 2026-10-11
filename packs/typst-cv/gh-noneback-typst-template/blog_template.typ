#let doc_tmplate(
  title: none, 
  authors: (),
  keywords: (),
  category:(),
  abstract: [],
  doc
) = {
set page(
  paper: "us-letter", header: align(right+horizon, title), numbering: "1",
)
set par(
  justify: true
)
set text(
  font: ("Times New Roman","Songti SC"),
  size: 11pt
)
show link: underline
// title
align(center , text(17pt)[
  *#title*
])

// author
let ncols = calc.min(authors.len(), 3)
set align(center)
grid(
  columns: (1fr,) * ncols, row-gutter: 24pt, 
  ..authors.map(author => [
    #author.name \
    #author.affiliation \
    #link("mailto:" + author.email)
  ])
)

// abstract
par(justify: false)[
  *Abstract* \
  #abstract
]
// keyword & category
par(justify: true)[
  #align(left)[
    *keywords*: #keywords \
    *categories*: #category \
  ]
]

// heading
show heading.where(
  level: 1
): it => block(width: 100%)[
  #set align(center)
  #set text(12pt, weight: "bold")
  #it.body \
]

show heading.where(
  level: 2
): it => block(width: 100%)[
  #set align(left)
  #set text(11pt, weight: "bold", style: "italic")
  #it.body\
]

show heading.where(
  level: 3
): it => block(width: 100%)[
  #set align(center)
  #set text(11pt, weight: "regular", style: "italic")
  #smallcaps(it.body)
]
// outline
set heading(numbering: "1.1.")
outline(
  indent: 1em
)
linebreak()
// list item
set enum(numbering: "1.a.i")
// content
columns(2, align(left)[#doc])
}

#let insert_image(
  path, name, desc
)= {
  figure(
    image(path, width:90%), caption: [#desc],
  )
}


/* */


