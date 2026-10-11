#let field-row(name, value) = (
  [],
  [*#name：*],
  value,
)

#let cover(config) = {
  set page(
    paper: "a4",
    margin: (x: 2.1cm, top: 2.1cm, bottom: 2.1cm),
    header: none,
    footer: none,
  )

  place(top + left, dx: 0.65cm, dy: 0.55cm)[
    #config.logo
  ]

  v(5.8cm)
  align(center)[
    #text(size: 26pt, weight: "bold")[#config.project-title]

    #v(0.8cm)
    #text(size: 14pt)[#config.project-subtitle]
  ]

  v(1fr)

  align(center)[
    #text(size: 26pt, weight: "bold")[#config.document-type]

    #v(0.25cm)
    #block(width: 12cm, height: 0pt, stroke: (top: 0.5pt))

    #v(0.55cm)
    #block(width: 30em)[
      #set text(size: 11pt)
      #grid(
        columns: (2.2cm, 6.4em, 20em),
        row-gutter: 0.8em,
        column-gutter: 1.6em,
        align: (left, right, left),
        ..field-row("项目编号", config.project-number),
        ..field-row("项目导师", config.mentor),
        ..field-row("申请人", config.applicant),
        ..field-row("学校", config.school),
        ..field-row("联系方式", config.contact),
        ..field-row("Github 主页", config.github-homepage),
        ..field-row("日期", config.submit-date),
      )
    ]
  ]

  v(1.2cm)
  align(center)[#text(size: 9pt)[#config.footer-keywords]]
  pagebreak()
}
