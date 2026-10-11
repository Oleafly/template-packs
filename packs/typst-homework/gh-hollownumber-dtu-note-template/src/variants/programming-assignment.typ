// DTU Programming Assignment Variant
// Specialized template for programming assignments with enhanced code components

#import "../colors.typ": *
#import "../layouts/assignment.typ": dtu-assignment
#import "../enhanced.typ": code-block, alert
#import "@preview/codelst:2.0.2": sourcecode

// Programming-specific components
#let code-specification(content) = {
  block(
    width: 100%,
    fill: dtu-blue.lighten(95%),
    stroke: 2pt + dtu-blue,
    radius: 5pt,
    inset: 1em,
    [
      #text(weight: "bold", fill: dtu-blue, size: 11pt)[Specification]
      #v(0.5em)
      #content
    ]
  )
}

#let test-case(description: "", content) = {
  // Parse the content to find Input and Output sections
  // This would require more complex parsing logic
  block(
    width: 100%,
    fill: dtu-green.lighten(90%),
    stroke: 1pt + dtu-green,
    radius: 3pt,
    inset: 1em,
    [
      #text(weight: "bold", fill: dtu-dark-green, size: 11pt)[Test Case]
      #if description != "" [
        #text(size: 10pt, fill: dtu-dark-green)[ - #description]
      ]
      #v(0.5em)

      // Auto-format with Input/Output sections
      #content
    ]
  )
}

#let algorithm-analysis(content) = {
  block(
    width: 100%,
    fill: dtu-purple.lighten(90%),
    stroke: 2pt + dtu-purple,
    radius: 5pt,
    inset: 1em,
    [
      #text(weight: "bold", fill: dtu-purple, size: 11pt)[Algorithm Analysis]
      #v(0.5em)
      #content
    ]
  )
}

#let complexity-table(time-best: "", time-avg: "", time-worst: "", space: "") = {
  table(
    columns: 4,
    align: center,
    fill: (_, row) => if row == 0 { dtu-blue.lighten(80%) },
    [*Best Case*], [*Average Case*], [*Worst Case*], [*Space Complexity*],
    [#time-best], [#time-avg], [#time-worst], [#space]
  )
}

#let code-implementation(language: "python", caption: "", content) = {
  block(
    width: 100%,
    fill: rgb("#f8f8f8"),
    stroke: 1pt + dtu-gray,
    radius: 3pt,
    inset: 1em,
    [
      #if caption != "" [
        #text(size: 10pt, weight: "bold", fill: dtu-dark-blue)[#caption]
        #v(0.5em)
      ]
      #sourcecode(
        numbering: "1",
        frame: none,
      )[#content]
    ]
  )
}

#let programming-problem(number: none, points: none, difficulty: none, content) = {
  let header = if number != none [
    #text(weight: "bold", size: 14pt, fill: dtu-red)[Problem #number]
  ] else [
    #text(weight: "bold", size: 14pt, fill: dtu-red)[Problem]
  ]

  let metadata = ()
  if points != none {
    metadata.push(text(size: 11pt, fill: dtu-gray)[#points points])
  }
  if difficulty != none {
    let diff-color = if difficulty == "Easy" { dtu-green } else if difficulty == "Medium" { dtu-orange } else { dtu-coral }
    metadata.push(text(size: 11pt, fill: diff-color, weight: "medium")[#difficulty])
  }

  if metadata.len() > 0 {
    header = header + text(size: 11pt, fill: dtu-gray)[ (] + metadata.join(text(size: 11pt, fill: dtu-gray)[, ]) + text(size: 11pt, fill: dtu-gray)[)]
  }

  v(1.5em)
  header
  v(0.5em)
  content
}

#let code-output(content) = {
  block(
    width: 100%,
    fill: rgb("#1e1e1e"),
    stroke: 1pt + dtu-gray,
    radius: 3pt,
    inset: 1em,
    [
      #text(fill: rgb("#d4d4d4"), font: "Consolas", size: 10pt)[
        #content
      ]
    ]
  )
}

#let debugging-tip(content) = {
  block(
    width: 100%,
    fill: dtu-yellow.lighten(90%),
    stroke: 1pt + dtu-orange,
    radius: 3pt,
    inset: 0.8em,
    [
      #text(weight: "bold", fill: dtu-orange, size: 10pt)[Debugging Tip: ]
      #content
    ]
  )
}

#let performance-note(content) = {
  block(
    width: 100%,
    fill: dtu-blue.lighten(95%),
    stroke: 1pt + dtu-blue,
    radius: 3pt,
    inset: 0.8em,
    [
      #text(weight: "bold", fill: dtu-blue, size: 10pt)[Performance: ]
      #content
    ]
  )
}

// Programming assignment template
#let dtu-programming-assignment(
  course: "",
  course-name: "",
  title: "",
  due-date: datetime.today(),
  author: "",
  semester: "",
  programming-language: "Python",
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

  // Add programming language info to header
  v(-1em)
  align(center)[
    #text(size: 10pt, fill: dtu-gray, weight: "medium")[Programming Language: #programming-language]
  ]
  v(1em)

  // Code-friendly styling
  set text(size: 11pt)
  set par(leading: 0.65em)

  // Better code display
  show raw: set text(font: ("JetBrains Mono", "Fira Code", "Consolas", "Monaco", "monospace"), size: 10pt)

  body
}
