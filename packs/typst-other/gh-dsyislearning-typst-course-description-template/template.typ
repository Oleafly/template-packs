#let template(
  university: none,
  major: none,
  school: none,
  name: none,
  id: none,
  cover: none,
  watermark: none,
  doc,
) = {
  // Cover
  page()[
    #align(center)[
      #image(cover.logo_path, width: cover.logo_width)
      #if not cover.logo_with_university_name {
        text(weight: "semibold", size: 24pt)[#university]
        v(1fr)
      }
      #text(weight: "bold", size: 30pt, "Course Description")
      #v(1fr)
      #text(weight: "semibold", size: 16pt)[#major]
      #parbreak()
      #text(weight: "semibold", size: 18pt)[#school]
    ]
    #v(3fr)
    #set text(weight: "medium", size: 14pt)
    Name: #name #parbreak()
    Student No. #id #parbreak()
  ]

  // Credit System Explanation Page
  page(
    footer: [#h(1fr)#datetime.today().display()]
  )[
    #align(center)[
      #text(weight: "bold", size: 18pt)[Credit System Explanation]
    ]
    
    #v(1em)
    
    #set par(justify: true, leading: 0.65em)
    #set text(size: 11pt)
    
    This document describes courses taken at Hohai University. The credit system at Hohai University differs from the European Credit Transfer and Accumulation System (ECTS). One classroom hour at Hohai University equals 45 minutes of instruction time. The following conversion and workload information applies:
    
    #v(1em)
    
    #table(
      columns: (auto, 1fr),
      stroke: 0.5pt,
      inset: 10pt,
      [*Hohai Credit*], [1 credit point],
      [*ECTS Equivalent*], [≈ 1.5 ECTS],
      [*Classroom Hours*], [16 hours (each hour = 45 minutes)],
      [*Total Study Time*], [≈ 45 hours (including lectures, exercises, and self-study)],
    )
    
    #v(1em)
    
    The total study time of approximately 45 hours per credit point includes classroom instruction (lectures, tutorials, experiments, or project work), exercise sessions and practical work, as well as self-study activities such as lecture preparation, homework, and exam preparation.
  ]

  // Page settings
  set page(
    header: [
      Course Description - #name
      #h(1fr)
      #university
    ],
    footer: context [
      #counter(page).display("1 / 1", both: true)
      #h(1fr)
      #datetime.today().display()
    ],
    background: image(
      watermark.img_path,
      width: watermark.img_width,
    )
  )

  // Table of contents
  page(footer: [#h(1fr)#datetime.today().display()])[
    #outline(
      title: "Table of Contents",
      indent: 2em,
    )
  ]

  // Main body
  counter(page).update(1)
  set par(justify: true)
  set heading(numbering: "1.1.")
  doc
}

#let course(
  name: none,
  id: none,
  semester: none,
  credit: none,
  hours: none,
  grade: none,
  preparatory: none,
  prerequisite: none,
  content: none,
  description: none,
  assessment: none,
) = {
  heading(depth: 2)[#name]
  let cells = (
    ([*Course Title*], name),
    ([*Course No.*], id),
    ([*Semester*], semester),
    ([*Credit*], credit),
    ([*Course Hours*], hours),
    ([*My Grade*], grade),
    ([*Preparatory Course(s)*], preparatory),
    ([*Prerequisite(s)*], prerequisite),
    ([*Content*], content),
    ([*Course Description*], description),
    ([*Assessment*], assessment),
  )
  let table_args = ()
  for row in cells {
    if row.at(1) != none {
      table_args.push(row.at(0))
      table_args.push(row.at(1))
    }
  }
  table(
    columns: (auto, 1fr),
    ..table_args,
  )
}
