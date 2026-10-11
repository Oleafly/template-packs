// Assignly - Typst Course Assignment Template
// Main entry point for the template system
//
// This template provides comprehensive functionality for creating course assignments
// with support for multiple question types, bilingual content, and dual rendering modes.
//
// Usage:
//   #import "assignly.typ": *
//
//   #assignment(title: "Quiz 1", course: "MATH 101", due-date: "2025-09-25")[
//     // Assignment content here
//   ]

// Import core modules
#import "lib/utils.typ": *
#import "lib/layout.typ": *
#import "lib/questions.typ": *

// Global state for show-answers flag
#let show-answers-state = state("show-answers", false)

// Global state for show-points flag
#let show-points-state = state("show-points", true)

// Main assignment function - document initialization and configuration
#let assignment(
  // Required parameters
  title: "",
  course: "",
  due-date: "",
  // Optional configuration
  show-answers: false,
  show-points: true,
  font-latin: "Libertinus Serif",
  font-cjk: "Noto Serif CJK SC",
  author: "",
  instructions: "",
  // Content body
  body,
) = {
  // Validate required parameters
  assert(title != "", message: "Assignment title is required")
  assert(course != "", message: "Course name is required")
  assert(due-date != "", message: "Assignment due-date is required")

  // Set global states
  show-answers-state.update(show-answers)
  show-points-state.update(show-points)

  // Initialize page setup
  setup-page()

  // Configure typography with bilingual font support, wrapping the whole content
  setup-typography(
    font-latin: font-latin,
    font-cjk: font-cjk,
    base-size: 11pt,
    line-height: 1.2,
  )[
    // Page headers and footers
    #set page(
      header: [
        #set text(size: 10pt)
        #course #h(1fr) #title
      ],
      footer: [
        #set text(size: 10pt)
        #h(1fr) Page #context counter(page).display() #h(1fr)
      ],
    )

    // Reset question counter for this assignment
    #counter("question").update(0)

    // Render assignment header
    #assignment-header(
      title: title,
      course: course,
      due-date: due-date,
      author: author,
      show-answers: show-answers,
    )

    // Instructions section if provided - support both string and content types
    #if instructions != "" and instructions != none [
      #v(1em)
      #block(
        width: 100%,
        fill: rgb(248, 248, 248),
        stroke: 0.5pt + gray,
        radius: 3pt,
        inset: 12pt,
      )[
        #text(weight: "bold")[Instructions:] #instructions
      ]
      #v(1em)
    ] else [
      #v(1.5em)
    ]

    // Main content body
    #body
  ]
}

// Utility functions for document structure

// Enhanced section function with better formatting and numbering support
#let section(title, instructions: "", body, numbered: false) = {
  if numbered {
    counter("section").step()
    let section-num = context counter("section").display()
    section-header(title: [#section-num. #title], instructions: instructions)
  } else {
    section-header(title: title, instructions: instructions)
  }
  body
}

// Enhanced image figure with better error handling and layout
#let image-figure(
  path,
  caption: "",
  width: auto,
  height: auto,
  alt-text: "",
) = {
  figure(
    image(path, width: width, height: height, alt: alt-text),
    caption: if caption != "" { caption } else { none },
  )
}

// Enhanced answer space with customizable styling
#let answer-space(lines: 3, line-height: 1.5em, line-style: 0pt) = {
  block(
    above: 0.8em,
    below: 0.8em,
  )[
    #for i in range(lines) [
      #v(if i == 0 { line-height + 0.8em } else { line-height })
      #line(length: 100%, stroke: line-style)
    ]
    #v(0.5em)
  ]
}

// Additional utility: Page break helper
#let page-break() = {
  pagebreak()
}

// Additional utility: Horizontal separator
#let separator(style: 1pt + gray) = {
  v(0.8em)
  line(length: 100%, stroke: style)
  v(0.8em)
}

// Additional utility: Note box for special instructions
#let note-box(content, type: "info") = {
  // Use explicit emoji characters with VS16 to request emoji presentation
  // and force an emoji-capable font for rendering to avoid monochrome glyphs.
  let (fill-color, stroke-color, icon-text) = if type == "warning" {
    (rgb(255, 250, 205), rgb(255, 193, 7), "⚠️") // U+26A0 + U+FE0F
  } else if type == "error" {
    (rgb(255, 235, 238), rgb(220, 53, 69), "❌") // Cross Mark
  } else if type == "success" {
    (rgb(212, 237, 218), rgb(40, 167, 69), "✅") // White Heavy Check Mark
  } else {
    (rgb(217, 237, 247), rgb(23, 162, 184), "ℹ️") // Information Source + VS16
  }

  v(0.8em)
  rect(
    width: 100%,
    fill: fill-color,
    stroke: 1pt + stroke-color,
    radius: 4pt,
    inset: 10pt,
  )[
    // Icon rendered with emoji-capable font only
    #text(
      font: ("Segoe UI Emoji", "Segoe UI Symbol"),
      weight: "bold",
    )[#icon-text]
    // "Note:" rendered with normal document font
    #text(weight: "bold")[Note:]
    #content
  ]
  v(0.8em)
}

// Export all functions for external use
// (Functions from imported modules are automatically available)
