#import "@preview/datify:1.0.1": *
#import "@preview/bidi-flow:0.1.1": *

#let _resolve-date = (date, pattern: auto) => context {
  if type(date) == none { return none }
  set text(size: 1.1em)
  let english-pattern = "MMMM d, yyyy"
  let other-pattern = "d MMMM, yyyy"
  let d = date
  block(width: 100%, above: 1em, {
    set text(size: 1.1em)
    if type(date) != date and date != "today" { return date }
    if type(date) == auto or date == "today" { d = datetime.today() }
    let p = pattern
    if p == auto {
      if text.lang == "en" { p = english-pattern } else { p = other-pattern }
    }
    custom-date-format(d, pattern: p, lang: text.lang)
  })
}


#let _resolve-authors = authors => {
  set text(size: 1.2em)
  if authors == none { return none }
  block(width: 100%, {
    if type(authors) == array {
      let rows = authors.chunks(3)
      let grids = rows.map(r => {
        grid(
          columns: range(r.len()).map(_ => 1fr), ..r.map(c => { c })
        )
      })
      grids.join()
    } else { authors }
  })
}


#let maketitle = (author: none, date: none, date-pattern: auto, it) => {
  set align(center)
  v(1em)
  show title: set text(size: 1.2em, weight: "regular")
  block(title(it))
  // text(size: 2em, it)
  v(1em)
  _resolve-authors(author)
  _resolve-date(date)
  v(2em)
}



#let toprule = () => table.hline(stroke: .8pt)
#let midrule = () => table.hline(stroke: .5pt)
#let bottomrule = () => table.hline(stroke: .8pt)
#let cable(frame: true, header: true, center: false, ..args) = {
  set align(if center { std.center } else { start })
  block(
    stroke: if frame { (top: .75pt, bottom: .75pt) } else { none },
    above: 2em,
    below: 2em,

    outset: 0pt,
  )[
    #set table(
      stroke: (x, y) => if header and y == 1 {
        (top: 0.5pt)
      } else {
        none
      },
    )
    #table(..args)
  ]
}
#block(
  stroke: .5pt + black,
  {
    {
      place(top + start, dx: .8em, dy: -.5em + 1pt, block(
        inset: (left: .25em, right: .25em),
        fill: white,
        strong([hey]),
      ))
    }
    block(inset: .5em, width: 100%, [hey])
  },
)

#let qc = counter("qc")
#qc.step()

#let q = (label: none, numbering: "א. ", ..body) => {
  qc.step()
  strong({ if label != none { label } else { "" } + context qc.display() })
  enum(numbering: numbering, ..body.pos())
}


#let hl = (label: none, numbering: "א. ", ..body) => {
  set text(lang: "he")
  // qc.step()
  // strong({ if label != none { label } else { "" } + context qc.display() })
  enum(numbering: "א. ", tight: false, ..body.pos())
}
