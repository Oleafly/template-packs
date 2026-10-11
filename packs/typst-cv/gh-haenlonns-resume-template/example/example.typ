#import "../template.typ" as resume

#let data = json("./example.json")
#show: resume.setup

#resume.header(data.header)
#resume.groups(data.sections.at("skills"))
#resume.entries(data.sections.at("work"))
#resume.entries(data.sections.at("projects"))
#resume.entries(data.sections.at("leadership"))
#resume.entries(data.sections.at("education"))
