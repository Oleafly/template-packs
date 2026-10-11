// Assignly - Layout and Typography System
// Handles page layout, spacing, typography, and visual formatting

// Import utility functions
#import "utils.typ": get-show-answers, get-show-points, show-points-state

// Page setup and document initialization
#let setup-page(
  margins: (left: 2.5cm, right: 2.5cm, top: 2cm, bottom: 2cm),
  paper: "a4",
) = {
  set page(
    paper: paper,
    margin: margins,
    header: [],
    footer: [],
  )
}

// Typography configuration with enhanced bilingual support
#let setup-typography(
  font-latin: "Libertinus Serif",
  font-cjk: "Noto Serif CJK SC",
  base-size: 11pt,
  line-height: 1.2,
  body,
) = {
  // Use Typst 0.13 syntax with covers property for proper font application
  set text(
    font: (
      // Latin font with covers for Latin-in-CJK contexts
      (name: font-latin, covers: "latin-in-cjk"),
      // CJK font as primary CJK handler
      font-cjk,
      // Fallbacks for Windows systems
      "Microsoft YaHei",
      "Arial",
      // Emoji support
      "Segoe UI Emoji",
      "Segoe UI Symbol",
    ),
    size: base-size,
    fallback: true,
  )

  set par(
    justify: true,
    first-line-indent: 0pt,
  )

  // Mathematical expressions with covers support
  show math.equation: set text(
    font: (
      (name: font-latin, covers: "latin-in-cjk"),
      font-cjk,
      "Cambria Math",
    ),
  )

  // Code blocks and inline code
  show raw: set text(
    font: (
      (name: "Consolas", covers: "latin-in-cjk"),
      font-cjk,
      "Courier New",
    ),
    size: base-size * 0.9,
  )

  // Heading styles with bilingual support
  show heading.where(level: 1): it => {
    set align(center)
    set text(size: 16pt, weight: "bold")
    set text(font: (
      (name: font-latin, covers: "latin-in-cjk"),
      font-cjk,
      "Arial",
      "Segoe UI Emoji",
      "Segoe UI Symbol",
    ))
    block(above: 1em, below: 0.8em, it.body)
  }

  show heading.where(level: 2): it => {
    set text(size: 14pt, weight: "bold")
    set text(font: (
      (name: font-latin, covers: "latin-in-cjk"),
      font-cjk,
      "Arial",
      "Segoe UI Emoji",
      "Segoe UI Symbol",
    ))
    block(above: 0.8em, below: 0.6em, it.body)
  }

  show heading.where(level: 3): it => {
    set text(size: 12pt, weight: "bold")
    set text(font: (
      (name: font-latin, covers: "latin-in-cjk"),
      font-cjk,
      "Arial",
      "Segoe UI Emoji",
      "Segoe UI Symbol",
    ))
    block(above: 0.6em, below: 0.4em, it.body)
  }

  // Emit wrapped body so that all style/show rules apply within this scope
  body
}

// Assignment header layout
#let assignment-header(
  title: "",
  course: "",
  due-date: "",
  author: "",
  show-answers: false,
) = {
  block(
    width: 100%,
    stroke: (bottom: 1.5pt + black),
    inset: (bottom: 0.8em),
  )[
    #align(center)[
      #text(size: 18pt, weight: "bold")[#title]
    ]

    #if show-answers [
      #v(0.3em)
      #align(center)[
        #rect(
          fill: rgb(255, 200, 200),
          stroke: 1pt + red,
          inset: 5pt,
          radius: 3pt,
        )[
          #text(weight: "bold", fill: red)[ANSWER KEY - TEACHER VERSION]
        ]
      ]
    ]

    #v(0.5em)

    #if author == "" {
      grid(
        columns: (1fr, 1fr),
        column-gutter: 1em,
        align: (left, right),
        [*Course:* #course], [*Due Date:* #due-date],
      )
    } else {
      grid(
        columns: (1fr, 1fr, 1fr),
        column-gutter: 1em,
        align: (left, center, right),
        [*Course:* #course], [*Due Date:* #due-date], [*Instructor:* #author],
      )
    }
  ]
}

