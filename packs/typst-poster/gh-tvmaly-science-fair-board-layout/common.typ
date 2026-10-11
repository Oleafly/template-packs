// Shared settings for the science fair board templates.
// Print at 100% scale. Do not use "fit to page".

#let font_name = "Arial"
#let body_size = 16pt
#let section_title_size = 30pt
#let subsection_size = 22pt
#let trim_stroke = 0.5pt + black

#let placeholder_note = text(size: 10pt, weight: "bold")[PLACEHOLDER TEXT - REPLACE BEFORE PRINTING]

#let section_title(title) = align(center)[
  #text(size: section_title_size, weight: "bold")[#underline[#title]]
]

#let subsection(title) = text(size: subsection_size, weight: "bold")[#title]

#let card(width: 10.5in, height: 8in, inset: 0.25in, body) = align(center + horizon)[
  #box(width: width, height: height, inset: inset, stroke: trim_stroke)[
    #set par(leading: 0.62em)
    #body
  ]
]

#let section_card(title, width: 10.5in, height: 8in, inset: 0.25in, body) = card(width: width, height: height, inset: inset)[
  #section_title(title)
  #v(0.16in)
  #placeholder_note
  #v(0.12in)
  #body
]

#let photo_box(label) = box(width: 100%, height: 100%, inset: 0.08in, stroke: 0.5pt + black)[
  #align(center + horizon)[
    #text(size: 12pt)[#label]
  ]
]
