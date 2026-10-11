// DTU Physics Assignment Variant
// Specialized template for physics assignments with enhanced physics components
// Designed for OpenStax Physics Vol. 1 & 2 coursework
// Includes packages: physica (notation), quill (diagrams), zero (units)

#import "../colors.typ": *
#import "../layouts/assignment.typ": dtu-assignment

// Physics packages for enhanced functionality
#import "@preview/physica:0.9.4": *  // Physics notation (vectors, derivatives, etc.)
#import "@preview/quill:0.7.0": *    // Quantum circuit diagrams
#import "@preview/unify:0.7.1": qty, unit, num  // SI units and quantities

// =============================================================================
// PHYSICS-SPECIFIC COMPONENTS
// =============================================================================

// Physical Law - for stating fundamental laws and principles
#let physical-law(name: "", content) = {
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

// Experimental Setup - for describing laboratory experiments
#let experiment(title: "", content) = {
  let header = if title == "" { "Experimental Setup" } else { "Experiment: " + title }
  block(
    width: 100%,
    fill: dtu-green.lighten(90%),
    stroke: 2pt + dtu-dark-green,
    radius: 5pt,
    inset: 1em,
    breakable: true,
    [
      #text(weight: "bold", fill: dtu-dark-green, size: 11pt)[#header]
      #v(0.5em)
      #content
    ]
  )
}

// Given/Find/Solution structure for physics problems
#let physics-given(content) = {
  block(
    width: 100%,
    fill: dtu-blue.lighten(95%),
    stroke: (left: 4pt + dtu-blue),
    inset: (left: 1.2em, right: 1em, top: 0.8em, bottom: 0.8em),
    breakable: true,
    [
      #text(weight: "bold", fill: dtu-blue, size: 11pt)[Given:]
      #v(0.3em)
      #content
    ]
  )
}

#let physics-find(content) = {
  block(
    width: 100%,
    fill: dtu-purple.lighten(92%),
    stroke: (left: 4pt + dtu-purple),
    inset: (left: 1.2em, right: 1em, top: 0.8em, bottom: 0.8em),
    breakable: true,
    [
      #text(weight: "bold", fill: dtu-purple, size: 11pt)[Find:]
      #v(0.3em)
      #content
    ]
  )
}

#let physics-solution(content) = {
  block(
    width: 100%,
    fill: dtu-green.lighten(95%),
    stroke: (left: 4pt + dtu-dark-green),
    inset: (left: 1.2em, right: 1em, top: 1em, bottom: 1em),
    breakable: true,
    [
      #text(weight: "bold", fill: dtu-dark-green, size: 11pt)[Solution:]
      #v(0.5em)
      #content
    ]
  )
}

// Free Body Diagram placeholder - describes force diagrams
#let free-body-diagram(description: "", content) = {
  let header = if description == "" { "Free Body Diagram" } else { "Free Body Diagram: " + description }
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

// Unit analysis box
#let unit-analysis(content) = {
  block(
    width: 100%,
    fill: dtu-yellow.lighten(90%),
    stroke: 1pt + dtu-yellow.darken(20%),
    radius: 3pt,
    inset: 0.8em,
    breakable: true,
    [
      #text(weight: "bold", fill: dtu-yellow.darken(30%), size: 10pt)[Unit Analysis: ]
      #content
    ]
  )
}

// Physics problem header with topic area
#let physics-problem(number: none, points: none, topic: none, content) = {
  let header = if number != none [
    #text(weight: "bold", size: 14pt, fill: dtu-red)[Problem #number]
  ] else [
    #text(weight: "bold", size: 14pt, fill: dtu-red)[Problem]
  ]

  let metadata = ()
  if points != none {
    metadata.push(text(size: 11pt, fill: dtu-gray)[#points points])
  }
  if topic != none {
    metadata.push(text(size: 11pt, fill: dtu-blue, weight: "medium")[#topic])
  }

  if metadata.len() > 0 {
    header = header + text(size: 11pt, fill: dtu-gray)[ (] + metadata.join(text(size: 11pt, fill: dtu-gray)[, ]) + text(size: 11pt, fill: dtu-gray)[)]
  }

  v(1.5em)
  header
  v(0.5em)
  content
}

// Conceptual question box
#let conceptual-question(content) = {
  block(
    width: 100%,
    fill: dtu-salmon.lighten(60%),
    stroke: 2pt + dtu-coral,
    radius: 5pt,
    inset: 1em,
    breakable: true,
    [
      #text(weight: "bold", fill: dtu-coral, size: 11pt)[Conceptual Question]
      #v(0.5em)
      #content
    ]
  )
}

// Physics approximation/assumption note
#let assumption(content) = {
  block(
    width: 100%,
    fill: rgb("#f5f5ff"),
    stroke: 1pt + dtu-purple,
    radius: 3pt,
    inset: 0.8em,
    [
      #text(weight: "bold", fill: dtu-purple, size: 10pt)[Assumptions: ]
      #content
    ]
  )
}

// Result box for final answers
#let final-result(content) = {
  block(
    width: 100%,
    fill: dtu-green.lighten(85%),
    stroke: 3pt + dtu-dark-green,
    radius: 5pt,
    inset: 1em,
    [
      #align(center)[
        #text(weight: "bold", fill: dtu-dark-green, size: 12pt)[Result]
        #v(0.3em)
        #content
      ]
    ]
  )
}

// Physics hint
#let physics-hint(content) = {
  block(
    width: 100%,
    fill: dtu-yellow.lighten(90%),
    stroke: 1pt + dtu-yellow.darken(20%),
    radius: 3pt,
    inset: 0.8em,
    [
      #text(weight: "bold", fill: dtu-yellow.darken(30%), size: 10pt)[Hint: ]
      #content
    ]
  )
}

// Equation reference box for key equations
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

// =============================================================================
// PHYSICS ASSIGNMENT TEMPLATE
// =============================================================================

#let dtu-physics-assignment(
  course: "",
  course-name: "",
  title: "",
  due-date: datetime.today(),
  author: "",
  semester: "",
  textbook-chapter: none,  // e.g., "OpenStax Physics Vol. 1, Ch. 4"
  body
) = {
  // Use the base assignment template
  show: dtu-assignment.with(
    course: course,
    course-name: course-name,
    title: title,
    due-date: due-date,
    author: author,
    semester: semester
  )

  // Add textbook reference if provided
  if textbook-chapter != none {
    v(-1em)
    align(center)[
      #text(size: 10pt, fill: dtu-gray, weight: "medium")[Reference: #textbook-chapter]
    ]
    v(1em)
  }

  // Physics-specific styling
  set math.equation(numbering: "(1)")

  // Enhanced math display for physics equations
  show math.equation: set text(size: 12pt)

  // Better spacing for physics content
  set par(leading: 0.7em)

  // Physics-appropriate list styling
  set enum(
    numbering: (..args) => {
      let level = args.pos().len()
      if level == 1 {
        numbering("1.", ..args)
      } else if level == 2 {
        numbering("(a)", ..args)
      } else {
        numbering("i.", ..args)
      }
    }
  )

  body
}
