#import "/elements/elements.typ": *
// #import "/utils/hook-utils.typ.wip": nested-elem-set
#import "/utils/numbly-utils.typ": *
#import "/utils/typing-utils.typ": char-replace
#import "@preview/hydra:0.6.2": hydra
#import "@preview/zebraw:0.5.5": zebraw, zebraw-init
#import "@preview/cjk-spacer:0.2.0": cjk-spacer

#let western-close-punc-without-bang = regex(
  "[\\p{Pf}\\p{Pe}\\p{Term}--[!"
    + "\\u3000-\\u303F"
    + "\\uFE10-\\uFE1F"
    + "\\uFE30-\\uFE4F"
    + "\\uFE50-\\uFE6F"
    + "\\uFF00-\\uFFEF"
    + "]]",
)

#let notebook-theme(doc) = {
  /// List and Enum
  let notebook-list-marker(level) = {
    let fill = luma(22%)
    let shape = if level == 0 {
      circle(radius: 0.145em, fill: fill)
    } else if level == 1 {
      polygon(
        fill: fill,
        (0em, 0em),
        (0.29em, 0.17em),
        (0em, 0.34em),
      )
    } else {
      rect(width: 0.19em, height: 0.19em, fill: fill)
    }

    box(width: 1em, baseline: -3pt)[
      #align(center + horizon, shape)
    ]
  }
  let custom-list-settings = (
    enum: (
      numbering: partial-display("{1}.{2}.{3}.{4}."),
      post-numbering: none,
      full: false,
      loose: (
        type: "block-indent",
        connector: (
          enabled: true,
          position: 1em,
        ),
      ),
      tight: (
        connector: (
          enabled: true,
          position: 1em,
        ),
      ),
    ),
    list: (
      marker: notebook-list-marker,
      loose: (
        type: "block-indent",
        connector: (
          enabled: true,
          position: 1em,
        ),
      ),
      tight: (
        connector: (
          enabled: true,
          position: 1em,
        ),
      ),
    ),
  )
  show: better-lists(custom-list-settings)

  /// Page
  set page(
    paper: "a4",
    margin: (x: 1.91cm, y: 2.54cm),
    fill: luma(98%),
    numbering: "1",
    header: context {
      align(bottom, {
        set par(first-line-indent: 0pt)
        hydra(1)
        place(bottom, dy: 0.5em)[#line(
          length: 100%,
          stroke: 1pt + black,
        )]
      })
    },
  )

  /// Text related
  // Keep `!=` intact so text replacement rules can still match it.
  show: cjk-spacer.with(
    western-close-punc-regex: western-close-punc-without-bang,
  )
  show: char-replace
  set text(
    size: 10pt,
    fill: luma(20%),
    font: ("Source Han Serif SC", "Charter"),
    cjk-latin-spacing: auto,
    weight: "medium",
    hyphenate: true,
    lang: "zh",
  )

  /// Paragraph
  set par(
    first-line-indent: (amount: 2em, all: true),
    spacing: 1.2em,
    justify: true,
    leading: 0.65em,
  )

  /// Heading
  set heading(
    numbering: numbly("{1:一}、", "{1}.{2}", "{1}.{2}.{3}"),
    supplement: "章节",
  )
  show heading: set text(
    fill: luma(20%),
    font: ("Arial", "HarmonyOS Sans SC"),
  )
  show heading: set block(above: 0.8em)

  show heading.where(level: 1): set text(
    size: 16pt,
    weight: "bold",
  )
  show heading.where(level: 1): set block(below: 0.8em)

  show heading.where(level: 2): set text(
    size: 14pt,
    weight: "bold",
  )

  show heading.where(level: 3): set text(
    size: 12pt,
    weight: "bold",
  )

  // Chapter level counters which should be cleared, place them here
  let clear-counters = (
    counter(footnote),
    counter(math.equation),
    counter(figure.where(kind: "image")),
    counter(figure.where(kind: "table")),
  )

  show heading.where(level: 1): it => {
    for c in clear-counters {
      c.update(0)
    }
    it
  }

  show heading.where(level: 1): it => pagebreak(weak: true) + it

  /// Quote
  show quote.where(block: true): block.with(
    width: 100%,
    stroke: 0.8pt + luma(80%),
    fill: luma(96.5%),
    radius: 0.4em,
    inset: (x: 1em, y: 1em),
    above: 0.65em,
    below: 0.65em,
  )

  /// Figure
  set figure(
    numbering: (..nums) => {
      let figure_pos = nums.at(0)
      numbering("1-1", (counter(heading).at(here())).first(), figure_pos)
    },
  )

  show figure.where(kind: "image"): set figure(supplement: "图")
  show figure.where(kind: "table"): set figure(supplement: "表")

  /// Underline
  set underline(
    offset: 2pt,
    stroke: (
      paint: blue,
      thickness: 0.75pt,
    ),
  )

  show raw: set text(
    font: ("Maple Mono", "LXGW Wenkai GB"),
    size: 10pt,
  )

  /// Code Block
  let notebook-code-block-style = (
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
  show: zebraw-init.with(..notebook-code-block-style)

  show raw.where(block: false): notebook-inline-code
  show raw.where(block: true): it => block(zebraw(it), radius: 0.375em, stroke: gray + 1pt)

  /// Link
  show link: notebook-link

  /// Emphasize
  show emph: it => text(
    font: (
      (name: "LXGW WenKai GB", covers: regex("[\\u4e00-\\u9fa5\\uFF00-\\uFFEF]")),
      "Source Han Serif SC",
      "Charter",
    ),
    style: "italic",
    it.body,
  )

  /// Math
  show math.equation: set math.equation(supplement: "公式")
  show math.equation: set text(
    features: ("cv01",), // solve some strange glyph issues, like emptyset symbol
    font: ("New Computer Modern Math", "Source Han Serif SC"),
    weight: 500,
    cjk-latin-spacing: auto,
  )

  show math.frac: v-h-frac
  // Note: recommend style modification being placed together
  show math.equation.where(block: false): it => [#h(0.3em)#math.display(it)#h(0.3em)]
  set math.equation(numbering: n => {
    numbering("(1.1)", counter(heading).at(here()).first(), n)
  })

  // Note: should be placed after all math.equation rules to avoid any unexpected modification.
  show: math-hook

  doc
}
