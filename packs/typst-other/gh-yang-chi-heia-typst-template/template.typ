#let project(
  title: "",
  subtitle: "",
  authors: (),
  teachers: (),
  body,
) = {
  // Set the document's basic properties.
  set document(author: authors.map(a => a.name), title: title)  
  set text(font: "Linux Libertine", lang: "fr")

  
  align(center, image("image/template/main-heia-fr.png", width: 95%))
  
  v(50pt)  
  
  align(center)[#line(length: 70%, stroke: 1pt)]
     
  align(center)[
    #text(18pt, weight: 700, title)
  ]  
   
  align(center)[
    #text(16pt, subtitle)
  ] 
  
  
  align(center)[#datetime.today().display("[year]")]

  v(10pt)  
  
  align(center)[#line(length: 70%, stroke: 1pt)]
  
  // Author information.
  v(60pt)
  pad(
    top: 0.5em,
    bottom: 0.5em,
    x: 2em,
    align(left)[#text(16pt, "Author :", weight: "bold")]    
  )
  v(10pt)
  pad(
    top: 0.5em,
    bottom: 0.5em,
    x: 2em,
    grid(
      columns: (1fr,) * calc.min(3, authors.len()),
      gutter: 1em,
      ..authors.map(author => align(left)[
        *#author.name* \
        #author.email \
        #author.affiliation 
      ]),
    ),
  )
  

  v(30pt)
  
  // Teacher information section
  if teachers.len() > 0 {
    pad(
      top: 0.5em,
      bottom: 0.5em,
      x: 2em,
      align(left)[#text(16pt, "Supervisors / Teachers :", weight: "bold")]    
    )
    
    v(10pt)
    
    pad(
      top: 0.5em,
      bottom: 0.5em,
      x: 2em,
      grid(
        columns: (1fr,) * calc.min(3, teachers.len()), // Same grid layout as authors
        gutter: 1em,
        ..teachers.map(teacher => align(left)[
          *#teacher.name* \
          #teacher.email \
          #teacher.affiliation 
        ]),
      ),
    )
  }
    
  align(center + bottom)[#text(12pt, "Fribourg, le ")#datetime.today().display("[day].[month].[year]")]
  
  // Main body.
  set par(justify: true)

  pagebreak()


  // Table of contents.
  outline(depth: 3, title: "Table des matières")
  
  pagebreak()
  
  set page(numbering: "1", number-align: center)
  counter(page).update(1)
  body
  
  pagebreak()
  set page(numbering: none)
  bibliography("bibliography.bib")

  pagebreak()
  outline(
  title: [Liste des figures],
  target: figure.where(kind: image),
)
  
}
