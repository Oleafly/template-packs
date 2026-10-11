#import "items.typ"
#import "sections.typ"
#import "resume.typ": resume
#import "resume.typ" as res

#let name = "Contemplate Mibbons"
#show: doc => resume(
  name: name,
  doc
)

= #name

#res.header-links(sections.links)

== Selected Projects

#for a in sections.projects [
  #res.project(..a)
]

== Work Experience

#for a in sections.experience [
  #res.position(..a)
]

== Education

#for a in sections.education [
  #res.education(..a)
]
