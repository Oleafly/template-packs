#import "metadata.typ": *
#import "layout/thesis_template.typ": project
#import "layout/titlepage.typ": titlepage
#import "layout/disclaimer.typ": disclaimer
#import "content/acknowledgement.typ": acknowledgement
#import "content/abstract_en.typ": abstract_en
#import "content/abstract_de.typ": abstract_de

#titlepage(
  title: title,
  author: author,
  supervisor1: supervisor1,
  supervisor2: supervisor2,
  startDate: startDate,
  submissionDate: submissionDate,
)

#disclaimer()
#acknowledgement()
#abstract_en()
#abstract_de()

#show: project.with(
  title: title,
  author: author,
  body-font: body-font,
  sans-font: sans-font,
  bibliography: bibliography("thesis.bib", title: none, style: "apa"),
  appendices: include "content/appendix.typ",
)

#include "chapters/01_introduction.typ"
#include "chapters/02_background.typ"
#include "chapters/03_method.typ"
#include "chapters/04_conclusion.typ"
