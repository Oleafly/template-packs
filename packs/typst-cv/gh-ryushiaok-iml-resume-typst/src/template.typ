// This function gets your whole document as its `body` and formats
// it as an article in the style of the IEEE.
#let iml-resume(
  // The paper's title.
  title: [Paper Title],
  // An array of authors. For each author you can specify a name,
  // department, organization, location, and email. Everything but
  // but the name is optional.
  authors: ((name: "", department: [], organization: [], location: [], email: ""),),
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
  body,
) = {
  // Set document metadata.
  set document(title: title, author: authors.map(author => author.name))

  // Set the body font.
  set text(font: "Noto Serif CJK JP")
  show emph: set text(font: "Noto Sans CJK JP")

  show "、": "，"
  show "。": "．"

  // Configure the page.
  set page(
    paper: paper-size,
    // The margins depend on the paper size.
    margin: if paper-size == "a4" {
      (top: 25mm, bottom: 20mm, x: 15mm)
    } else {
      (x: (50pt / 216mm) * 100%, top: (55pt / 279mm) * 100%, bottom: (64pt / 279mm) * 100%)
    },
    header: [
      #set text(8pt, baseline: 5pt)
      #smallcaps[*YYYY年度 卒業論文発表会（YYYY年MM月DD日）*]
      #h(1fr)
      *知的機構研究室*
      #line(length: 100%, stroke: 0.5pt)
    ],
  )

  // Configure equation numbering and spacing.
  set math.equation(numbering: "(1)")
  show math.equation: set block(spacing: 0.65em)

  // Configure appearance of equation references
  show ref: it => {
    if it.element != none and it.element.func() == math.equation {
      // Override equation references.
      link(it.element.location(), numbering(it.element.numbering, ..counter(math.equation).at(it.element.location())))
    } else {
      // Other references as usual.
      it
    }
  }

  // Configure lists.
  set enum(indent: 10pt, body-indent: 9pt)
  set list(indent: 10pt, body-indent: 9pt)

  // Configure headings.
  set heading(numbering: "1.1.1")
  // set heading(numbering: "1.1.1")
  show heading: it => context {
    let loc = here()
    // Find out the final number of the heading counter.
    let levels = counter(heading).at(loc)
    let deepest = if levels != () {
      levels.last()
    } else {
      1
    }

    set text(10pt, weight: 400, font: "MS PGothic")
    set par(first-line-indent: 0em) // 2 Methods
    if it.level == 1 [
      // First-level headings are centered smallcaps.
      // We don't want to number of the acknowledgment section.
      #let is-ack = it.body in ([Acknowledgment], [Acknowledgement])
      // #set align(center)
      #set text(if is-ack { 10pt } else { 12pt })
      // #show: smallcaps
      #v(20pt, weak: true)
      #if it.numbering != none and not is-ack {
        numbering("1", levels.first())
        h(7pt, weak: true)
      }
      #it.body
      #v(13.75pt, weak: true)
    ] else if it.level == 2 [
      // Second-level headings are run-ins.
      #set par(first-line-indent: 0pt)
      // #set text(style: "italic")
      #v(10pt, weak: true)
      #if it.numbering != none {
        numbering("1.1", levels.at(0), levels.at(1))
        h(7pt, weak: true)
      }
      #it.body
      #v(10pt, weak: true)
    ] else [
      // Third level headings are run-ins too, but different.
      #if it.level == 3 {
        numbering("1.1.1", levels.at(0), levels.at(1), levels.at(2))
        [ ]
      }
      // _#(it.body):_
      #it.body
      #v(10pt, weak: true)
    ]
  }

  // Display the paper's title.
  v(3pt, weak: true)
  align(center, text(15pt, title))
  v(5.35mm, weak: true)

  align(center, text(11pt, authors.map(author => author.name).join(", ")))

  v(40pt, weak: true)

  // Start two column mode and configure paragraph properties.
  show: columns.with(2, gutter: 12pt)
  set par(justify: true, first-line-indent: 1em, spacing: 0.65em)

  // Display abstract and index terms.
  if abstract != none [
    #set text(weight: 700)
    #h(1em) _Abstract_---#abstract

    #if index-terms != () [
      #h(1em)_Index terms_---#index-terms.join(", ")
    ]
    #v(2pt)
  ]

  // Display the paper's contents.
  set text(size: 10pt)
  body

  // Display bibliography.
  if bibliography-file != none {
    show bibliography: set text(8pt)
    bibliography(bibliography-file, title: text(10pt)[References], style: "ieee")
  }
}
