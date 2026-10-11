#import "/elements/elements.typ": better-lists, notebook-inline-code
#import "/utils/numbly-utils.typ": partial-display
#import "/utils/size-utils.typ": 三号, 五号, 四号, 小五, 小四
#import "@preview/numbly:0.1.0": numbly
#import "@preview/zebraw:0.5.5": zebraw, zebraw-init

#let thesis-list-settings = (
  enum: (
    numbering: partial-display("{1}.{2}.{3}.{4}."),
    post-numbering: none,
    full: false,
    tight: (
      type: "first-line-indent",
      numbering-align: "right",
    ),
    loose: (
      type: "first-line-indent",
      numbering-align: "right",
    ),
  ),
  list: (
    marker: ([•], [◦], [▪]),
    tight: (
      type: "first-line-indent",
      marker-align: "right",
    ),
    loose: (
      type: "first-line-indent",
      marker-align: "right",
    ),
  ),
)

/// Format image/table numbering as chapter-local indices when possible.
#let thesis-figure-numbering(..nums) = {
  let values = nums.pos()
  let heading-path = counter(heading).at(here())
  if heading-path.len() == 0 {
    numbering("1", values.at(0))
  } else {
    numbering("1.1", heading-path.first(), values.at(0))
  }
}

#let render-thesis-heading(
  it,
  size,
  above,
  below,
  centered: false,
  indent: 0pt,
  reset-chapter-counters: false,
) = {
  if reset-chapter-counters {
    // Reset chapter-scoped counters when a new chapter starts.
    counter(math.equation).update(0)
    counter(figure.where(kind: "image")).update(0)
    counter(figure.where(kind: "table")).update(0)
  }

  let body = if centered {
    align(center, it)
  } else if indent != 0pt {
    [#h(indent)#it]
  } else {
    it
  }

  block(above: above, below: below, width: 100%)[
    #set text(size: size, weight: "bold")
    #body
  ]
}

#let render-thesis-third-heading(it) = {
  let numbering = if it.numbering == none {
    none
  } else {
    counter(heading).display(it.numbering)
  }

  block(above: 12pt, below: 6pt, width: 100%)[
    #set text(size: 小四, weight: "bold")
    #h(2em)
    #if numbering != none {
      numbering
      h(0.5em)
    }
    #it.body
  ]
}

#let undergraduate-thesis-theme(
  doc,
  title: none,
  header-title: auto,
  header-left: [大学本科毕业论文（设计）],
  page-numbering: "1",
) = {
  let resolved-header-title = if header-title == auto { title } else { header-title }

  if title != none {
    set document(title: title)
  }

  show: better-lists(thesis-list-settings)

  set page(
    paper: "a4",
    margin: (
      top: 2.5cm,
      bottom: 2.5cm,
      left: 2.5cm,
      right: 2cm,
    ),
    header-ascent: 1.5cm,
    footer-descent: 1.5cm,
    numbering: page-numbering,
    header: context {
      set text(
        size: 小五,
        font: ("Times New Roman", "SimSun"),
      )
      set par(first-line-indent: 0pt, spacing: 0pt)
      block(width: 100%)[
        #grid(
          columns: (1fr, 1fr),
          align: (left + bottom, right + bottom),
          [#header-left], if resolved-header-title == none { [] } else { [#resolved-header-title] },
        )
        #v(0.35em)
        #line(length: 100%, stroke: 0.7pt + black)
      ]
    },
    footer: context {
      set text(
        size: 五号,
        font: "SimSun",
      )
      set par(first-line-indent: 0pt, spacing: 0pt)
      align(center)[#counter(page).display()]
    },
  )

  set text(
    size: 小四,
    font: ("Times New Roman", "SimSun"),
    lang: "zh",
    cjk-latin-spacing: auto,
  )

  set par(
    first-line-indent: (amount: 2em, all: true),
    justify: true,
    spacing: 8pt,
  )

  set heading(
    numbering: numbly("第{1:一}章", "{1}.{2}", "{1}.{2}.{3}"),
    supplement: none,
  )

  show heading: set text(
    font: ("Arial", "SimHei"),
    fill: black,
  )

  show heading.where(level: 1): it => render-thesis-heading(
    it,
    三号,
    24pt,
    18pt,
    centered: true,
    reset-chapter-counters: true,
  )
  show heading.where(level: 2): it => render-thesis-heading(
    it,
    四号,
    24pt,
    6pt,
  )
  show heading.where(level: 3): it => render-thesis-third-heading(
    it,
  )
  show heading.where(level: 4): it => panic("Heading level can not exceed level 3")

  set figure(
    numbering: thesis-figure-numbering,
    gap: 6pt,
  )
  set figure.caption(separator: [ ])
  show figure.caption: set text(
    size: 五号,
    font: ("Times New Roman", "SimSun"),
  )
  show figure.where(kind: "image"): set figure(supplement: "图")
  show figure.where(kind: "image"): set block(
    above: 6pt,
    below: 12pt,
  )
  show figure.where(kind: "table"): set figure(supplement: "表")
  show figure.where(kind: "table"): set figure.caption(position: top)
  show figure.where(kind: "table"): set block(
    above: 6pt,
    below: 6pt,
  )

  show math.equation: set text(
    font: ("New Computer Modern Math", "Times New Roman", "SimSun"),
    cjk-latin-spacing: auto,
  )
  show math.equation: set math.equation(
    supplement: none,
    numbering: n => text(
      size: 五号,
      font: ("SimSun", "Times New Roman"),
      [（#n）],
    ),
  )

  show raw: set text(
    font: ("Maple Mono", "LXGW Wenkai GB"),
    size: 10pt,
  )
  let thesis-code-block-style = (
    inset: (x: 0.7em, y: 0.45em),
    background-color: rgb("#f6fdf8"),
    comment-color: luma(88%),
    lang-color: rgb("#40444f"),
    lang-font-args: (
      fill: white,
      weight: "bold",
      size: 0.9em,
    ),
    numbering-font-args: (
      fill: luma(55%),
    ),
    numbering-separator: true,
  )
  show: zebraw-init.with(..thesis-code-block-style)
  show raw.where(block: false): notebook-inline-code
  show raw.where(block: true): set block(
    stroke: 1pt + luma(50%),
    radius: 0.4em,
  )
  show raw.where(block: true): zebraw

  doc
}
