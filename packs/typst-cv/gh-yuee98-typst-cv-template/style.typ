#let page-width = 210mm
#let page-height = 297mm
#let page-margin-x = 0.55in
#let page-margin-top = 0.52in
#let page-margin-bottom = 0.46in

#let body-font = ("Times New Roman", "Noto Serif SC", "SimSun")
#let body-size = 10pt
#let body-leading = 0.44em
#let paragraph-spacing = 0.08em

#let rule-stroke = 0.45pt
#let header-after-gap = 0.76em
#let section-before-gap = 0.90em
#let section-title-rule-gap = 0.10em
#let section-content-gap = 0.48em
#let top-item-gap = 0.48em
#let sub-item-gap = 0.46em
#let entry-heading-detail-gap = 0.44em
#let entry-detail-body-gap = 0.38em
#let entry-after-gap = 0.72em
#let one-line-body-gap = 0.36em
#let publication-gap = 0.30em

#let resume-style(title: "Alex Chen - Resume", author: "Alex Chen", lang: "zh", font: none, body) = {
  set document(title: title, author: author)
  set page(
    width: page-width,
    height: page-height,
    margin: (
      left: page-margin-x,
      right: page-margin-x,
      top: page-margin-top,
      bottom: page-margin-bottom,
    ),
  )
  set text(
    font: if font != none { font } else { body-font },
    size: body-size,
    lang: lang,
  )
  set par(justify: false, leading: body-leading, spacing: paragraph-spacing)
  show link: it => {
    set text(fill: black)
    it
  }

  body
}

#let resume-header(name, subtitle, email, phone) = {
  grid(
    columns: (1fr, auto),
    column-gutter: 1.2em,
    align(left)[
      #text(size: 16pt, weight: "bold")[#name] \
      #text(size: 10.5pt)[#subtitle]
    ],
    align(right)[
      #if email != "" {
        text(size: 10pt)[Email : #link("mailto:" + email)[#email]]
        linebreak()
      }
      #if phone != "" {
        text(size: 10pt)[Mobile : #phone]
      }
    ],
  )
  v(header-after-gap)
}

#let resume-section(title) = {
  v(section-before-gap)
  block(width: 100%, sticky: true)[
    #text(size: 12.2pt, weight: "bold")[#title]
    #v(section-title-rule-gap)
    #rect(width: 100%, height: rule-stroke, fill: black, stroke: none)
    #v(section-content-gap)
  ]
}

#let bullet(body, level: 1, keep: true) = {
  let mark = if level == 1 { "•" } else { "-" }
  let mark-size = if level == 1 { 9.2pt } else { 9.6pt }
  let item = grid(
    columns: (0.72em, 1fr),
    column-gutter: 0.22em,
    align(top)[#text(size: mark-size)[#mark]],
    body,
  )
  if keep {
    block(width: 100%, breakable: false)[#item]
  } else {
    item
  }
  v(if level == 1 { top-item-gap } else { sub-item-gap })
}

#let plain-item(body) = bullet(body)

#let skill-item(label, body) = bullet[
  #strong[#label]: #body
]

#let sub-item(body) = bullet(body, level: 2)

#let entry-heading(org, date) = block(width: 100%, sticky: true)[
  #grid(
    columns: (1fr, auto),
    column-gutter: 1em,
    text(size: 10.4pt, weight: "bold")[#org],
    align(right)[#text(size: 9.8pt)[#date]],
  )
]

#let entry-detail-row(title, detail) = block(width: 100%, sticky: true)[
  #grid(
    columns: (1fr, 1.25fr),
    column-gutter: 1em,
    text(size: 9.4pt, style: "italic")[#title],
    align(right)[#text(size: 9.4pt)[#detail]],
  )
]

#let project-meta(detail, date: none) = {
  if date == none {
    text(style: "italic")[#detail]
  } else if detail == none {
    date
  } else {
    [#date · #text(style: "italic")[#detail]]
  }
}

#let project-entry(title, detail, bullets, date: none) = {
  block(width: 100%)[
    #entry-detail-row(title, project-meta(detail, date: date))
  ]
  v(entry-detail-body-gap)
  for item in bullets {
    sub-item(item)
  }
}

#let company-entry(org, date, body) = {
  entry-heading(org, date)
  v(entry-heading-detail-gap)
  body
  v(entry-after-gap)
}

#let resume-entry(org, title, detail, date, bullets, keep: false) = {
  let entry = company-entry(org, date)[
    #project-entry(title, detail, bullets)
  ]
  if keep {
    block(width: 100%, breakable: false)[#entry]
  } else {
    entry
  }
}

#let one-line-entry(title, date, bullets) = {
  entry-heading(title, date)
  v(one-line-body-gap)
  for item in bullets {
    sub-item(item)
  }
  v(entry-after-gap)
}

#let publication-counter = counter("publication")

#let publication(authors, title, venue, year) = {
  publication-counter.step()
  block(width: 100%, breakable: false)[
    #grid(
      columns: (1.65em, 1fr),
      column-gutter: 0.08em,
      context { [[#{publication-counter.get().first()}]] },
      {
        authors
        [. ]
        title
        [. #emph[#venue], #year.]
      },
    )
  ]
  v(publication-gap)
}
