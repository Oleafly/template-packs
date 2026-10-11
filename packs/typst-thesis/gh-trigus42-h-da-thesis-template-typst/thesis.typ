#import "template.typ": thesis, mainmatter, outlines, part, appendix
#import "@preview/glossarium:0.5.10": make-glossary, register-glossary
#import "@preview/ctheorems:2.0.0": thm-rules
#import "matter/abbreviations.typ": abbreviations, abbreviations-list
#import "matter/glossary.typ": glossary, glossary-list

#register-glossary(abbreviations + glossary, use-key-as-short: false)

#show: thesis.with(
  title: "A Classic Thesis Style",
  author: "André Miede",
  student-id: "081542",
  degree: "Bachelor of Science (B. Sc.)",
  degree-line: auto,
  supervisor: "Prof. Dr.-Ing. Michael von Rüden",
  second-supervisor: "Prof. Dr. Martin Stiemerling",
  faculty: "Fachbereich Informatik",
  university: "Hochschule Darmstadt",
  location: "Darmstadt",
  date: "24. September 2026",
  language: "de",
  two-sided: false,
  open-right: false,
  line-spacing: 1.5,
  description: "Bachelor thesis template for the Hochschule Darmstadt Faculty of Computer Science.",
  keywords: ("thesis", "Typst", "Hochschule Darmstadt"),
)
#show: make-glossary
#show: thm-rules.with(qed-symbol: sym.square.stroked)

#include "matter/declaration.typ"
// Uncomment this include if the thesis is subject to a blocking notice.
// #include "matter/blocking-notice.typ"
#include "matter/abstract-en.typ"
#include "matter/abstract-de.typ"
#outlines(figures: true, tables: true, listings: true)
#abbreviations-list()

#mainmatter()

#part("Thesis")
#include "chapters/introduction.typ"
#include "chapters/background.typ"
#include "chapters/examples.typ"

#part("Appendix")
#appendix()
#include "chapters/appendix.typ"

#glossary-list()
#include "matter/bibliography.typ"
