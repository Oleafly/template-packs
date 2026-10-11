#let accent = gray

#let quad(a, b, c, d) = {
  grid(
    columns: (1fr, auto),
    [
      === #a\
      #b
    ],
    align(right)[
      #c\
      #d
    ]
  )
}

#let bullets(details) = {
  if details != none {
    for detail in details [
      - #detail
    ]
  }
}

#let header-link(title: none, url: none, text-url: none, icon: none) = [
  #set align(horizon)
  #set text(8pt)
  #box(baseline: 20%)[
    #set align(center)
    // #image("icons/link-2-svgrepo-com.svg", height: 1em)
    #image("icons/" + icon, height: 1em)
  ] #link(url)[#text-url]
]

#let header-links(links) = {
  v(1em)
  set align(center)
  for link-item in links {
    h(6pt)
    box[#header-link(..link-item)]
    h(6pt)
  }
}

#let project(
  title: none,
  url: none,
  text-url: none,
  date: none,
  description: none,
  technology: none,
  details: (),
) = {
  quad([
    #title
    #if url != none [
      // #h(8pt)
      #set text(accent)
      // #link(url)[#text-url]
      // terrible hack:
      #move(dx: 200pt, dy: -2.05em)[
      #link(url)[#text-url]
      #v(-4.26em)
      ]
    ]
  ], description,
  technology, date)
  bullets(details)
}

#let education(
  title: none,
  organization: none,
  location: none,
  show-detail: true,
  dates: none,
  details: none) = {
  quad(title, organization, location, dates)
  if show-detail {
    bullets(details)
  }
}

#let position(
  department: none,
  organization: none,
  title: none,
  location: none,
  dates: none,
  show-detail: true,
  details: none) = {
  quad(
    if department != none [#department, ] + organization,
    title,
    location,
    dates
  )
  if show-detail {
    bullets(details)
  }
}

#let resume(
  name: none,
  doc,
) = {
  set document(
    title: name + "'s Résumé",
    author: name,
    date: auto,
  )
  
  set page(
    "us-letter",
    margin: (x: 0.5in, y: 0.5in),
  )

  set text(10pt)

  show heading.where(
    level: 1
  ): it => [
    #set align(center)
    #set pad(bottom: 1em)
    #it
  ]

  show heading.where(
    level: 2
  ): it => [
    #pad(y: 0.4em)[
    #grid(columns: (auto, auto), gutter: 4pt,
    [
      #it
    ],
    align(right + bottom)[
      #line(length: 100%, stroke: accent)
    ]
    )]
  ]
  
  doc
}