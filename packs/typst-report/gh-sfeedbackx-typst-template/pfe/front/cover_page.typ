// ======================================================
// COVER PAGE TEMPLATE (Typst)
// ------------------------------------------------------
// This file generates the cover page for the PFE report.
//
// HOW TO USE:
// - Only modify variables inside "CONTENT VARIABLES".
// - Layout code below controls positioning.
// - Logos paths must be valid relative paths.
//
// NOTE:
// Avoid modifying grid or align unless you understand
// Typst layout system.
// ======================================================

#import "../_lib/utils.typ": title_box
// Import custom title box component (defined externally)

#set page(margin: (top: 20pt, rest: 30pt))
// Global page margin settings


// ======================================================
// CONTENT VARIABLES
// ------------------------------------------------------
// Edit ONLY these values to customize the cover.
// Everything below will update automatically.
// ======================================================

// ======================================================
// COVER PAGE — CUSTOMIZATION VARIABLES
// ------------------------------------------------------
// Replace these values with your own project data.
// Everything below will update automatically.
// ======================================================

#let main_title = [Graduation Project Report]
#let presented_for = [Presented in partial fulfillment of the requirements for:]
#let degree = [
  Your Degree Name \
  Your Specialization
]

#let republic = [YOUR REPUBLIC]
#let ministry = [YOUR MINISTRY]
#let university = [YOUR UNIVERSITY]
#let faculty = [YOUR FACULTY]
#let department = [Your Department]

#let student_name = [YOUR FULL NAME]
#let student_label = [Realized by:]

#let project_title = [
  Your Project Title: A Subtitle \
  or Description of Your Work
]

#let jury_president = [Jury President Name]
#let jury_reviewer = [Reviewer Name]
#let jury_supervisor = [Supervisor Name]
#let jury_pedagogic_advisor = [Pedagogic Advisor Name]

#let host_org = []
#let host_org_name = [Your Host Organization]

#let student_class = [Your Class Info]
#let academic_year = [Academic Year 20XX - 20XX]

#let logo_fst = "../assets/FSTLOGO.png"
#let logo_utm = "../assets/Logo_UTM.png"
#let logo_host_org = "../assets/FSTLOGO.png"



// ======================================================
// HEADER SECTION (University Text and Logos)
// Layout: [Left Logo] [Centered Text] [Right Logo]
// ======================================================
#grid(
  // how much each cell take space
  columns: (1fr, 4fr, 1fr),
  //space between the cells
  column-gutter: 5pt,
  align: (horizon, center, horizon),
  // image right you can adjust the width as you like
  [
    #image(logo_fst, width: 100pt),
  ],
  // text center
  [
    #set text(size: 14pt, weight: "bold")
    #republic \
    #ministry \
    #university

    #align(horizon)[
      #text(size: 9.5pt, weight: "bold")[#faculty] \
      #text(size: 12pt, weight: "regular")[#department]
    ]
  ],
  //right image
  [#image(logo_utm, width: 90pt)],
)

#v(3em)
// Vertical spacing


// ======================================================
// MAIN TITLE + STUDENT SECTION
// ======================================================
#align(center)[
  #text(size: 20pt, weight: "bold")[#main_title]

  // This stack ensures the lines stay tight together and centered
  #stack(
    spacing: 1em,
    text(size: 13pt)[#presented_for],
    text(size: 14pt, weight: "regular")[
      #degree
    ],
  )
  #v(0.2em)
  #text(size: 18pt)[#student_label]

  #text(size: 19pt, weight: "bold")[#student_name]

]


#v(1em)

// ======================================================
// PROJECT TITLE BOX (custom component)
// ======================================================
#title_box([
  #project_title
])
#v(1em)


// ======================================================
// JURY MEMBERS SECTION
// Left column = labels, right column = names
// ======================================================
#grid(
  columns: (20pt, 0.5fr, 1fr),
  align: (left),
  [],
  [#text(size: 12pt)[Jury President:

    Reviewer:

    Supervised by:

    Pedagogic Advisor:
  ]],
  [#text(size: 12pt, weight: "bold")[
    #jury_president

    #jury_reviewer

    #jury_supervisor

    #jury_pedagogic_advisor
  ]],
)

#v(1.5em)

// ======================================================
// HOST ORGANIZATION SECTION
// ======================================================
#align(center)[
  #text(size: 16pt, weight: "regular")[Host organization: #host_org \
    #host_org_name

  ]
]
#v(1em)

// Host organization logo placement
#align(center)[
  #image(logo_host_org, width: 79pt)
]

#v(0.8em)

// ======================================================
// STUDENT CLASS BOX
// ======================================================
#align(center, block(
  width: 60%,
  stroke: (paint: black, thickness: 0.5pt),
  inset: (y: 8pt),
  text(size: 16pt, [#student_class]),
))

#v(1.5em)

// ======================================================
// ACADEMIC YEAR FOOTER
// ======================================================
#align(center)[
  #text()[#academic_year]
]

// Page break for next content
#pagebreak()
