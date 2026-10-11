// ============================================================
//  front.typ — Title, Certificate, Declaration, Acknowledgement
//  All content is pulled from config.typ — don't edit text here.
// ============================================================

#import "config.typ": inst, project, authors, guide, hod, dean

#set page(
  paper: "a4",
  margin: (x: 2.5cm, y: 2.5cm),
  numbering: "I",
  background: place(
    center + horizon,
    rect(width: 100% - 2cm, height: 100% - 2cm, stroke: 1.5pt)
  )
)

#set par(leading: 1em)

// ── Helper: "NAME (USN) and NAME (USN)" ──────────────────────
#let author-list = {
  let parts = authors.map(a => [*#a.name (#a.usn)*])
  if parts.len() == 1 {
    parts.at(0)
  } else {
    parts.slice(0, -1).join([, ]) + [ and ] + parts.last()
  }
}

// ── Helper: logo block ───────────────────────────────────────
// One logo → centred. Multiple → evenly spaced left to right.
#let logo-header = {
  let logos = inst.logos
  if logos.len() == 1 {
    align(center)[#image(logos.at(0), width: 40%)]
  } else {
    align(center)[
      #grid(
        columns: range(logos.len()).map(_ => auto),
        column-gutter: 2cm,
        align: horizon,
        ..logos.map(p => image(p, height: 1.5cm))
      )
    ]
  }
}

// ── PAGE 1: TITLE PAGE ───────────────────────────────────────

#align(center)[
  #logo-header
  #v(1em)

  #text(weight: "bold", size: 14pt)[#inst.faculty] \
  #text(weight: "bold", size: 14pt)[#inst.department] \
  #text(size: 10pt)[#inst.address-1] \
  #text(size: 10pt)[#inst.address-2]

  #v(1em)

  #text(weight: "bold", size: 14pt)[#inst.batch \ \ A Project Report on] \
  #v(1em)
  #text(weight: "bold", size: 24pt, fill: black.darken(20%))[#project.title]

  #if project.subtitle != "" [
    #v(0.5em)
    #text(size: 14pt)[#project.subtitle]
  ]

  #v(1em)

  #text(weight: "bold")[Submitted in partial fulfillment for the award of the degree of] \
  #v(1em)
  #text(weight: "bold")[#inst.degree] \
  #text(weight: "bold")[IN] \
  #text(weight: "bold")[#inst.branch]

  #v(2em)

  #text(weight: "bold")[Submitted By] \
  #v(0.5em)
  #table(
    columns: (auto, auto),
    inset: 8pt,
    align: center,
    stroke: none,
    ..authors.map(a => ([*#a.name*], [*#a.usn*])).flatten()
  )

  #v(2.5em)

  #text(weight: "bold")[Under the Guidance of] \
  #text(weight: "bold", size: 13pt)[#guide.name] \
  #text[#guide.designation] \
  #linebreak()
  #text[#guide.department] \
  #text[Faculty of Engineering and Technology] \
  #text[#guide.university]
]

#pagebreak()

// ── PAGE 2: CERTIFICATE ──────────────────────────────────────

#set par(leading: 1.5em)

#logo-header

#align(center)[
  #text(weight: "bold", size: 14pt)[#inst.faculty] \
  #v(0.5em)
  #text(weight: "bold", size: 14pt)[#inst.department] \
  #linebreak()
  #text(size: 10pt)[#inst.address-1] \
  #text(size: 10pt)[#inst.address-2]
]

#align(center)[
  #v(1.5em)
  #text(weight: "bold", size: 16pt)[CERTIFICATE]
]

#v(1.5em)

#par(justify: true)[
  This is to certify that the project work titled *"#project.title"* is carried out by #author-list who are bonafide students of Bachelor of Technology at the Faculty of Engineering & Technology, #upper(inst.university), in partial fulfillment for the award of degree in #inst.degree in #inst.branch, during the academic year #inst.academic_year.
]

