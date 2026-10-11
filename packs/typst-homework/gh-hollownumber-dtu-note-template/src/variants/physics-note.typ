// DTU Physics Note Variant
// Specialized template for physics lecture notes with enhanced physics components
// Designed for OpenStax Physics Vol. 1 & 2 coursework
// Includes packages: physica (notation), quill (diagrams), unify (units)

#import "../colors.typ": *
#import "../layouts/note.typ": dtu-note

// Physics packages for enhanced functionality
#import "@preview/physica:0.9.4": *  // Physics notation (vectors, derivatives, etc.)
#import "@preview/quill:0.7.0": *    // Quantum circuit diagrams
#import "@preview/unify:0.7.1": qty, unit, num  // SI units and quantities

// =============================================================================
// PHYSICS NOTE COMPONENTS
// =============================================================================

// Physical Law - for stating fundamental laws and principles
#let law(name: "", content) = {
  let title = if name == "" { "Physical Law" } else { name }
  block(
    width: 100%,
    fill: dtu-red.lighten(92%),
    stroke: 2pt + dtu-red,
    radius: 5pt,
    inset: 1em,
    breakable: true,
    [
      #text(weight: "bold", fill: dtu-red, size: 11pt)[#title]
      #v(0.5em)
      #content
    ]
  )
}

// Principle - for fundamental physics principles
#let principle(name: "", content) = {
  let title = if name == "" { "Principle" } else { name }
  block(
    width: 100%,
    fill: dtu-purple.lighten(90%),
    stroke: 2pt + dtu-purple,
    radius: 5pt,
    inset: 1em,
    breakable: true,
    [
      #text(weight: "bold", fill: dtu-purple, size: 11pt)[#title]
      #v(0.5em)
      #content
    ]
  )
}

// Derivation - for showing step-by-step mathematical derivations
#let derivation(title: "", content) = {
  let header = if title == "" { "Derivation" } else { "Derivation: " + title }
  block(
    width: 100%,
    fill: rgb("#fafafa"),
    stroke: (left: 3pt + dtu-dark-blue),
    inset: (left: 1.2em, right: 1em, top: 0.8em, bottom: 0.8em),
    breakable: true,
    [
      #text(weight: "bold", fill: dtu-dark-blue, size: 11pt)[#header]
      #v(0.3em)
      #content
      #h(1fr) $square.stroked$
    ]
  )
}

// Phenomenon - for describing physical phenomena
#let phenomenon(name: "", content) = {
  let title = if name == "" { "Phenomenon" } else { name }
  block(
    width: 100%,
    fill: dtu-green.lighten(90%),
    stroke: 2pt + dtu-dark-green,
    radius: 5pt,
    inset: 1em,
    breakable: true,
    [
      #text(weight: "bold", fill: dtu-dark-green, size: 11pt)[#title]
      #v(0.5em)
      #content
    ]
  )
}

// Experimental observation
#let observation(content) = {
  block(
    width: 100%,
    fill: dtu-yellow.lighten(85%),
    stroke: (left: 4pt + dtu-orange),
    inset: (left: 1.2em, right: 1em, top: 0.8em, bottom: 0.8em),
    breakable: true,
    [
      #text(weight: "bold", fill: dtu-orange, size: 11pt)[Experimental Observation]
      #v(0.3em)
      #content
    ]
  )
}

// Physics constant definition
#let constant(symbol, name, value) = {
  block(
    width: 100%,
    fill: dtu-gray.lighten(70%),
    stroke: 1pt + dtu-gray,
    radius: 3pt,
    inset: 0.8em,
    [
      #grid(
        columns: (auto, 1fr, auto),
        align: (left, center, right),
        column-gutter: 1em,
        [#text(weight: "bold", fill: dtu-dark-blue)[$#symbol$]],
        [#text(fill: dtu-black)[#name]],
        [#text(style: "italic", fill: dtu-dark-gray)[#value]]
      )
    ]
  )
}

// Key equation box for important formulas
#let key-equation(name: "", equation) = {
  block(
    width: 100%,
    fill: dtu-blue.lighten(92%),
    stroke: 2pt + dtu-blue,
    radius: 5pt,
    inset: 1em,
    [
      #if name != "" [
        #text(weight: "bold", fill: dtu-blue, size: 10pt)[#name]
        #v(0.3em)
      ]
      #align(center)[
        #text(size: 12pt)[$#equation$]
      ]
    ]
  )
}

