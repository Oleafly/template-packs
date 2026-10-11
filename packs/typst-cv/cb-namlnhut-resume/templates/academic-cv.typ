#import "/templates/lib.typ": *

#let data = yaml("/data/cv.yaml")
#let variant = "academic"

#show: cv-setup

#header(data.personal)

= EDUCATION

#for e in for-variant(data.education, variant) [
  #eduentry(e.degree, e.dates, e.institution_lines, e.details)
]

= RESEARCH INTERESTS

#data.research_interests

= PUBLICATIONS

#v(space-list-gap)
#text(size: 1.15em, weight: "bold")[Research Outcomes: B.S and M.S. in Computer Science (2022--2024)]
#v(space-list-gap)

== Peer-Reviewed Journal Articles

#pub-list(data.publications.journal_articles)

== Conference Proceedings

#pub-list(data.publications.conference)

= PROFESSIONAL EXPERIENCE

#for e in for-variant(data.experience.professional, variant) [
  #entry(e.title, e.dates, e.org, e.body)
]

= RESEARCH EXPERIENCE

#for e in for-variant(data.experience.research, variant) [
  #entry(e.title, e.dates, e.org, e.body)
]

= TEACHING EXPERIENCE

#for e in for-variant(data.experience.teaching, variant) [
  #entry(e.title, e.dates, e.org, e.body)
]

#v(space-list-gap)
*Lecturing Undergraduate Courses Taught:*
#list(..data.teaching.lectured_courses)

#v(space-list-gap)
*TA Courses Taught:*

#v(space-list-gap)
*1. Graduate Courses*
#list(..data.teaching.ta_graduate)

#v(space-list-gap)
*2. Undergraduate Courses*
#list(..data.teaching.ta_undergraduate)

= HONORS & AWARDS

#for e in for-variant(data.honors, variant) [
  #entry(e.title, e.dates, e.org, text(size: 0.9em)[#e.body])
]

= SKILLS

*Languages:* #data.skills.languages

*Programming:* #data.skills.programming

*Framework:* #data.skills.frameworks

*Mathematical Programming Tooling:* #data.skills.math_tools

= REFERENCES

#for r in data.references [
  *#r.name* \
  #r.affiliation \
  Email: #link("mailto:" + r.email)[#r.email]

  #v(space-entry-below)
]

= SERVICES

*Journal Reviewer:*
#enum(..data.services.journal_reviewer.map(j => link(j.url)[#j.name]))