#v(3em)

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 1em,
  align: (left, left, left),
  [
  #text(weight: "bold", size: 11pt)[#guide.name] \
  #text(size: 8pt)[
    #guide.designation, \
    #guide.department, \
    Faculty of Engineering & Technology, \
    #guide.university
  ] \
  #text(size: 8pt)[Date:]
],
  [
  #text(weight: "bold", size: 11pt)[#hod.name] \
  #text(size: 8pt)[
    #hod.designation, \
    #hod.department, \
    Faculty of Engineering & Technology, \
    #hod.university
  ] \
  #text(size: 8pt)[Date:]
],
  [
  #text(weight: "bold", size: 11pt)[#dean.name] \
  #text(size: 8pt)[
    #dean.designation \
    Faculty of Engineering & Technology, \
    #dean.university
  ] \
  #text(size: 8pt)[Date:]
]
)

#v(4em)

#table(
  columns: (1fr, 1fr),
  stroke: none,
  [*Name of the Examiner*], [*Signature of Examiner*],
  [], [],
  [1. ], [],
  [], [],
  [2. ], [],
)

#pagebreak()

// ── PAGE 3: DECLARATION ──────────────────────────────────────

#align(center)[
  #text(weight: "bold", size: 16pt)[DECLARATION]
]

#v(2em)

#par(justify: true)[
  We, #author-list, the students of eighth semester B.Tech in #inst.branch, at Faculty of Engineering & Technology, *#upper(inst.university)*, hereby declare that the project titled *"#project.title"* has been carried out by us and submitted in partial fulfillment for the award of degree in #inst.degree in #inst.branch during the academic year #inst.academic_year. Further, the matter presented in the project has not been submitted previously by anybody for the award of any degree or any diploma to any other University, to the best of our knowledge and faith.
]

#v(4em)

#grid(
  columns: (1fr, 1fr),
  align: (left, right),
  [
  #text(weight: "bold")[Student Name & USN] \
  #v(1em)
  #authors.map(a => [
    #a.name \
    (#a.usn) \
    #v(1.5em)
  ]).join()
],
  [
  #align(center)[
    #text(weight: "bold")[Signature] \
  ]
]
)

#v(3em)

#text(weight: "bold")[Place:] #inst.city \
#v(0.5em)
#text(weight: "bold")[Date:]

#pagebreak()

// ── PAGE 4: ACKNOWLEDGEMENT ───────────────────────────────────

#set par(leading: 1em, justify: true)

#align(center)[
  #text(weight: "bold", size: 16pt)[ACKNOWLEDGEMENT]
]

#v(2em)

#emph[It is a great pleasure for us to acknowledge the assistance and support of all who have been responsible for the successful completion of this project work.]

#linebreak()

#emph[We take this opportunity to express our sincere gratitude to the *Faculty of Engineering & Technology, #upper(inst.university)* for providing us with the opportunity to pursue our bachelor's degree at this institution.]

#linebreak()

#emph[We would like to thank *#dean.name, #dean.designation, Faculty of Engineering & Technology, #upper(inst.university)* for constant encouragement and expert advice.]

#linebreak()

#emph[We express our sincere thanks to *#hod.name, Head of the Department, #inst.department, #upper(inst.university)*, for providing the academic guidance that made this work possible.]

#linebreak()

#emph[We would like to thank our guide *#guide.name, #guide.designation, #inst.department, #upper(inst.university)*, for sparing valuable time to extend help in every step of the project, which paved the way for smooth progress and fruitful culmination of the work.]

#linebreak()

#emph[We would like to thank our *Project Coordinator #inst.coordinator_name* and all the staff members of #inst.department for their support.]

#linebreak()

_We are also grateful to our families and friends who provided support throughout the course._

#linebreak()

_We would like to thank one and all who directly or indirectly helped us in completing this project successfully._

#linebreak()

#align(right)[
  #text(weight: "bold")[Signature]
]
