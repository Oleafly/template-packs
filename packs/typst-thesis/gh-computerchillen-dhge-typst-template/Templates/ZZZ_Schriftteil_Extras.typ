#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.10": *

//Codly Addon Config, für verschiedene Sprachen verschiedene 
//#codly(
//  languages: (
//    term: (
//      name: " Terminal",
//      icon: text(font: "tabler-icons", "\u{ebef}"),
//      color: rgb("#000000")
//    ),
//    py: (
//      name: " Python",
//      icon: text(font: "tabler-icons", "\u{ed01}"),
//      color: rgb("#2b5983")
//    ),
//    md: (
//      name: " Markdown",
//      icon: text(font: "tabler-icons", "\u{ec41}"),
//      color: rgb("#4a525a")
//    ),
//    bash: (
//      name: " Bash Script",
//      icon: text("$_", size: 0.9em, baseline: -1pt),
//      color: rgb("#909090")
//    ),
//    ps: (
//      name: " Powershell",
//      icon: text(font: "tabler-icons", "\u{f5ed}"),
//      color: rgb("#002557")
//    ),
#codly(
  languages: codly-languages,
  zebra-fill: color.luma(252),
  radius: 0.5em,
  fill: color.luma(245),
  stroke: 1.5pt + color.luma(200),
  number-format: none
)

//Mono Text (z.b. um Dateinamen im Text als solche zu kennzeichnen)
#let mono(body) = [#text(font: "New Computer Modern Mono", body)]
#let inlinemath(body) = [#text(font: "New Computer Modern Math", style: "italic", body)]