#import "../lib/utils.typ"

// Styles

#let preset-style(body) = {
  set par(leading: 0.5em)
  set page(paper: "us-letter", margin: (x: 0.1in, top: 0.15in, bottom: 0in))
  set text(font: "PT Sans", size: 12pt, fill: black)
  show heading.where(level: 1): set text(size: 22pt)
  show heading.where(level: 2): it => underline(it)

  body
}

// Components

#let header(name: "", address: "", links: ()) = {
  [
    #align(center)[
      = #name
      #address

      #set text(fill: blue)
      #utils.space-between(..links)
    ]
    #line(length: 100%)
  ]
}

#let education(
  institution: "",
  location: "",
  program: "",
  major: "",
  start: "",
  end: "",
  courses: (),
) = {
  [
    #utils.window-xp(
      nw: institution,
      ne: location,
      sw: program + " in " + major,
      se: start + " - " + end,
    )
    #if courses.len() > 0 [
      *Notable Courses*: #courses.join(", ")
    ]
  ]
}

#let experience(
  role: "",
  location: "",
  company: "",
  start: "",
  end: "",
  points: (),
) = {
  [
    #utils.window-xp(
      nw: role,
      ne: location,
      sw: company,
      se: start + " - " + end,
    )
    #list(..points)
  ]
}

#let project(name: "", lnk: "", desc: "", skills: ()) = {
  [
    #strong(name) (#text(fill: blue)[#link("https://" + lnk, lnk)]) #desc #strong("[" + skills.join(", ") + "]")
    #linebreak()
  ]
}

#let skills(entries: (:)) = {
  for (skill-type, skills) in entries [
    - *#skill-type*: #skills.join(", ")
  ]
}

// Complete builder

#let full(
  head: "",
  profile: "",
  education: (),
  experience: (),
  projects: (),
  skills-dict: (:),
) = {
  show: preset-style

  head

  [== Profile]

  profile

  [== Education]

  for e in education {
    e
  }

  [== Experience]

  for e in experience {
    e
  }

  [== Projects]

  for p in projects {
    p
  }

  [== Skills]

  skills(entries: skills-dict)
}
