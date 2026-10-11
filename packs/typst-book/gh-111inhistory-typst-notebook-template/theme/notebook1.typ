#import "/elements/elements.typ": *
// #import "/utils/hook-utils.typ.wip": nested-elem-set
#import "/utils/numbly-utils.typ": *
#import "/utils/typing-utils.typ": char-replace
#import "@preview/hydra:0.6.2": hydra
#import "@preview/zebraw:0.5.5": zebraw, zebraw-init
#import "@preview/cjk-spacer:0.2.0": cjk-spacer
#import "@preview/marginalia:0.3.1" as marginalia

#let western-close-punc-regex = regex(
  "[\\p{Pf}\\p{Pe}\\p{Term}--[!"
    + "\\u3000-\\u303F"
    + "\\uFE10-\\uFE1F"
    + "\\uFE30-\\uFE4F"
    + "\\uFE50-\\uFE6F"
    + "\\uFF00-\\uFFEF"
    + "]]",
)

#let marginalia-config = (
  inner: (far: 1cm, width: 0cm, sep: 0.6cm),
  outer: (far: 5mm, width: 4cm, sep: 0.8cm),
  top: 2.35cm,
  bottom: 2.35cm,
  book: false,
  clearance: 12pt,
)

#let notebook-theme1(doc) = {
  let par-spacing = 0.65em

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
        type: "first-line-indent",
        spacing: par-spacing,
        connector: (
          enabled: true,
          position: 1em,
        ),
      ),
      tight: (
        spacing: par-spacing,
        connector: (
          enabled: true,
          position: 1em,
        ),
      ),
    ),
    list: (
      marker: notebook-list-marker,
      loose: (
        type: "first-line-indent",
        spacing: par-spacing,
        connector: (
          enabled: true,
          position: 1em,
        ),
      ),
      tight: (
        spacing: par-spacing,
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
    width: 24cm,
    height: 29.7cm,
    fill: rgb("#f9f9f9"),
    numbering: "1",
    background: {
      place(top + left, dx: 19cm, dy: 2.35cm)[
        #line(
          length: 25cm,
          angle: 90deg,
          stroke: (thickness: 0.6pt, paint: gray, dash: (5pt, 3pt)),
        )
      ]
    },
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
  show: marginalia.setup.with(..marginalia-config)

  /// Text related
  // Keep `!=` intact so text replacement rules can still match it.
  show: cjk-spacer.with(
    western-close-punc-regex: western-close-punc-regex,
  )
  show: char-replace
  let notebook-body-font = ((name: "Charter", covers: "latin-in-cjk"), "LXGW WenKai GB")
  let notebook-serif-font = (
    (name: "Charter", covers: "latin-in-cjk"),
    "Source Han Serif SC",
  )
  set text(
    size: 12pt,
    fill: black,
    font: notebook-body-font,
    cjk-latin-spacing: auto,
    weight: 500,
    // top-edge: 1em,
    // bottom-edge: "baseline",
    hyphenate: true,
    lang: "zh",
  )
  show strong: it => text(
    font: notebook-serif-font,
    size: 11pt,
    weight: "bold",
    it.body,
  )

  /// Paragraph
  set par(
    first-line-indent: (amount: 2em, all: true),
    spacing: par-spacing,
    justify: true,
    leading: par-spacing,
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
    size: 17pt,
    weight: "bold",
  )
  show heading.where(level: 1): set block(below: 0.8em)

  show heading.where(level: 2): set text(
    size: 15pt,
    weight: "bold",
  )

  show heading.where(level: 3): set text(
    size: 12pt,
    weight: "bold",
  )

  // Chapter level counters which should be cleared, place them here
  let clear-counters = (
    counter(footnote),
    marginalia.notecounter,
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
  show figure.caption: set text(font: notebook-serif-font, weight: "medium")

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
    size: 11pt,
  )

  /// Code Block
  let notebook-code-block-style = (
    inset: (x: 0.7em, y: 0.45em),
    background-color: rgb("#fcfeff"),
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
  show link: notebook-link.with(accent_background: rgb("#dcdcdc"))

  /// Ref
  show ref: notebook-ref.with(
    text_color: black,
    fill_color: rgb("#dbeaed00"),
    stroke_color: rgb("#ffffff00"),
  )

  set terms(tight: false, separator: [：])
  show terms: notebook-terms
  // show terms: it => [#h(2em)#it]

  /// Emphasize
  show emph: set text(
    size: 12pt,
    font: (
      (name: "Source Han Serif SC", covers: regex("[\\u4e00-\\u9fa5\\uFF00-\\uFFEF]")),
      "Charter",
      "LXGW WenKai GB",
    ),
    style: "italic",
  )

  /// Math
  show math.equation: set math.equation(supplement: "公式")
  show math.equation.where(block: false): math.display
  show math.equation: set text(
    size: 11pt,
    font: ("New Computer Modern Math", "Charter", "Source Han Serif SC"),
    features: ("cv01",),
    weight: 500,
    // size: 11.5pt,
    cjk-latin-spacing: auto,
  )

  show math.frac: v-h-frac
  // Note: recommend style modification being placed together
  // show math.equation.where(block: false): it => [#h(3pt)#math.display(it)#h(3pt)]
  set math.equation(numbering: n => {
    numbering("(1.1)", counter(heading).at(here()).first(), n)
  })

  // Note: should be placed after all math.equation rules to avoid any unexpected modification.
  show: math-hook

  /// Footnote
  show footnote: it => {
    set text(fill: blue)
    super("[") + it + super("]")
  }

  doc
}
