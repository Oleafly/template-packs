// Typography Utilities
// Text styling and emphasis helpers

#import "../colors.typ": *

#let dtu-emphasis(content) = {
  text(fill: dtu-red, weight: "semibold")[#content]
}

#let dtu-subtle(content) = {
  text(fill: dtu-dark-gray, size: 0.9em)[#content]
}

#let dtu-large(content, size: 1.2em) = {
  text(size: size, weight: "medium")[#content]
}

#let dtu-small(content, size: 0.8em) = {
  text(size: size, fill: dtu-dark-gray)[#content]
}

// Brand-consistent text styling
#let dtu-brand-text(content, color: dtu-red) = {
  text(fill: color, weight: "bold")[#content]
}
