#let classic(
  title: "",
  subtitle: "",
  toc: false,
  font: "New Computer Modern Sans",
  monofont: "New Computer Modern Mono",
  authors: (),
  subject: "",
  career: "",
  date: "",
  npar: false,
  body,
) = {

  let authors_str = ""
  if type(authors) == array {
    authors_str = authors.join(", ")
  } else {
    authors_str = authors
  }

  set document(author: authors_str, title: title)

  set text(font: font, size: 11pt, lang: "es")

  set page(
    paper: "a4",
    margin: (top: 2.5cm, right: 2.5cm, left: 2.5cm, bottom: 1.5cm),
    header: [
      #set text(9pt)
      #grid(
      columns: (1fr, 1fr, 1fr),
      [#image("images/UNRN-logo.jpg", width: 30%)],[#align(center+horizon)[#smallcaps[#title]]],[#align(right+horizon)[#context[#counter(page).display()]]]
    )
      #line(length: 100%, stroke: 0.25pt)
    ]
  )

  set heading(numbering: "1.1")
  set math.equation(numbering: "(1)") 

  set par(leading: 1em)

  set list(
    indent: 0.3cm,
  )

  set enum(
    indent: 0.3cm,
    full: true
  )

  [
   #set page(paper: "a4", header: none, footer: none)

   #v(5em)

   #let bold-line = line(length: 100%, stroke: 0.75pt)
    
   #align(center)[#image("images/UNRN.png", width: 65%)]

   #v(1em)

   #bold-line

   #align(center)[#text(size: 32pt, weight: "extrabold")[#title]]

   #v(1em)

   #align(center)[#text(size: 24pt, weight: "bold")[#subtitle]]

   #bold-line

   #v(2em)

   #text(size: 16pt)[
     #align(center)[#authors_str]
   ]

   #v(20em)

  #text(size: 13pt)[
    #align(left)[
      #career

      #subject
    ]
  ]

   #text(size: 13pt)[
    #align(center + bottom)[#date]
   ]

   #v(5em)

   #pagebreak()
  ]

    let p = counter("p")
    let step = p.step()

    let margin = .4em

    let display(visible: bool) = context {
      let clearance = .4em
      let numbering = "1"
      if visible {
        let num = p.display(numbering)
        box(align(left)[#h(-1.5em) #num])
      } else {
        box(width: 0pt)
      }
    }

    let no-par-num = it => context { 
      let value = p.get()
      show par: x => { 
        if x.body.at("children", default: ()).at(0, default: none) == step {
          x 
        } 
        else { 
            par(step + display(visible: false) + x.body)
        } 
      }
      it
      p.update(value)
    }

    show par: it => {
      context { 
        if npar {
        if it.body.at("children", default: ()).at(0, default: none) == step {
          it
        } else {
          par(step + display(visible: true) + it.body)
        }
      } else {
        no-par-num(it)
      }
    }}


    show list: it => no-par-num(it)
    show enum: it => no-par-num(it)
    show terms: it => no-par-num(it)
    show terms.item: it => no-par-num(it)

    show heading: it => {
      p.update(0)
      it
    }

  show raw: set text(font: monofont)
  show raw.where(block: true): block.with(inset: 7pt, radius: 3pt, width: 100%)
  show raw.where(block: true): block.with(fill: rgb("#f2f2f2"), inset: 7pt, radius: 3pt, width: 100%)
  show raw.where(block: true): text.with(size: 10pt)
  show raw.where(block: false): text.with(size: 11pt)


  set footnote.entry(
    separator: [#v(0.2em) #line(length: 100%, stroke: 0.25pt)]
  )

  show table: align.with(center)
  show table.cell.where(y: 0): strong
  set table(
    column-gutter: 10pt,
    stroke: (x, y) => if y == 0 {
      (bottom: 0.7pt + black)
    },
  )

  if toc {
    outline(title: [*Índice*], indent: 1em)
    pagebreak()
  }

  body

}
