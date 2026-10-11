// W&M Thesis/Dissertation Template
//
// Copyright (c) 2026 Star Brilliant
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#let main-font = "New Computer Modern"

// TeX pt = 1/72.27in, Typst pt = 1/72in
#let tex-pt = 7200pt / 7227

// LaTeX \documentclass[11pt]{report}
#let tiny-size = 6 * tex-pt
#let script-size = 8 * tex-pt
#let footnote-size = 9 * tex-pt
#let small-size = 10 * tex-pt
#let normal-size = 10.95 * tex-pt
#let large-size = 12 * tex-pt
#let Large-size = 14.4 * tex-pt
#let LARGE-size = 17.28 * tex-pt
#let huge-size = 20.74 * tex-pt
#let Huge-size = 24.88 * tex-pt

#let tiny-baseline-skip = 7 * tex-pt
#let script-baseline-skip = 9.5 * tex-pt
#let footnote-baseline-skip = 11 * tex-pt
#let small-baseline-skip = 12 * tex-pt
#let normal-baseline-skip = 13.6 * tex-pt
#let large-baseline-skip = 14 * tex-pt
#let Large-baseline-skip = 18 * tex-pt
#let LARGE-baseline-skip = 22 * tex-pt
#let huge-baseline-skip = 25 * tex-pt
#let Huge-baseline-skip = 30 * tex-pt

// LaTeX \doublespacing
#let tiny-double-spacing-leading = tiny-baseline-skip * 0.618
#let script-double-spacing-leading = script-baseline-skip * 0.618
#let footnote-double-spacing-leading = footnote-baseline-skip * 0.618
#let small-double-spacing-leading = small-baseline-skip * 0.618
#let normal-double-spacing-leading = normal-baseline-skip * 0.618
#let large-double-spacing-leading = large-baseline-skip * 0.618
#let Large-double-spacing-leading = Large-baseline-skip * 0.618
#let LARGE-double-spacing-leading = LARGE-baseline-skip * 0.618
#let huge-double-spacing-leading = huge-baseline-skip * 0.618
#let Huge-double-spacing-leading = Huge-baseline-skip * 0.618

#let par-indent = 17 * tex-pt

