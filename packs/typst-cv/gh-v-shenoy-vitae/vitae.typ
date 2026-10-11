#let hsep() = {
  line(length: 100%, stroke: rgb(0, 0, 0, 75))
}

#let vsep() =  {
  set text(fill: rgb(0, 0, 0, 200), size: 12pt, weight: "bold")
  [ | ]
}

#let iconify_link(l) = {
  grid(
    columns: 2,
    gutter: 5pt,
    image("assets/icons/" + l.icon + ".svg", width: 12pt),
    [ #v(2pt); #link(l.url, l.display); ],
  )
}

#let render_links(links) = {
  show link: underline
  grid(
    columns: links.len(),
    gutter: 7pt,
    ..links.map(iconify_link),
  )
}

#let section_heading(name) = {
  grid(
    columns: 2,
    gutter: 1fr,
    [ = #name #h(5pt) ],
    [ #v(5pt) #line(length: 100%, stroke: 1.5pt) ]
  )
}

#let render_header(name, links) = {
  set align(center)
  [
    #set text(font: "Libre Baskerville", size: 13pt)
    = #name
  ]
  render_links(links)
}

#let render_summary(summary) = {
  section_heading("Summary")
  [
    #set text(size: 10pt)
    #par(summary)
  ]

}

#let render_experience(ex) = {
  section_heading("Experience")

  for job in ex {
    if job.show {
      [ == #job.company ]

      for pos in job.positions {
        grid(
          columns: 2,
          gutter: 1fr,
          [
            #strong(emph(pos.role)) #vsep() #emph(pos.team)
          ],
          [
            #set align(right)
            #pos.location
            #vsep()
            #strong(pos.start) -- #strong(pos.end)
          ]
        )

        for point in pos.info {
          [ - #eval(point, mode: "markup") ]
        }
      }
    }
  }
}


#let render_education(education) = {
  section_heading("Education")

  for school in education {
    grid(
      columns: 2,
      gutter: 1fr,
      [
        == #school.name
        #eval(school.degree, mode: "markup") #vsep() #eval(school.grade, mode: "markup")
      ],
      [
        #set align(right)
        === #school.start -- #school.end
        #school.location
      ]
    )

    // for point in school.info {
    //   [ - #eval(point, mode: "markup") ]
    // }
  }
}

#let render_skills(skills) = {
  section_heading("Skills")

  for (section, values) in skills.pairs() {
    strong(section + ": ")
    values.join(" " + sym.circle.filled.tiny + " ")
    linebreak()
  }
}

#let render_cv(data) = {
  render_header(data.name, data.links)
  render_summary(data.summary)
  render_experience(data.experience)
  render_education(data.education)
  render_skills(data.skills)
}

#let data = yaml("data.yaml")

#set document(
  title: data.name + " -- CV",
  author: data.name
)

#set page(
  paper: "a4",
  margin: (
    x: 1cm,
    y: 0.8cm
  ),
  // footer: [
  //   #set align(right)
  //   #set text(size: 9pt, fill: rgb(0, 0, 0, 150))
  //   Updated on -- #datetime.today().display("[day] [month repr:long], [year]")
  // ],
)

#set text(font: "Calibri", size: 10pt)

#render_cv(data)
