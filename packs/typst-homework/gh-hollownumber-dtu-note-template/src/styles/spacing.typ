// Spacing Utilities
// Consistent spacing helpers for better document layout

// Standard spacing constants
#let small-gap = v(0.5em)
#let medium-gap = v(1em)
#let large-gap = v(1.5em)
#let section-gap = v(2em)

// Flexible spacing functions
#let spacing(size: "medium") = {
  if size == "small" { small-gap }
  else if size == "large" { large-gap }
  else if size == "section" { section-gap }
  else { medium-gap }
}

#let horizontal-space(size: "medium") = {
  if size == "small" { h(0.5em) }
  else if size == "large" { h(1.5em) }
  else if size == "section" { h(2em) }
  else { h(1em) }
}
