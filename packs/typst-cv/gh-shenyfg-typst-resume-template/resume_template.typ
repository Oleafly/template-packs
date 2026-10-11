// 通用的简历样式模板

#let render_resume(personal, sections, config) = {
  // ============ Page and Font Settings ============
  set document(
    title: personal.name + config.title-suffix,
    author: personal.name,
  )
  set page(
    paper: "a4",
    margin: (top: 20pt, right: 24pt, bottom: 20pt, left: 24pt),
  )

  set text(
    font: config.fonts,
    size: 10pt,
  )

  set heading(numbering: none)

  // ============ Style Component Definitions ============

  // Divider line
  let rule = line(length: 100%, stroke: 0.5pt + gray)

  // Two-column layout: left title, right content
  let section = (title, content) => [
    #rule
    #table(
      columns: (80pt, 1fr),
      stroke: none,
      inset: 0pt,
      column-gutter: 20pt,
      align: (left + top, left + top),
      [#text(size: 11pt, weight: "bold", fill: rgb(60, 60, 60))[#title]],
      [#content],
    )
  ]

  // Education component
  let education = (when: "", school: "", major: "", degree: "") => [
    #table(
      columns: (1fr, auto),
      stroke: none,
      inset: 0pt,
      column-gutter: 12pt,
      [*#school* · #major · #degree], [#emph[#when]],
    )
    #v(3pt)
  ]

  // Project/Work experience component
  let project = (when, what, where, body) => [
    #table(
      columns: (1fr, auto),
      stroke: none,
      inset: 0pt,
      column-gutter: 12pt,
      [*#what* · #where], [#emph[#when]],
    )
    #if body != [] [
      #body
    ]
    #v(6pt)
  ]

  // Work experience with nested projects component
  let work_with_projects = (when, what, where, projects) => [
    #table(
      columns: (1fr, auto),
      stroke: none,
      inset: 0pt,
      column-gutter: 12pt,
      [#text(size: 12pt, weight: "bold", fill: rgb(0, 0, 0))[#what] · #text(size: 11pt)[#where]],
      [#text(size: 11pt)[#emph[#when]]],
    )
    #if projects != none and projects != () [
      #v(6pt)
      #for proj in projects [
        #pad(left: 16pt)[
          #project(proj.at(0), proj.at(1), proj.at(2), proj.at(3))
        ]
      ]
    ] else [
      #v(6pt)
    ]
  ]

  // Link styling
  show link: set text(fill: rgb(0, 96, 192))

  // ============ Content Rendering ============

  // Header information
  align(center)[
    #text(size: 20pt, weight: "bold")[#personal.name]
    #v(-12pt)
    #text(size: 12pt)[#personal.title]
    #v(-6pt)
    #text(size: 10pt)[#personal.contact]
  ]
  v(4pt)

  // 解析每个章节
  for sec in sections {
    if sec.title in config.education_titles {
      // 教育经历格式
      section(sec.title, [
        #for edu in sec.content [
          #education(
            when: edu.at(0),
            school: edu.at(1),
            major: edu.at(2),
            degree: edu.at(3),
          )
        ]
      ])
    } else if sec.title in config.work_titles {
      // 工作经历格式（嵌套项目）
      section(sec.title, [
        #for work in sec.content [
          #work_with_projects(work.at(0), work.at(1), work.at(2), work.at(3))
        ]
      ])
    } else {
      section(sec.title, sec.content)
    }
  }
}

