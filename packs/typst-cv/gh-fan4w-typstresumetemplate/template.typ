#let primary = rgb("#000000")
#let secondary = rgb("#0D47A1")
#let accent = rgb("#263238")
#let links = rgb("#1565C0")
#let strong-title-weight = 500

#let fa(code, size: 10pt) = text(font: "Symbols Nerd Font", size: size)[#code]
#let field(data, key, default) = data.at(key, default: default)

#let section(icon, title, extra: none, before: 5pt, after: -2pt) = [
  #v(before)
  #box(fill: secondary, inset: (x: 5pt, y: 4pt))[
    #text(fill: white, weight: "bold", size: 12pt)[#icon #h(5pt)#title]
  ]
  #if extra != none { extra }
  #v(after)
]

#let contacts(items) = grid(
  columns: (10pt, auto),
  column-gutter: 5pt,
  row-gutter: 4pt,
  align: (center + horizon, left + horizon),
  ..items.map(item => (
    text(fill: primary)[#fa(item.icon, size: field(item, "icon-size", 10pt))],
    text(size: 10.7pt)[#item.body],
  )).flatten(),
)

#let contact-block(data) = {
  let photo = field(data, "photo", none)
  if photo == none {
    contacts(data.contacts)
  } else {
    grid(
      columns: (auto, 0.75in),
      column-gutter: 18pt,
      align: (left + top, right + top),
      contacts(data.contacts),
      image(photo, width: 0.75in),
    )
  }
}

#let header(data) = [
  #grid(
    columns: (1fr, auto),
    align: (left + top, right + top),
    column-gutter: 18pt,
    [
      #v(21pt)
      #stack(
        dir: ttb,
        spacing: 21pt,
        text(size: 35pt, weight: "bold", fill: secondary)[#data.fullname],
        emph(text(size: 11pt)[#data.subtitle]),
      )
    ],
    [
      #contact-block(data)
    ],
  )
  #v(10pt)
]

#let entry-tsdl(title, date, subheading, location, body, after: 2pt) = [
  #v(-1pt)
  #grid(
    columns: (1fr, auto),
    column-gutter: 20pt,
    row-gutter: 6pt,
    text(size: 12pt, fill: secondary)[#title],
    text(size: 11pt, fill: accent)[#date],
    emph(text(size: 11pt, fill: accent)[#subheading]),
    emph(text(size: 11pt, fill: accent)[#location]),
  )
  #v(-3pt)
  #body
  #v(after)
]

#let entry-td(title, date, body, strong-title: true, after: 5pt) = [
  #v(1pt)
  #grid(
    columns: (1fr, auto),
    column-gutter: 20pt,
    if strong-title {
      text(size: 12pt, weight: strong-title-weight, fill: secondary)[#title]
    } else {
      text(size: 12pt, fill: secondary)[#title]
    },
    text(size: 11pt, fill: accent)[#date],
  )
  #v(-5pt)
  #body
  #v(after)
]

#let skill(name, body) = [
  #text(fill: secondary)[#name] #h(8pt)#body
  #v(0.5pt)
]

#let bullet-list(items) = [
  #for item in items [
    - #item
  ]
]

#let render-education(entries) = [
  #section(fa("\u{f19d}", size: 10pt), "Education")
  #for entry in entries {
    entry-tsdl(
      entry.title,
      entry.date,
      entry.subheading,
      entry.location,
      after: field(entry, "after", 2pt),
    )[
      #bullet-list(field(entry, "items", ()))
    ]
  }
]

#let render-entries(entries) = [
  #for entry in entries {
    entry-td(
      entry.title,
      entry.date,
      strong-title: field(entry, "strong-title", true),
      after: field(entry, "after", 5pt),
    )[
      #bullet-list(field(entry, "items", ()))
    ]
  }
]

#let render-skills(entries) = [
  #grid(
    columns: (70pt, 1fr),
    column-gutter: 10pt,
    row-gutter: 2.5pt,
    align: (left + horizon, left + horizon),
    ..entries.map(entry => (
      text(fill: secondary)[#entry.name],
      entry.body,
    )).flatten(),
  )
]

#let resume(
  content,
  paper: "a4",
  margin: (left: 0.48in, right: 0.58in, top: 0.38in, bottom: 0.38in),
  font: ("PingFang SC", "Helvetica Neue", "Songti SC", "SimSun"),
) = {
  set page(paper: paper, margin: margin)
  set text(font: font, size: 10.6pt, fill: primary, lang: "zh")
  set par(justify: false, leading: 0.34em)
  set list(marker: text(font: "Symbols Nerd Font", fill: primary)[\u{f105}], indent: 0.95em, body-indent: 0.45em, spacing: 5.5pt)
  show link: set text(fill: links)

  header(content.profile)

  if field(content, "education", ()) != () {
    render-education(content.education)
  }

  if field(content, "projects", ()) != () {
    section(fa("\u{f0c3}", size: 10pt), "PROJECTS")
    render-entries(content.projects)
  }

  if field(content, "experience", ()) != () {
    section(fa("\u{f200}", size: 10pt), "EXPERIENCE", before: 3pt, after: -4pt)
    render-entries(content.experience)
  }

  if field(content, "skills", ()) != () {
    section(fa("\u{f085}", size: 10pt), "Skills", before: 3pt, after: -4pt)
    render-skills(content.skills)
  }
}
