#let conf(
  // Team Number.
  teamNo: none,

  // Summary Sheet.
  summary: none,

  //Problem Chosen.
  problem: none,

  // A list of index terms to display after the abstract.
  index-terms: (),

  // The paper size. 
  paper-size: "a4",

  // The path to a bibliography file.
  bibliography-file: none,

  // The paper's content.
  body
) = {

  // Set the body font.
  set text(font: "STIX Two Text", size: 12pt)

  // Configure the page.
  set page(
    paper: paper-size,
    // The margins depend on the paper size.
    margin: if paper-size == "a4" {
      (x: 41.5pt, top: 80.51pt, bottom: 89.51pt)
    },
    header: [
      #set text(12pt)
      #smallcaps[Team \#1234]
      #h(1fr)
      _Page_
      _#counter(page).display("1 of 1", both:true)_
    ],
  )

  // Config equation numbering and spacing.
  set math.equation(numbering: "(1)")
  show math.equation: set block(spacing: 1em)

  // Config tables.
  set table(
    fill: (col, _) => if calc.odd(col) { luma(240) } else { white },
    align: (col, row) =>
      if row == 0 { center }
      else if col == 0 { left }
      else { right },
  )

  // Config Code.
  show raw.where(block: false): box.with(
    fill: luma(240),
    inset: (x: 3pt, y: 0pt),
    outset: (y: 3pt),
    radius: 2pt,
  )
  show raw.where(block: true): block.with(
    fill: luma(240),
    inset: 6pt,
    radius: 4pt,
    breakable: true
  )
  
  // Config lists.
  set enum(indent: 10pt, body-indent: 9pt)
  set list(indent: 10pt, body-indent: 9pt)

  // Config figures
  show figure: set block(breakable: true)
  
  // Config headings.
  set heading(numbering: "I.A.1.")
  show heading: it => locate(loc => {
    // Find out the final number of the heading counter.
    let levels = counter(heading).at(loc)
    let deepest = if levels != () {
      levels.last()
    } else {
      1
    }

    set text(13pt, weight: 400)
    if it.level == 1 [
      // First-level headings are centered smallcaps.
      #let is-ack = it.body in ([Acknowledgment], [Acknowledgement])
      #set align(center)
      #set text(if is-ack { 15pt } else { 15pt })
      #show: smallcaps
      #v(18pt, weak: true)
      #if it.numbering != none and not is-ack {
        numbering("I.", deepest)
        h(7pt, weak: true)
      }
      #it.body
      #v(13.75pt, weak: true)
    ] else if it.level == 2 [
      // Second-level headings are run-ins.
      #set par(first-line-indent: 0pt)
      #set text(style: "italic", weight: "medium")
      #v(13pt, weak: true)
      #if it.numbering != none {
        numbering("A.", deepest)
        h(7pt, weak: true)
      }
      #it.body
      #v(10pt, weak: true)
    ] else [
      // Third level headings are run-ins too, but different.
      #if it.level == 3 {
        numbering("1.", deepest)
        [ ]
      }
      _#(it.body):_
    ]
  })
  
  // Display TeamNo and ProblemNo.
  if teamNo != none [
    #align(center, smallcaps[#text(size:10pt, weight: 500)[Team Control Number]])
    #v(7pt, weak: true)
    #set text(14pt, weight: 300)
    
    #align(center, smallcaps[#text(size:25pt, weight: 500, fill: rgb("#be3030"))[#teamNo]])
    #v(12pt, weak: true)
  ]
  
  if problem != none [
    #align(center, smallcaps[#text(size:10pt, weight: 500)[Problem Chosen]])
    #v(7pt, weak: true)
    #set text(14pt, weight: 300)
    
    #align(center, smallcaps[#text(size:25pt, weight: 500, fill: rgb("#be3030"))[#problem]])
    #v(10pt, weak: true)
    #align(center, smallcaps[#text(size:14pt, weight: 500)[2023]])
    #v(5pt, weak: true)
    #align(center, smallcaps[#text(size:10pt, weight: 500)[HiMCM]])
    #v(10pt, weak: true)

  ]
  
  
  // Display summary sheet and index terms.
  if summary != none [
    #align(center, smallcaps[#text(size:15pt, weight: 700)[Summary Sheet]])
    #line(length: 100%)
    #set par(justify: true, first-line-indent: 2em)
    #set text(12pt, weight: 300)
    #summary

    #if index-terms != () [
      #set text(13pt, weight: 300)
      #linebreak()
      #h(2em) _*Index terms*_ --- #index-terms.join(", ")
    ]
    #v(2pt)
  ]
  
  pagebreak()

  // Display outline.
  align(center)[
    #set text(13pt)
    #show outline.entry.where(
      level: 1
    ): it => {
      v(25pt, weak: true)
      strong(delta:500, it)
    }
    #outline(title: smallcaps[#text(weight: 700, size:20pt)[Contents]], indent: auto)
  ]
  
  pagebreak()
  
  // Start two column mode and configure paragraph properties.
  // show: columns.with(2, gutter: 12pt)
  set par(justify: true, first-line-indent: 1em)
  show par: set block(spacing: 0.65em)

  // Display the paper's contents.
  body

  // Display bibliography.
  if bibliography-file != none {
    show bibliography: set text(12pt)
    bibliography(bibliography-file, title: text(13pt)[References], style: "ieee")
  }
}
