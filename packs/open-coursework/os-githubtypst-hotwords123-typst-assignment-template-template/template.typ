#import "@preview/hydra:0.6.2": hydra, selectors

#let _wrap-default(value, default) = if value == auto { default } else { value }
#let _join-nonempty(sep: [, ], ..items) = items.pos().filter(item => item != none).join(sep)

// Assignment mode: problems
#let problem-container = block.with(
  fill: rgb(245, 255, 245),
  width: 100%,
  inset: 8pt,
  radius: 4pt,
  stroke: rgb(128, 199, 128),
)

#let question-counter = counter("assignment-template:question")

#let reset-question = {
  question-counter.update(0)
}

#let problem(
  container: problem-container,
  title: none,
  before: none,
  body,
) = {
  heading(title)
  reset-question
  before
  reset-question
  container(body + parbreak()) // Ensure the body is wrapped in paragraphs
}

#let question(
  numbering: "1.",
  body-indent: 0.5em,
) = {
  question-counter.step()
  context question-counter.display(numbering)
  h(body-indent, weak: true)
}

// Shorthand for question, can be overridden if needed
#let qn = question()

#let statement-container = block.with(
  fill: rgb(250, 250, 250),
  width: 100%,
  inset: 8pt,
  radius: 4pt,
  stroke: rgb(160, 160, 160),
)

#let solution(statement, body, ..args) = problem(
  before: statement-container(statement + parbreak()),
  body,
  ..args,
)

#let assignment-class(
  title: none,
  author: (),
  course-name: none,
  mode: "assignment",
  header: auto,
  footer: auto,
  lang: "en",
  body,
) = {
  set document(title: title, author: author)
  set page(
    paper: "a4",
    header: _wrap-default(header, context {
      let (page-number,) = counter(page).get()
      if page-number > 1 {
        set text(size: 10pt)
        set par(first-line-indent: 0em)
        show: strong

        // Remove extra space after heading numbering in header
        show <heading-numbering-space>: none

        hydra(
          // For some reason, `selectors.by-level(max: 2)` doesn't work properly here,
          // so we use a custom selector instead.
          selectors.custom(selector.or(heading.where(level: 1), heading.where(level: 2))),
          skip-starting: true,
        )
        h(1fr)
        _join-nonempty(sep: [: ], course-name, title)
      }
    }),
    footer: _wrap-default(footer, context {
      let (page-number,) = counter(page).get()
      let (total-pages,) = counter(page).final()

      set align(center)
      set text(size: 10pt)

      if lang == "zh" [
        第 #page-number 页，共 #total-pages 页
      ] else [
        Page #page-number of #total-pages
      ]
    }),
  )

  // Title
  show std.title: set align(center)
  show std.title: set text(size: 18pt)

  show: it => if mode == "report" {
    // Headings
    show heading: set block(below: 1em)
    set heading(numbering: (..nums) => {
      numbering("1.1", ..nums)
      [#h(0.5em, weak: true) <heading-numbering-space>]
    })

    it
  } else {
    // Headings
    set heading(numbering: (..nums) => {
      if nums.pos().len() == 1 {
        let index = numbering("1", ..nums)
        if lang == "zh" [
          第 #index 题
        ] else [
          Problem #index
        ]
      } else {
        numbering("1.1", ..nums)
      }
    })

    // Reduce font size for problem titles
    show heading.where(level: 1): set text(size: 0.9em)

    it
  }

  let en-font = "New Computer Modern"

  show: it => if lang == "zh" {
    set text(lang: "zh", region: "CN")

    // Font settings
    let cjk-font-spec(cjk-font, en-font: en-font) = (
      (name: en-font, covers: "latin-in-cjk"),
      cjk-font,
    )

    // https://typst-doc-cn.github.io/guide/FAQ/install-fonts.html
    set text(size: 11pt, font: cjk-font-spec("FZShuSong-Z01S"))
    show strong: set text(font: cjk-font-spec("FZHei-B01S"))
    show emph: set text(font: cjk-font-spec("FZKai-Z03S"))
    show heading: set text(font: cjk-font-spec("FZXiaoBiaoSong-B05S"))
    show std.title: set text(font: cjk-font-spec("FZHei-B01S"))

    // https://typst-doc-cn.github.io/guide/FAQ/chinese-in-raw.html
    show raw: set text(font: cjk-font-spec("Source Han Sans SC", en-font: "DejaVu Sans Mono"))

    // https://typst-doc-cn.github.io/guide/FAQ/equation-chinese-font.html
    show math.equation: set text(font: ("New Computer Modern Math", "FZShuSong-Z01S"))

    // https://typst-doc-cn.github.io/guide/FAQ/smartquote-font.html
    show smartquote: set text(font: en-font)

    // https://typst-doc-cn.github.io/guide/FAQ/underline-misplace.html
    set underline(offset: .1em, stroke: .05em, evade: false)

    // Paragraph and list indentation for Chinese documents
    set par(
      first-line-indent: (amount: 2em, all: true),
      spacing: 0.8em,
      leading: 0.8em,
    )
    set list(indent: 2em)
    set enum(indent: 2em)
    set terms(indent: 2em, hanging-indent: -2em)

    it
  } else {
    set text(lang: "en")

    // Font settings
    set text(size: 11pt, font: en-font)

    it
  }

  if title != none {
    std.title()
  }

  body
}
