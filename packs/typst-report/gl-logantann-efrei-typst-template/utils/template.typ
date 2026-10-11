// TEMPLATE DOCUMENT


#let buildMainHeader(mainHeadingContent) = {
  [    
    #h(1fr)  #emph(mainHeadingContent) 
    #line(length: 100%)
  ]
}

#let template(
  title: [],
  authors: (),
  keywords: (1.),
  abstract: [],
  publisher: "",
  paper-type: [Article],
  body
) = {
  set page(
    paper: "a4",
    numbering: "1",
    number-align: right,
    header: buildMainHeader(paper-type)
  )
  set text(font: "Libertinus Serif", lang: "fr")

  set list(indent: 8pt)
  show heading: set block(below: 8pt)
  
  if publisher != none {
    align(center, publisher)
  }

  v(0.25fr)

  text(1.1em, paper-type)
  v(1.2em, weak: true)
  text(2em, weight: 700, title)

  // Author information.
  pad(
    top: 0.7em,
    grid(
      rows: authors.len(),
      gutter: 1em,
      ..authors.map(author => align(start)[
        #author.affiliation *#author.name* $quad$
        _#author.postal _
      ]),
    ),
  )

  v(1fr)

  // Main body.
  set par(justify: true)
  
  line(length: 100%)
  pad(
    y: 0.3cm,
    left: 1cm,
    right: 1cm,
    text(size: 11pt)[
      #smallcaps[*Abstract*]\
      #abstract
      
      #v(.7em)
      #smallcaps[*Keywords*]\
      #{keywords.join("; ")}.
    ]
  )

  // Styling
  show heading.where(
    level: 1,
    numbering: "I.1.a.",
  ): it => box(inset: (left: 20pt, top: 10pt, bottom: 10pt),text(size: 20pt, it))

  body
}