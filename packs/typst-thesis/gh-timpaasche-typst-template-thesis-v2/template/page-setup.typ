#import "/template/tp-functions.typ": *
#import "/metadata.typ": *


// own header design
#let get-tp-header(line1: none, line2: none, image1: none, image2: none, double-pages: true) = [
  #set text(font: "Cascadia Mono", size: 10pt, fill: black)
  #let page = counter(page).get().first()
  #let imageLeft = if calc.even(page) and double-pages {image2} else {image1}
  #let imageRight = if calc.even(page) and double-pages {image1} else {image2}
  #grid(columns: (25%,50%,25%), gutter: 0%,
    [#set align(left);#if imageLeft != none {image(imageLeft, height: 1cm)}],
    [#set align(center); #line1; #linebreak(); #line2],
    [#set align(right);#if imageRight != none {image(imageRight, height: 1cm)}]
  )
]


// own footer design
#let get-tp-footer(local-authores, preface: false, double-pages: true) = [
  #set text(font: "Cascadia Mono", size: 10pt, fill: black)
  #let loacl-page = counter(page).get().first()
  #grid(columns: (20%,60%,20%), gutter: 0%,
    [ #if double-pages and calc.even(loacl-page) {align(left, counter(page).display(if preface{"I"} else {"1"}))} ],
    [ #align(center, for local-author in local-authores {get-full-name(local-author);if(local-authores.last() != local-author){" - "}}) ],
    [ #set align(right);#if calc.odd(loacl-page) {counter(page).display(if preface{"I"} else {"1"})} else if not double-pages {counter(page).display(if preface{"I"} else {"1"})}  ]
  )
]


#let set-up(
  body
) = {
  
  set page(
    paper: "a4",
    margin: (top: 3cm, bottom: 2.4cm, left: 2.2cm, right: 2.2cm),
    header: context {get-tp-header(line1: "Title", line2: "Subtitle", image1:"/src/images/logos/HKA_EIT_Logo.jpg", image2: "/src/images/logos/TP_Logo_150px_ligth_green.jpg")},
    footer: context {get-tp-footer(authors, preface: true)},
  )

  set text(
    font: "Roboto",
    size: 11pt,
    lang: "de",
  )
    
  set heading(numbering: none, outlined: false)
    
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
  
  set par(
    justify: true,
    linebreaks: "optimized"
  )
  
  set outline(
    indent: auto,
  )
  
  show raw.where(block: true): local-raw => [
    #align(center, block(
      fill: luma(240),
      inset: 10pt,
      radius: 4pt,
      width: 90%,
      align(left, local-raw))
  )]

  body
}

#let change-style-to-main(body) = {
  set page(
    header: context {
      get-tp-header(line1: "Title", line2: "Subtitle", image1:"/src/images/logos/HKA_EIT_Logo.jpg", image2: "/src/images/logos/TP_Logo_150px_ligth_green.jpg")
    },
    footer: context {
      get-tp-footer(authors, preface: false,)
    },
  )

  set heading(numbering: "1.1.1.", outlined: true)
  
  counter(page).update(1) 

  body
}


// own title page design
#let create-tp-titlepage(
  document-type: "Thesis",
  subtitle: "Placeholder for the title",
  main-image: none,
  authors: (create-metadata-of-person(),),
  technicalSupervisors: none,
  scientificSupervisors: none
) = [
  #set align(center)
  #set text(font: "Cascadia Mono", size: 12pt, lang: "de")
  #v(3cm)
  #if main-image != none {
    image(alt: "Thesis-Logo", height: 4cm, main-image)
    v(8mm)
  } else {
    v(6cm)
    v(8mm)
  }
  
  #text(weight: "bold", size: 36pt, document-type)#v(-2em)
  #text(weight: "bold", size: 24pt, subtitle)#v(16mm)
  #set text(weight: "regular", size: 12pt)
  
  #let dict = get-titlepage-dictionary(
    authors: authors,
    technicalSupervisors: technicalSupervisors,
    scientificSupervisors: scientificSupervisors
  )
  #table(columns: (50%, 50%), stroke: 0mm, align: (right, left), ..for (k, v) in dict{(k, v)})
  #v(1cm)
  #table(columns: (50%, 50%), stroke: 0mm, align: (right, left), 
      "Datum:", [#datetime.today().display("[day].[month].[year]")]
    )
  
  #pagebreak()
]
