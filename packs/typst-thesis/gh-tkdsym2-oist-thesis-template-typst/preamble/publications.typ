#import "../oist_thesis.typ": unnumbered-chapter

// =====================================================
// Spacing / style knobs (tweak freely)
// =====================================================

// Level 2 headings (Publications, Presentations)
#let h2_above = 1.0em
#let h2_below = 1.0em
#let h2_size = 1.5em

// Level 3 headings (Journal, Conference, ...)
#let h3_above = 0.25em
#let h3_below = 0.5em
#let h3_size = 1.2em

// Space around each list (between a heading and its entries, and after)
#let list_above = 2.5em
#let list_below = 2.5em

// Inside a list
#let list_item_spacing = 1.5em   // gap between entries
#let list_par_leading = 0.65em   // line spacing within one entry
#let list_par_spacing = 0.5em    // paragraph spacing within one entry

// Oral / Poster badge
#let badge_inset_x = 5pt
#let badge_inset_y = 1pt
#let badge_stroke = 0.6pt + black
#let badge_radius = 2pt
#let badge_font_size = 9pt
#let badge_gap = 0.4em            // gap between the badge and the entry text

// =====================================================

#unnumbered-chapter("List of Publications")

// Small outlined badge marking the presentation type, e.g. #entry_type("Oral")
#let entry_type(kind) = {
  box(
    inset: (x: badge_inset_x, y: badge_inset_y),
    stroke: badge_stroke,
    radius: badge_radius,
    text(size: badge_font_size, weight: "bold", font: "Helvetica", kind),
  )
  h(badge_gap)
}

// Contribution line shown under each publication / presentation entry.
// Renders as a small indented italic line: "Contribution: <body>".
#let contrib(body) = {
  linebreak()
  pad(left: 1.0em, top: 0.2em)[
    #set text(size: 10pt)
    #strong[Contribution:] #emph(body)
  ]
}

#[
  #show heading.where(level: 2): it => block(above: h2_above, below: h2_below)[
    #set text(size: h2_size, weight: "bold", font: "Times New Roman")
    #it.body
  ]

  #show heading.where(level: 3): it => block(above: h3_above, below: h3_below)[
    #set text(size: h3_size, weight: "bold", font: "Times New Roman")
    #it.body
  ]

  #show list: it => block(above: list_above, below: list_below)[
    #set par(leading: list_par_leading, spacing: list_par_spacing)
    #set list(spacing: list_item_spacing)
    #it
  ]

  #heading(level: 2, numbering: none, outlined: true, "Publications")

  #heading(level: 3, numbering: none, outlined: true, "Journal (peer-reviewed)")

  - #underline[#strong[Author, A.]], Coauthor, B., & Supervisor, C. (2025). Title of the first journal article that overlaps with this thesis. _Journal Name_, _12_(3), 123456. https://doi.org/10.0000/example.2025.123456 #contrib[Writing -- original draft, Visualization, Validation, Software, Methodology, Investigation, Formal analysis, Data curation, Conceptualization]

  - #underline[#strong[Author, A.]], & Supervisor, C. (2025). Title of the second journal article that overlaps with this thesis. _Another Journal_, _7_(1), 42. https://doi.org/10.0000/example.2025.000042 #contrib[Writing -- review & editing, Methodology, Investigation, Formal analysis]

  #heading(level: 2, numbering: none, outlined: true, "Presentations")

  #heading(level: 3, numbering: none, outlined: true, "Conference")

  - #entry_type("Oral") #underline[#strong[Author, A.]], & Supervisor, C. (2024). Title of the conference talk. _Name of the Conference_, City, Country. #contrib[Presentation, Data curation, Formal analysis]

  - #entry_type("Poster") #underline[#strong[Author, A.]], Coauthor, B., & Supervisor, C. (2023). Title of the poster. _Name of the Meeting_, City, Country. #contrib[Presentation, Investigation, Formal analysis]
]
