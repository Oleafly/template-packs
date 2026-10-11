#let project(
  title: "",
  work-type: "",
  lecture: "",
  professor: "",
  authors: (),
  body,
) = {

  // document metadata
  set document(title: title)

  // page defaults
  set page(
    paper: "a4",
    margin: (top: 3cm, bottom: 2.5cm, left: 2.5cm, right: 2cm),
    header: none,
    footer: none,
    numbering: none,
  )

  set text(font: "New Computer Modern", size: 11pt, lang: "de")
  set par(justify: true, leading: 0.65em)
  set heading(numbering: "1.1")
  show heading.where(level: 1): it => {
    v(0.8em)
    it
    v(0.5em)
  }

  // cover page
  page(
    margin: (top: 3cm, bottom: 2cm, left: 2.5cm, right: 2cm),
    header: none,
    footer: none,
    numbering: none,
  )[
    // Logo centered at top
    #align(center)[
      #image("HKALogo.png", width: 80%)
    ]

    #v(1fr)

    // Title block
    #align(center)[
      #text(size: 14pt, weight: "bold")[#work-type]
      #v(0.4em)
      #text(size: 22pt, weight: "bold")[#title]
      #v(1.2em)
      #v(1.2em)
      #text(size: 14pt, weight: "medium")[Im Rahmen der Vorlesung 
      
      _#lecture _ 
      
      bei]
       #v(1.2em)
      #text(size: 14pt, weight: "bold")[#professor]
      
    ]

    #v(1fr)
    
    // Authors table
    #align(center)[
      #text(size: 13pt)[Erarbeitet von:]
      #table(
        columns: (auto, ),
        align: (left),
        stroke: none,
        inset: 8pt,

        ..authors.map(a => text(size: 13pt, a.name)).flatten()
      )
    ]
    #v(2cm)
  ]

  // table of contents
  page(
    margin: (top: 3cm, bottom: 2.5cm, left: 2.5cm, right: 2cm),
    header: none,
    footer: none,
    numbering: none,
  )[
    #text(size: 13pt)[#outline(indent: auto, depth: 3)]
  ]

  // main content: header + page numbers
  set page(
    margin: (top: 3cm, bottom: 2.5cm, left: 2.5cm, right: 2cm),
    numbering: "1",
    number-align: center,
    header: [
      #text(size: 15pt)[#work-type]
      #v(-0.6em)
      #line(length: 100%, stroke: 0.4pt)
    ],
    footer: context [
      #align(center)[
        #text(size: 15pt)[#counter(page).display("1")]
      ]
    ],
  )

  // reset page counter for main content
  counter(page).update(1)

  body
}
