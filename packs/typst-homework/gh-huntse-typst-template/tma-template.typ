// OU TMA Typst Template
#import "@preview/headcount:0.1.0": *
#import "@preview/non-unlabeled:0.2.0": *

#let hfrac = math.frac.with(style: "horizontal")
#let phi = sym.phi.alt

#let todo(label) = {
  box(
    fill: rgb("#e8f5e9"),
    stroke: rgb("#a5d6a7"),
    inset: (x: 4pt, y: 2pt),
    radius: 2pt,
    text(size: 7.5pt, fill: rgb("#2e7d32"))[*TODO:* #raw(label)],
  )}

#let tma(
  name: "Student Name",
  pin: "T0001234",
  course: "M303",
  number: 1,
  body
) = {
  set document(title: course + " TMA " + str(number), author: name)
  set page(
    paper: "a4",
    margin: (top: 2.5cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
    header: context {
      let total = counter(page).final().at(0)
      let current = counter(page).get().at(0)
      set text(size: 10pt)
      grid(
        columns: (1fr, 1fr, 1fr),
        align(left, name + "  " + pin),
        align(center, course + " TMA " + if number < 10 { "0" } else { "" } + str(number)),
        align(right, "Page " + str(current) + " of " + str(total)),
      )
      line(length: 100%, stroke: 0.5pt)
    },
  )

  set text(size: 12pt, font: "New Computer Modern")
  set par(justify: true)

  set heading(numbering: "1.")
  show math.equation: dont-number-unlabeled(math.equation)
  set math.equation(numbering: dependent-numbering("(1.1)", levels: 1))
  show math.equation.where(block: true): it => {
    set align(left)
    pad(left: 2em, it)
  }
 let link-colour = rgb("#1a5fb4")
 show link: it => {
   if type(it.dest) != str { return it }
   set text(size: 0.65em, fill: link-colour, font: "DejaVu Sans Mono")
   underline(stroke: 0.4pt + link-colour, offset: 1.5pt, it)
 }

  // Top-level heading = Question N → new page, bold "Question N"
  show heading.where(level: 1): it => {
    counter(math.equation).update(0)
    pagebreak(weak: true)
    v(0.5em)
    text(weight: "medium", size: 14pt, it.body)
    v(0.3em)
  }

  // Second level == Part (a), (b), …
  show heading.where(level: 2): it => {
    v(0.5em)
    text(weight: "medium", size: 12pt, it.body)
    v(0.2em)
  }

  // Third level === Sub-part (i), (ii), …
  show heading.where(level: 3): it => {
    v(0.3em)
    text(weight: "medium", size: 12pt, it.body)
    v(0.1em)
  }

  body
}
