#set page(
  margin: (x: 12mm, y: 16mm),
  footer: [
    Last updated: #datetime.today().display("[month repr:long] [year]")
  ],
  footer-descent: 0%
)
#set par(justify: true)
// #set text(font: "OpenDyslexic 3")

#show heading.where(level: 1): set text(size: 24pt)
#show heading.where(level: 2): it => {
  smallcaps(text(size: 15pt, it.body))
  // Hack to get rid of vertical spacing of line function
  v(-0.9em)
  line(length: 100%, stroke: 0.8pt)
  v(-0.2em)
}

#let subsection-heading(organization, title, duration, location) = {
  text(weight: "bold")[#organization]
  h(1fr)
  duration
  linebreak()
  title
  h(1fr)
  location
}
#let spacer-m = v(0.8em)
#let spacer-s = v(0.4em)

// Adjust column sizes here
#grid(
  columns: (1fr, 2fr),
  column-gutter: 16pt,
// Left column
  [
= Your Name
#spacer-s
#link("mailto:example@email.com") \
// Note: use hyphen - for seperator
#link("tel:+1 (234) 567-8901") \
#show link: underline
#link("example.com") \

#spacer-m

== Languages
- #lorem(5)
- #lorem(5)
- #lorem(5)

#spacer-m

== Skills
- #lorem(10)
- #lorem(10)
- #lorem(10)

#spacer-m

== Personal Interests
- #lorem(8)
- #lorem(8)
- #lorem(8)

  ],
// Right column
  [
== Education
// Note: use en dash – for duration
#subsection-heading("Institution", "Degree", "2011.1 – 2022.2", "Location")
- #lorem(20)
- #lorem(20)
- #lorem(20)

#spacer-m

== Experience
#subsection-heading("Organization", "Title", "2011.1 – 2022.2", "Location")
- #lorem(20)
- #lorem(20)
- #lorem(20)

#spacer-m

#subsection-heading("Organization", "Title", "2011.1 – 2022.2", "Location")
- #lorem(20)
- #lorem(20)
- #lorem(20)

#spacer-m

== Projects
#show link: underline
#subsection-heading("Title", link("project.site"), "2011.1 – 2022.2", "Location")
- #lorem(20)
- #lorem(20)
- #lorem(20)
  ]
)
