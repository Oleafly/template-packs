#import "@preview/fontawesome:0.5.0": *

#let color = rgb("#131A28")
#let title-color = rgb("#691B25")
#let email-icon = box(fa-icon("envelope", fill: color))
#let birth-icon = box(fa-icon("cake", fill: color))
#let homepage-icon = box(fa-icon("home", fill: color))
#let linkedin-icon = box(fa-icon("linkedin", fill: color))
#let phone-icon = box(fa-icon("square-phone", fill: color))
#let github-icon = box(fa-icon("github", fill: color))

#let resume_footer(author, date) = {
  set text(
    fill: gray,
    size: 8pt,
  )

  grid(
    columns: (1fr, 1fr, 1fr),
    align(left)[
      #date
    ],
    align(center)[
      #smallcaps[
        #author.firstname#sym.space#author.lastname
        #sym.dot.c #context document.title
      ]
    ],
    align(right)[
      #context counter(page).display()
    ],
  )
}

#let sidebar(sidebar, doc, accent-color: title-color) = grid(
  columns: (20%, 1fr),
  rows: (auto, auto),
  gutter: 10pt,
  {
    set text(size: 9pt)
    set align(left)
    set par(justify: false)

    show heading: it => {
      set block(above: 0.1em, below: 0.1em)
      text(rgb(accent-color), size: 11pt, it.body.text)
    }

    sidebar
  },
  doc,
)

#let resume(
  author: (:),
  date: datetime.today().display("[month repr:long] [day], [year]"),
  accent-color: title-color,
  language: "en",
  font: "HK Grotesk",
  body,
) = {
  if type(accent-color) == str {
    accent-color = rgb(accent-color)
  }

  show smallcaps: set text(font: "Libertinus Serif")
  show link: set text(blue)

  set document(
    author: author.firstname + " " + author.lastname,
    title: "resume",
  )

  set text(
    font: font,
    lang: language,
    size: 11pt,
    fill: color,
    fallback: true,
  )

  set page(
    paper: "a4",
    margin: (left: 15mm, right: 15mm, top: 7mm, bottom: 7mm),
    footer: [#resume_footer(author, date)],
    footer-descent: 0pt,
  )

  set heading(
    numbering: none,
    outlined: false,
  )

  show heading.where(level: 1): it => {
    set text(
      title-color,
      size: 13pt,
      weight: "regular",
    )

    align(left)[
      #strong(it.body.text)
      #box(width: 1fr, line(length: 100%))
    ]
  }

  show heading.where(level: 2): it => {
    set text(
      color,
      size: 12pt,
      style: "normal",
      weight: "bold",
    )
    it.body
  }

  show heading.where(level: 3): it => {
    set text(
      size: 10pt,
      weight: "regular",
    )
    smallcaps[#it.body]
  }

  let name = {
    align(center)[
      #pad(bottom: 0em)[
        #block[
          #set text(
            accent-color,
            size: 40pt,
            style: "normal",
            font: font,
          )
          #smallcaps(author.firstname + " " + author.lastname)
        ]
      ]
    ]
  }

  let generics = {
    set box(height: 9pt)

    let separator = box(width: 5pt)

    align(center)[
      #set text(
        size: 9pt,
        weight: "regular",
        style: "normal",
      )
      #block[
        #align(horizon)[
          #if ("nationality" in author) [
            #fa-icon("globe", fill: color)
            #author.nationality
            #separator
          ]
          #if ("birth" in author) [
            #birth-icon
            #author.birth
            #separator
          ]
          #if ("address" in author) [
            #fa-icon("location-crosshairs", fill: color)
            #author.address, DK
          ]
        ]
      ]
    ]
  }

  let contacts = {
    set box(height: 7pt)

    let separator = box(width: 5pt)

    align(center)[
      #set text(
        size: 9pt,
        weight: "regular",
        style: "normal",
      )
      #block[
        #align(horizon)[
          #if ("phone" in author) [
            #phone-icon
            #box[#text(author.phone)]
            #separator
          ]
          #if ("email" in author) [
            #email-icon
            #box[#link("mailto:" + author.email)[#author.email]]
          ]
          #if ("homepage" in author) [
            #separator
            #box[
              #homepage-icon
              #box[#link(author.homepage)[#author.homepage]]
            ]
          ]
          #if ("github" in author) [
            #separator
            #github-icon
            #box[#link("https://github.com/" + author.github)[#author.github]]
          ]
          #if ("linkedin" in author) [
            #separator
            #linkedin-icon
            #box[
              #link("https://www.linkedin.com/in/" + author.linkedin)[#author.linkedin]
            ]
          ]
          #if ("twitter" in author) [
            #separator
            #twitter-icon
            #box[#link("https://twitter.com/" + author.twitter)[\@#author.twitter]]
          ]
          #if ("scholar" in author) [
            #let fullname = str(author.firstname + " " + author.lastname)
            #separator
            #google-scholar-icon
            #box[#link("https://scholar.google.com/citations?user=" + author.scholar)[#fullname]]
          ]
          #if ("orcid" in author) [
            #separator
            #orcid-icon
            #box[#link("https://orcid.org/" + author.orcid)[#author.orcid]]
          ]
        ]
      ]
    ]
  }

  if author.profile-picture != none {
    let height = 2.4cm
    let width = 3 / 4 * height

    grid(
      columns: (100% - width, width),
      gutter: 10pt,
      [
        #name
        #generics
        #contacts
      ],
      align(center + horizon)[
        #block(
          radius: 2pt,
          clip: true,
          stroke: 0pt,
          width: width,
          height: height,
          author.profile-picture,
        )
      ],
    )
  } else {
    name
    generics
    contacts
  }

  body
}

#let resume-entry(
  title: none,
  location: "",
  date: "",
  description: "",
  title-link: "",
  accent-color: title-color,
) = {
  location = text(size: 11pt, weight: "medium", location)
  if title-link == "" {
    title = heading(level: 2, title)
  } else {
    title = heading(level: 2, title) + link(title-link)[ link]
  }

  grid(
    columns: (auto, 1fr),
    align(left, title), align(right, location),
  )

  if date != "" or description != "" {
    description = heading(level: 3, description)
    date = text(size: 9pt, weight: "light", date)

    v(-0.5em)
    grid(
      columns: (auto, 1fr),
      align(left)[=== #description], align(right, date),
    )
  }
}
