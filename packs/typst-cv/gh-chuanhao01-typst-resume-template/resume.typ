// Base font-size
#let font-size = 11pt
#let accent-color = "#262F99"

#let rlink(dest, body) = {
  underline(link(dest, body))
}

#let setup(
  name: "",
  // Leave empty for generated
  title: "",
  // Base font size
  font: "New Computer Modern",
  paper: "us-letter",
  // Margins on the entire document
  margin: 0.5in,
  body,
) = {
  // Sets document metadata
  set document(
    author: name,
    title: if title.len() == 0 { name + "'s Resume" } else { title },
  )

  // Document-wide formatting, including font and margins
  set text(
    // LaTeX style font
    font: font,
    size: font-size,
    lang: "en",
    // Disable ligatures so ATS systems do not get confused when parsing fonts.
    ligatures: false,
  )

  // Reccomended to have 0.5in margin on all sides
  set page(
    margin: margin,
    paper: paper,
  )

  // Link styles
  // show link: underline

  body
}

#let header(
  name: "",
  job_title: "",
  phone_numer: "",
  email: "",
  location: "",
  website: "",
  // github.com/USERNAME
  github: "",
  // linkedin/in/USERNAME
  linkedin: "",
  // For the list on the sides
  font-size: 11pt,
  // Name font size
  name-size: 25pt,
  // Job Title font size
  job-size: 18pt,
) = {
  show heading.where(level: 1): it => [
    #set text(size: name-size)
    #it.body
  ]
  show heading.where(level: 2): it => [
    #set text(fill: rgb(accent-color), size: job-size)
    #it.body
  ]
  set text(size: font-size)
  grid(
    columns: (auto, 1fr, auto),
    gutter: 3pt,
    align(left, list(marker: none, phone_numer, rlink("mailto:" + email, email), location)),
    align(center, list(
      marker: none,
      [= #name ],
      [== #job_title],
    )),
    align(right, list(marker: none, website, rlink("https://" + linkedin, linkedin), rlink("https://" + github, github))),
  )
}

#let section(
  title: "",
  title-size: 16pt,
  above: 0.7em,
  below: 0.5em,
) = {
  show heading: it => [
    #set block(above: above, below: below)
    #set text(size: title-size, weight: "bold")
    #block[
      #align(left)[
        #text(fill: rgb(accent-color))[#it.body]
        #box(width: 1fr, line(length: 100%))
      ]
    ]
  ]

  [= #title]
}

#let generic-two-by-two(
  top-left: "",
  top-right: "",
  bottom-left: "",
  bottom-right: "",
) = {
  [
    #top-left #h(1fr) #top-right \
    #bottom-left #h(1fr) #bottom-right
  ]
}

#let item(
  title: "",
  date: "",
  name: "",
  location: "",
  top-size: 12pt,
  bottom-size: font-size,
  above: 0.8em,
  below: 0.4em,
  body: none,
) = {
  block(above: above, below: below)[
    #generic-two-by-two(
      top-left: text(size: top-size, weight: "bold", title),
      top-right: text(size: top-size, weight: "bold", date),
      bottom-left: text(size: top-size, emph(name)),
      bottom-right: text(size: top-size, emph(location)),
    ) \
    #body
  ]
}

#let single-item(
  title: "",
  top-size: 12pt,
  bottom-size: font-size,
  above: 0.8em,
  below: 0.4em,
  body: none,
) = {
  block(above: above, below: below)[
    #text(size: top-size, weight: "bold", title) #h(1fr) \
    #body
  ]
}