// Section header layout
#let section-header(title: "", instructions: "") = {
  block(
    width: 100%,
    above: 1.5em,
    below: 1em,
  )[
    #text(size: 14pt, weight: "bold")[#title]

    #if instructions != "" [
      #v(0.4em)
      #text(size: 10pt, style: "italic")[#instructions]
    ]
  ]
}

// Question styling and spacing
#let question-block(number, content, points: 1) = context {
  block(
    width: 100%,
    inset: (top: 0.8em, bottom: 0.5em),
  )[
    #grid(
      columns: (auto, 1fr, auto),
      column-gutter: (0.5em, 1em),
      [*#number.*],
      [#content],
      [#if show-points-state.get() {
        text(size: 9pt, fill: gray)[#if (
          points == 1
        ) [(1 point)] else [(#points points)]]
      }],
    )
  ]
}

// Option list formatting (for multiple choice questions)
#let option-list(
  options,
  correct-indices: (),
  style: "letters",
  left-inset: 1.2em,
  show-answers: false,
) = {
  let markers = if style == "letters" {
    ("A", "B", "C", "D", "E", "F", "G", "H")
  } else {
    range(1, options.len() + 1).map(str)
  }

  for (i, option) in options.enumerate() {
    let is-correct = i in correct-indices
    let marker = if i < markers.len() { markers.at(i) } else { str(i + 1) }

    block(inset: (left: left-inset, top: 0.3em))[
      #if is-correct and show-answers {
        text(weight: "bold")[#marker. #option] + text(fill: green)[ (✓)]
      } else [
        #marker. #option
      ]
    ]
  }
}

// Answer highlighting for teacher mode with enhanced visibility
#let highlight-answer(content, show-answer: false) = {
  if show-answer {
    rect(
      fill: rgb(255, 255, 0, 50), // Light yellow highlight
      stroke: none,
      inset: 2pt,
      radius: 2pt,
    )[#content]
  } else {
    content
  }
}

// Enhanced correct answer indicator
#let correct-answer-indicator(show-indicator: false) = {
  if show-indicator {
    text(fill: green, weight: "bold")[✓]
  }
}

// Enhanced explanation box with conditional visibility
#let explanation-box(explanation, show-explanation: false) = {
  if show-explanation and explanation != "" {
    v(0.5em)
    rect(
      width: 100%,
      fill: rgb(240, 255, 240), // Light green background
      stroke: 0.8pt + green,
      inset: 8pt,
      radius: 3pt,
    )[
      #text(size: 9pt, style: "italic", fill: rgb(0, 100, 0))[
        *💡 Explanation:* #explanation
      ]
    ]
  }
}

// Teacher mode answer key box
#let teacher-answer-box(content) = context {
  let show-answers = show-answers-state.get()
  if show-answers {
    rect(
      width: 100%,
      fill: rgb(255, 240, 240), // Light red background
      stroke: 1pt + red,
      inset: 8pt,
      radius: 3pt,
    )[
      #text(size: 9pt, weight: "bold", fill: red)[
        📚 TEACHER REFERENCE: #content
      ]
    ]
  }
}

// Blank line generation for fill-in answers
#let blank-line(width: 3cm, answer: none, show-answer: false) = {
  if show-answer and answer != none [
    #highlight-answer(answer, true)
  ] else [
    #box(
      width: width,
      stroke: (bottom: 0.8pt + black),
      height: 1.2em,
    )
  ]
}

// Answer lines for short answer questions
#let answer-lines(count: 3, line-spacing: 2em) = {
  for i in range(count) {
    v(if i == 0 { 0.5em } else { line-spacing })
    line(
      length: 100%,
      stroke: 0.5pt + gray,
    )
  }
  v(0.5em)
}

// Point display formatting
#let points-display(points, align-right: true) = {
  let content = text(size: 9pt, fill: gray)[
    #if points == 1 [(1 point)] else [(#points points)]
  ]

  if align-right {
    align(right, content)
  } else {
    content
  }
}
