// Graduate Independent Study Form - Typst Template
// Based on UNC Charlotte Graduate Independent Study Template (Revised 2.20.2019)
// This file defines the layout, styling, and helper functions for the
// Independent Study form. It is used by `main.typ` which provides the
// specific content for the form.

// --- Helper function for input lines ---
// Creates a horizontal line for input, optionally pre-filled with `body` content.
// - width: The width of the input line (defaults to 100%).
// - body: Content to display on the input line.
#let input(width: 100%, body) = {
  box(width: width, height: 1em, stroke: (bottom: 0.5pt + black))[#body]
}

// --- Helper function for checkboxes ---
// Renders a checkbox, either checked or unchecked.
// - checked: A boolean indicating whether the box should be checked.
#let checkbox(checked) = {
  if checked {
    box(
      stroke: .05em + black,
      fill: white,
      height: .8em,
      width: .8em,
      {
        // Draw the checkmark using two rotated lines.
        // Shorter leg of the checkmark
        box(move(dy: .48em, dx: 0.1em, rotate(45deg, reflow: false, line(length: 0.3em, stroke: black + .1em))))
        // Longer leg of the checkmark
        box(move(dy: .38em, dx: -0.05em, rotate(-45deg, reflow: false, line(length: 0.48em, stroke: black + .1em))))
      },
    )
  } else {
    // Render an empty box if not checked.
    box(stroke: .05em + black, fill: white, height: .8em, width: .8em)
  }
}

// --- Helper function for multi-line text areas ---
// Creates a text area that expands to fit its content, but maintains a minimum height.
// - min-height: The minimum height of the text area, in multiples of a single line height (approximated by "F").
// - body: The content of the text area.
#let text-area(min-height: 3, body) = context {
  layout(size => {
    let fake-content = [F]
    let body-height = measure(box(width: size.width, body)).height
    let min-height = measure(fake-content).height * min-height
    if body-height < min-height {
      block(height: min-height)[#body]
    } else {
      body
    }
  })
}

// --- Helper function for creating a labeled field ---
// Creates a grid layout for a field name and its corresponding input value.
// - no-column: If true, the field name does not have a colon appended.
// - field-name: The label for the field.
// - field-value: The value or content of the field.
#let field(no-column: false, field-name, field-value) = {
  grid(
    columns: (auto, 1fr),
    column-gutter: 2pt,
    if no-column { field-name } else [#field-name:], input[#field-value],
  )
}

// --- Helper function for creating a detailed text area section ---
// Creates a section with a heading (field-name) followed by a text-area.
// - field-name: The heading for this detail section.
// - field-text: The content for the text-area.
#let detail(field-name, field-text) = {
  [=== #field-name:]
  text-area(field-text)
}

// --- Helper function for signature blocks ---
// Creates a pair of input lines for a signature and date.
// - signature-label: The label for the signature (e.g., "Student Signature").
#let signature-block(signature-label) = {
  grid(
    columns: (3fr, 1fr),
    row-gutter: 0.5em,
    input[], input[],
    [#signature-label], [Date],
  )
}

// --- Template Setup ---
// Main function to configure and generate the document.
#let template-config(
  name: "John Doe", // Student's full name.
  id: "80xxxxxxx", // Student's ID number.
  email: "jdoe@charlotte.edu", // Student's email address.
  instructor: "Dr. Jane Smith", // Supervising instructor's name.
  department: "Computer Science", // Department offering the course.
  title: "Independent Study in Typst Programming", // Title of the independent study.
  credit: "3", // Number of credit hours.
  term: "Fall 2025", // Academic term (e.g., "Fall 2025", "Spring 2026").
  substitution: none, // Course number if this is a substitution (e.g., "ITCS 6114"), otherwise `none`.
  doc, // The main content of the document (learning outcomes, grading, etc.).
) = {
  set page(
    paper: "us-letter",
    margin: (x: 1in, y: 0.8in),
  )
  set text(font: "Arial", size: 11pt)
  set par(spacing: 1.25em, justify: true)
  show figure.where(kind: table): set figure.caption(position: top)

  // --- Header ---
  align(center)[
    #set par(spacing: 0.5em)
    #image("assets/logo.svg", height: 7em)
    #text(size: 14pt)[
      *Graduate Independent Study Template*
    ]

    _(To be completed by the student and supervising faculty member)_
  ]

  // --- Student and Course Information ---

  field[Student Name][#name]
  grid(
    columns: (3fr, 5fr),
    field[Student ID \#][#id], field[Student Email Address][#email],
  )
  field[Supervising Instructor][#instructor]
  field[Department][#department]
  field[Course Title/Topic][#title]
  grid(
    columns: (1fr, 1fr),
    field[Credit Hours][#credit], field[Term][#term],
  )

  [How will this course apply to your plan of study?]

  // Determine if this is a course substitution or an elective.
  let is-substitution = substitution != none
  grid(
    columns: (1fr, 5em, auto, 5em),
    field(no-column: true)[#align(left)[#checkbox(is-substitution) Course substitution for]][#substitution],
    align(center)[or],
    [#checkbox(not is-substitution) Elective],
  )

  // Heading show rules.
  doc

  // --- Signatures and Dates ---
  place(
    bottom,
    float: true,
    clearance: 6pt,
    block(breakable: false)[
      #v(2em)
      #signature-block("Student Signature")
      #signature-block("Supervising Instructor Signature")
      #v(2em)
      #grid(
        columns: (auto, auto, 1fr),
        column-gutter: 2em,
        align: left + top,
        [CC:],
        [
          Graduate Program Director\
          Department File
        ],
      )
      #v(1em)

      #text(size: 8pt)[
        #align(center)[
          This form does not apply to Thesis or Dissertation research. Departments are free to use their own form, if they prefer.

          However, the form and syllabus must be filled with the department before this IS begins.
        ]
      ]
    ],
  )
}