// Unit definition
#let unit-def(quantity, symbol, unit) = {
  block(
    width: 100%,
    fill: rgb("#f5f5ff"),
    stroke: 1pt + dtu-purple,
    radius: 3pt,
    inset: 0.8em,
    [
      #grid(
        columns: (1fr, auto, auto),
        align: (left, center, right),
        column-gutter: 1em,
        [#text(fill: dtu-black)[#quantity]],
        [#text(weight: "bold", fill: dtu-purple)[$#symbol$]],
        [#text(style: "italic", fill: dtu-dark-gray)[[#unit]]]
      )
    ]
  )
}

// Physical intuition note
#let intuition(content) = {
  block(
    width: 100%,
    fill: dtu-salmon.lighten(60%),
    stroke: (left: 4pt + dtu-coral),
    inset: (left: 1.2em, right: 1em, top: 0.8em, bottom: 0.8em),
    breakable: true,
    [
      #text(weight: "bold", fill: dtu-coral, size: 11pt)[Physical Intuition]
      #v(0.3em)
      #content
    ]
  )
}

// Common misconception warning
#let misconception(content) = {
  block(
    width: 100%,
    fill: rgb("#fff5f5"),
    stroke: 2pt + dtu-coral,
    radius: 4pt,
    inset: 1em,
    breakable: true,
    [
      #text(weight: "bold", fill: dtu-coral, size: 11pt)[Common Misconception]
      #v(0.3em)
      #content
    ]
  )
}

// Vector diagram description
#let vector-diagram(description: "", content) = {
  let header = if description == "" { "Vector Diagram" } else { "Vector Diagram: " + description }
  block(
    width: 100%,
    fill: rgb("#fff8f0"),
    stroke: 2pt + dtu-orange,
    radius: 5pt,
    inset: 1em,
    breakable: true,
    [
      #text(weight: "bold", fill: dtu-orange, size: 11pt)[#header]
      #v(0.5em)
      #content
    ]
  )
}

// Limiting case analysis
#let limiting-case(case-name: "", content) = {
  let header = if case-name == "" { "Limiting Case" } else { "Limiting Case: " + case-name }
  block(
    width: 100%,
    fill: dtu-blue.lighten(95%),
    stroke: 1pt + dtu-blue,
    radius: 3pt,
    inset: 0.8em,
    breakable: true,
    [
      #text(weight: "bold", fill: dtu-blue, size: 10pt)[#header]
      #v(0.3em)
      #content
    ]
  )
}

// Dimensional analysis
#let dimensional-analysis(content) = {
  block(
    width: 100%,
    fill: dtu-yellow.lighten(90%),
    stroke: 1pt + dtu-yellow.darken(20%),
    radius: 3pt,
    inset: 0.8em,
    breakable: true,
    [
      #text(weight: "bold", fill: dtu-yellow.darken(30%), size: 10pt)[Dimensional Analysis]
      #v(0.3em)
      #content
    ]
  )
}

// =============================================================================
// PHYSICS NOTE TEMPLATE
// =============================================================================

#let dtu-physics-note(
  course: "",
  course-name: "",
  title: "",
  date: datetime.today(),
  author: "",
  semester: "",
  textbook-reference: none,  // e.g., "OpenStax Physics Vol. 1, Ch. 4"
  body
) = {
  // Use the base note template
  show: dtu-note.with(
    course: course,
    course-name: course-name,
    title: title,
    date: date,
    author: author,
    semester: semester
  )

  // Add textbook reference if provided
  if textbook-reference != none {
    v(-1em)
    align(center)[
      #text(size: 10pt, fill: dtu-gray, weight: "medium")[Reference: #textbook-reference]
    ]
    v(1em)
  }

  // Physics-specific styling
  set math.equation(numbering: "(1)")

  // Enhanced math display for physics equations
  show math.equation: set text(size: 12pt)

  // Better spacing for physics content
  set par(leading: 0.7em)

  body
}
