#import "@preview/codelst:2.0.1": sourcecode

#let template(doc, title: none, author: none, bib: none, showoutline: true) = {
  let printableAscii = "[\p{ascii}&&\P{C}]"

  let mixedBold(body) = {
    set text(font: "Hiragino Sans", weight: "extralight")
    show regex(printableAscii): set text(font: "Times New Roman", weight: "light", size: 1.15em)
    body
  }

  set text(font: "Hiragino Mincho ProN", weight: "regular", size: 10.5pt)

  show strong: mixedBold
  set heading(numbering: "1.")
  show heading: it => {
    mixedBold(text(weight: "regular", it))
    par(text(size: 0pt, ""))
  }
  show outline: par.with(first-line-indent: 0pt)
  show link: it => {
    set text(blue)
    underline(it)
  }
  show raw.where(block: false): it => {
    h(.2em, weak: true)
    box(
      fill: luma(240), inset: (x: 2pt, y: 0pt), outset: (y: 1pt), radius: 2pt, clip: true, it,
    )
    h(.2em, weak: true)
  }
  show raw.where(block: true) : it => {
    set text(font: "HackGen Console NF", weight: "regular", size: 10.5pt)
    sourcecode(numbers-style: i => text(fill: luma(180), i), it)
  }

  set par(first-line-indent: 1em)

  set text(bottom-edge: -0.25em)

  set page(numbering: "1")

  set outline(title: "目次", depth: 4)
  show outline: text.with(bottom-edge: -0.1em)

  set table(stroke: (x: none))
  show table : text.with(bottom-edge: 0pt)

  {
    // titlepage
    pagebreak(weak: true)
    set page(numbering: none)
    set align(center)
    if title != none or author != none or showoutline {
      v(1fr)
    }
    if title != none {
      text(size: 2em, mixedBold(title))
    }
    if author != none {
      v(1em)
      author
    }
    if showoutline {
      v(1fr)
      outline()
      v(1fr)
    }
  }

  doc

  if bib != none {
    bibliography(
      bib, style: "association-for-computing-machinery", title: "参考文献", full: true,
    )
  }
}
