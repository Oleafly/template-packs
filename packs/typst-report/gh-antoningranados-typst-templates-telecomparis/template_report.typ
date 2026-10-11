#let report(
  title: "", subtitle: "",
  student_name: "", student_mail: "",
  supervisor_name: "", supervisor_mail: "",
  course_name: "", date: "", footer: "", header_content: [], body) = {

  set document(title: title)
  set page(
    paper: "a4",
    margin: (left: 20mm, right: 20mm, top: 20mm, bottom: 20mm),
  )
  set enum(numbering: "1.a)")
  show link: underline
  show link: set text(blue)

  set text(
    font: "New Computer Modern",
    size: 10pt,
    ligatures: true
  )

  set heading(numbering: "1.")
  show heading: it => {
    set block(above: 1.5em, below: 0.8em)
    pad(left: 2em * (it.level - 1), it)
  }
  set par(justify: true, first-line-indent: 2em)
  show figure.caption: it => emph[#it]
  show outline.entry: it => pad(left: 2em * (it.level - 1), it)

  // LOGO
  move(dx: -1em, dy: 0em, image("templates_res/logo_school.svg", width: 20%))
  v(-10em)

  // HEADER PAGE
  align(center+horizon)[
    #v(10em)
    #par(leading: 1em)[#text(size: 20pt, weight: "bold")[#title]]
    #if subtitle.len() > 0 [
      #v(6em)
      #text(size: 16pt, weight: "bold")[#subtitle]
    ]
    #v(6em)

    #if header_content != [] [
      #header_content
      #v(6em)
    ]

    #let informations = ();
    #informations.push(table.cell(align: right+top)[Student :])
    #informations.push(table.cell(align: left)[
        *#student_name*\
        #if student_mail.len() > 0 [#link(student_mail)]
    ])

    #if supervisor_name.len() > 0 [
      #informations.push(table.cell(align: right+top)[Supervisor :])
      #informations.push(table.cell(align: left)[
          *#supervisor_name*\
          #if supervisor_mail.len() > 0 [#link(supervisor_mail)]
      ])
    ]

    #informations.push(linebreak())
    #informations.push(linebreak())

    #informations.push(table.cell(align: right)[School :])
    #informations.push(table.cell(align: left)[*Télécom Paris*])

    #if course_name.len() > 0 [
      #informations.push(table.cell(align: right)[Course :])
      #informations.push(table.cell(align: left)[*#course_name*])
    ]

    #informations.push(linebreak())
    #informations.push(linebreak())

    #if date.len() > 0 [
      #informations.push(table.cell(align: right)[Date :])
      #informations.push(table.cell(align: left)[*#date*])
    ]

    #table(
      columns: (auto, auto),
      stroke: none,
      ..informations,
    )
  ]

  pagebreak()

  // PAGES STYLE (+ FOOTER) FOR THE NEXT PAGES
  let page_counter = counter(page)
  page_counter.update(1)
  set page(
    numbering: "1/1",
    footer: context { box(stroke: (top: 1pt), inset: 10pt)[
      #if footer.len() > 0 [
        #footer
      ] else [
        #title
      ]
      #if course_name.len() > 0 [
        — #course_name
      ]
      #h(1fr)
      #page_counter.display("1/1", both: true)
    ] },
    footer-descent: 20%,
    margin: (left: 20mm, right: 20mm, top: 15mm, bottom: 15mm),
  )

  set footnote.entry(separator: line(length: 100%))

  // TABLE OF CONTENT
  set par(leading: 2em)
  outline()
  set par(leading: 0.7em)
  pagebreak()


  body
}
