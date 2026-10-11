#import "/layout/thesis_template.typ": thesis
#import "/metadata.typ": paper_title, author

// bring in preamble sections content
#let abstract = include "/content/preamble/abstract.typ"
#let acknowledgements = include "/content/preamble/acknowledgement.typ"
#import "/content/preamble/acronyms.typ": acronyms
#let conclusions = include "/content/conclusions.typ"


// Fill these both in with the content sections that you've modified/created
#let sections = (
  include "/content/sections/introduction.typ",
  include "/content/sections/background.typ",
  include "/content/sections/related_work.typ",
  include "/content/sections/requirements_analysis.typ",
  include "/content/sections/system_design.typ",
  include "/content/sections/evaluation.typ",
  include "/content/sections/summary.typ",
)

#let appendices = (
  include "/content/appendices/appendix_a.typ",
  include "/content/appendices/appendix_b.typ",
  include "/content/appendices/appendix_c.typ",
)
// has to be done manually cos Typst doesn't support soft-coded file operations


// set up document metadata
#set document(title: paper_title, author: author)

// enforce that sections are manually 'loaded in'
#thesis(
  sections, appendices, acronyms: acronyms, conc_body: conclusions,
  abstract_body: abstract, acknowledgements_body: acknowledgements,
  is_print: true, main-font: "New Computer Modern"
)
