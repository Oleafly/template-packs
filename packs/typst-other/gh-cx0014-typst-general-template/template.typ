/*
  Typst General Template
    Contains formatting rules and convenient functions

  Include the following lines in your main.typ:
    #import "template.typ": *
    #show: project.with(...)

  @param title
    Displayed as large, bolded text above content

  @param subtitle
    Displayed next to title in italics

  @param comma-add-space
    Add a space next to commas in equations (makes viewing easier)

  By Daniel Hui, @cx0014
*/

#let project(title: "", subtitle: "", comma-add-space: false, body) = {
  set document(title: title)
  set page(
    paper: "a4",
    margin: (y: 0.75in, x: 0.75in),
    numbering: "1",
  )

  // Fonts
  set text(font: "TeX Gyre Schola")
  show math.equation: set text(font: "TeX Gyre Schola Math")
  show raw: set text(ligatures: true, font: "Cascadia Code")

  // Headings
  set heading(numbering: "1.")
  show heading: set block(below: 1em)

  // Title Bar
  grid(
    columns: (auto, 1fr),
    align: (horizon + left, horizon + right),
    text(weight: "bold", 1.75em, title), emph(subtitle),
  )
  line(length: 100%)

  // Add spaces after commas in equations if selected
  let comma-space-val = math.thin.amount
  if comma-add-space { comma-space-val = 0.4em }
  show math.equation: eq => {
    show $+$.body.func().where(text: ","): [,] + h(comma-space-val, weak: true)
    eq
  }

  // Display main content
  body
}

// For labelling sections like Question 1.1 in assignments.
// My preference is to turn off numbering for those headers.
#let subpart(number) = heading("Part " + number, numbering: none, level: 2)

// For use in lovelace pseudocode environments.
#let comment(body, gap_to_right: 2em) = {
  h(gap_to_right)
  text(
    sym.triangle.stroked.r + sym.space + body,
    fill: gray,
    style: "italic",
  )
}

// For use with the pseudocode package lovelace.
// Place the following lines at the top of the document:
// #let pseudocode = pseudocode.with(..lovelace-defaults)
// #let pseudocode-list = pseudocode-list.with(..lovelace-defaults)
#let lovelace-defaults = (
  booktabs: true,
  indentation: 1.5em,
  hooks: .5em,
)

// Create a one-line separator with asterisks.
#let dinkus(n: 5) = {
  align(center)[
    #let n = 5
    #while n > 0 {
      sym.ast.op
      h(0.75em)
      n = n - 1
    }
  ]
}
