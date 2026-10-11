// This function gets your whole document as its `body` and formats
// it as an article in the style of the IEEE.

#let style(
  // The paper's title.
  title: "Paper Title",

  // An array of authors. For each author you can specify a name,
  // department, organization, location, and email. Everything but
  // but the name is optional.
  authors: (),

  // The paper's abstract. Can be omitted if you don't have one.
  abstract: none,

  // A list of index terms to display after the abstract.
  index-terms: (),

  // The article's paper size. Also affects the margins.
  paper-size: "a4",

  // The path to a bibliography file if you want to cite some external
  // works.
  bibliography-file: none,

  // The paper's content.
  body
) = {
  // Set document metadata.
  set document(title: title, author: authors.map(author => author.name))

  // Set the body font.
  set text(lang: "ja", size: 10pt, font: "Noto Serif CJK JP")

  // Set image size.
  set image(width: 80%)

  // Set table caption upper.
  show figure.where(
    kind: table
  ): set figure.caption(position: top)

  // Configure the page.
  set page(
    paper: paper-size,
    // The margins depend on the paper size.
    margin: if paper-size == "a4" {
      (x: 41.5pt, top: 80.51pt, bottom: 89.51pt)
    } else {
      (
        x: (50pt / 216mm) * 100%,
        top: (55pt / 279mm) * 100%,
        bottom: (64pt / 279mm) * 100%,
      )
    },
    header: align(right, text(8pt)[
      xxx第1回レポート
    ]),
    //footer: align(left, text(8pt)[
    //  $copyright$2023 xyz Society of Japan 
    //]),
    numbering: "1",
  )

  set raw(theme: "../monokai.tmTheme", tab-size: 4)
  show raw: it => {
    show raw.line: it => box(
      width: 100%,
      align(horizon, stack(
        dir: ltr,
        box(
          width: 17pt,
          inset: (x: 7pt),
          align(right, text(white)[
              #it.number
          ]
        )),
        it.body,
      ))
    )

    block(
      width: 100%,
      fill: rgb("#1d2433"),
      inset: 8pt,
      radius: 5pt,
      text(fill: rgb("#c2cacc"), it)
    )
  }

  // Configure equation numbering and spacing.
  set math.equation(numbering: "(1)")
  show math.equation: set block(spacing: 0.65em)

  // Configure lists.
  set enum(indent: 10pt, body-indent: 9pt)
  set list(indent: 10pt, body-indent: 9pt)

  // Configure headings.
  set heading(numbering: "1.")

  // Display the paper's title.
  v(3pt, weak: true)
  align(center, text(20pt)[*#title*])
  v(8.35mm, weak: true)

  // Display the author name
  v(20pt, weak: true)
  align(center, text(13pt)[
    #authors.map(author => author.organization).join(", ")
  ])
  align(center, text(16pt)[
    #authors.map(author => text()[*#author.name* #footnote(numbering: "*")[#author.email]]).join(", ")
  ])

  set par(
      first-line-indent: (amount: 1em, all: true),
      justify: true,
  )

  // Display abstract and index terms.
  if abstract != none [
    #set text(size: 9pt, weight: 500)
    #v(15pt)
    #align(center)[
      #box(width: 80%)[ #align(left)[
        #set par(justify: false)

        *概要*: #abstract

      ]]
      #box(width: 80%)[ #align(left)[
        #if index-terms != () [
          #v(5pt)
          *_キーワード_*---#index-terms.join(", ")
        ]
      ]]
    ]

    #v(2pt)
  ]
  v(15pt)

  // Display the paper's contents.
  body

  // Display bibliography.
  if bibliography-file != none {
    show bibliography: set text(8pt)
    set text(lang: "en")
    bibliography(bibliography-file, title: text(10pt)[References], style: "ieee")
  }
}

