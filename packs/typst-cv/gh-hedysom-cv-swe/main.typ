#let configuration = yaml("configuration.yaml")
#import "./lib.typ": *
// Page settings
#set page(margin: (left: 1.5cm, right: 1.5cm,top: 2cm, bottom: 2cm))
#set text(size: 10pt)

#let clean_list(list) = list.filter(item => item != none and item.trim() != "" and item != "-")

// Main header
#grid(
  columns: (1fr, 1fr, 1fr),
  align(left)[
    #link(configuration.header.email) \
    #configuration.header.phone \
  ],
  align(center)[
    #text(weight: "semibold",size: 2em)[#configuration.header.name] \
    #link(configuration.header.website)[#configuration.header.websiteDisplayName]
  ],
  align(right)[
    #link(configuration.header.githubUrl)[#configuration.header.github] \
    #link(configuration.header.linkedinUrl)[#configuration.header.linkedin] \
  ]
)


// Education
#section([Education])
#for ed in configuration.education [
  #exp-header((left: ed.location, center: ed.name, right: ed.date))
  - #ed.degree
  #if "finalGrade" in ed or "gpa" in ed [
    - #if "finalGrade" in ed [Final Grade: #ed.finalGrade]#if "gpa" in ed [, GPA: #ed.gpa]
  ]
]

// spacer
#block(below: 1em)

// Work experience
#section([Employment])
#for exp in configuration.employment [
  #exp-header((left: exp.location, center: exp.company, right: exp.date))
  #for responsibility in exp.responsibilities [
    - #responsibility
  ]
]

// spacer
#block(below: 1em)

// Projects
#section([Projects])
#for project in configuration.projects [
  #project-header((title: project.title, website: project.website))
  #for contribution in project.contributions [
    - #contribution
  ]
]

// spacer
#block(below: 1em)

// Technical skills
#let skills = if "skills" in configuration { configuration.skills } else { (:)}
#let languages = if "languages" in skills { clean_list(skills.languages) } else { () }
#let frameworks = if "frameworks" in skills { clean_list(skills.frameworks) } else { () }
#let tools = if "tools" in skills { clean_list(skills.tools) } else { () }

#if languages.len() + frameworks.len() + tools.len() > 0 [
  #section([Technical Skills])
  #if languages.len() > 0 [
    - Languages: #(languages.join(", ") + ".")
  ]
  #if frameworks.len() > 0 [
    - Frameworks and libraries: #(frameworks.join(", ") + ".")
  ]
  #if tools.len() > 0 [
    - Tools: #(tools.join(", ") + ".")
  ]
]

// Spoken languages
#let spoken_languages = if "spoken_languages" in skills { clean_list(skills.spoken_languages) } else { () }
#if spoken_languages.len() > 0 [
  #section([Spoken Languages])
  - #(spoken_languages.join(", ") + ".")
]
// spacer
#block(below: 1em)

// Additional Information
#let additional_info = if "additional_information" in configuration and "additional" in configuration.additional_information {
  clean_list(configuration.additional_information.additional)
} else { () }

#if additional_info.len() > 0 [
  #section([Additional Information])
  - #(additional_info.join(", ") + ".")
]
