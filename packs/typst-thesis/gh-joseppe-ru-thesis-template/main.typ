#import "@preview/acrostiche:0.7.0": *

#import "template.typ": template
#import "meta.typ": acronyms, meta


#template(
  appendix: include "anhang.typ",
  bib: bibliography("literatur.bib", style: "apa", title: "Literatur"),
)[
  #include "inhalt.typ"
]


