#import "@preview/lovelace:0.3.1": *
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *

// #show: codly-init.with()


#let noenum(eq) = math.equation(block: true, numbering: none, eq)
#let envelope = symbol(
  "🖂",
  ("stamped", "🖃"),
  ("stamped.pen", "🖆"),
  ("lightning", "🖄"),
  ("fly", "🖅"),
)
#let cal(it) = math.class("normal", context {
  show math.equation: set text(font: "Garamond-Math", stylistic-set: 3)

  let scaling = 100% * (1em.to-absolute() / text.size)
  let wrapper = if scaling < 60% { math.sscript } else if scaling < 100% { math.script } else { it => it }

  box(text(top-edge: "bounds", $wrapper(math.cal(it))$))
})

#let algo-counter = counter("algorithm")

#let algorithm(title: "Algorithm", body) = {
  algo-counter.step()
  line(length: 100%)
  v(-10pt)
  strong("Algorithm " + context algo-counter.display()) + " " + title
  v(-1em)
  line(length: 100%)
  v(-1.8em)
  pseudocode-list(line-numbering: "1:", stroke: 0.2pt, body)
  v(-1.8em)
  line(length: 100%)
}

#let project(
  title: "",
  authors: (),
  date: none,
  hours: 0,
  body,
  faculty: "",
  department: "",
  course: (name: "", code: ""),
  semester: "",
) = {
  authors = authors.sorted(key: x => x.name.split(" ").last())
  set line(stroke: 0.5pt)
  set table(
    inset: 4pt,
    stroke: 0.5pt,
  )
  show: codly-init
  codly(zebra-fill: none, number-placement: "outside")
  codly(languages: codly-languages)
  show table.cell.where(y: 0): strong
  show figure.where(kind: raw): set figure(supplement: "Código")
  show math.equation: set text(font: "New Computer Modern Math")
  show math.cancel: set math.cancel(stroke: (paint: red, thickness: 1pt))
  set bibliography(title: "Referencias")
  set math.mat(delim: "[", align: right)
  show math.frac: it => $display(it)$
  show ref: it => {
    let eq = math.equation
    let el = it.element
    if el != none and el.func() == eq {
      // Override equation references.
      numbering(
        el.numbering,
        ..counter(eq).at(el.location()),
      )
    } else {
      // Other references as usual.
      it
    }
  }
  set math.equation(numbering: "(1)", supplement: "")
  // Set the document's basic properties.
  set page(
    paper: "us-letter",
    numbering: "1",
    number-align: center,
    margin: (left: 2.5cm, right: 2.5cm, top: 2cm, bottom: 3cm),
  )
  set raw(align: left)


  // Set body font family.
  set text(font: "New Computer Modern", size: 10pt, lang: "es")
  set par(justify: true)
  set block(above: 1.5em, below: 1.5em)
  show heading: set block(above: 1.5em, below: 1.5em)
  // show heading: self => [
  //   #self.level #h(10pt) #self.body \
  // ]

  // Set the heading
  set heading(supplement: "Pregunta", numbering: (..nums) => {
    let levels = nums.pos()
    if levels.len() == 1 {
      // Level 1: Question 1
      [Pregunta #numbering("1", ..levels)]
    } else {
      // Level 2+: a), b), etc.
      // .last() ensures it only shows the current sub-level letter
      numbering("(a)", levels.last())
    }
  })

  v(-4mm)
  grid(
    columns: (1.8cm, 14.5cm),
    rows: 1,
    column-gutter: 20pt,
    // [#image("logo-uc.svg", width: 80%)],
    [#v(-1mm)
      #image("assets/logo/logo-uc.svg", width: 110%)],
    align(left, [
      #v(5mm)
      #set par(leading: 0.5em)
      #smallcaps[
        Pontificia Universidad Católica de Chile\
        #faculty\
        #department\
        #if course != (name: "", code: "") [
          #course.code -- #course.name
        ]
        #if semester != "" [
          Semestre #semester
        ]
      ]
    ]),
  )

  align(center)[
    #text(14pt, weight: 800)[
      #title\
    ]
    #if date != none [
      #text(10pt)[#date]
    ]
    #text(10pt)[
      #grid(
        columns: (1fr,) * calc.min(3, authors.len()),
        gutter: 1em,
        ..authors.map(author => align(center)[
          *Nombre: #author.name*\
          #link("mailto:" + author.email, envelope) #author.email
        ]),
      )
    ]

  ]

  line(length: 100%, stroke: 0.5pt)
  v(-13pt)
  line(length: 100%, stroke: 0.5pt)

  body
}
