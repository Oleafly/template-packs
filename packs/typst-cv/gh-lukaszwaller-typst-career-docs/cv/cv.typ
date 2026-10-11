#let defaults = (
  metadata: (
    title: "",
    keywords: ()
  ),
  name: "",
  email: "",
  phone: "",
  location: "",
  website: "",
  linkedin: "",
  github: "",
  experience: (),
  projects: (),
  portfolio: (),
  education: (),
  skills: (
    languages: (), 
    frameworks: (),
    devops: (),
    core: (),
    cloud: () 
  ),
)

#let data_file = sys.inputs.at("data", default: "me.yaml")
#let data = defaults + yaml(data_file)

#set document(
  title: data.metadata.title,
  keywords: data.metadata.keywords,
)

#set page(margin: 15mm)
#show heading.where(level: 1): set text(size: 16pt, weight: 700)
#show heading.where(level: 2): set text(size: 12pt, weight: 700)

#show link: underline

#align(center)[
  = #data.name

  == #data.profession

  #link("mailto:" + data.email) | #link("tel:" + data.phone)
  #linebreak()
  #link("https://" + data.github)[#data.github] |
  #link("https://" + data.website)[#data.website] |
  #link("https://" + data.medium)[#data.medium]
]

== Summary

#line(length: 100%, stroke: 1pt + gray)

#data.summary

== Skills

#line(length: 100%, stroke: 1pt + gray)

*Languages:* #(data.skills.languages.join(", "))
#linebreak()
*Frameworks:* #(data.skills.frameworks.join(", "))
#linebreak()
*DevOps:* #(data.skills.devops.join(", "))
#linebreak()
*Core Competencies:* #(data.skills.core.join(", "))
#linebreak()
*Cloud:* #(data.skills.cloud.join(", "))

== Experience

#line(length: 100%, stroke: 1pt + gray)

#for xp in data.experience {
  grid(columns: (80%, 20%), [
    *#xp.title*, #link("https://" + xp.link)[#xp.company] - #xp.location
  ], [
    #if xp.at("date") != none and xp.date != "" {
      align(right)[#xp.date]
    }
  ])

  if xp.at("description") != none {
    set par(leading: 0.4em)

    if type(xp.description) == array {
      {
        set list(indent: 1em, spacing: 0.8em)
        show list: set block(above: 0.8em, below: 1em)

        for item in xp.description [
          - #item
        ]
      }
    } else {
        block(above: 0.6em, below: 0.8em)[
            #xp.description
          ]
    }
  }
}

== Projects

#line(length: 100%, stroke: 1pt + gray)

#for project in data.projects {
    [*#project.name* (#link("https://" + project.link)[Go to article])]
    linebreak()
    project.description
    linebreak()
}

#if data.at("portfolio") != none {  
  [*Portfolio* (#link("https://" + data.portfolio.website)[Go to portfolio])]
  linebreak()
  [Feel free to explore more of my fun projects showcasing various technologies on my 
  #link(data.portfolio.website)[website] or #link(data.portfolio.github)[GitHub].]
  linebreak()
}

== Education

#line(length: 100%, stroke: 1pt + gray)

#for edu in data.education {
  block(above: 1em, below: 0.6em)[
    #grid(columns: (80%, 20%),
      [
        #link("https://" + edu.link)[*#edu.institution*] (#edu.location): *#edu.degree* - #edu.grade
      ], [
        #if edu.at("date") != none and edu.date != "" {
          align(right)[#edu.date]
        }
      ]
    )
  ]
}