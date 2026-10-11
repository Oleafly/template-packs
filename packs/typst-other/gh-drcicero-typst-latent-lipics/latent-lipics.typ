#let lmr = "New Computer Modern" // "Latin Modern Roman"
#let lms = "New Computer Modern Sans" // "Latin Modern Sans"
#let lmm = "New Computer Modern Mono" // "Latin Modern Mono"

// This function gets your whole document as its `body` and formats
// it as an article in the style of the IEEE.
#let lipics(
  // The paper's title.
  title: "Paper Title",

  // An array of authors. For each author you can specify a name,
  // department, organization, location, and email. Everything but
  // but the name is optional.
  authors: (),

  // The paper's abstract. Can be omitted if you don't have one.
  abstract: none,

  ccsdesc: none,
  keywords: (),
  supplement: none,

  // The path to a bibliography file if you want to cite some external
  // works.
  bibliography-file: none,

  // The paper's content.
  body
) = {
  // Set document metdata.
  set document(title: title, author: authors.map(author => author.name))

  // Configure the page.
  let ww = 210mm - 140mm
  let hh = 297mm - 222mm
  set page(
    paper: "a4", // 210 x 297 mm

    // The margins depend on the paper size.
    margin: (
      inside: 32mm, outside: ww - 32mm,
      top: 27mm + 8mm, bottom: 27mm,
    ),

    header: context {
      let pg = counter(page).get().at(0)
      text(10.5pt, weight: 700, font: lms, box(
        if (pg == 1) {
        } else if (pg.bit-and(1) == 0) {
          place(top + left, dx: -1.5cm, [1:#pg])
          title
        } else {
          place(top + right, dx: 1.5cm, [1:#pg])
          document.author.join(", ")
          h(1fr)
        }
      ))
    },
  )
  v(-8mm)

  set text(font: lmr, size: 9.4pt)

  // Configure equation numbering and spacing.
  set math.equation(numbering: "(1)")
  show math.equation: set block(spacing: 0.65em)

  // Configure lists.
  set enum(indent: 0pt, body-indent: 9pt)
  set list(indent: 0pt, body-indent: 9pt, marker: [#align(bottom, rect(width: 2.5mm, height: 1.2mm, fill: luma(60%)))])
  show raw: set text(1.2em, font: lmm)

  // Configure headings.
  set heading(numbering: "1.1.1")
  show heading: it => context {
    set text(font: lms)
    
    // Find out the final number of the heading counter.
    let levels = counter(heading).at(here())

    if levels.len() == 1 {
      set par(first-line-indent: 0pt)
      set text(12pt)
      grid(columns: (auto, 1fr), gutter: 1em, align: (horizon, horizon),
        rect(fill: rgb(99%, 78%, 07%),
             numbering(if it.numbering == none { "1" } else { it.numbering }, ..levels)),
        it.body)
      v(1em, weak: true)
    } else if levels.len() == 2 {
      set par(first-line-indent: 0pt)
      set text(12pt)
      grid(columns: (auto, 1fr), gutter: 1em, align: (horizon, horizon),
        numbering(if it.numbering == none { "1" } else { it.numbering }, ..levels),
        it.body)
      v(1em, weak: true)
    } else {
      set par(first-line-indent: 0mm, spacing: 2em)
      it.body
    }
  }

  // Display the paper's title.
  v(3pt, weak: true)
  text(17.28pt, weight: "bold", font: lms, title)
  v(5mm, weak: true)

  // Display the authors list.
  for author in authors {
    text(11.7pt, weight: 700, author.name)
    if "email" in author [ #link("mailto:" + author.email, "🖂") ]
    if "link"  in author [ #link(author.link, "🌐") ]
    if "orcid" in author [ #link("https://" + author.orcid, emoji.id) ]
    if "affiliation" in author [ \ #author.affiliation ]
    v(0pt)
  }
  v(5mm, weak: true)

  // Start two column mode and configure paragraph properties.
  //show: columns.with(2, gutter: 12pt)
  set par(justify: true, first-line-indent: 1.5em, spacing: 0.65em)

  // Display abstract and index terms.
  if abstract != none [
    #grid(columns: (auto, auto, 1fr), align: (horizon, bottom, horizon),
      line(length: 7mm),
      text(10pt, weight: "bold", font: lms, [~Abstract~]),
      line(length: 100%))
    #abstract

    #if ccsdesc != none { v(3pt); h(-1.5em); text(font: lms, weight: 700, fill: luma(31%), [2012 ACM Subject Classification]); [ #ccsdesc] }

    #if keywords != () { v(3pt); h(-1.5em); text(font: lms, weight: 700, fill: luma(31%), [Keywords and phrases]); [ #keywords.join(", ")] }

    #if supplement != () { v(3pt); h(-1.5em); text(font: lms, weight: 700, fill: luma(31%), [Supplementary material]); [ #supplement] }

    #v(2pt)
  ]

  set text(font: lmr, size: 9.8pt)

  place(bottom + end, float: true, clearance: 0em, {
    footnote(numbering: (loc) => " ", par(first-line-indent: 0em, [
      _ © Jane Open Access and Joan R. Public; \
      licensed under Creative Commons License CC-BY 4.0 \
      42nd Conference on Very Important Topics (CVIT 2016). \
      Editors: John Q. Open and Joan R. Access; Article No. 23; pp. 23:1–23:7 \
      Leibniz International Proceedings in Informatics \
      Schloss Dagstuhl – Leibniz-Zentrum für Informatik, Dagstuhl Publishing, Germany. _
    ]))})

  // Display the paper's contents.
  body

  /* Display bibliography.
  if bibliography-file != none {
    show bibliography: set text(8pt)
    bibliography(bibliography-file, title: text(10pt)[References], style: "ieee")
  }
  */
}
