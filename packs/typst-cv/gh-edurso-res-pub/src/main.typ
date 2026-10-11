#import "yml.typ": yml_resume

#set document(
  title: "Resume", // TODO add name here
  // author: "Add Name Here", // TODO add name here
  keywords: ("resume"),
  date: datetime.today()
)

#let resume_data = yaml("../resume.yml")
#yml_resume(resume_data)
