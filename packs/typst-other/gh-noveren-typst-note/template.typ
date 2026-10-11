#import "@preview/cjk-unbreak:0.2.3": remove-cjk-break-space

#let conf(
  doc,
  color-theme: rgb(138, 92, 245),
  heading_1_pagebreak: false,
  main: false,
) = {
  show: remove-cjk-break-space

  let font-size = 10.5pt;
  let font-size-sub = 9pt;
  set page(
    paper: "a4",
    margin: (top: 1cm, bottom: 1cm, left: 1.5cm, right: 1.5cm),
    numbering: "1",
  )

  set heading(numbering: "1.")
  show heading.where(level: 1): it => {
    if heading_1_pagebreak {
      pagebreak()
    }
    it
  }
  show heading: set block(below: 1.5em)

  set par(justify: true, leading: 1em)

  set text(
    font: ((name: "XITS Math", covers: "latin-in-cjk"), "Source Han Serif SC"),
    cjk-latin-spacing: auto,
    size: font-size,
  )
  show raw: set text(
    font: ("JetBrainsMono NF", "Source Han Serif SC"),
    size: font-size,
  )
  show raw.where(block: false): set text(
    fill: rgb(0xC7, 0x50, 0x10),
  )

  show emph: it => {
    set text(fill: color-theme, weight: "bold")
    it
  }

  set outline(title: block(width: 100%)[#align(center + horizon)[
    目录
  ]])

  show link: it => {
    set text(fill: color-theme)
    underline(offset: 2pt, stroke: color-theme + 1pt)[#it]
  }

  show raw.where(block: true): it => {
    set text(size: font-size-sub);
    block(
      fill: rgb("#fafafa"),
      width: 100%,
      inset: (top: 8pt, bottom: 8pt, left: 8pt),
      radius: 4pt,
      it
    )
  }

  show quote.where(): it => {
    block(
      width: 100%,
      inset: (top: 4pt, bottom: 4pt, left: 12pt),
      outset: (left: -3pt),
      stroke: (left: color-theme + 3pt),
      it.body
    )
  }

  set list(
    marker: text(fill: gray)[•],
  )

  doc
}
