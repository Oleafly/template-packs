#import "components/header.typ": header
#import "components/section.typ": section
#import "components/experience.typ": experience
#import "components/projects.typ": projects
#import "components/skills.typ": skills

#let resume(
  profile,
  summary,
  experiences,
  projectList,
  skillList,
  section_titles,
) = [
  #header(profile)

  // summary
  #text(
    size: 10pt,
    weight: "medium",
    fill: rgb("#444444"),
  )[
    #summary
  ]
  #experience(
    section_titles.experience,
    experiences,
  )

  #projects(
    section_titles.projects,
    projectList,
  )

  #skills(
    section_titles.skills,
    skillList,
  )
]
