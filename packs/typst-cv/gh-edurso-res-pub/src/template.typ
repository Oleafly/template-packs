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
    size: 10.25pt,
      font: "New Computer Modern",
  )

  body
}

#let name_header(name) = {
  set text(size: 2.25em)
  [*#name*]
}

#let header(
  name: "Eric D'Urso",
  phone: "+1 (734) 560-3417",
  email: "edurso@umich.edu",
  linkedin: "linkedin.com/in/edurso",
  site: "edurso.com",
) = {
  align(center,
    block[
      #name_header(name) \
      #phone |
      #link("mailto:" + email)[#email] |
      #link("https://" + linkedin)[#linkedin] |
      #link("https://" + site)[#site]
    ]
  )
  v(5pt)
}

#let resume_heading(txt) = {
  show heading: set text(size: 0.92em, weight: "regular")

  block[
    = #smallcaps(txt)
    #v(-4pt)
    #line(length: 100%, stroke: 1pt + black)
  ]
}

#let edu_item(
  name: "Sample University", 
  degree: "B.S in Stuff",
  gpa: 3.9,
  location: "Foo, BA", 
  date: "Aug. 1600 - May 1750",
  courses: ("Class100", "Class101")
) = {
  set block(above: 0.7em, below: 1em)

  let size = calc.ceil(courses.len() / 3)
  let chunks = courses.chunks(size)

  pad(left: 1em, right: 0.5em, box[
    #grid(
      columns: (3fr, 1fr),
      align(left)[
        *#name* \
        _#degree _, GPA: #gpa
      ],
      align(right)[
        #date \
        _#location _
      ]
    )
    #grid(
      columns: (2fr, 2fr, 2fr),
      list(..chunks.at(0)),
      list(..chunks.at(1)),
      list(..chunks.at(2)),
    )
  ])
}

#let exp_item(
  name: "Sample Workplace",
  role: "Worker",
  date: "June 1837 - May 1845",
  location: "Foo, BA",
  points: ""
) = {
  set block(above: 0.7em, below: 1em)
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
    #let pts = ()
    #for (summary, skills) in points {
      if skills == none {
        pts.push([#summary])
      } else {
        pts.push([#summary (_#skills _)])
      }
    }
    #list(..pts)
  ])
}

#let project_item(
  name: "Example Project",
  skills: "Programming Language 1, Database3",
  date: "May 1234 - June 4321",
  ..points
) = {
  set block(above: 0.7em, below: 1em)
  pad(left: 1em, right: 0.5em, box[
    *#name* | _#skills _ #h(1fr) #date
    #list(..points)
  ])
}

#let award_item(
  awards: "Gold Medal",
) = {
  set block(above: 0.7em, below: 1em)
  
  let size = calc.ceil(awards.len() / 2)
  let chunks = awards.chunks(size)

  pad(left: 1em, right: 0.5em, box[
    #grid(
      columns: (2fr, 2fr,),
      list(..chunks.at(0)),
      list(..chunks.at(1)),
    )
  ])
}

#let skill_item(
  category: "Skills",
  skills: "Stuff, More Stuff",
) = {
  set block(above: 0.7em)
  set text(size: 0.91em)
  pad(left: 1em, right: 0.5em, block[*#category*: #skills])
}
