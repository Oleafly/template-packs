#import "config.typ": section_title, primary_color, accent_color, new_contact

#v(0.1em)
#section_title("Projects")

#let projects_data = json("data/projects.json")

#for project in projects_data [
  #text(fill: primary_color, weight: 600, size: 1.1em)[#project.name]
  #h(1fr)
  #text(fill: accent_color, weight: 600, size: 1em)[#project.institution]
  #v(-0.4em)

  #new_contact(project.link, project.link_name)
  #v(-0.3em)

  #if project.description.len() > 0 [
    #list(
      marker: text(size: 1.5em, baseline: -0.1em)[•],
      ..project.description.map(desc => {
        if desc != "" {
          [#desc]
          v(0.3em)
        }
      }).filter(item => item != none)
    )
  ]

  #v(0.2em)
]
