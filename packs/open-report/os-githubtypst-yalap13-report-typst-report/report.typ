/*

Template for homework: to be imported in another document as follows:

  #import "homework.typ": *

To set up, write the following and specify the arguments:

  #show: Homework.with(
    title: "Homework Title",
    authors: (
      (
        "name": "John Doe",
        "short_name": "J. Doe",
        "matricule": "123 456 789"
      ),
      (
        "name": "Jane Doherty",
        "short_name": "J. Doherty",
        "matricule": "987 654 321"
      )
    ),
    course: (
      "id":"GPH-0000",
      "name":"Nom du cours"
    ),
    professors: "M/Mme Prof",
    // compact: true,
    // due_date: "June 3rd 2025",
    // english: true
  )

The last three arguments, if not specified, will have the default values of false, today's date, and false

*/

#import "@preview/physica:0.9.3": *

// Functions to get today's date if due date is undefined
#let month_conversion = (
  "January": "janvier",
  "February": "février",
  "March": "mars",
  "April": "avril",
  "May": "mai",
  "June": "juin",
  "July": "juillet",
  "August": "août",
  "September": "septembre",
  "October": "octobre",
  "November": "novembre",
  "December": "décembre",
)
#let get_due_date(due_date, english) = {
  if due_date == none {
    let date = datetime.today()
    if not english {
      let month = month_conversion.at(date.display("[month repr:long]"))
      str(date.day()) + " " + month + " " + str(date.year())
    } else {
      date.display("[month repr:long] [day] [year]")
    }
  } else {
    due_date
  }
}

// Define an empty problem text state (to be updated based on the language state)
#let problem_text = state("thing", "")

