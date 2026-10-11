#let resume(body) = {
  set list(indent: 1em)
  show list: set text(size: 0.92em)
  show link: underline
  show link: set underline(offset: 3pt)
  
  set page(
    paper: "us-letter",
    margin: (x: 0.5in, y: 0.5in)
  )
  
  set text(
    size: 11pt,
      font: "New Computer Modern",
  )

  body
}

#let name_header(name) = {
  set text(size: 2em)
  [*#name*]
}

#let header(
  name: "Sigma Rizz",
  website: "github.com/sigma",
  email: "sigma@rizz.edu",
  linkedin: "linkedin.com/in/sigma",
  number: "123456789",
  misc: "US Citizen"
) = {
  align(left,
    block[
      #name_header(name) \
      #link("https://" + website)[#website] |
      #link("mailto:" + email)[#email] |
      #link("https://" + linkedin)[#linkedin] |
      #number |
      #misc
    ]
  )
}

#let resume_heading(txt) = {
  show heading: set text(size: 0.9em, weight: "regular")

  block[
    = #smallcaps(txt)
    #v(-4pt)
    #line(length: 100%, stroke: 1pt + black)
  ]
}

#let coursework_item(
  category: "Coursework",
  courses: "gooning 101, sigma 102, fpga 067",
) = {
  set block(above: 0.7em)
  set text(size: 1em)
  pad(left: 2em, block[*#category* #courses])
}


#let edu_item(
  name: "University Of Illinois Urbana Champaign", 
  degree: "B.S in ECE", 
  GPA: "6.7", 
  date: "December 2026"
) = {
  set block(above: 0.7em, below: 1em)
  pad(left: 1em, right: 0.5em, grid(
    columns: (3fr, 1fr),
    align(left)[
      *#name* \
      _#degree _
    ],
    align(right)[
      #GPA \
      _#date _
    ]
  ))
}

#let exp_item(
  role: "Worker",
  date: "June 1837 - May 1845",
  ..points
) = {
    set block(above: 0.7em, below: 0.7em)
    pad(left: 1em, right: 0.5em, box[
      #grid(
        columns: (3fr, 1fr),
        align(left)[
          *#role* 
        ],
        align(right)[
          #date 
        ]
      )
      #list(..points)
    ])
}

#let project_item(
  name: "Example Project",
  skills: "Programming Language 1, Database3",
  ..points
) = {
  set block(above: 0.7em, below: 0.7em)
  pad(left: 1em, right: 0.5em, box[
    *#name* | _#link("https://" + skills)[#skills] _ #h(1fr) 
    #list(..points)
  ])
}

#let skill_item(
  category: "Skills",
  skills: "Balling, Yoga, Valorant",
) = {
  set block(above: 0.7em)
  set text(size: 0.91em)
  pad(left: 1em, right: 0.5em, block[*#category*: #skills])
}



//////////////////// Archived items ////////////////////

#let exp_item_location(
  name: "Sample Workplace",
  role: "Worker",
  date: "June 1837 - May 1845",
  location: "Foo, BA",
  ..points
) = {
    set block(above: 0.7em, below: 0.7em)
    pad(left: 1em, right: 0.5em, box[
      #grid(
        columns: (3fr, 1fr),
        align(left)[
          *#role* \
          _#name _
        ],
        align(right)[
          #date \
          _#location _
        ]
      )
      #list(..points)
    ])
}
