// Assignly - Question Types Implementation
// Functions for different question types: single-choice, multiple-choice,
// true/false, fill-in-the-blank, short answer, and multi-part

#import "utils.typ": *
#import "layout.typ": *

// Helper function to calculate option indent based on question number width
#let calculate-option-indent(question-num) = {
  let question-num-dot = question-num + "."
  let question-num-dot-size = measure(text(weight: "bold")[#question-num-dot])
  question-num-dot-size.width + 0.5em
}

// Helper function for creating fill-in-the-blank spaces in content mode
#let fill-blank-space(
  answer: "",
  width: "3cm",
) = context {
  let show-answers = show-answers-state.get()
  if show-answers and answer != "" {
    text(weight: "bold", fill: blue)[*#answer*]
  } else {
    // Use a line element instead of box for better baseline alignment
    // The line will align with the text baseline automatically
    box(width: eval(width), baseline: 0.2em)[
      #line(length: 100%, stroke: 0.5pt)
    ]
  }
}

// Single-choice question (multiple choice with one correct answer)
#let single-choice(
  question,
  options,
  answer,
  explanation: "",
  points: 1,
) = context {
  // Validation - support both string and content types
  if type(question) == str {
    validate-non-empty(question, "Question")
  } else {
    assert(
      question != none and question != "",
      message: "Question cannot be empty",
    )
  }
  assert(
    options.len() >= 2,
    message: "Single choice must have at least 2 options",
  )
  validate-index(answer, options.len(), context-name: "Answer")

  let show-answers = show-answers-state.get()
  let question-num = next-question()

  // Calculate indent for options based on question number width
  let option-indent = calculate-option-indent(question-num)

  question-block(question-num, question, points: points)

  option-list(
    options,
    correct-indices: if show-answers { (answer,) } else { () },
    left-inset: option-indent,
    show-answers: show-answers,
  )

  explanation-box(explanation, show-explanation: show-answers)

  v(0.5em)
}

// Multiple-choice question (multiple correct answers)
#let multiple-choice(
  question,
  options,
  answers,
  explanation: "",
  points: 1,
) = context {
  // Validation
  validate-non-empty(question, "Question")
  assert(
    options.len() >= 2,
    message: "Multiple choice must have at least 2 options",
  )
  assert(answers.len() >= 1, message: "Must have at least 1 correct answer")

  for answer in answers {
    validate-index(answer, options.len(), context-name: "Answer")
  }

  let show-answers = show-answers-state.get()
  let question-num = next-question()

  // Calculate indent for options based on question number width
  let option-indent = calculate-option-indent(question-num)

  question-block(question-num, question, points: points)

  h(option-indent)
  text(size: 9pt, style: "italic")[Select all correct answers:]
  v(0.3em)

  option-list(
    options,
    correct-indices: if show-answers { answers } else { () },
    left-inset: option-indent,
    show-answers: show-answers,
  )

  explanation-box(explanation, show-explanation: show-answers)

  v(0.5em)
}

// True/False question
#let true-false(
  question,
  answer,
  explanation: "",
  points: 1,
) = context {
  // Validation
  validate-non-empty(question, "Question")
  assert(
    type(answer) == bool,
    message: "True/false answer must be true or false",
  )

  let show-answers = show-answers-state.get()
  let question-num = next-question()

  // Calculate indent for options based on question number width
  let option-indent = calculate-option-indent(question-num)

  question-block(question-num, question, points: points)

  let options = ("True", "False")
  let correct-index = if answer { 0 } else { 1 }

  option-list(
    options,
    correct-indices: if show-answers { (correct-index,) } else { () },
    left-inset: option-indent,
    show-answers: show-answers,
  )

  explanation-box(explanation, show-explanation: show-answers)

  v(0.5em)
}

// Fill-in-the-blank question
#let fill-blank(
  template,
  answers,
  explanation: "",
  points: 1,
  blank-width: "2cm",
) = context {
  // Validation - support both string and content types
  if type(template) == str {
    validate-non-empty(template, "Question template")
  } else {
    assert(
      template != none and template != "",
      message: "Question template cannot be empty",
    )
  }

  let show-answers = show-answers-state.get()
  let question-num = next-question()

  // Compose the stem so it appears inline with the question number
  let stem = if type(template) == str {
    // Legacy string-based processing
    let blanks = template.split("___")
    let blank-count = blanks.len() - 1

    assert(
      blank-count > 0,
      message: "Template must contain blank markers (___)",
    )
    assert(
      answers.len() == blank-count,
      message: "Number of answers ("
        + str(answers.len())
        + ") must match number of blanks ("
        + str(blank-count)
        + ")",
    )

    // Build content sequence to ensure content type (not plain string)
    let acc = []
    acc += [#blanks.first()]
    for i in range(blank-count) {
      if show-answers {
        acc += text(weight: "bold", fill: blue)[*#answers.at(i)*]
      } else {
        // Use line element for better baseline alignment
        acc += box(width: eval(blank-width), baseline: 0.2em)[
          #line(length: 100%, stroke: 0.5pt)
        ]
      }
      acc += [#blanks.at(i + 1)]
    }
    acc
  } else {
    // New content-based processing
    // For content type, user must manually place blanks using fill-blank-space()
    template
  }

  // Render question number and stem inline
  question-block(question-num, stem, points: points)

  explanation-box(explanation, show-explanation: show-answers)

  v(0.5em)
}

// Short answer question
#let short-answer(
  question,
  answer: "",
  explanation: "",
  points: 1,
  answer-lines: 3,
) = context {
  // Validation
  validate-non-empty(question, "Question")
  assert(answer-lines > 0, message: "Answer lines must be positive")

  let show-answers = show-answers-state.get()
  let question-num = next-question()

  question-block(question-num, question, points: points)

  if show-answers and answer != "" {
    block(
      fill: rgb(240, 255, 240),
      width: 100%,
      radius: 3pt,
      inset: 8pt,
    )[
      *Answer:* \ #answer
    ]
  } else {
    // Provide blank space for student answers
    block(inset: (left: 1.5em, top: 0.5em))[
      #v(answer-lines * 1.5em + 0.5em)
    ]
  }

  explanation-box(explanation, show-explanation: show-answers)

  v(0.5em)
}

// Multi-part question (contains other questions)
#let multi-part(
  title,
  parts,
  points: auto,
) = context {
  // Validation
  validate-non-empty(title, "Multi-part title")
  assert(
    parts.len() >= 1,
    message: "Multi-part question must have at least 1 part",
  )

  let show-answers = show-answers-state.get()
  let question-num = next-question()

  // Calculate total points if not specified
  let total-points = if points == auto {
    // This would ideally extract points from each part question function
    // For now, assume 1 point per part as fallback
    parts.len()
  } else {
    points
  }

  question-block(question-num, title, points: total-points)

  // Render each part with sub-numbering using table layout for better alignment
  let grid-rows = ()
  for (i, part) in parts.enumerate() {
    let part-letter = ("a", "b", "c", "d", "e", "f", "g", "h").at(i)
    grid-rows.push(grid.cell(align: right)[*#part-letter)*])
    grid-rows.push(grid.cell(align: left)[#part])
  }

  // Create table with proper column alignment
  if grid-rows.len() > 0 {
    grid(
      inset: (left: 0.5em),
      columns: (auto, 1fr),
      row-gutter: 1em,
      align: (right, left),
      ..grid-rows
    )
  }

  v(0.5em)
}
