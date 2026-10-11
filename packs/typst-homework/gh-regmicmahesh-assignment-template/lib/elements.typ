

#let bibliography-page(
  filename: none,
) = {
  bibliography(filename, full: true)
}

#let toc-page() = {
  set page(numbering: none)
  outline(title: "Table of Contents")
  pagebreak()
}

#let cover-page(
  subject-name: none,
  assignment-title: none,
  group-members: none,
  lecturer-name: none,
) = {
  set page(
    header: [
      #grid(
        align: (left + horizon, right + horizon),
        columns: (3fr, 1fr),
        heading(outlined: false, [#subject-name]), image("/images/cdu.webp", width: 75pt),
      )
    ],
    numbering: none,
  )

  align(horizon + center)[
    #heading(outlined: false, assignment-title)
  ]

  align(bottom)[
    #grid(
      align: top + left,
      column-gutter: 20%,
      columns: (1fr, 1fr),
      [
        #heading(level: 2, outlined: false, [Submitted By])
        #for value in group-members [
          #value.name \(*#value.sid*\) \
        ]
      ],
      [
        #heading(level: 2, outlined: false, [Submitted To])
        #lecturer-name \
        Charles Darwin University \
        Faculty of Science and Technology \
        Date: #datetime.today().display()
      ],
    )
  ]
}
