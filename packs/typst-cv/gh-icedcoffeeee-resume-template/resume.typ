#import "@preview/nerd-icons:0.2.0": *
#change-nerd-font("JetBrainsMono NF")

#set page(paper: "a4", margin: 1in)
#set text(size: 10pt, font: "TeX Gyre Termes")
#set par(justify: true)
#set list(indent: 1em)

#show heading: it => [
  #v(0.5em)
  #upper(text(size: 10pt, strong(it))) #v(-1em)
  #line(length: 100%) #v(-0.1em)
]

#let values = yaml("values.yaml")
#place(right, dy: -1em, image(values.profile.image, height: 1in))

#text(size: 14pt, [*#values.profile.name*])
#linebreak() #values.profile.title
#linebreak() #values.profile.location
#linebreak() #raw(values.profile.email)

#let socials = (columns: (), links: ())
#for (name, href) in values.socials {
  socials.columns.push(auto)
  socials.links.push([#link(href)[#nf-icon("nf-dev-" + name)]])
}

#v(-0.25em)
#grid(columns: socials.columns, column-gutter: 1em, ..socials.links)
#v(-0.5em)

#let space = 0.75em // adjust spacing

= SKILLS & SPECIALIZATION

#let skills = ()
#for (title, values) in values.skills {
  skills.push([*#title*])
  skills.push([#values.])
}

#table(
  columns: (auto, 1fr),
  stroke: (x, y) => { none },
  inset: 0.5em,
  ..skills
)

= EXPERIENCE & PROJECTS

#for (title, value) in values.experience [
  #v(space)
  *#title* #h(1fr) #value.date
  #linebreak()
  _#value.location _
  #eval(value.explanation, mode: "markup")
]

= EDUCATION

#for (title, value) in values.education [
  #v(space)
  *#title*, #value.extra #h(1fr) #value.date
  #linebreak()
  _#value.location _
  #eval(value.explanation, mode: "markup")
]
