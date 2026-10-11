#import "@preview/elembic:1.1.1" as e
#import "@preview/oxifmt:1.0.0": strfmt
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.10": *

#import "components/base.typ" as base

#let exam = e.element.declare(
  "exam",
  doc: "exam template",
  prefix: "@preview/typtest:0.0.1:exam",
  fields: (
    e.field("version", str, named: true, required: true,
      doc: "exam version"),
    e.field("date", datetime, named: true, required: true,
      doc: "exam date"),
    e.field("show-solution", bool, default: false,
      doc: "show exam solutions"),
    e.field("course", content, named: true, required: true,
      doc: "course title"),
    e.field("title", content, named: true, required: true,
      doc: "exam title"),
    e.field("problems", e.types.array(base.problem), named: true,
      required: true,
      doc: "exam problems"),
    e.field("instructions", content, required: true,
      doc: "exam instructions"),
  ),
  display: it => {
    set page(
      paper: "us-letter",
      margin: (x: 1in, y: 1in),
      number-align: right + bottom,
      numbering: "1",
      header: context {
        if counter(page).get().first() > 1 [
          #it.date.display()
          #h(1fr)
          #it.course - #it.title
          #h(1fr)
          #it.version \
          #line(length: 100%, stroke: 2pt)
        ]
      }
    )

    set raw(theme: "assets/infimum.tmTheme")
    show: codly-init.with()
    codly(
      zebra-fill: none,
      stroke: none, 
      display-icon: false,
      breakable: false,
    )

    let problem-table = {
      let args = ()
      let total = 0
      for problem in it.problems {
        let fields = e.fields(problem)
        args.push(fields.title)
        args.push(str(fields.points))
        total += fields.points
      }
      set text(size: 14pt)
      table(
        columns: 2,
        table.header([Problem], [Points]),
        ..args,
        [Total], [#total],
      )
    }

    // create titlepage
    let box-args = arguments(
      width: 1fr,
      height: 2.25em,
      stroke: (bottom: 1pt),
      baseline: 4pt,
    )
    let titlepage = [
      #set align(center)
      #text(size: 24pt, weight: "bold")[#it.course #it.title] \
      #grid(
        columns: 2,
        rows: 2,
        gutter: 1em,
        align: (left, right),
        text(size: 16pt)[Version:], text(size: 16pt)[#it.version],
        text(size: 16pt)[Date:], text(size: 16pt)[#it.date.display()],
      )

      #block(width: 70%, stroke: 2pt, inset: 1.5em)[
        #set align(left)
        #set text(size: 16pt)

        Name: #box(..box-args)

        Email: #box(..box-args)
      ]

      #text(size: 20pt, weight: "bold")[
        DO NOT OPEN UNTIL EXAM BEGINS
      ]

      #problem-table

      #set align(left)
      #it.instructions
    ]

    // document
    [
      #show: e.set_(base.problem, show-solution: it.show-solution)
      #titlepage

      #for problem in problems [
        #pagebreak()
        #problem
      ]
    ]
  },
)
