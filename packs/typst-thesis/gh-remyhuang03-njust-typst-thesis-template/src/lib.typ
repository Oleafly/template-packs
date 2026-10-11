#import "my_vanilla.typ": body, vanilla
#import "@preview/cuti:0.4.0": show-cn-fakebold
#import "functions.typ": *

#let thesis-template(
  title-cn: "",
  title-en: "",
  running-title: none,
  author: "",
  advisor: "",
  coadvisor: "",
  degree: "",
  major: "",
  school: "",
  submit-date: "",
  abstract-cn: [],
  keywords-cn: (),
  abstract-en: [],
  keywords-en: (),
  acknowledgements: [],
  references: none,
  appendix: [],
  body,
) = {
  let chapter-title = state("chapter-title", title-cn)

  ///// show rules /////
  show: show-cn-fakebold

  set par(
    first-line-indent: 2em,
  )

  show: vanilla.with(
    styles: (
      body: (
        spacing: 20pt,
        leading: 20pt,
        first-line-indent: 2em,
        hanging-indent: 2em,
        justify: true,
      ),
    ),
  )

  ///// Basic setup /////
  set document(title: title-cn, author: author)
  set page(
    paper: "a4",
    margin: (top: 30mm, bottom: 24mm, left: 25mm, right: 25mm),
    numbering: none,
    header: running-header("毕业设计（论文）报告", title-cn, chapter-title),
    footer: centered-footer(),
    header-ascent: 30mm - 20mm,
    footer-descent: 24mm - 20mm,
  )

  set text(
    font: ("Times New Roman", "SimSun"),
    size: 12pt,
    lang: "zh",
  )
  show raw: set text(font: "Courier New", size: 10.5pt)

  set block(spacing: 0.9em)
  set heading(numbering: none)

  let vanilla-body-leading = ((20pt - 12pt) / 12pt) * 1em
  set enum(numbering: "1.", spacing: vanilla-body-leading)
  show list.item: set par(
    leading: vanilla-body-leading,
    spacing: vanilla-body-leading,
  )
  show enum.item: set par(
    leading: vanilla-body-leading,
    spacing: vanilla-body-leading,
  )

  // Citation style: superscript bracketed references, e.g., [1] in the upper-right.
  show cite: it => super(it)

  // Format heading references as "1.3.2 小节" instead of "小节 1.3.2".
  show ref: it => {
    let el = it.element
    if el != none and el.func() == heading and el.numbering != none {
      let loc = el.location()
      return link(loc)[
        #numbering(el.numbering, ..counter(heading).at(loc)) 小节]
    }
    it
  }

  ///// figures /////
  set figure(
    numbering: num => context {
      let current = counter(heading.where(level: 1)).get()
      let chapter = if current.len() > 0 { current.first() } else { 0 }
      numbering("1.1", chapter, num)
    },
    placement: top,
  )

  show figure.where(kind: image): set figure(supplement: [图])
  show figure.where(kind: table): set figure(supplement: [表])

  show figure: set text(
    font: ("Times New Roman", "SimSun"),
    size: 10.5pt,
  )

  show figure.caption: it => align(center)[
    #it.supplement#context it.counter.display(it.numbering) #it.body
  ]

  ///// tables /////
  show figure.where(kind: table): it => block(
    width: 100%,
    above: 12pt,
    below: 12pt,
  )[
    #it.caption

    #align(center)[
      #table(
        columns: it.body.columns,
        inset: (x: 6pt, y: 4pt),
        stroke: none,
        align: center + horizon,
        fill: none,
        table.hline(y: 0, stroke: 0.5pt),
        table.hline(y: 1, stroke: 0.5pt),
        ..it.body.children,
        table.hline(stroke: 0.5pt),
      )
    ]
  ]
  ///// equations /////
  set math.equation(
    numbering: num => context {
      let current = counter(heading.where(level: 1)).get()
      let chapter = if current.len() > 0 { current.first() } else { 0 }
      numbering("(1.1)", chapter, num)
    },
    supplement: [式],
  )

  ///// headings /////
  show heading: set par(first-line-indent: 0pt)
  show heading.where(level: 1): it => {
    if it.numbering == none {
      chapter-title.update([#it.body])
      block(
        width: 100%,
        above: 18pt,
        below: 18pt,
      )[
        #align(center)[#text(size: 16pt, weight: "bold")[#it.body]]
      ]
    } else {
      chapter-title.update([
        #context counter(heading.where(level: 1)).display()#sym.space.en#it.body
      ])
      v(0.5em)
      text(size: 15pt, weight: "bold")[
        #context counter(heading.where(level: 1)).display()#sym.space.en#it.body
      ]
      v(0.4em)
    }
  }

  show heading.where(level: 2): it => {
    v(0.5em)
    text(size: 14pt, weight: "bold")[
      #context counter(heading).display()#sym.space.en#it.body
    ]
    v(0.4em)
  }

  show heading.where(level: 3): it => {
    v(0.35em)
    text(size: 12pt, weight: "bold")[
      #context counter(heading).display()#sym.space.en#it.body
    ]
    v(0.25em)
  }

  // Ensure list-of-figures/tables numbers match body captions.
  // The default outline prefix evaluates figure numbering at outline location
  // (front matter), which can yield "0.x". We recompute by figure location.
  show outline.entry: it => {
    if it.element.func() == figure {
      let loc = it.element.location()
      let chapter-counter = counter(heading.where(level: 1)).at(loc)
      let chapter = if chapter-counter.len() > 0 {
        chapter-counter.first()
      } else { 0 }
      let figure-counter = it.element.counter.at(loc)
      let num = if figure-counter.len() > 0 { figure-counter.first() } else {
        0
      }
      let prefix = [#it.element.supplement #numbering("1.1", chapter, num)]
      return link(loc, it.indented(prefix, it.inner()))
    }
    if it.element.func() == heading and it.level == 1 {
      return text(weight: "bold", size: 14pt)[#it]
    }
    it
  }


  [
    #set page(
      numbering: "I",
    )
    #cover-first-heading(outlined: true)[摘#(four-space)要]
    #abstract-cn
    #render-keywords([关键词：], keywords-cn)

    #pagebreak()
    #cover-first-heading(outlined: true)[Abstract]
    #abstract-en
    #render-keywords([Keywords: ], keywords-en)
    #pagebreak()

    #cover-first-heading(outlined: false)[目#(four-space)录]
    #outline(title: none)
    #pagebreak()

    #cover-first-heading(outlined: false)[图表目录]
    #outline(title: none, target: figure)

    #pagebreak()
    #counter(page).update(1)
    #set page(
      numbering: "1",
    )

    #set heading(numbering: "1.1.1")
    #body

    #pagebreak()
    #cover-first-heading(outlined: true)[致#(four-space)谢]
    #acknowledgements


    #pagebreak()
    #cover-first-heading(outlined: true)[参考文献]
    #references


    #pagebreak()
    #cover-first-heading(outlined: true)[附#(four-space)录]
    #appendix
  ]
}
