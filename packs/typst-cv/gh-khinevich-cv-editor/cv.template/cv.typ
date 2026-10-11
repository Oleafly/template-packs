#import "../template/basic-resume.typ": *
#import "../template/experience.typ": render-experience
#import "../template/education.typ": render-education
#import "../template/skills.typ": render-skills

#let hdr = yaml("header.yml")

#show: resume.with(
  author:           hdr.name,
  email:            hdr.email,
  phone:            hdr.phone,
  location:         hdr.location,
  linkedin:          hdr.linkedin,
  linkedin-display:  hdr.at("linkedin-display", default: "LinkedIn"),
  github:            hdr.github,
  github-display:    hdr.at("github-display", default: "GitHub"),
  accent-color:     hdr.at("accent-color", default: "#26428b"),
  paper:            hdr.at("paper", default: "a4"),
)

== Work Experience
#render-experience(data: yaml("experience.yml"))

== Education
#render-education(data: yaml("education.yml"))

#render-skills(data: yaml("skills.yml"))
