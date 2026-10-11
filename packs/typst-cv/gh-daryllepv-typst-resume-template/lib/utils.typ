#let bulletSep = [#h(5pt) $bullet$ #h(5pt)]

#let to-string(it) = {
  if type(it) == str {
    it
  } else if type(it) != content {
    str(it)
  } else if it.has("text") {
    it.text
  } else if it.has("children") {
    it.children.map(to-string).join()
  } else if it.has("body") {
    to-string(it.body)
  } else if it == [ ] {
    " "
  }
}

#let contacts-row(location, contacts) = [
  #let loc = [#location.city, #location.state]
  #link(location.link)[#loc] #bulletSep
  #for (idx, c) in contacts.enumerate() [
    #if c.type == "mobile" [
      #link(to-string[tel:#c.countryCode#c.number])[#c.countryCode#c.number]
    ] else [
      #link(to-string[mailto:#c.email])
    ]
    #if idx < contacts.len() - 1 [ #bulletSep ]
  ]\
]

#let links-row(links: array) = [
  #for (idx, l) in links.enumerate() [
    #if "label" in l.keys() [#l.label:] #if l.type == "default" [
      #link("https://" + l.site + "/" + l.username)[#l.site/#l.username]
    ] else [
      #link("https://" + l.site)[#l.site]
    ]
    #if idx < links.len() - 1 [ #bulletSep ]
  ]\
]

#let duration(startDate, endDate) = [
  #set text(style: "italic")
  #align(right)[
    #startDate.month #startDate.year #sym.dash.em
    #if endDate == none [
      Present
    ] else [
      #endDate.month #endDate.year
    ]
  ]
]

#let exp-heading(exp) = [
  #grid(
    column-gutter: 6pt,
    row-gutter: 6pt,
    columns: (1fr, 1fr),
    [=== #exp.role],
    duration(exp.startDate, exp.endDate),
    emph(exp.org.name),
  )
]

#let get-proj-org(project) = [
  #align(right)[
    #if not "org" in project.keys() {
      return ""
    }
    #project.org
  ]
]

#let proj-heading(project) = [
  #grid(
    column-gutter: 6pt,
    row-gutter: 6pt,
    columns: (1fr, 1fr),
    [=== #project.name],
    get-proj-org(project),
    link("https://" + project.link)[
      #set text(style: "italic")
      #project.link
    ],
    if "startDate" in project or "endDate" in project {
      duration(project.startDate, project.endDate)
    }
  )
]

#let educ-heading(educ) = [
  #grid(
    column-gutter: 6pt,
    row-gutter: 6pt,
    columns: (1fr, 1fr),
    [=== #educ.school],
    align(right)[
      #set text(style: "italic")
      #duration(educ.startDate, educ.endDate)
    ],
    [
      #set text(style: "italic")
      #educ.focus.degree in #educ.focus.field
    ]
  )
]