#let wm-thesis(
  is-proposal: false,
  onion-skin-pdf: none,
  onion-skin-pdf-num-pages: none,
  short-author: none,
  graduation-year: [],
  graduation-month: [],
  bib: none,
  advisor: [],
  hometown: [],
  previous-degrees: (),
  department: [Department of Computer Science],
  committee: (),
  abstract: [],
  acknowledge: [],
  dedication: [],
  vita: [],
  body,
) = {
  let short-author = if short-author != none { short-author } else { context document.author.first() }

  let top-margin = /* default */ 1in + /* \topmargin */0.25in + /* \headheight */12 * tex-pt + /* \headsep */25 * tex-pt
  let left-margin = /* default */ 1in + /* \oddsidemargin */0.5in
  let right-margin = /* \paperwidth */ 8.5in - left-margin - /* \textwidth*/5.9in
  let bottom-margin = /* \paperheight */ 11in - top-margin - /* \textheight */8.4in
  let top-skip = /* \topskip */ 11 * tex-pt
  let top-edge = /* Typst top-edge */ normal-baseline-skip
  set page(
    paper: "us-letter",
    margin: (
      top: top-margin + top-skip - top-edge,
      left: left-margin,
      right: right-margin,
      bottom: bottom-margin,
    ),
    numbering: "1",
    header-ascent: /* \headsep */ 25 * tex-pt,
    footer: none,
    footer-descent: /* \footskip */ 24 * tex-pt - top-edge,
    background: if onion-skin-pdf != none {
      context {
        let this-page = here().page()
        if this-page <= onion-skin-pdf-num-pages {
          place(top + left, image(onion-skin-pdf, width: 100%, height: 100%, page: this-page, fit: "contain"))
          rect(width: 100%, height: 100%, fill: white.transparentize(50%))
        }
      }
    },
  )
  set par(
    leading: normal-double-spacing-leading,
    spacing: normal-double-spacing-leading,
    justify: true,
    first-line-indent: par-indent,
  )
  set text(
    font: main-font,
    size: normal-size,
    top-edge: normal-baseline-skip,
    lang: "en",
    region: "US",
    script: "latn",
  )

  show title: set block(spacing: 0pt)
  show title: set text(size: large-size, weight: "regular", top-edge: large-baseline-skip, tracking: -0.01em)
  let plain-heading(it) = {
    set par(leading: 0pt, spacing: 0pt, justify: false, first-line-indent: 0pt)
    set text(size: Large-size, top-edge: Large-baseline-skip, tracking: -0.015em)
    v(top-edge - Large-baseline-skip)
    align(center, block(
      below: 12 * tex-pt, // \topsep + \parskip + \partopsep
      strong(delta: -300, upper(it.body)),
    ))
  }
  show heading.where(level: 1): plain-heading
  set outline(indent: level => (0em, 1.47em, 3.72em, 6.85em).at(level, default: 1.47em * level))
  show outline: set par(leading: large-double-spacing-leading, spacing: large-double-spacing-leading)
  show outline: set text(size: large-size, top-edge: large-baseline-skip, tracking: -0.01em)
  show outline.entry: set block(above: large-double-spacing-leading, below: 0pt)
  show outline.entry.where(level: 1): set block(above: 20.4 * tex-pt)
  show outline.entry.where(level: 1): it => link(
    it.element.location(),
    it.indented(it.prefix(), it.inner(), gap: 0.96em),
  )
  show outline.entry.where(level: 2): it => link(
    it.element.location(),
    it.indented(it.prefix(), it.inner(), gap: 0.99em),
  )
  show outline.entry.where(level: 3): it => link(
    it.element.location(),
    it.indented(it.prefix(), it.inner(), gap: 1.105em),
  )
  show outline.entry.where(level: 4): it => link(
    it.element.location(),
    it.indented(it.prefix(), it.inner(), gap: 1.24em),
  )
  let list-of-figure-styling(it) = {
    show outline.entry: set block(above: large-double-spacing-leading)
    show outline.entry: it => block(inset: (left: 1.47em), link(
      it.element.location(),
      it.indented(counter(figure.where(kind: it.element.kind)).display(at: it.element.location()), it.inner(), gap: 0.98em),
    ))
    it
  }
  show outline.where(target: figure.where(kind: table)): list-of-figure-styling
  show outline.where(target: figure.where(kind: image)): list-of-figure-styling
  show bibliography: set par(spacing: 9 * tex-pt)
  show bibliography: it => {
    show grid.cell.where(x: 0): set align(right)
    it
  }

  show figure: set par(leading: 0pt, spacing: 0pt)
  show figure.caption: set par(leading: 0pt, spacing: 0pt)
  show figure.caption: set text(size: small-size, top-edge: small-baseline-skip)
  show figure.caption: it => block(align(left)[
    #strong[#it.supplement #it.counter.display()]: #it.body
  ])
  show figure.where(kind: table): set figure.caption(position: top)
  set table(stroke: none, inset: (x: 0.54em, top: 0.21em, bottom: 0.35em))
  show table: set text(top-edge: "cap-height")

  // Title Page
  page(footer: none)[
    #set align(center)
    #set par(leading: 0pt, spacing: 0pt, justify: false, first-line-indent: 0pt)
    #set text(size: large-size, top-edge: large-baseline-skip, tracking: -0.01em)
    #v(top-edge - large-baseline-skip)
    #title()
    #v(large-baseline-skip * 8)
    #par(context document.author.first())
    #v(large-baseline-skip)
    #par(hometown)
    #v(large-baseline-skip * 4)
    #for i in previous-degrees {
      par(i)
    }
    #v(large-baseline-skip * 4)
    #par[
      A #if is-proposal [Proposal] else [Dissertation] presented to the Graduate Faculty \
      of The College of William & Mary in Candidacy for the Degree of \
      Doctor of Philosophy
    ]
    #v(large-baseline-skip * 7)
    #par(department)
    #v(large-baseline-skip * 4)
    #par[William & Mary]
    #par[#graduation-month, #graduation-year]
  ]

  // Copyright Page
  if not is-proposal {
    page(footer: none)[
      #set align(center)
      #set par(leading: 0pt, spacing: 0pt, justify: false, first-line-indent: 0pt)
      #set text(size: 12 * tex-pt, tracking: -0.01em)
      #v(8.4in - 23 * tex-pt)
      #h(0.2em)#sym.copyright#(sym.space.en)Copyright by #short-author #graduation-year
    ]
  }

  // Approval Page
  page[
    // This page is so full that LaTeX squeezes vertical spacings.
    // We add manual vertical adjustments to match point by point.
    #set align(center)
    #set par(leading: 0pt, spacing: 0pt, justify: false, first-line-indent: 0pt)
    #set text(size: Large-size, top-edge: Large-baseline-skip, tracking: -0.015em)
    #v(top-edge - Large-baseline-skip)
    #par(if is-proposal [Oral Exam Committee] else [APPROVAL PAGE])

    #set text(size: large-size, top-edge: large-baseline-skip, tracking: -0.01em)
    #v(large-baseline-skip * 3 - 1.2 * tex-pt)
    #par[This #if is-proposal [Proposal] else [Dissertation] is submitted in partial fulfillment of]
    #v(-0.4 * tex-pt)
    #par[the requirements for the degree of]
    #v(large-baseline-skip - 0.8 * tex-pt)
    #par[Doctor of Philosophy]
    #v(large-baseline-skip * 3)

    #set text(size: normal-size, top-edge: normal-baseline-skip, tracking: 0pt)
    #v(normal-baseline-skip + 0.2 * tex-pt)
    #line(length: 3in, stroke: 0.4 * tex-pt)
    #v(0.2 * tex-pt)

    #set text(size: small-size, top-edge: small-baseline-skip, tracking: 0pt)
    #par(short-author)

    #set text(size: large-size, top-edge: large-baseline-skip, tracking: -0.01em)
    #v(normal-baseline-skip * 3 - 0.4 * tex-pt)
    #par[#if is-proposal [Reviewed] else [Approved] by the Committee, #graduation-month #graduation-year]

    #for (i, j) in committee.enumerate() {
      set text(size: normal-size, top-edge: normal-baseline-skip, tracking: 0pt)
      v(normal-baseline-skip * 3 + 1.4 * tex-pt)
      line(length: 3in, stroke: 0.4 * tex-pt)
      v(0.2 * tex-pt)

      set text(size: small-size, top-edge: small-baseline-skip, tracking: 0pt)
      v(-1.6 * tex-pt)
      if i == 0 {
        par[Committee Chair]
      }
      par[#j.member, #j.department]
      v(1.6 * tex-pt)
      par(j.organization)
    }
  ]

  // Abstract page
  page[
    #heading(outlined: false)[Abstract]
    #set par(leading: 0pt, spacing: 0pt, justify: false, first-line-indent: 0pt)
    #set text(size: large-size, top-edge: large-baseline-skip, tracking: -0.01em)
    #abstract
  ]

  // Reset page numbers to Roman numerals
  set page(numbering: "i", footer: auto)
  counter(page).update(1)

  // Table of contents
  page[
    #v(1.26in)
    #heading(outlined: false)[Table of Contents]
    #v(-0.2em)
    #outline(title: none, target: heading)
  ]

  // Acknowledgments page
  if not is-proposal [
    = Acknowledgments
    #set par(leading: 0pt, spacing: 0pt, justify: false, first-line-indent: 0pt)
    #v(34 * tex-pt)
    #acknowledge
  ]

  // Dedication
  if not is-proposal {
    page[
      #set align(center)
      #set par(leading: 0pt, spacing: 0pt, justify: false, first-line-indent: 0pt)
      #set text(size: large-size, top-edge: large-baseline-skip, tracking: -0.01em)
      #v(top-edge - large-baseline-skip)
      #v(normal-baseline-skip + 3in)
      #[
        #show heading: none
        = Dedication
      ]
      #dedication
    ]
  }

  // List of Tables
  page[
    #v(1.26in)
    = List of Tables
    #v(0.49em)
    #outline(title: none, target: figure.where(kind: table))
  ]

  // List of Figures
  page[
    #v(1.26in)
    = List of Figures
    #v(0.49em)
    #outline(title: none, target: figure.where(kind: image))
  ]

  // Reset page numbers to Roman numerals
  counter(page).update(1)
  set page(numbering: "1")
  set heading(numbering: "1.1")
  set math.equation(numbering: it => {
    let chapter = counter(heading).get().first()
    numbering("(1.1)", chapter, it)
  })
  set figure(numbering: it => {
    let chapter = counter(heading).get().first()
    numbering("1.1", chapter, it)
  })

  show heading.where(level: 1): it => [
    #pagebreak(weak: true)
    #set par(leading: huge-double-spacing-leading, spacing: huge-double-spacing-leading, justify: false, first-line-indent: 0pt)
    #set text(size: huge-size, top-edge: huge-baseline-skip, tracking: -0.015em)
    #counter(math.equation).update(0)
    #v(top-edge - huge-baseline-skip)
    #block(breakable: false, strong[
      #if it.numbering != none {
        v(90.5 * tex-pt)
        par[Chapter #counter(heading).display()]
        v(20 * tex-pt)
      } else {
        v(75 * tex-pt)
      }

      #set par(leading: Huge-double-spacing-leading, spacing: Huge-double-spacing-leading)
      #set text(size: Huge-size, top-edge: Huge-baseline-skip, tracking: -0.013em)
      #it.body
      #v(23.5 * tex-pt)
    ])
  ]
  show heading.where(level: 2): set block(above: 27.6 * tex-pt, below: 19.2 * tex-pt)
  show heading.where(level: 2): set par(leading: Large-double-spacing-leading, spacing: Large-double-spacing-leading, justify: true, first-line-indent: 0pt)
  show heading.where(level: 2): set text(size: Large-size, top-edge: Large-baseline-skip, tracking: -0.0135em)
  show heading.where(level: 2): it => block(par(hanging-indent: 2.55em, box(width: 2.55em, counter(heading).display()) + it.body))
  show heading.where(level: 3): set block(above: 24 * tex-pt, below: 15.5 * tex-pt)
  show heading.where(level: 3): set par(leading: large-double-spacing-leading, spacing: large-double-spacing-leading, justify: true, first-line-indent: 0pt)
  show heading.where(level: 3): set text(size: large-size, top-edge: large-baseline-skip, tracking: -0.0135em)
  show heading.where(level: 3): it => block(par(hanging-indent: 3.45em, box(width: 3.45em, counter(heading).display()) + it.body))
  show heading.where(level: 4): set block(above: 23.7 * tex-pt, below: 15.5 * tex-pt)
  show heading.where(level: 4): set par(leading: normal-double-spacing-leading, spacing: normal-double-spacing-leading, justify: true, first-line-indent: 0pt)
  show heading.where(level: 4): set text(size: normal-size, top-edge: normal-baseline-skip, tracking: -0.0135em)
  show heading.where(level: 4): it => block(par(hanging-indent: 4.4em, box(width: 4.4em, counter(heading).display()) + it.body))

  body

  set heading(numbering: none)
  [
    = Bibliography
    #set par(leading: 0pt, spacing: 0pt, first-line-indent: 0pt)
    #v(5.5 * tex-pt)
    #if bib != none {
      bibliography(bib, title: none, style: "./wmbib.csl")
    }
  ]

  show heading.where(level: 1): plain-heading
  page(
    number-align: top + right,
    header-ascent: 22.5 * tex-pt,
  )[
    = Vita
    #v(35 * tex-pt)
    #align(center, block({
      set text(size: Large-size, top-edge: Large-baseline-skip)
      context document.author.first()
    }))
    #v(36 * tex-pt)
    #vita
  ]
}
