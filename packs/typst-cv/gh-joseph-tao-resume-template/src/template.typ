#import "icons.typ": *;

#let project(name: "Name", pic_path: none, doc) = {
  set document(
    title: "Resume" + name,
    author: name,
  )
  set text(size: 12pt, font: ("Linux Libertine", "Noto Serif CJK SC"))
  set page(margin: (x: 0.9cm, y: 1.3cm), paper: "a4")
  set par(justify: true, leading: 0.65em, spacing: 0.65em)

  // title
  align(center)[
    #text(style: "normal", weight: "extrabold", size: 1.8em)[#name]
  ]

  // insert picture
  if pic_path != none {
    place(
      top + right,
      dy: -2em,
      image(
        pic_path,
        height: 33mm,
      )
    )
  }

  show link: underline

  // project body
  doc
}

#let info(..infos) = {
  set align(center)
  infos.pos().map(dir => {
    box(
      height: 1em,
      {
      if "icon" in dir {
        if (type(dir.icon) == str) {
          icon(dir.icon)
        } else {
          dir.icon
        }
      }
      if "link" in dir {
        link(dir.link, dir.content)
      } else {
        dir.content
      }
    })
  }).join([ $dot.c$ ])
}

#let resume_section(title) = {
  [== #title]
  line(length: 100%)
}

#let resume_item(proj_title, proj_time, proj_postion, proj_rule) = {
  [*#proj_title*]
  h(1fr)
  if proj_time != none {
    [#proj_time]
  }
  if proj_postion != none or proj_rule != none {
    linebreak()
  }
  if proj_postion != none {
    [#proj_postion]
  }
  h(1fr)
  if(proj_rule != none) {
    [#proj_rule]
  }
  linebreak()
}

#let resume_desc(l, r) = {
  [- *#l*: #r]
}

#let proj(name, stack, course, time, body) = [
  #grid(
    columns: (1fr, auto),
    align: (left, right),
    [*#name* | #stack], [*#course*, #time]
  )
  #body
]

#let multi-col(columns: (1fr, 1fr), ..body) = {
  grid(columns: columns, gutter: 1em, ..body)
}