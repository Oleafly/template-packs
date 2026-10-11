#let resume = json("data.json")

#set text(font: "Libertinus Serif", size: 10pt, fill: black)
#set par(leading: 0.55em, justify: true)
#set page(margin: (top: 1cm, bottom: 1cm, left: 1.2cm, right: 1.2cm), paper: "a4")

#show link: set text(fill: rgb("#1155cc"))

#let section(title) = {
  v(0.6em)
  text(weight: "bold", size: 10pt)[#upper(title)]
  v(-0.6em)
  line(length: 100%, stroke: 0.5pt + gray)
  v(0.1em)
}

#let packed-list(points) = {
  for point in points {
    grid(
      columns: (10pt, 1fr),
      [•], eval("[" + point + "]"),
    )
    v(-0.1em)
  }
}

#align(center)[
  #text(size: 18pt, weight: "bold")[#resume.basics.name] \
  #v(0.1em)
  #text(size: 9pt)[
    #resume.basics.phone |
    #link("mailto:" + resume.basics.email)[#resume.basics.email] |
    #link(resume.basics.linkedin)[LinkedIn] |
    #link(resume.basics.github)[GitHub]
  ]
]

#section("Summary")
#resume.basics.summary

#section("Skills")
#text(weight: 600)[Languages/Frameworks: ] #resume.skills.languages.join(", ") \
#text(weight: 600)[Cloud/DevOps/DB: ] #resume.skills.infrastructure.join(", ")

#section("Experience")
#for job in resume.experience [
  #grid(
    columns: (1fr, auto),
    [*#job.company*], [#job.date],
  )
  #text(style: "italic", size: 9pt, fill: gray.darken(50%))[#job.position]
  #v(0.2em)
  #packed-list(job.highlights)
]

#section("Projects")
#for proj in resume.projects [
  #grid(
    columns: (1fr, auto),
    [*#proj.name*] + " ["+ link(proj.link)[link] + "]", [#text(style: "italic", size: 9pt)[#proj.tools]],
  )
  #v(0.2em)
  #packed-list(proj.highlights)
]

#section("Education")
#for edu in resume.education [
  #grid(
    columns: (1fr, auto),
    [*#edu.institution*], [#edu.date],
  )
  #edu.degree
]
