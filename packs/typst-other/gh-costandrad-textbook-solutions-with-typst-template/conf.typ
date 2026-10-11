
#import "@preview/cetz:0.4.2"
#import "@preview/cetz-plot:0.1.3"
#import "@preview/lilaq:0.5.0" as lq

#let primary-color = rgb("#c91437")
#let secondary-color = rgb("#808387")


#let darkred = rgb("#b00008")
#let akared = rgb("#c80009")


#let solution(content) = [
  #rect(radius: 5pt, stroke: primary-color, fill: white, inset: 8pt)[
    #text(fill: primary-color, weight: "bold")[Solução:]
  ]
  
  #content

  #align(right)[
    #h(1fr) #rect(width: 10pt, height: 10pt, fill: primary-color)
  ]
]

#let conf(
  author: [],
  repo: [https://github.com/costandrad], 
  book: (
    title: "",
    subtitle: none,
    year: 2013,
    press: "Bookman",
    address: "Porto Alegre",
    authors: (
      (
        name: "",
        short-name: "",
      ),
      (
        name: "",
        short-name: "",
      ),
    ),
    
    chapter: (
      number: 1,
      title: ""
    )
  ),

  doc
) = {

  let book_authors = book.authors.flatten().map(a => a.short-name).join("; ")
  let book_subtitle = if book.subtitle != none {". : #book.subtitle"} else {""}

  let references = text(weight: "light")[#upper(book_authors) #text(weight: "bold")[#book.title]#book_subtitle. #book.address: #book.press, #book.year.]


  set page(
    paper: "a4",
    margin: (top: 3cm, bottom: 2cm, left: 2cm, right: 2cm),
    header: context {
      if here().page() == 1 {
        []
      } else if calc.rem(here().page(), 2) == 0 {
        [
          #set text(size: 10pt)
          #rect(width: 100%, stroke: (bottom: 0.6pt))[
            #text(weight: "bold")[#book.title (#book_authors)]
            #h(1fr) #counter(page).display()
          ]
        ]
      } else {
        [
          #set text(size: 10pt)
          #rect(width: 100%, stroke: (bottom: 0.6pt))[
            #counter(page).display()
            #h(1fr) 
            #text(weight: "bold")[#author]
            
          ]
        ]
      }
    },
    footer: [
      #set text(size: 10pt)
      #rect(width: 100%, stroke: (top: 0.6pt))[
        #text(weight: "bold")[Capítulo #book.chapter.number: #book.chapter.title]
        #h(1fr) #link("#repo")[#text(fill: darkred)[#repo]]
      ]

    ]
  )

  set text(
    lang: "pt",
    font: "Arial",
    size: 12pt
  )

  set par(
    //first-line-indent: (amount: 1.25cm, all: true),
    justify: true,
    leading: 1.0em
  )

  place(
    top+center,
    float: true,
    scope: "parent",
    clearance: 2em,
    {
      rect(width: 100%, radius: 5pt, stroke: primary-color, inset: 10pt)[
        #grid(
          columns: (4fr, 8fr, 4fr),
          align(horizon+left)[
            //#image("assets/images/cover.png", height: 3cm)
            #image("assets/images/icone.svg", height: 3cm)
          ],
          align(horizon+center)[
            #text(fill: primary-color, size: 20pt, weight: "bold")[#book.title]\
            
            #text(fill: black, weight: "light")[#book_authors]\

            #text(weight: "bold")[Resoluções por]\

            #text(fill: akared, size: 15pt, weight: "bold")[#author]\
          ],
          align(horizon+right)[
            //#image("assets/images/icone.svg", height: 3cm)
            #image("assets/images/cover.png", height: 3cm)
          ],
        )
      ]
    }
  )

  rect(width: 100%, radius: 5pt, inset: 10pt, stroke: none, fill: white)[
    #set text(weight: "bold", fill: primary-color, size: 14pt)
    #align(center)[
      Capítulo #book.chapter.number: #book.chapter.title
    ]
  ]

  doc

  v(1fr)
  text(weight: "bold", size: 14pt)[Referências]
  v(0.25cm)
  
  references
}