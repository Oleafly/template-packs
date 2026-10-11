#import "../theme.typ": *

// Usage:
//   #cv-skill-group(
//     category: "Languages",
//     skills: ("Rust", "Go", "TypeScript", "Python"),
//   )
#let cv-skill-group(
  category: "",
  skills: (),
) = {
  block({
    text(weight: "bold", size: size-meta)[#category]
    text(size: size-body)[: #skills.join([,#h(0.4em)])]
  })
  v(0.4em)
}
