#import "src/page.typ"

#import "src/resume.typ": resume

#import "src/data/en.typ": experiences, profile, projects, skills, summary ,section_titles

#set text(
  font: "Inter",
)

#resume(
  profile,
  summary,
  experiences,
  projects,
  skills,
  section_titles
)
