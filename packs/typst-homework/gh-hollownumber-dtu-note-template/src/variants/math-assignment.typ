// DTU Math Assignment Variant
// Specialized template for mathematics assignments with enhanced mathematical components

#import "../colors.typ": *
#import "../layouts/assignment.typ": dtu-assignment

// Math-specific components
#let lemma(name: "", content) = {
  let title = if name == "" { "Lemma" } else { "Lemma (" + name + ")" }
  block(
    width: 100%,
    fill: dtu-light-gray.lighten(50%),
    stroke: 2pt + dtu-purple,
    radius: 5pt,
    inset: 1em,
    [
      #text(weight: "bold", fill: dtu-purple, size: 11pt)[#title]
      #v(0.5em)
      #content
    ]
  )
}

#let proof(content) = {
  block(
    width: 100%,
    fill: rgb("#fafafa"),
    stroke: (left: 3pt + dtu-dark-blue),
    inset: (left: 1.2em, right: 1em, top: 0.8em, bottom: 0.8em),
    [
      #text(weight: "bold", fill: dtu-dark-blue, size: 11pt)[Proof:]
      #v(0.3em)
      #content
      #h(1fr) □
    ]
  )
}

#let corollary(name: "", content) = {
  let title = if name == "" { "Corollary" } else { "Corollary (" + name + ")" }
  block(
    width: 100%,
    fill: dtu-green.lighten(85%),
    stroke: 2pt + dtu-dark-green,
    radius: 5pt,
    inset: 1em,
    [
      #text(weight: "bold", fill: dtu-dark-green, size: 11pt)[#title]
      #v(0.5em)
      #content
    ]
  )
}

#let proposition(name: "", content) = {
  let title = if name == "" { "Proposition" } else { "Proposition (" + name + ")" }
  block(
    width: 100%,
    fill: dtu-yellow.lighten(85%),
    stroke: 2pt + dtu-orange,
    radius: 5pt,
    inset: 1em,
    [
      #text(weight: "bold", fill: dtu-orange, size: 11pt)[#title]
      #v(0.5em)
      #content
    ]
  )
}

#let solution(content) = {
  block(
    width: 100%,
    fill: dtu-blue.lighten(95%),
    stroke: (left: 4pt + dtu-blue),
    inset: (left: 1.2em, right: 1em, top: 1em, bottom: 1em),
    [
      #text(weight: "bold", fill: dtu-blue, size: 11pt)[Solution:]
      #v(0.5em)
      #content
    ]
  )
}

#let math-problem(number: none, points: none, content) = {
  let header = if number != none [
    #text(weight: "bold", size: 14pt, fill: dtu-red)[Problem #number]
  ] else [
    #text(weight: "bold", size: 14pt, fill: dtu-red)[Problem]
  ]

  if points != none {
    header = header + text(size: 11pt, fill: dtu-gray)[ (#points points)]
  }

  v(1.5em)
  header
  v(0.5em)
  content
}

#let math-hint(content) = {
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

// Enhanced equation numbering for math assignments
#let numbered-equation(content, label: none) = {
  if label != none {
    math.equation(block: true, numbering: "(1)", content); ref(label)
  } else {
    math.equation(block: true, numbering: "(1)", content)
  }
}

// Matrix helper
#let matrix(..content) = {
  math.mat(..content)
}

// Math assignment template
#let dtu-math-assignment(
  course: "",
  course-name: "",
  title: "",
  due-date: datetime.today(),
  author: "",
  semester: "",
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

  // Math-specific styling
  set math.equation(numbering: "(1)")
  set math.mat(delim: "[")
  set math.vec(delim: "[")

  // Enhanced math display
  show math.equation: set text(size: 12pt)

  // Better spacing for mathematical content
  set par(leading: 0.7em)

  // Enhanced list styling for mathematical enumerations
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
