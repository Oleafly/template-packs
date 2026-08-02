
// +-------------------------------------------+
// |        SETTINGS OF THE DOCUMENT           |
// +-------------------------------------------+

#let loadStyle(doc) = {
  set text(
    font: "Roboto",
    size: 11pt,
    lang: "de"
  )
  
  set heading(numbering: "1.1.1.")
  
  show heading.where(level: 1): it => block(width: 100%)[
    #set text(18pt, weight: 1200, font: "Cascadia Mono")
    #smallcaps(it)
    #v(4mm)
  ]
  
  show heading.where(level: 2): it => block(width: 100%)[
    #set text(16pt, weight: 1000, font: "Cascadia Mono")
    #smallcaps(it)
    #v(2mm)
  ]
  
  show heading.where(level: 3): it => block(width: 100%)[
    #set text(14pt, weight: 800, font: "Cascadia Mono")
    #smallcaps(it)
    #v(2mm)
  ]
  
  set page(
    paper: "a4",
    margin: (
      top: 3cm,
      bottom: 2cm,
      //left: 1.5cm,
      //right: 1.5cm
    )
  )
  set par(
    justify: true,
    leading: 0.52em,
  )
  doc
}


// +-------------------------------------------+
// |         STYLE OF THE HEADER               |
// +-------------------------------------------+

#let setHeader(line1: [], line2: [], author: ()) = {
  set text(font: "Cascadia Mono", size: 10pt, weight: "bold", fill: rgb("#a7b2a2"))
  grid( columns: (33%,33%,33%), gutter: 0%,
    [
      #set align(left);
    ],
    [
      #set align(center);
      #line1;
      #linebreak();
      #line2
    ],
    [
      #set align(right);
      #image("../images/logos/TP_Logo_150px_ligth_green.jpg", height: 1cm)
    ]
  )
}

// +-------------------------------------------+
// |         STYLE OF THE FOOTER               |
// +-------------------------------------------+

#let setFooter(line1: [], line2: [], author: ()) = {
  set text(font: "Cascadia Mono", size: 10pt, weight: "bold", fill: rgb("#a7b2a2"))
  grid( columns: (10%,80%,10%), gutter: 0%,
    [
      #set align(left);
    ],
    [
      #set align(center);
      #author.name - #author.address.street - #author.address.place
    ],
    [
      #set align(right);
      #counter(page).display("1")
    ]
  )
}

// +-------------------------------------------+
// |       STYLE OF THE TITLEPAGE              |
// +-------------------------------------------+

#let titlePage(
  title: "Anschreiben",
  company: (),
  author: (),
  firstpage: [],
  doc,
) = {
  
  set page(
    header: setHeader(line1: title, line2: company.name, author: author),
    footer: setFooter(line1: title, line2: company.name, author: author)
  )
  
  set text(font: "Roboto")
  set align(left)
  
  grid(columns: (80%, 20%),
    [
      #set text(weight: "bold", size: 36pt, font: "Cascadia Mono") 
      #title
    ], [
      #set align(right)
      //#image(alt: "HKA-Logo", width: 6cm, "../images/logos/TP_Logo_1600px_ligth_green.jpg")
    ]
  )

  v(1cm)
    
  table(columns: (20%, 50%), stroke: 0mm, align: (right, left),
    "Name",   author.name,
    "E-Mail", author.email,
    "Straße", author.address.street,
    "Ort",    author.address.place,
    "Land",   author.address.contry
  )

  v(1cm)
  
  table(columns: (20%, 50%), stroke: 0mm, align: (right, left),
    "Name",   company.name,
    "Straße", company.address.street,
    "Ort",    company.address.place,
    "Land",   company.address.contry
  )
  
  if(firstpage != []){
    v(1cm)
    firstpage
  }
  
  loadStyle(
    doc
  )
}
