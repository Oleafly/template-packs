#import "template/thesis-template.typ" as thesis
#import "imports.typ": *



#show: thesis.thesis.with(
  title: [Thesis Template],
  author: "Max Mustermann",
  email: "max.mustermann@example.com",
  university: [School of Engineering and Architecture],
  fields: (
    "Advisor" : [John Advisor],
    "1st Expert" : [John Expert 1],
    "2nd Expert" : [John Expert 2],
  ),
  accent-paint: blue,
  coverpage: (title, author, email, creation-date, university, fields, paint) => {
    page(margin: 0pt, {
      // for cover page to display industry partner and experts
      import "@preview/nth:1.0.1"
  
      grid(
        columns: (auto, 1fr),
        block(height: 100%, width: 1cm, fill: paint, inset: 2mm, align(bottom + right, {
          rotate(-90deg, reflow: true, image("assets/HSLU_2022_logo.svg", height: 6mm))
        })),
  
        grid.cell(inset: (x: 2cm, y: 3cm), [
          #upper[
            #strong(university)\
            Master of Engineering in Typst Typography
          ]
          #v(3cm, weak: true)
          #text(3em, strong(title))
          #v(2cm, weak: true)
          #text(strong(author))#linebreak()
          #link("mailto:" + email, email)
          #v(1fr, weak: true)
          #show grid.cell.where(x: 0): strong
          #grid(
            rows: 1em,
            columns: 2,
            column-gutter: 1em,
            row-gutter: 0.3em,
            align: (right,left),
            ..fields.pairs().flatten()
          )
  
          #v(1em, weak: true)
          #emph(creation-date.display("[month repr:long] [day], [year]"))
        ]),
      )
    }) + page(place(bottom+center,[This page is intentionally left blank.]))
  },
)


/* ------------------------------------------------------ */
/* CONTENT                                                */
/* ------------------------------------------------------ */
#show raw: set text(font: "JetBrains Mono")
#show heading: set text(font:"Cantarell")
#set text(font: "Libertinus Serif")


// FRONT MATTER -----------------------------------------
#show: thesis.frontmatter

#include "content/frontmatter/acknowledgements.typ"
#include "content/frontmatter/infosheet.typ"
#include "content/frontmatter/abstract.typ"
#include "content/frontmatter/glossary.typ"
#include "content/frontmatter/outline.typ"


// MAIN MATTER ------------------------------------------
#show: thesis.mainmatter

#show heading.where(level: 1): it => {
  counter(figure.where(kind: "timing-diagrams")).update(0)
  it
}
#set raw(lang :"typc")

#show link: set text(blue)
#show link: underline.with(offset: 0.15em)


#include "content/template-showcase.typ"


// BACK MATTER ------------------------------------------
#show: thesis.backmatter

#include "content/backmatter/bibliography.typ"
#include "content/backmatter/listofthings.typ"


// APPENDIX ---------------------------------------------
#show: thesis.appendix

#include "content/appendix/used_things.typ"


/* ------------------------------------------------------ */
/* END CONTENT                                            */
/* ------------------------------------------------------ */



// DELETE ME  DELETE ME  DELETE ME  DELETE ME  DELETE ME  DELETE ME  DELETE ME
#set heading(outlined: true)
#show heading.where(level: 1): it => {
  it.body
}
#show link: set text(black)
#show link: set underline(stroke: 0pt)

#page(
  background: rotate(40deg, text(
    9em,
    red.lighten(70%),
    font: "JetBrains Mono",
    text(stroke: red.lighten(70%) + 3pt, strong[
      #h(0em) #box[Delete me!]#h(2em)
      #v(0.4em, weak: true)
      #h(0em) #box[Delete me!]#h(0em)
      #v(0.4em, weak: true)
      #box[Delete me!]#h(-2em)
    ]),
  )),
  [
    #drafting.note-outline(title: [List of Notes #text(red, [DELETE ME WHEN FINISHED!])])
  ],
)
