// environments.typ

// We may use imports...
#import "shorthands.typ": *

// Outer label for a question and the answer
#let q(body) = {
  set enum(numbering: "(a)")
  body
}

// For a paragraph answer
#let ans(body) = {
  body
}

// Proof
#let proof(body) = {ans[_*Proof:*_ #h(5pt) #body #qed]}

// Part of an answer
// e.g., a, b, c, ...
#let part(body) = {
  body
}
