#import "@preview/glossarium:0.5.3": print-glossary

#let glossary-list = (
  (key: "DRY", short: "DRY", long: "Don't Repeat Yourself", description: "a principle of software development aimed at reducing repetition"),
  (key: "API", short: "API", long: "Application Programming Interface", description: "a standardized general-purpose modeling language in the field of software engineering"),
  (key: "UML", short: "UML", plural: "UMLs", long: "Unified Modelling Language", longplural: "Unified Modelling Languages", description: "a set of rules and protocols for building and interacting with software applications")
)

#let tableOfAcronyms(title: "Acronyms", layoutConfig: none, list: glossary-list) = {
  show: layoutConfig

  heading(numbering: none, outlined: false, bookmarked: true, title)

  v(1em)

  print-glossary(list, show-all: true)
}
