
#import "@preview/hydra:0.6.1": hydra

#let fantasy-encyclopedia(title:"", body) = {

  set page(paper: "a4", numbering: none, background:{image("cover.png", width: 100%)})

  align(horizon+center,text(title, font: "Charm", size: 60pt, fill: rgb("#cdb15b")))
  pagebreak()


  set page(
    paper: "a4",
    header: context {
            if calc.odd(here().page()) {
              align(right, text(emph(hydra(1,skip-starting: false,use-last: true)), font:"Charm"))
            } else {
              align(left, text(emph(hydra(1,skip-starting: false)), font: "Charm")) 
            }
            //line(length: 100%)
          },
    footer: context { 
            if calc.odd(here().page()) {              
              align(right,  {                             
                h(20pt)                 
                text(counter(page).display("1"), font: "Charm",size: 14pt)
              })
            } else {
              align(left,  {
                h(-20pt)
                text(counter(page).display("1"), font: "Charm",size: 14pt)
              }) 
            }            
          },      
    columns: 2,
    numbering: "1",
    background: context{
            if calc.odd(here().page()) {
              scale(x: -100%,image("page_border.png", width: 100%))
            } else {
              image("page_border.png", width: 100%)
            }
      
    }
  )
  counter(page).update(1)

  


  set par(justify: true)
  set text(
    font: "Merriweather 24pt",
    size: 10pt,
  )
  set align(left)

  show heading.where(
    level: 1
  ): it => block(width: 100%)[
    #set align(left)
    #set text(20pt, weight: "bold",font:"Charm"    )
    #v(0.2em)
    #text(it.body)
    #v(0.1em)
  ]

  body
}