// Layout function
#let resume(data) = {
  // Config variables extraction
  let name = data.name
  let email = data.at("email", default: "")
  let phone = data.at("phone", default: "")
  let tel = data.at("tel", default: "")
  let website = data.at("website", default: "")
  let website_display = data.at("website_display", default: "")
  let linkedin = data.at("linkedin", default: "")
  let linkedin_display = data.at("linkedin_display", default: "")
  let github = data.at("github", default: "")
  let github_display = data.at("github_display", default: "")

  // Spacing constants
  let entry-spacing = 0pt
  let bullet-spacing = 0.65em
  let bullet-line-height = 0.5em
  let heading-after-spacing = -6pt
  let heading-row-gap = 3pt
  let heading-before-spacing = -2pt
  let section-title-spacing = -7pt
  let post-list-spacing-adjust = -2pt

  // Font size constants
  let base-font-size = 10.5pt
  let name-font-size = 24pt
  let section-font-size = 12pt
  let body-font-size = 9pt

  // Indentation constants
  let bullet-indent = 0.05in
  let list-body-indent = 0.05in
  let awards-indent = 0.05in

  // Page setup
  set page(
    paper: "us-letter",
    margin: (x: 0.5in, y: 0.3in),
  )

  set text(
    font: "Latin Modern Roman",
    size: base-font-size,
  )

  set par(justify: false)

  // Helper functions
  let section(title) = {
    v(section-title-spacing)
    text(size: section-font-size, weight: "regular", smallcaps(title))
    v(section-title-spacing)
    line(length: 100%, stroke: 0.5pt + black)
    v(section-title-spacing)
  }

  let resume-list-start(content) = {
    set text(size: body-font-size)
    set par(leading: bullet-line-height)
    set list(marker: [•], indent: bullet-indent, body-indent: list-body-indent, spacing: bullet-spacing)
    content
  }

  let resumeSubheading(title, date, subtitle, location) = {
    v(heading-before-spacing)
    table(
      columns: (1fr, auto),
      stroke: none,
      align: (left, right),
      inset: 0pt,
      column-gutter: 0pt,
      row-gutter: heading-row-gap,
      [*#text(size: body-font-size)[#title]*], [#text(size: body-font-size)[#date]],
      [#text(style: "italic", size: body-font-size)[#subtitle]], [#text(style: "italic", size: body-font-size)[#location]]
    )
    v(heading-after-spacing)
  }

  let resumeProjectHeading(title, date) = {
    table(
      columns: (1fr, auto),
      stroke: none,
      align: (left, right),
      inset: 0pt,
      column-gutter: 0pt,
      [#text(size: body-font-size)[#title]], [#text(size: body-font-size)[#date]]
    )
    v(heading-after-spacing)
  }

  // Render bullet items if they exist
  let render-items(entry) = {
    if "items" in entry and entry.items != none and entry.items.len() > 0 {
      resume-list-start([
        #for item in entry.items [
          - #eval(item, mode: "markup")
        ]
      ])
      v(post-list-spacing-adjust)
    }
  }

  // Render a section with entries
  let render-section(title, entries, render-heading) = {
    section(title)
    for (i, entry) in entries.enumerate() {
      render-heading(entry)
      let has-items = "items" in entry and entry.items != none and entry.items.len() > 0
      render-items(entry)
      if i < entries.len() - 1 {
        v(entry-spacing)
      } else if not has-items {
        // Cancel out the negative heading-after-spacing when there are no items
        v(-heading-after-spacing)
      }
    }
  }

  // Document Content
  align(center)[
    #text(size: name-font-size, weight: "regular")[#smallcaps[#name]] \
    #v(1pt)
    #if phone != "" { link(tel)[#phone] }
    #if phone != "" and email != "" { " | " }
    #if email != "" { link("mailto:" + email)[#email] }
    #if email != "" and website != "" { " | " }
    #if website != "" { link(website)[#website_display] }
    #if website != "" and linkedin != "" { " | " }
    #if linkedin != "" { link(linkedin)[#linkedin_display] }
    #if linkedin != "" and github != "" { " | " }
    #if github != "" { link(github)[#github_display] }
  ]

  if "education" in data {
    render-section("Education", data.education, edu => {
      resumeSubheading(edu.institution, edu.date, edu.degree, edu.location)
    })
  }

  if "experience" in data {
    render-section("Experience", data.experience, exp => {
      resumeSubheading(
        eval(exp.company, mode: "markup"),
        exp.date,
        eval(exp.role, mode: "markup"),
        exp.location
      )
    })
  }

  if "projects" in data {
    render-section("Projects", data.projects, project => {
      resumeProjectHeading(eval(project.title, mode: "markup"), project.date)
    })
  }

  if "awards" in data {
    section("Awards")
    set list(marker: none, indent: awards-indent, body-indent: 0in)
    set text(size: body-font-size)
    for award in data.awards [
      - #eval(award, mode: "markup")
    ]
  }

  if "skills" in data {
    section("Skills")
    set list(marker: none, indent: awards-indent, body-indent: 0in)
    set text(size: body-font-size)
    for skill_group in data.skills [
      - *#skill_group.category*: #eval(skill_group.skills, mode: "markup")
    ]
  }
}
