// ======================================================
// APPENDIX (Template Demo)
// ------------------------------------------------------
// Replace the content below with your own appendices:
// additional diagrams, code listings, data tables, etc.
// ======================================================

#import "../constant.typ": *
#import "../_lib/utils.typ": (
  definition, figureref, figurerefnocap, note, tableref, titleref,
)

#set page(
  paper: "a4",
  footer: context {
    stack(
      dir: ttb,
      spacing: 5pt,
      line(length: 100%, stroke: 0.5pt),
      align(center, counter(page).display()),
    )
  },
  margin: (top: 2.5cm, left: 3cm, right: 2cm, bottom: 2.5em),
  header: context {
    let doc_title = "Appendix"
    align(left + horizon)[
      #block(
        width: 100%,
        stroke: (bottom: 0.7pt),
        inset: (bottom: 5pt),
        below: 0pt,
        text(style: "italic", size: 12pt, doc_title),
      )
    ]
  },
)
#set text(size: 12pt, lang: "en", hyphenate: false)
#set par(justify: true, leading: 0.75em, first-line-indent: 0.5cm, spacing: 1.2em)
#show par: set text(hyphenate: false)
#set list(indent: 1.8em, spacing: 1em, body-indent: 0.5em, marker: ([•], [–], [◦]))
#show table.cell.where(y: 0): set text(weight: "bold", fill: white)
#set table(
  stroke: 0.5pt + black,
  inset: 8pt,
  align: left,
  fill: (col, row) => if row == 0 { rgb("#1a1a6e") }
  else if calc.odd(row) { luma(245) }
  else { white },
)
#show figure.where(kind: table): it => {
  set block(breakable: true)
  set text(size: 10pt, style: "italic")
  it
}
#set figure(gap: 0.7em)
#show figure.caption: it => {
  set text(size: 10pt, style: "italic")
  set align(center)
  it
}
#let fakepar = context {
  box()
  v(-measure(block() + block()).height)
}
#show heading.where(level: 1): it => {
  text(size: 18pt, weight: "bold")[#it]
  fakepar
}

// ======================================================
// APPENDIX CONTENT
// ======================================================
#heading(level: 1, numbering: none)[Appendix]
#lvl_4_ab_lvl_2_dwn
This appendix contains supplementary material for the project, including additional
diagrams, configuration files, and reference data.
#vs-xl

#figure(
  image(
    "../assets/xp_scrum.jpg",
    width: 100%,
    fit: "contain",
  ),
  caption: [Appendix Figure — Sample Supplementary Diagram],
)
#vs-xxl
