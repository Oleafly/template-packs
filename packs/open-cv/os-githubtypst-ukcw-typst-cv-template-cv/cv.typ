#set text(
  font: "New Computer Modern",
  size: 9pt,
)

#set page("us-letter")
#set par(justify: true)

#let chiline() = {v(-3pt); line(length: 100%); v(-5pt)}

#let experience(header, location, subheader, date_string, bullets) = {
  [*#subheader* #h(1fr) #location \
  #emph(header) #h(1fr) #date_string]
  for item in bullets {
    [ - #item]
  }
}

#let project(header, secondary_header, date_string, bullets) = {
  [*#header* #if secondary_header != "" [| #emph(secondary_header)] #h(1fr) #date_string]
  for item in bullets {
    [ - #item]
  }
}

#[
  #set align(center)
  = Ulysses Kee
  ulysseskcw96\@gmail.com |
  #link("https://linkedin.com/in/ulysses-kee")[#underline(offset: 3pt)[linkedin.com/in/ulysses-kee]] | #link("https://github.com/ukcw")[#underline(offset: 3pt)[github.com/ukcw]] | #link("https://ukcw.io")[#underline(offset: 3pt)[ukcw.io]] 
  
  *Work Authorization: Singapore Citizen*
]

== EDUCATION
#chiline()

*#lorem(2)* #h(1fr) #lorem(2) \
#lorem(4) #h(1fr) Jan. 2048 – Jan. 2048 \
*Thesis*: #link("https://ukcw.io/")[#underline(offset: 3pt)[#lorem(8)]]

*#lorem(2)* #h(1fr) #lorem(2) \
#lorem(4) #h(1fr) Jan. 2048 -- Jan. 2048 \
*Relevant Courses*: _#lorem(2)_, _#lorem(2)_, _#lorem(2)_, _#lorem(2)_, _#lorem(2)_

== EXPERIENCE
#chiline()

#let experience_bullets_1 = ([#lorem(17)], [#lorem(17)], [#lorem(17)])
#experience([#lorem(2)],[#lorem(2)],[#lorem(2)],"Jan 2048 - Jan 2048", experience_bullets_1)


#let experience_bullets_2 = ([#lorem(17)], [#lorem(17)], [#lorem(17)])
#experience([#lorem(2)],[#lorem(2)],[#lorem(2)],"Jan 2048 - Jan 2048", experience_bullets_2)

#let experience_bullets_3 = ([#lorem(17)], [#lorem(17)], [#lorem(17)])
#experience([#lorem(2)],[#lorem(2)],[#lorem(2)],"Jan 2048 - Jan 2048", experience_bullets_3)

== PROJECTS
#chiline()

#let project_bullets_1 = ([#lorem(17)],)

#project([#lorem(2)], [#lorem(2), #lorem(2), #lorem(2)], "Jan. 2048", project_bullets_1)

#let project_bullets_2 = ([#lorem(17)],)

#project([#lorem(2)], [#lorem(2), #lorem(2), #lorem(2)], "Jan. 2048", project_bullets_2)

#let project_bullets_3 = ([#lorem(17)],)

#project([#lorem(2)], [#lorem(2), #lorem(2), #lorem(2)], "Jan. 2048", project_bullets_3)

== TECHNICAL SKILLS
#chiline()

*Languages*: Python, JavaScript/TypeScript, Java, Rust, SQL, HTML/CSS \
*Frameworks*: React, Node.js, Express, MongoDB, GraphQL, Docker, LaTeX, Hadoop, Spark, Airflow, Flink, Kafka
