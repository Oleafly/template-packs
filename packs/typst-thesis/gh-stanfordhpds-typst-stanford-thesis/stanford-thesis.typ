// Stanford PhD Dissertation Template for Typst
// Re-exports the template from the Quarto extension so pure Typst users
// can simply: #import "stanford-thesis.typ": thesis
//
// Usage:
//   #import "stanford-thesis.typ": thesis
//   #show: thesis.with(
//     title: "Your Dissertation Title",
//     author: "Your Name",
//     department: "Computer Science",
//   )

#import "_extensions/stanford-thesis/typst-template.typ": thesis

// Create a part divider page. Use between chapters to group them into parts.
// The heading show rule in thesis() detects the part-number state and renders
// a centered divider page with "Part I", "Part II", etc.
#let _part-counter = counter("thesis-part")

#let part(title) = {
  _part-counter.step()
  context {
    let n = _part-counter.get().first()
    state("part-number").update(n)
  }
  heading(level: 1, numbering: none, title)
  state("part-number").update(0)
}