// Define the assignment_class function
#let Report(
  title: none,
  authors: none,
  course: none,
  professors: none,
  due_date: none,
  faculty: "Département de physique",
  compact: false,
  english: false,
  body
) = {
  set page(paper: "us-letter")
  // Set spell check language
  set text(lang: if english { "en" } else { "fr" })

  // Common settings
  let due_date = get_due_date(due_date, english)
  set page(margin: (y: 1in, x: 1in))
  set par(leading: 0.55em, first-line-indent: 0em, justify: true)
  set text(font: "New Computer Modern")
  show raw: set text(font: "New Computer Modern Mono")
  set par(spacing: 0.55em)
  show heading: set block(above: 1.4em, below: 1em)
  show math.equation.where(block: false): box
  show math.equation.where(block: true): it => block(above: 1em, below: 1em, it)
  show math.equation.where(block: true): set par(leading: 1.5em)
  // Opinionated settings
  // set math.equation(numbering: "(1)")
  set enum(numbering: "a)", indent: 1em)

  // Tables and figures
  set table(stroke: (x, y) => (
    top: if y < 1 { 1pt }
      else if y < 2 {0.5pt}
      else {0pt},
    bottom: {1pt}
    )
  )
  show figure.where(
    kind: table
  ): set figure.caption(position: top)

  // Adds space after a figure
  show figure: set block(below: 2em)
  // Change separator and supplement of figure captions
  set figure.caption(separator: [ --- ])
  set figure(supplement: "Figure")
  // A block of 90% width in which the content is centered by default,
  // the content is a block of automatic width (same width as content) and content is left-aligned
  show figure.caption: it => block(
    width: 90%,
    block(width: auto)[
      #align(left)[
        #smallcaps[#it.supplement]#h(.25em)#context{it.counter.display()}#it.separator #it.body
      ]
    ]
  )

  // set figure(supplement: "Figure")
  // set figure.caption(separator: " --- ")
  // set ref(supplement: it => {none})
  // show figure.caption: it => {
  //   align(left, block(width: 90%, it))
  // }

  // Document layout settings
  set page(
    header: context{
      let page_number = counter(page).at(here()).first() - 1
      if page_number == 0 {
        none
      } else {
        grid(
          columns: (1fr, 1fr),
          align:
            (left, right),
            [#authors.map(author => author.short_name).join(", ")],
            [*#course.id*, #title]
        )
        line(length: 100%)
      }
    },
    footer: context {
      let page_number = counter(page).at(here()).first()
      let total_pages = counter(page).final().last()
      if not compact {
        page_number = page_number - 1
        total_pages = total_pages - 1
      }
      if page_number == 0 and not compact{
          none
      } else {
          align(center)[
            // Page
            #page_number
            // #if english {[of]} else {[de]}
            // #total_pages
            ]
      }
    },
    header-ascent: 20%,
    footer-descent: 30%,
  )
  // Turn on grid lines to simplify layout modifications (optional)
  // set grid(stroke: (thickness: 0.2mm, dash: "dashed", paint: rgb("#8d8d8dff")))
  // COMPACT LAYOUT
  if compact {
    grid(
      columns: (1fr, 1fr),
      rows: (8%, 7%, auto, 2%),
      align: (horizon + left, horizon + right),
      [#image("logo_UdeS.png", width: 70%)],
      [
        #set text(size: 12pt)
        #due_date\ #smallcaps([#course.id #course.name])
      ],
      grid.cell(colspan: 2)[
        #set text(size: 18pt, weight: "bold")
        #set align(center)
        #title
      ],
      align(top+left)[
        #set text(size: 12pt)
        #for author in authors [
          #author.name (#author.matricule)\
        ]
      ],
      align(top+right)[
        #set text(size: 12pt)
        #emph[Remis à\ ]
        #if type(professors) == "array" {
          for professor in professors [
            #professor \
          ]
        } else if type(professors) == "string" {
          [#professors]
        }
      ],
      grid.cell(colspan: 2, align: bottom)[
        #line(length: 100%, stroke: (thickness: 0.6mm))
      ],
    )
  } else {

// NON COMPACT LAYOUT
    set align(center)
    grid(
      rows: (1fr, 1%, 6%, 1%, 5%, auto, 5%, 18%, 4%, 2%, 1fr),
      align: (center+horizon),
      [
        #align(left)[#image("logo_UdeS.png", width: 40%)]
      ],
      [],
      [
        #set text(size: 14pt)
        #smallcaps[Université de Sherbrooke]
      ],
      [
        #text(style: "oblique", size: 12pt)[#faculty]
      ],
      [
        #line(length:90%, stroke: (thickness: 0.3mm))
      ],
      [
        #set text(size: 24pt, weight: "bold")
        #title
      ],
      [
        #line(length:90%, stroke: (thickness: 0.4mm))
      ],
      [
        #set text(size: 12pt)
        #grid(
          columns: (1fr, 1fr),
          align: (top+left, top+right),
          inset: (left: 40pt, right: 40pt),
          [
            #set par(justify: false)
            #emph[#if english {[By\ ]} else {[Par\ ]}]
            #for author in authors [#author.name (#author.matricule)\ ]
          ],
          [
            #emph[#if english {[Submitted to\ ]} else {[Remis à\ ]}]
            #if type(professors) == "array" {
              for professor in professors [
                #professor \
              ]
            } else if type(professors) == "string" {
              [#professors]
            }
          ]
        )
      ],
      [#emph[#if english {[For the course]} else {[Pour le cours]}]],
      [
        #text(size: 12pt)[#smallcaps[#course.id #course.name]]
      ],
      [
        #set text(size: 12pt)
        #due_date
      ],
    )
    pagebreak(weak: false)
  }

  // Rest of the document
  body
}

// Define the question and subquestion environments
#let question_counter = counter("question")
#let subquestion_counter = counter("subquestion")
#let question(body, title: none, number: none) = {
  set text(size: 10pt)
  question_counter.step()
  subquestion_counter.update(c => 0)

  block(
    fill:rgb("#e4e4e4"),
    width: 100%,
    inset:8pt,
    radius: 3pt,
    stroke: black+.5pt,
    breakable: false,
    [
      #set math.equation(numbering: "(1)")
      #if title != none {
        [*#context{question_counter.display()}. #title*\ ]
      } else {
        [*#question_counter.display().*]
      }
      #body
    ],
  )
}

#let subquestion(body, number: none) = {
  set text(size: 10pt)
  subquestion_counter.step()

  block(
    fill:rgb("#e4e4e4"),
    width: 100%,
    inset:8pt,
    radius: 3pt,
    stroke: black + .5pt,
    breakable: false,
    [
      #set math.equation(numbering: "(1)")
      *(#context{subquestion_counter.display("a")})*
      #body
    ],
  )
}
#let add_subquestion() = {
  subquestion_counter.step()
  v(1pt)
  [\ *(#context{subquestion_counter.display("a")})*]
}

// Define big red text
#let sauce(body) = {
  set text(fill:red, size: 20pt, weight: 600)
  body
}

// Overrides for math
// Show identity and diagonal with 0s by default
#let imat = imat.with(fill:0)
#let dmat = dmat.with(fill:0)
// Upright bold for math
#let ub(item) = {math.upright(math.bold(item))}
// Greek phi and epsilon and variations
#let varphi = math.phi
#let phi = math.phi.alt
#let varepsilon = math.epsilon
#let epsilon = math.epsilon.alt
// Non-variable width hat accent
#let hat(content) = math.accent(content, "\u{302}", size: 10%)
// math.plus.minus shorthand
#let pm = math.plus.minus
#let mp = math.minus.plus
// math.expectationvalue shorthand
#let ev(content) = expectationvalue(content)
// Override of ketbra and braket so that there is no deprecation warning
#let ketbra(arg1, arg2) = [#ket(arg1)#bra(arg2)]

#let lind(smth) = {[#math.cal("D") [#smth]]}
